import 'package:fhir/r4.dart';

void addAnswer(
  String answer,
  QuestionnaireResponseItem responseAnswer,
  QuestionnaireItem? _currentItem,
  bool remove,
) {
  switch (_currentItem?.type) {
    case QuestionnaireItemType.boolean:
      {
        responseAnswer.answer!.add(QuestionnaireResponseAnswer(
            valueBoolean: Boolean(answer.toString())));
      }
      break;
    case QuestionnaireItemType.integer:
      {
        responseAnswer.answer!.add(QuestionnaireResponseAnswer(
            valueInteger: Integer(answer.toString())));
      }
      break;
    case QuestionnaireItemType.decimal:
      {
        responseAnswer.answer!.add(QuestionnaireResponseAnswer(
            valueDecimal: Decimal(answer.toString())));
      }
      break;
    case QuestionnaireItemType.text:
      {
        responseAnswer.answer!
            .add(QuestionnaireResponseAnswer(valueString: answer.toString()));
      }
      break;
    case QuestionnaireItemType.string:
      {
        responseAnswer.answer!
            .add(QuestionnaireResponseAnswer(valueString: answer.toString()));
      }
      break;
    case QuestionnaireItemType.date:
      {
        responseAnswer.answer!.add(
            QuestionnaireResponseAnswer(valueDate: Date(answer.toString())));
      }
      break;
    case QuestionnaireItemType.datetime:
      {
        responseAnswer.answer!.add(QuestionnaireResponseAnswer(
            valueDateTime: FhirDateTime(answer.toString())));
      }
      break;
    case QuestionnaireItemType.time:
      {
        responseAnswer.answer!.add(
            QuestionnaireResponseAnswer(valueTime: Time(answer.toString())));
      }
      break;
    case QuestionnaireItemType.choice:
      {
        if (remove) {
          responseAnswer.answer!.remove(QuestionnaireResponseAnswer(
              valueCoding: _currentItem!.answerOption!
                  .firstWhere(
                      (element) => element.valueCoding?.display == answer)
                  .valueCoding));
        } else {
          responseAnswer.answer!.add(QuestionnaireResponseAnswer(
              valueCoding: _currentItem!.answerOption!
                  .firstWhere(
                      (element) => element.valueCoding?.display == answer)
                  .valueCoding));
        }
      }
      break;
    default:
      print(_currentItem?.type);
      break;
  }
}
