import 'package:flutter/material.dart';

class DecimalResponse extends StatelessWidget {
  DecimalResponse(this.setAnswer, List<String> initialAnswer) {
    controller = TextEditingController(
        text: initialAnswer.isEmpty
            ? null
            : double.tryParse(initialAnswer[0])?.toString());
  }

  final Function setAnswer;
  late final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (text) => setAnswer(text),
        keyboardType: TextInputType.number,
      );
}
