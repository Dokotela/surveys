import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '_internal/constants/constants.dart';
import 'ui/views/survey_view.dart';

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
                      onPressed: () => Get.to(
                            () => SurveyView(),
                            arguments: [testQuestionnaire],
                          ),
                      child: Text('Test Questionnaire')),
                  ElevatedButton(
                      onPressed: () => Get.to(
                            () => SurveyView(),
                            arguments: [Questionnaire.fromJson(prapareSurvey)],
                          ),
                      child: Text('Prapare Questionnaire')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
