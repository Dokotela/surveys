import 'package:fhir_surveys/controllers/survey_controller.dart';
import 'package:fhir_surveys/ui/views/survey_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SurveyView extends StatelessWidget {
  final controller = Get.put(SurveyController());
  final viewController = Get.put(SurveyViewController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 5.0,
                      percent: controller!.index / controller!.total,
                      footer: Text(
                        'Screen\n'
                        '${controller!.index + 1}/${controller!.total}',
                      ),
                      progressColor: Colors.green,
                    ),
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 5.0,
                      percent: controller!.percentComplete,
                      footer: Text('${controller!.percentComplete.toInt()}'
                          '%\nComplete'),
                      progressColor: Colors.green,
                    )
                  ],
                ),
                Text(controller!.text, style: TextStyle(fontSize: 24)),
                Expanded(
                    child: SingleChildScrollView(
                        child: viewController!.answers())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller!.back(),
                      child: Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: () => controller!.next(),
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
