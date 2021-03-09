import 'package:fhir/r4.dart';
import 'package:fhir_surveys/controllers/survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'styled_components.dart';

class DisplayQuestion extends StatelessWidget {
  final SurveyController controller = Get.find();

  StatelessWidget _byType() {
    switch (controller.type) {
      case QuestionnaireItemType.boolean:
        return BooleanResponse(controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.choice:
        {
          if (controller.multipleChoice) {
            return MultipleChoiceResponse(controller.setCurrentAnswer,
                controller.choiceResponses, controller.initial);
          } else {
            return SingleChoiceResponse(controller.setCurrentAnswer,
                controller.choiceResponses, controller.initial);
          }
        }
      case QuestionnaireItemType.date:
        return DateResponse(controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.datetime:
        return DateTimeResponse(
            controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.decimal:
        return DecimalResponse(controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.integer:
        return IntegerResponse(controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.string:
        return StringResponse(controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.text:
        return TextResponse(controller.setCurrentAnswer, controller.initial);

      case QuestionnaireItemType.time:
        return TimeResponse(controller.setCurrentAnswer, controller.initial);

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return controller.type == QuestionnaireItemType.group
        ? Center(
            child: Text(
            controller.text,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ))
        : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: Get.height * .03),
                Text(controller.groupText, style: TextStyle(fontSize: 24)),
                Container(height: Get.height * .03),
                Text(controller.text, style: TextStyle(fontSize: 18)),
                Expanded(child: SingleChildScrollView(child: _byType())),
              ],
            ),
          );
  }
}
