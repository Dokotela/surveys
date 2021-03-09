import 'package:fhir/r4.dart';

final boolQuestionnaire = Questionnaire(
  name: 'bool_questionnaire',
  title: 'Boolean Questionnaire',
  item: [
    QuestionnaireItem(
      linkId: 'bool1',
      text: 'Are you alive?',
      type: QuestionnaireItemType.boolean,
    ),
  ],
);
