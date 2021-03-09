import 'package:flutter/material.dart';

class TextResponse extends StatelessWidget {
  TextResponse(this.setAnswer, {this.initialValue});

  final Function setAnswer;
  final TextEditingController controller = TextEditingController();
  final String? initialValue;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (text) => setAnswer(text),
        initialValue: initialValue,
      );
}
