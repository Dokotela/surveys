import 'package:fhir/r4.dart';

class FhirSurvey {
  FhirSurvey({
    required this.questionnaire,
    this.response,
  }) {
    surveyItems = <SurveyItem>[];
    response ??= QuestionnaireResponse(
      status: QuestionnaireResponseStatus.in_progress,
      item: response?.item ?? <QuestionnaireResponseItem>[],
    );
    if (questionnaire.item != null) {
      _getItems(questionnaire.item!, response!.item!);
    }
  }

  void _getItems(List<QuestionnaireItem> items,
      List<QuestionnaireResponseItem>? responses) {
    for (final item in items) {
      surveyItems.add(
        SurveyItem.fromItem(
          item.copyWith(item: []),
          responses
              ?.firstWhere((response) => response.linkId == item.linkId,
                  orElse: () => QuestionnaireResponseItem(
                      linkId: item.linkId, text: item.text))
              .copyWith(item: []),
        ),
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

  /// fhir resource questionnaire
  final Questionnaire questionnaire;

  /// fhir generated response to questionnaire
  QuestionnaireResponse? response;

  /// list of our items that we're going to use for rendering
  late List<SurveyItem> surveyItems;
}

class SurveyItem {
  SurveyItem.fromItem(this.item, this.response);

  bool get required => item.required_?.value ?? false;
  bool get multipleAnswer => item.repeats?.value ?? false;
  String get linkId => item.linkId ?? '';
  String get text => '${item.prefix ?? ''} ${item.text ?? ''}';
  int get maxLength => item.maxLength?.value ?? 0;
  bool get completed => response?.answer?.isNotEmpty ?? false;

  final QuestionnaireItem item;
  QuestionnaireResponseItem? response;
}
