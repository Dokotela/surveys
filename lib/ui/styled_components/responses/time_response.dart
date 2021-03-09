import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeResponse extends StatelessWidget {
  TimeResponse(this.setAnswer, List<String> initialAnswer) {
    initialValue = initialAnswer.isEmpty
        ? TimeOfDay.now()
        : TimeOfDay.fromDateTime(
            DateTime.tryParse(initialAnswer[0]) ?? DateTime.now());
  }

  final Function setAnswer;
  late final TimeOfDay initialValue;

  @override
  Widget build(BuildContext context) {
    Rx<TimeOfDay>? dateTime = Rx<TimeOfDay>();
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () => showTimePicker(
            context: Get.context!,
            initialTime: initialValue,
          ).then(
            (time) {
              if (time != null) {
                dateTime.value = time;
                setAnswer(dateTime.value.toString());
              }
            },
          ),
          child: Text('Click to Enter Time'),
        ),
        Obx(() => Text(dateTime.value?.toString() ?? initialValue.toString())),
      ],
    );
  }
}
