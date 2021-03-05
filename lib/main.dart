import 'package:fhir/r4.dart';
import 'package:fhir_surveys/views/survey_view.dart';
import 'package:fhir_surveys/surveys/prapare.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'surveys/test_questionnaire.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(home: HomePage());
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
                      onPressed: () => Get.to(TempView()),
                      child: Text('Temporary View')),
                  ElevatedButton(
                      onPressed: () => Get.to(() => SurveyView(),
                          arguments: [testQuestionnaire]),
                      child: Text('Test Questionnaire')),
                  ElevatedButton(
                      onPressed: () => Get.to(SurveyView(),
                          arguments: [Questionnaire.fromJson(prapareSurvey)]),
                      child: Text('Prapare Questionnaire'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TempView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Something or other');
  }
}
