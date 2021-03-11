import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateResponse extends StatelessWidget {
  DateResponse(this.setAnswer, List<String> initialAnswer) {
    initialValue = initialAnswer.isEmpty
        ? DateTime.now()
        : DateTime.tryParse(initialAnswer[0]) ?? DateTime.now();
  }

  final Function setAnswer;
  late final DateTime initialValue;

  @override
  Widget build(BuildContext context) {
    Rx<DateTime>? dateTime = Rx<DateTime>();
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () => showDatePicker(
            context: Get.context!,
            initialDate: initialValue,
            firstDate: DateTime(1900, 1, 1),
            lastDate: DateTime(2999, 12, 31),
          ).then(
            (date) {
              if (date != null) {
                dateTime.value = date;
                setAnswer(dateTime.value?.toIso8601String() ?? initialValue);
              }
            },
          ),
          child: Text('Click to Enter Date'),
        ),
        Obx(() => Text(
            dateTime.value?.toIso8601String() ?? initialValue.toIso8601String(),
            style: TextStyle(fontSize: 20))),
      ],
    );
  }
}
