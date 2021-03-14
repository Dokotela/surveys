import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleChoiceResponse extends StatelessWidget {
  SingleChoiceResponse(
    this.setAnswer,
    this.answers,
    this.initialAnswer,
    this.linkId,
    this.freeText,
  );

  final Function setAnswer;
  final List<String> answers;
  final List<String> initialAnswer;
  final TextEditingController controller = TextEditingController();
  final String? linkId;
  final Widget? freeText;

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [];
    final Rx<int> choice = Rx<int>(
      answers.indexWhere((element) =>
          initialAnswer.isEmpty ? false : element == initialAnswer[0]),
    );

    for (var i = 0; i < answers.length; i++) {
      if (answers.isNotEmpty) {
        options.add(
          Obx(
            () => RadioListTile(
              title: Text(answers[i], style: TextStyle(fontSize: 20)),
              value: i,
              groupValue: choice.value,
              onChanged: (changed) {
                setAnswer(answers[i], linkId);
                choice.value = i;
              },
            ),
          ),
        );
      }
    }
    return Column(children: options);
  }
}
