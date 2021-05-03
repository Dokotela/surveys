import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateResponse extends StatelessWidget {
  DateResponse(this.setAnswer, List<String> initialAnswer, this.linkId) {
    initialValue = initialAnswer.isEmpty
        ? DateTime.now()
        : DateTime.tryParse(initialAnswer[0]) ?? DateTime.now();
  }

  final Function setAnswer;
  late final DateTime initialValue;
  final String? linkId;

  @override
  Widget build(BuildContext context) {
    Rx<DateTime>? dateTime = initialValue.obs;
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
                setAnswer(dateTime.value.toIso8601String());
              }
            },
          ),
          child: Text('Click to Enter Date'),
        ),
        Obx(() => Text(dateTime.value.toIso8601String(),
            style: TextStyle(fontSize: 20))),
      ],
    );
  }
}
