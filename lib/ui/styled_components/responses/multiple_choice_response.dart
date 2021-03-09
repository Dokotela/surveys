import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleChoiceResponse extends StatelessWidget {
  MultipleChoiceResponse(this.setAnswer, this.answers, this.initialAnswer);

  final Function setAnswer;
  final List<String> answers;
  final List<String> initialAnswer;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [];
    final choice = <RxBool>[];
    bool _getChoice(int i) => choice[i].value!;

    for (var i = 0; i < answers.length; i++) {
      if (answers.isNotEmpty) {
        if (initialAnswer.indexWhere((element) => element == answers[i]) ==
            -1) {
          choice.add(false.obs);
        } else {
          choice.add(true.obs);
        }

        options.add(
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: _getChoice(i),
                  onChanged: (changed) {
                    if (changed ?? false) {
                      setAnswer(answers[i]);
                    } else {
                      setAnswer(answers[i], true);
                    }
                    choice[i].value = changed ?? false;
                  },
                ),
              ),
              Text(answers[i]),
            ],
          ),
        );
      }
    }
    return Column(children: options);
  }
}
