import 'package:fhir/r4.dart';
import 'package:fhir_surveys/controllers/survey_controller.dart';
import 'package:fhir_surveys/ui/styled_components/styled_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyViewController extends GetxController {
  SurveyController controller = Get.find();

  StatelessWidget answers() {
    switch (controller.type) {
      case QuestionnaireItemType.boolean:
        return BooleanResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.choice:
        return ChoiceResponse(
            controller.setCurrentAnswer, controller.choiceResponses);

      case QuestionnaireItemType.date:
        return DateResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.datetime:
        return DateTimeResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.decimal:
        return DecimalResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.integer:
        return IntegerResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.string:
        return StringResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.text:
        return TextResponse(controller.setCurrentAnswer);

      case QuestionnaireItemType.time:
        return TimeResponse(controller.setCurrentAnswer);

      default:
        return Container();
    }
  }
}
