import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeResponse extends StatelessWidget {
  DateTimeResponse(this.setAnswer, List<String> initialAnswer, this.linkId) {
    initialDate = initialAnswer.isEmpty
        ? DateTime.now()
        : DateTime.tryParse(initialAnswer[0]) ?? DateTime.now();
    initialTime = initialAnswer.isEmpty
        ? TimeOfDay.now()
        : TimeOfDay.fromDateTime(
            DateTime.tryParse(initialAnswer[0]) ?? DateTime.now());
  }

  final Function setAnswer;
  late final DateTime initialDate;
  late final TimeOfDay initialTime;
  final String? linkId;

  @override
  Widget build(BuildContext context) {
    Rx<DateTime>? dateTime = initialDate.obs;
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
            initialDate: initialDate,
            firstDate: DateTime(1900, 1, 1),
            lastDate: DateTime(2999, 12, 31),
          ).then(
            (date) {
              if (date != null) {
                dateTime.value = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  dateTime.value.hour,
                  dateTime.value.minute,
                );
                setAnswer(
                  dateTime.value.toIso8601String(),
                  linkId,
                );
              }
            },
          ),
          child: Text('Click to Enter Date'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () => showTimePicker(
            context: Get.context!,
            initialTime: initialTime,
          ).then(
            (time) {
              if (time != null) {
                dateTime.value = DateTime(
                  dateTime.value.year,
                  dateTime.value.month,
                  dateTime.value.day,
                  time.hour,
                  time.minute,
                );
                setAnswer(
                  dateTime.value.toIso8601String(),
                  linkId,
                );
              }
            },
          ),
          child: Text('Click to Enter Time'),
        ),
        Obx(() => Text(dateTime.value.toIso8601String(),
            style: TextStyle(fontSize: 20))),
      ],
    );
  }
}
