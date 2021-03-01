import 'package:fhir/r4.dart';
import 'package:fhir_surveys/fhir_survey_view.dart';
import 'package:fhir_surveys/prapare.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final questionnaire = Questionnaire.fromJson(prapareSurvey);
  // final questionnaire = testQuestionnaire;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FhirSurveyView(questionnaire),
    );
  }
}
