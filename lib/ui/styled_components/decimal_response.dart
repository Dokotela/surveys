import 'package:flutter/material.dart';

class DecimalResponse extends StatelessWidget {
  DecimalResponse(this.setAnswer, {this.initialValue});

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
