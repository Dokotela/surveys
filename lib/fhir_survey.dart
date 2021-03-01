import 'package:fhir/r4.dart';

class FhirSurvey {
  FhirSurvey({
    required this.questionnaire,
    this.response,
  }) {
    surveyItems = <SurveyItem>[];
    if (questionnaire.item != null) {
      _getItems(questionnaire.item!);
    }
  }

  void _getItems(List<QuestionnaireItem> items) {
    for (final item in items) {
      surveyItems.add(SurveyItem.fromItem(item));
      if (item.item != null) {
        _getItems(item.item!);
      }
    }
  }

  /// fhir resource questionnaire
  final Questionnaire questionnaire;

  /// fhir generated response to questionnaire
  QuestionnaireResponse? response;

  late List<SurveyItem> surveyItems;

  int index = 0;
}

class SurveyItem {
  SurveyItem.fromItem(this.item);

  bool get required => item.required_?.value ?? false;
  bool get multipleAnswer => item.repeats?.value ?? false;
  String get linkId => item.linkId ?? '';
  String get text => '${item.prefix ?? ''} ${item.text ?? ''}';
  int get maxLength => item.maxLength?.value ?? 0;

  final QuestionnaireItem item;
}
