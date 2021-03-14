import 'package:flutter/material.dart';

class IntegerResponse extends StatelessWidget {
  IntegerResponse(this.setAnswer, List<String> initialAnswer, this.linkId) {
    controller = TextEditingController(
        text: initialAnswer.isEmpty
            ? null
            : int.tryParse(initialAnswer[0])?.toString());
  }

  final Function setAnswer;
  late final TextEditingController controller;
  final String? linkId;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (text) => setAnswer(text, linkId),
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20),
      );
}
