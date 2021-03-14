import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooleanResponse extends StatelessWidget {
  BooleanResponse(this.setAnswer, this.initialAnswer, this.linkId);

  final Function setAnswer;
  final List<String> initialAnswer;
  final TextEditingController controller = TextEditingController();
  final String? linkId;

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
            title: Text('True', style: TextStyle(fontSize: 20)),
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
            title: Text('False', style: TextStyle(fontSize: 20)),
            leading: Radio(
              value: false,
              groupValue: boolean.value,
              onChanged: (newBool) {
                setAnswer('False', linkId);
                boolean.value = false;
              },
            ),
          ),
        ],
      ),
    );
  }
}
