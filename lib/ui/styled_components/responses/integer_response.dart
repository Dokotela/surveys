import 'package:flutter/material.dart';

class IntegerResponse extends StatelessWidget {
  IntegerResponse(this.setAnswer, {this.initialValue});

  final Function setAnswer;
  final TextEditingController controller = TextEditingController();
  final String? initialValue;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (text) => setAnswer(text),
        keyboardType: TextInputType.number,
        initialValue: initialValue,
      );
}
