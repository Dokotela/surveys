import 'package:fhir/r4.dart';
import 'package:fhir_surveys/models/survey_item.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  /// PROPERTIES
  late Map<String, SurveyItem> _surveyItems = {};
  final _index = 0.obs;
  List<String> _keys = [];
  late Questionnaire _questionnaire;
  QuestionnaireResponse? _response;

  @override
  void onInit() {
    _questionnaire = Get.arguments[0];
    _response = Get.arguments.length == 2
        ? Get.arguments[1]
        : QuestionnaireResponse(
            status: QuestionnaireResponseStatus.in_progress,
            item: <QuestionnaireResponseItem>[]);
    if (_questionnaire.item != null) {
      _getItems(_questionnaire.item!, _response?.item);
    }
    _keys.addAll(_surveyItems.keys);
    super.onInit();
  }

  /// GETTER FUNCTIONS
  double get percentComplete {
    int complete = 0;
    _surveyItems.forEach((k, v) {
      if (v.response?.answer != null) {
        if (v.response!.answer!.isNotEmpty) {
          complete++;
        }
      }
    });
    return complete / _surveyItems.keys.length;
  }

  SurveyItem? get _curSurveyItem => _surveyItems[_keys[_index.value]];
  int get index => _index.value;
  int get total => _surveyItems.keys.length;
  String get text => _surveyItems[_keys[_index.value]]?.text ?? '';
  QuestionnaireItemType? get type =>
      _surveyItems[_keys[_index.value]]?.item.type;
  List<String> get choiceResponses {
    final returnStrings = <String>[];
    if (_surveyItems[_keys[_index.value]]?.item.answerOption != null) {
      for (var answer
          in _surveyItems[_keys[_index.value]]!.item.answerOption!) {
        returnStrings.add(answer.valueCoding?.display ?? '');
      }
    }
    return returnStrings;
  }

  /// SETTER FUNCTIONS
  void setCurrentAnswer(String answer) {
    if (_curSurveyItem?.item.type == QuestionnaireItemType.choice) {
      _curSurveyItem!.response ??= QuestionnaireResponseItem(item: []);
      _curSurveyItem!.response!.item!.clear();
      _curSurveyItem!.response!.item!.add(QuestionnaireResponseItem(answer: [
        QuestionnaireResponseAnswer(
            valueCoding: _curSurveyItem!.item.answerOption!
                .firstWhere((element) => element.valueCoding?.display == answer)
                .valueCoding)
      ]));
    }
    print(_curSurveyItem!.response!.toJson());
  }

  // "answerBoolean" : <boolean>
  // "answerDecimal" : <decimal>
  // "answerInteger" : <integer>
  // "answerDate" : "<date>"
  // "answerDateTime" : "<dateTime>"
  // "answerTime" : "<time>"
  // "answerString" : "<string>"
  // "answerCoding" : { Coding }
  // "answerQuantity" : { Quantity }
  // "answerReference" : { Reference(Any) }

  void next() {
    _index.value = _index.value + 1 >= _keys.length ? 0 : _index.value + 1;
  }

  void back() =>
      _index.value = _index.value - 1 < 0 ? _keys.length - 1 : _index.value - 1;

  void _getItems(
    List<QuestionnaireItem> items,
    List<QuestionnaireResponseItem>? responses,
  ) {
    for (final item in items) {
      _surveyItems[item.linkId ?? '${_surveyItems.keys.length}'] =
          SurveyItem.fromItem(
        item.copyWith(item: []),
        responses
            ?.firstWhere((response) => response.linkId == item.linkId,
                orElse: () => QuestionnaireResponseItem(
                    linkId: item.linkId, text: item.text))
            .copyWith(item: []),
      );
      if (item.item != null) {
        _getItems(
            item.item!,
            responses
                ?.firstWhere((response) => response.linkId == item.linkId,
                    orElse: () => QuestionnaireResponseItem())
                .item);
      }
    }
  }
}
