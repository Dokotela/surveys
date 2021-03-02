import 'package:fhir/r4.dart';
import 'package:fhir_surveys/controller/questionnaire_controller.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FhirSurveyView extends StatelessWidget {
  FhirSurveyView(
      {Questionnaire? survey, QuestionnaireController? newController}) {
    controller =
        newController ?? QuestionnaireController(questionnaire: survey);
  }

  late QuestionnaireController controller;

  @override
  Widget build(BuildContext context) {
    print(controller.index);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5.0,
                    percent: controller.index / controller.total,
                    footer: Text(
                      'Screen\n'
                      '${controller.index}/${controller.total}',
                    ),
                    progressColor: Colors.green,
                  ),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5.0,
                    percent: controller.percentComplete,
                    footer: Text('${controller.percentComplete.toInt()}'
                        '%\nComplete'),
                    progressColor: Colors.green,
                  )
                ],
              ),
              Text(controller.text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      controller.back();
                      return FhirSurveyView(newController: controller);
                    })),
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      controller.next();
                      return FhirSurveyView(newController: controller);
                    })),
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
