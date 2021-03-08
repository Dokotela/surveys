import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceResponse extends StatelessWidget {
  ChoiceResponse(this.setAnswer, this.answers);

  final Function setAnswer;
  final List<String> answers;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ListTile> options = [];
    final Rx<int> choice = Rx<int>(-1);

    for (var i = 0; i < answers.length; i++) {
      if (answers.isNotEmpty) {
        options.add(
          ListTile(
            title: Text(answers[i]),
            leading: Obx(
              () => Radio(
                value: i,
                groupValue: choice.value,
                onChanged: (changed) {
                  setAnswer(answers[i]);
                  choice.value = i;
                },
              ),
            ),
          ),
        );
      }
    }
    return Column(children: options);
  }
}
