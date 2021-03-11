import 'package:fhir_surveys/controllers/survey_controller.dart';
import 'package:fhir_surveys/ui/styled_components/percent_indicator.dart';
import 'package:fhir_surveys/ui/styled_components/styled_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyView extends StatelessWidget {
  final controller = Get.put(SurveyController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blue[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PercentIndicator(
                    controller!.index,
                    controller!.totalScreens,
                    controller!.percentComplete,
                  ),
                  Container(height: Get.height * .02),
                  DisplayQuestion(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () => controller!.back(),
                          child: Text('Back', style: TextStyle(fontSize: 24))),
                      ElevatedButton(
                          onPressed: () => controller!.next(),
                          child: Text('Next', style: TextStyle(fontSize: 24))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
