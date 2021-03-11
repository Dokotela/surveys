import 'package:flutter/material.dart';

class TextResponse extends StatelessWidget {
  TextResponse(this.setAnswer, List<String> initialAnswer) {
    controller = TextEditingController(
        text: initialAnswer.isEmpty ? null : initialAnswer[0]);
  }

  final Function setAnswer;
  late final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (text) => setAnswer(text),
        style: TextStyle(fontSize: 20),
      );
}
