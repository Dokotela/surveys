import 'package:fhir/r4.dart';
import 'package:fhir_surveys/_internal/utils/initial_answer.dart';
import 'package:fhir_surveys/_internal/utils/utils.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  /// PROPERTIES
  final _index = 0.obs;
  final List<String> _keys = [];
  final _totalQuestions = 0.obs;
  int _questionsAnswered = 0;
  late Questionnaire _questionnaire;
  QuestionnaireResponse _response = QuestionnaireResponse();
  QuestionnaireItem? _currentItem;
  String groupText = '';

  /// GETTER FUNCTIONS
  double get percentComplete => _totalQuestions.value == 0
      ? 0
      : _questionsAnswered / _totalQuestions.value;
  int get index => _index.value;
  int get totalScreens => _keys.length;
  String get text => _currentItem?.text ?? '';
  bool get multipleChoice => _currentItem?.repeats?.value ?? false;
  List<String> get initial => initialAnswer(
      initialResponse: _currentItem?.initial,
      type: _currentItem?.type,
      responseAnswer:
          _getAnswerItem(_keys[_index.value], _response.item!).answer!);
  QuestionnaireItemType? get type =>
      _currentItem?.type ?? QuestionnaireItemType.display;
  List<String> get choiceResponses => _currentItem?.answerOption == null
      ? []
      : _currentItem!.answerOption!
          .map((answer) => answer.valueCoding?.display ?? '')
          .toList();
  QuestionnaireResponseItem _getAnswerItem(
      String linkId, List<QuestionnaireResponseItem> items) {
    for (var item in items) {
      if (item.linkId == linkId) {
        return item;
      }
      if (item.item != null) {
        if (item.item!.isNotEmpty) {
          return _getAnswerItem(linkId, item.item!);
        }
      }
    }
    throw Exception('could not find linkId: $linkId');
  }

  /// SETTER FUNCTIONS
  int _setCurrentItem(String linkId, List<QuestionnaireItem> items, int level) {
    for (var item in items) {
      if (item.linkId == linkId) {
        _currentItem = item;
        if (item.type == QuestionnaireItemType.group) {
          groupText = item.text ?? '';
        }
        return level;
      }
      if (item.item != null) {
        if (item.item!.isNotEmpty) {
          var foundLevel = _setCurrentItem(linkId, item.item!, level + 1);
          if (foundLevel != -1) {
            if (item.type == QuestionnaireItemType.group &&
                level + 1 == foundLevel) {
              groupText = item.text ?? '';
            }
            return foundLevel;
          }
        }
      }
    }
    return -1;
  }

  void setCurrentAnswer(String answer, [bool remove = false]) {
    final responseAnswer = _getAnswerItem(_keys[index], _response.item!);
    if (responseAnswer.answer!.isEmpty) {
      _questionsAnswered++;
    }
    if (!(_currentItem?.repeats?.value ?? false)) {
      responseAnswer.answer!.clear();
    }
    addAnswer(answer, responseAnswer, _currentItem, remove);
  }

  /// EVENTS
  void next() {
    _index.value = _index.value + 1 >= _keys.length ? 0 : _index.value + 1;
    _setCurrentItem(_keys[_index.value], _questionnaire.item!, 0);
  }

  void back() {
    _index.value = _index.value - 1 < 0 ? _keys.length - 1 : _index.value - 1;
    _setCurrentItem(_keys[_index.value], _questionnaire.item!, 0);
  }

  /// INIT
  @override
  void onInit() {
    _questionnaire = Get.arguments[0];
    _response = Get.arguments.length == 2
        ? Get.arguments[1]
        : QuestionnaireResponse(
            status: QuestionnaireResponseStatus.in_progress,
            item: <QuestionnaireResponseItem>[]);
    if (_questionnaire.item != null) {
      if (_response.item == null) {
        _response = _response.copyWith(item: []);
      }
      _response = _response.copyWith(
          item: _createResponse(
        _questionnaire.item!,
        _response.item!,
      ));
      _currentItem = _questionnaire.item?[0];
    }
    super.onInit();
  }

  List<QuestionnaireResponseItem> _createResponse(
    List<QuestionnaireItem> items,
    List<QuestionnaireResponseItem> responses,
  ) {
    for (var item in items) {
      var index =
          responses.indexWhere((element) => element.linkId == item.linkId);
      if (index == -1) {
        responses.add(QuestionnaireResponseItem(
          linkId: item.linkId,
          text: item.text,
        ));
      } else {
        responses[index] = responses[index].copyWith(text: item.text);
      }
      index = responses.indexWhere((element) => element.linkId == item.linkId);
      if (item.type != QuestionnaireItemType.group &&
          item.type != QuestionnaireItemType.display) {
        _totalQuestions.value++;
        if (responses[index].answer == null) {
          responses[index] = responses[index].copyWith(answer: []);
        }
      }
      _keys.add(item.linkId!);
      if (item.item != null) {
        if (responses[index].item == null) {
          responses[index] = responses[index].copyWith(item: []);
        }
        _createResponse(item.item!, responses[index].item!);
      }
    }
    return responses;
  }
}
