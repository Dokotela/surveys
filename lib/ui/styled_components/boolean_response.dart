import 'package:flutter/material.dart';

class BooleanResponse extends StatelessWidget {
  BooleanResponse(this.setAnswer);

  final Function setAnswer;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: (text) => setAnswer(text),
      );
}
