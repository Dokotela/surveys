import 'package:fhir/r4.dart';

List<String> initialAnswer({
  List<QuestionnaireInitial>? initialResponse,
  QuestionnaireItemType? type,
  required List<QuestionnaireResponseAnswer> responseAnswer,
}) {
  if (initialResponse == null) {
    if (responseAnswer.isEmpty) {
      return <String>[];
    }
  } else if (initialResponse.isEmpty && responseAnswer.isEmpty) {
    return <String>[];
  }
  switch (type) {
    case QuestionnaireItemType.boolean:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueBoolean != null) {
            return [responseAnswer[0].valueBoolean.toString()];
          }
        }
        if (initialResponse?[0].valueBoolean != null) {
          return [initialResponse![0].valueBoolean.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.integer:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueInteger != null) {
            return [responseAnswer[0].valueInteger.toString()];
          }
        }
        if (initialResponse?[0].valueInteger != null) {
          return [initialResponse![0].valueInteger.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.decimal:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueDecimal != null) {
            return [responseAnswer[0].valueDecimal.toString()];
          }
        }
        if (initialResponse?[0].valueDecimal != null) {
          return [initialResponse![0].valueDecimal.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.text:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueString != null) {
            return [responseAnswer[0].valueString.toString()];
          }
        }
        if (initialResponse?[0].valueString != null) {
          return [initialResponse![0].valueString.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.string:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueString != null) {
            return [responseAnswer[0].valueString.toString()];
          }
        }
        if (initialResponse?[0].valueString != null) {
          return [initialResponse![0].valueString.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.date:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueDate != null) {
            return [responseAnswer[0].valueDate.toString()];
          }
        }
        if (initialResponse?[0].valueDate != null) {
          return [initialResponse![0].valueDate.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.datetime:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueDateTime != null) {
            return [responseAnswer[0].valueDateTime.toString()];
          }
        }
        if (initialResponse?[0].valueDateTime != null) {
          return [initialResponse![0].valueDateTime.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.time:
      {
        if (responseAnswer.isNotEmpty) {
          if (responseAnswer[0].valueTime != null) {
            return [responseAnswer[0].valueTime.toString()];
          }
        }
        if (initialResponse?[0].valueTime != null) {
          return [initialResponse![0].valueTime.toString()];
        }
        return <String>[];
      }
    case QuestionnaireItemType.choice:
      {
        final answerStrings = <String>[];
        if (responseAnswer.isNotEmpty) {
          for (var answer in responseAnswer) {
            if (answer.valueCoding?.display != null) {
              answerStrings.add(answer.valueCoding!.display!);
            }
          }
        } else {
          for (var response in initialResponse!) {
            if (response.valueCoding?.display != null) {
              answerStrings.add(response.valueCoding!.display!);
            }
          }
        }
        return answerStrings;
      }
    default:
      print(type);
      break;
  }
  return <String>[];
}
