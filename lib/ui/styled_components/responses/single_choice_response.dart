import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleChoiceResponse extends StatelessWidget {
  SingleChoiceResponse(this.setAnswer, this.answers);

  final Function setAnswer;
  final List<String> answers;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<RadioListTile> options = [];
    final Rx<int> choice = Rx<int>(-1);

    for (var i = 0; i < answers.length; i++) {
      if (answers.isNotEmpty) {
        options.add(
          RadioListTile(
            title: Text(answers[i]),
            value: i,
            groupValue: choice.value,
            onChanged: (changed) {
              setAnswer(answers[i]);
              choice.value = i;
            },
          ),
        );
      }
    }
    return Column(children: options);
  }
}
