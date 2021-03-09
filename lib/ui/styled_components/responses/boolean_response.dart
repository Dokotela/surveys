import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooleanResponse extends StatelessWidget {
  BooleanResponse(this.setAnswer, this.initialAnswer);

  final Function setAnswer;
  final List<String> initialAnswer;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Rx<bool> boolean = initialAnswer.isEmpty
        ? Rx<bool>()
        : initialAnswer[0].toLowerCase() == 'true'
            ? Rx<bool>(true)
            : initialAnswer[0].toLowerCase() == 'false'
                ? Rx<bool>(false)
                : Rx<bool>();
    return Obx(
      () => Column(
        children: [
          ListTile(
            title: Text('True'),
            leading: Radio(
              value: true,
              groupValue: boolean.value,
              onChanged: (newBool) {
                setAnswer('True');
                boolean.value = true;
              },
            ),
          ),
          ListTile(
            title: Text('False'),
            leading: Radio(
              value: false,
              groupValue: boolean.value,
              onChanged: (newBool) {
                setAnswer('False');
                boolean.value = false;
              },
            ),
          ),
        ],
      ),
    );
  }
}
