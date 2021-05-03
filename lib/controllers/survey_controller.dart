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
  final _questionsTotal = 0.obs;

  /// the running total of questions that have been answered
  int _questionsAnswered = 0;

  /// the total number of questions that are active
  int _questionsActive = 0;

  /// the full [Questionnaire] that is being completed
  late Questionnaire _questionnaire;

  /// the full [QuestionnaireResponse ]that is being created - mirrors the
  /// Questionnaire for the most part
  late QuestionnaireResponse _response;

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

  /// GETTER FUNCTIONS
  String get _activeLinkId => _keys[_index.value];
  int get index => _index.value;
  int get totalScreens => _keys.length;
  double get percentComplete => _questionsTotal.value == 0
      ? 100
      : _questionsAnswered / _questionsTotal.value;
  bool get isFreeText => _currentItem!.code != null &&
          _currentItem!.code!.length == 1 &&
          _currentItem!.code![0].code == Code('22017-8') &&
          _currentItem!.code![0].display ==
              'State defined narrative Narrative' &&
          _currentItem!.code![0].system == FhirUri('http://loinc.org')
      ? true
      : false;
  QuestionnaireItemType? get type =>
      _currentItem?.type ?? QuestionnaireItemType.display;
  String? get linkId => _currentItem?.linkId;
  List<String> get initial => initialAnswer(
      initialResponse: _currentItem?.initial,
      type: _currentItem?.type,
      responseAnswer:
          _getAnswerItem(_keys[index], _response.item!)?.answer ?? []);
  // QuestionnaireResponse get getResponse => _response;
  // String get text => _currentItem?.text ?? '';
  // bool get multipleChoice => _currentItem?.repeats?.value ?? false;
  // QuestionnaireItem? get freeText => _freeTextItem;
  // List<String> get choiceResponses => _currentItem?.answerOption == null
  //     ? []
  //     : _currentItem!.answerOption!
  //         .map((answer) => answer.valueCoding?.display ?? '')
  //         .toList();
  // List<String> initialFreeText(String linkId) {
  //   final curLinkId = _currentItem!.linkId;
  //   _setCurrentItem(linkId, _questionnaire.item!, 0);
  //   final returnList = initial;
  //   _setCurrentItem(curLinkId!, _questionnaire.item!, 0);
  //   return returnList;
  // }

  /// looks through the QuestionnaireResponse items passed to it to find the
  /// item with the same linkId, calls itself recursively until it finds it
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

  // bool checkAnswer(String linkId, QuestionnaireAnswerOption answerOption) {
  //   final answerItem = _getAnswerItem(linkId, _response.item!);
  //   return answerItem?.answer?.contains(answerOption) ?? false;
  // }

  /// SETTER FUNCTIONS
  ///
  /// accepts a list of [QuestionnaireItem]s and an int [level] as arguments.
  /// Uses the level when figuring out how deeply are questions nested. Uses
  /// the [_activeLinkId] which is referenced by the [_index];
  /// are.
  int _setCurrentItem(List<QuestionnaireItem> items, int level) {
    for (var item in items) {
      if (item.linkId == _activeLinkId) {
        _currentItem = item.copyWith();
        _setFreeText();
        if (item.type == QuestionnaireItemType.group) {
          groupText = item.text ?? '';
        }
        return level;
      }
      if (item.item != null) {
        if (item.item!.isNotEmpty) {
          var foundLevel = _setCurrentItem(item.item!, level + 1);
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

  void _setFreeText() {
    var itemLength = _currentItem?.item?.length ?? 0;
    var codeIndex = -1;
    if (itemLength >= 1) {
      for (var item in _currentItem!.item!) {
        var codeLength = item.code?.length ?? 0;
        if (codeLength >= 1) {
          codeIndex = item.code!.indexWhere((coding) =>
              coding.code == Code('22017-8') &&
              coding.display == 'State defined narrative Narrative' &&
              coding.system == FhirUri('http://loinc.org'));
        }
      }
    }
    if (codeIndex == -1) {
      _freeTextItem = null;
    }
  }

  /// finds the index of the [linkId], and sets the current item using this
  /// value. It then gets the corresponding item in the QuestionnaireResponse,
  /// If the answer repeats (can hold multiple responses), it adds the answer.
  /// Otherwise, this means that the answer needs to be changed, so the answers
  /// are cleared before the new one is added.
  void setCurrentAnswer(String answer, String linkId, [bool remove = false]) {
    _index.value = _keys.indexOf(linkId);
    _setCurrentItem(_questionnaire.item!, 0);
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
  ///
  /// next increases the [_index] by 1, this allows [_setCurrentItem] to use the
  /// new index to locate the next Item based on the [_activeLinkId]
  void next() {
    final newIndex = _index.value + 1;
    _index.value = newIndex >= _keys.length ? 0 : newIndex;
    _setCurrentItem(_questionnaire.item!, 0);
    if (isFreeText) {
      next();
    }
  }

  /// next decreases the [_index] by 1, this allows [_setCurrentItem] to use the
  /// new index to locate the next Item based on the [_activeLinkId]
  void back() {
    final newIndex = _index.value - 1;
    _index.value = newIndex < 0 ? _keys.length - 1 : newIndex;
    _setCurrentItem(_questionnaire.item!, 0);
    if (isFreeText) {
      back();
    }
  }

  /// INIT - maybe I'll try putting all of the init methods down here together
  @override
  void onInit() {
    _initQuestionnaire(
        Get.arguments[0] is Questionnaire ? Get.arguments[0] : null);
    _initResponse(Get.arguments);
    _findLastAnsweredQuestion();
    _setCurrentItem(_questionnaire.item!, 0);
    super.onInit();
  }

  /// ensures that a Questionnaire has been passed, and initializes the
  /// questionnaire in that case
  void _initQuestionnaire(Questionnaire? questionnaire) => questionnaire == null
      ? throw Exception(
          'You must pass a FHIR Questionnaire to the Survey Controller!')
      : _questionnaire = Get.arguments[0];

  /// if there is a second argument, and it is a QuestionnaireResponse,
  /// assign it to the response, otherwise, initialize the response
  /// check to ensure _response.item isn't null, and then populate the
  /// _response.items for the whole questionnaire
  void _initResponse(List args) {
    _response = args.length == 2 && args[1] is QuestionnaireResponse
        ? args[1]
        : QuestionnaireResponse(
            status: QuestionnaireResponseStatus.in_progress,
            item: <QuestionnaireResponseItem>[]);
    if (_questionnaire.item != null) {
      if (_response.item == null) {
        _response = _response.copyWith(item: []);
      }
      _response = _response.copyWith(
          item: _createResponse(_questionnaire.item!, _response.item!));
    }
  }

  List<QuestionnaireResponseItem> _createResponse(
    List<QuestionnaireItem> items,
    List<QuestionnaireResponseItem> responses,
  ) {
    for (var item in items) {
      /// check to see if there is already a responseItem created for the
      /// response to that item
      var index =
          responses.indexWhere((response) => response.linkId == item.linkId);

      /// if not, create one
      if (index == -1) {
        responses.add(
            QuestionnaireResponseItem(linkId: item.linkId, text: item.text));

        /// and set the index to that last entry
        index = responses.length - 1;
      } else {
        /// this is not strictly necessary, it just ensures that the text of
        /// the item is the same in the Questionnaire and response
        responses[index] = responses[index].copyWith(text: item.text);
      }

      /// as long as the item isn't a group or display type, increase the total
      /// number of questions in the questionnaire
      if (item.type != QuestionnaireItemType.group &&
          item.type != QuestionnaireItemType.display) {
        _questionsTotal.value++;

        ///instantiate the answer if that hasn't been done yet
        if (responses[index].answer == null) {
          responses[index] = responses[index].copyWith(answer: []);
        }
      }

      /// add that item to the list of linkId/keys
      _keys.add(item.linkId!);

      /// check if there are subitems, if so, recursively call this function
      if (item.item != null) {
        if (responses[index].item == null) {
          responses[index] = responses[index].copyWith(item: []);
        }
        _createResponse(item.item!, responses[index].item!);
      }
    }
    return responses;
  }

  /// runs through the questionnaire backwards to forward, iteratively looping
  /// through _getAnswerItem, until it either reaches the beginning of the
  /// questionnaire, or finds the last answered question - this avoids having
  /// the questionnaire start at a skipped question instead of using the last
  /// answered one - ToDo: is this the way we should be traversing?
  void _findLastAnsweredQuestion() {
    var tempIndex = _keys.length - 1;
    var responseItem = _getAnswerItem(_keys[tempIndex], _response.item!);
    while (tempIndex >= 0 && (responseItem!.answer?.isEmpty ?? true)) {
      responseItem = _getAnswerItem(_keys[tempIndex], _response.item!);
      tempIndex--;
    }
    _index.value = tempIndex + 1;
  }
}
