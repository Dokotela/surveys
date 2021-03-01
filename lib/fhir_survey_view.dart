import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'fhir_survey.dart';

class FhirSurveyView extends StatelessWidget {
  FhirSurveyView(this.questionnaire);

  final Questionnaire questionnaire;

  @override
  Widget build(BuildContext context) {
    final fhirSurvey = FhirSurvey(questionnaire: questionnaire);
    return SafeArea(
      child: Scaffold(
        body: FhirSurveyDisplay(fhirSurvey, 0),
      ),
    );
  }
}

class FhirSurveyDisplay extends StatelessWidget {
  FhirSurveyDisplay(this.survey, this.index);

  final FhirSurvey survey;
  final int index;

  @override
  Widget build(BuildContext context) {
    print(index);
    print(survey.surveyItems.length);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: index / survey.surveyItems.length,
                  center: new Text(
                      '${((index / survey.surveyItems.length) * 100).toInt()}%'),
                  progressColor: Colors.green,
                )
              ],
            ),
            Text(survey.surveyItems[index].text),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FhirSurveyDisplay(
                          survey,
                          index - 1 < 0
                              ? survey.surveyItems.length - 1
                              : index - 1))),
                  icon: Icon(Icons.forward),
                  label: Text('Back'),
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FhirSurveyDisplay(
                          survey,
                          index + 1 >= survey.surveyItems.length
                              ? 0
                              : index + 1))),
                  icon: Icon(Icons.forward),
                  label: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
