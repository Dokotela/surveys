import 'package:fhir/r4.dart';

import '../model/survey_item.dart';

class QuestionnaireController {
  QuestionnaireController({required questionnaire, response}) {
    _questionnaire = questionnaire;
    response = response ??
        QuestionnaireResponse(
            status: QuestionnaireResponseStatus.in_progress,
            item: <QuestionnaireResponseItem>[]);
    if (_questionnaire.item != null) {
      _getItems(_questionnaire.item!, response.item);
    }
  }

  /// PROPERTIES
  late Questionnaire _questionnaire;
  late QuestionnaireResponse response;
  late Map<String, SurveyItem> surveyItems = {};
  int _index = 0;

  double get percentComplete {
    int complete = 0;
    surveyItems.forEach((k, v) {
      if (v.response?.answer != null) {
        if (v.response!.answer!.isNotEmpty) {
          complete++;
        }
      }
    });
    return complete / surveyItems.keys.length;
  }

  int get index => _index;
  int get total => surveyItems.keys.length;
  String get text => surveyItems[surveyItems.keys.toList()[_index]]?.text ?? '';

  void next() =>
      _index = _index + 1 >= surveyItems.keys.length ? 0 : _index + 1;
  void back() =>
      _index = _index - 1 < 0 ? surveyItems.keys.length - 1 : _index - 1;

  void _getItems(
    List<QuestionnaireItem> items,
    List<QuestionnaireResponseItem>? responses,
  ) {
    for (final item in items) {
      surveyItems[item.linkId ?? '${surveyItems.keys.length}'] =
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
