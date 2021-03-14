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
        return BooleanResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      case QuestionnaireItemType.choice:
        {
          if (controller.multipleChoice) {
            return MultipleChoiceResponse(
              controller.setCurrentAnswer,
              controller.choiceResponses,
              controller.initial,
              controller.linkId,
              controller.freeText != null
                  ? TextResponse(
                      controller.setCurrentAnswer,
                      controller.initialFreeText(controller.freeText!.linkId!),
                      controller.freeText!.linkId,
                      controller.freeText!.text,
                    )
                  : null,
            );
          } else {
            return SingleChoiceResponse(
              controller.setCurrentAnswer,
              controller.choiceResponses,
              controller.initial,
              controller.linkId,
              controller.freeText != null
                  ? TextResponse(
                      controller.setCurrentAnswer,
                      controller.initialFreeText(controller.freeText!.linkId!),
                      controller.freeText!.linkId,
                      controller.freeText!.text,
                    )
                  : null,
            );
          }
        }
      case QuestionnaireItemType.date:
        return DateResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      case QuestionnaireItemType.datetime:
        return DateTimeResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      case QuestionnaireItemType.decimal:
        return DecimalResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      case QuestionnaireItemType.integer:
        return IntegerResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      case QuestionnaireItemType.string:
        return StringResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      case QuestionnaireItemType.text:
        return TextResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
          controller.text,
        );

      case QuestionnaireItemType.time:
        return TimeResponse(
          controller.setCurrentAnswer,
          controller.initial,
          controller.linkId,
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: controller.type == QuestionnaireItemType.group
                ? Center(
                    child: Text(
                    controller.text,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: Get.height * .03),
                        Text(controller.groupText,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(height: Get.height * .03),
                        Text(controller.text, style: TextStyle(fontSize: 24)),
                        Expanded(
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                              child: _byType(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      );
}
