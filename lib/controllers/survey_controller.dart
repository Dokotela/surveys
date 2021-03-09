import 'package:fhir/r4.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  /// PROPERTIES
  final _index = 0.obs;
  final List<String> _keys = [];
  final _totalQuestions = 0.obs;
  final _questionsAnswered = 0.obs;
  late Questionnaire _questionnaire;
  QuestionnaireResponse _response = QuestionnaireResponse();
  QuestionnaireItem? _currentItem;

  /// GETTER FUNCTIONS
  double get percentComplete => _totalQuestions.value == 0
      ? 0
      : _questionsAnswered.value / _totalQuestions.value;
  int get index => _index.value;
  int get totalScreens => _keys.length;
  String get text => _currentItem?.text ?? '';
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
    throw Exception('could not find linkId');
  }

  /// SETTER FUNCTIONS
  bool _setCurrentItem(String linkId, List<QuestionnaireItem> items) {
    for (var item in items) {
      if (item.linkId == linkId) {
        _currentItem = item;
        return true;
      }
      if (item.item != null) {
        if (item.item!.isNotEmpty) {
          return _setCurrentItem(linkId, item.item!);
        }
      }
    }
    throw Exception('could not find linkId');
  }

  void setCurrentAnswer(String answer) {
    final responseAnswer = _getAnswerItem(_keys[index], _response.item!);
    if (!(_currentItem?.repeats?.value ?? true)) {
      responseAnswer.answer!.clear();
    }
    if (_currentItem?.type == QuestionnaireItemType.boolean) {
      responseAnswer.answer!.add(QuestionnaireResponseAnswer(
          valueBoolean: Boolean(answer.toString())));
    }
    if (_currentItem?.type == QuestionnaireItemType.choice) {
      responseAnswer.answer!.add(QuestionnaireResponseAnswer(
          valueCoding: _currentItem!.answerOption!
              .firstWhere((element) => element.valueCoding?.display == answer)
              .valueCoding));
    }
    print(_response.toJson());
  }

  /// EVENTS
  void next() {
    _index.value = _index.value + 1 >= _keys.length ? 0 : _index.value + 1;
    _setCurrentItem(_keys[_index.value], _questionnaire.item!);
  }

  void back() {
    _index.value = _index.value - 1 < 0 ? _keys.length - 1 : _index.value - 1;
    _setCurrentItem(_keys[_index.value], _questionnaire.item!);
  }

  void save() {
    // for(var item in _questionnaire.item!){
    //   _response.add()
    // }
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
