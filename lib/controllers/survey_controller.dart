import 'package:fhir/r4.dart';
import 'package:fhir_surveys/_internal/utils/initial_answer.dart';
import 'package:fhir_surveys/_internal/utils/utils.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  /// PROPERTIES
  ///
  /// index of the currentItem because I can't find a better way to make it
  /// observable each time I change items
  final _index = 0.obs;

  /// list of the linkId of all of the items in the questionnaire
  final List<String> _keys = [];

  /// total questions (active?) in the questionnaire
  final _totalQuestions = 0.obs;

  /// the running total of questions that have been answered
  int _questionsAnswered = 0;

  /// the full [Questionnaire] that is being completed
  late Questionnaire _questionnaire;

  /// the full [QuestionnaireResponse ]that is being created - mirrors the
  /// Questionnaire for the most part
  QuestionnaireResponse _response = QuestionnaireResponse();

  /// the currentItem that is being displayed
  QuestionnaireItem? _currentItem;

  /// text of the current group that should be displayed above the individual
  /// question text
  String groupText = '';

  /// a special item that is mostly used for purposes of questionnaires that
  /// we are defining and writing. It allows a freeTextItem to be displayed
  /// as part of a question, on the same screen, and is defined by the [Loinc]
  /// code [22017-8]
  QuestionnaireItem? _freeTextItem;

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
      _setFreeText();
    }
    super.onInit();
  }

  /// GETTER FUNCTIONS
  QuestionnaireResponse get getResponse => _response;
  double get percentComplete => _totalQuestions.value == 0
      ? 0
      : _questionsAnswered / _totalQuestions.value;
  int get index => _index.value;
  int get totalScreens => _keys.length;
  String get text => _currentItem?.text ?? '';
  bool get multipleChoice => _currentItem?.repeats?.value ?? false;
  String? get linkId => _currentItem?.linkId;
  QuestionnaireItem? get freeText => _freeTextItem;
  List<String> get initial => initialAnswer(
      initialResponse: _currentItem?.initial,
      type: _currentItem?.type,
      responseAnswer:
          _getAnswerItem(_keys[index], _response.item!)?.answer ?? []);
  QuestionnaireItemType? get type =>
      _currentItem?.type ?? QuestionnaireItemType.display;
  List<String> get choiceResponses => _currentItem?.answerOption == null
      ? []
      : _currentItem!.answerOption!
          .map((answer) => answer.valueCoding?.display ?? '')
          .toList();
  bool get isFreeText {
    if (_currentItem!.code != null) {
      if (_currentItem!.code!.length == 1) {
        if (_currentItem!.code![0].code == Code('22017-8') &&
            _currentItem!.code![0].display ==
                'State defined narrative Narrative' &&
            _currentItem!.code![0].system == FhirUri('http://loinc.org')) {
          return true;
        }
      }
    }
    return false;
  }

  List<String> initialFreeText(String linkId) {
    final curLinkId = _currentItem!.linkId;
    _setCurrentItem(linkId, _questionnaire.item!, 0);
    final returnList = initial;
    _setCurrentItem(curLinkId!, _questionnaire.item!, 0);
    return returnList;
  }

  QuestionnaireResponseItem? _getAnswerItem(
      String linkId, List<QuestionnaireResponseItem> items) {
    for (var item in items) {
      if (item.linkId == linkId) {
        return item;
      }
      if (item.item != null) {
        if (item.item!.isNotEmpty) {
          final responseItem = _getAnswerItem(linkId, item.item!);
          if (responseItem != null) {
            return responseItem;
          }
        }
      }
    }
  }

  bool checkAnswer(String linkId, QuestionnaireAnswerOption answerOption) {
    final answerItem = _getAnswerItem(linkId, _response.item!);
    return answerItem?.answer?.contains(answerOption) ?? false;
  }

  /// SETTER FUNCTIONS
  void _setFreeText() => _currentItem?.item != null
      ? _currentItem!.item!.length == 1
          ? _currentItem!.item![0].code != null
              ? _currentItem!.item![0].code!.length == 1
                  ? _currentItem!.item![0].code![0].code == Code('22017-8') &&
                          _currentItem!.item![0].code![0].display ==
                              'State defined narrative Narrative' &&
                          _currentItem!.item![0].code![0].system ==
                              FhirUri('http://loinc.org')
                      ? _freeTextItem = _currentItem!.item![0]
                      : _freeTextItem = null
                  : _freeTextItem = null
              : _freeTextItem = null
          : _freeTextItem = null
      : _freeTextItem = null;

  int _setCurrentItem(String linkId, List<QuestionnaireItem> items, int level) {
    for (var item in items) {
      if (item.linkId == linkId) {
        _currentItem = item.copyWith();
        _setFreeText();
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

  void setCurrentAnswer(String answer, String linkId, [bool remove = false]) {
    _setCurrentItem(linkId, _questionnaire.item!, 0);
    final responseAnswer = _getAnswerItem(linkId, _response.item!);
    if (responseAnswer!.answer!.isEmpty) {
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
    if (isFreeText) {
      next();
    }
    update();
  }

  void back() {
    _index.value = _index.value - 1 < 0 ? _keys.length - 1 : _index.value - 1;
    _setCurrentItem(_keys[_index.value], _questionnaire.item!, 0);
    if (isFreeText) {
      back();
    }
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
