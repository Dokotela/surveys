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
  var _curAnswer = '';

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

  int get index => _index.value;
  int get total => _surveyItems.keys.length;
  String get text => _surveyItems[_keys[_index.value]]?.text ?? '';
  QuestionnaireItemType? get type =>
      _surveyItems[_keys[_index.value]]?.item.type;
  List<QuestionnaireAnswerOption>? get answers =>
      _surveyItems[_keys[_index.value]]?.item.answerOption;

  /// SETTER FUNCTIONS
  void setCurrentAnswer(String answer) {
    print(answer);
    _curAnswer = answer;
  }

  void next() {
    print(_curAnswer);
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
