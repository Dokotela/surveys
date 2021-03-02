import 'package:fhir/r4.dart';
import 'package:fhir_surveys/views/fhir_survey_view.dart';
import 'package:fhir_surveys/surveys/prapare.dart';
import 'package:flutter/material.dart';

import 'surveys/test_questionnaire.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                FhirSurveyView(survey: testQuestionnaire))),
                    child: Text('Test Questionnaire'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => FhirSurveyView(
                                survey:
                                    Questionnaire.fromJson(prapareSurvey)))),
                    child: Text('Prapare Questionnaire'),
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
