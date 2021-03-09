import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  PercentIndicator(this.index, this.total, this.percentComplete);

  final int index;
  final int total;
  final double percentComplete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: index / total,
          footer: Text(
            'Screen\n'
            '${index + 1}/$total',
          ),
          progressColor: Colors.green,
        ),
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: percentComplete,
          footer: Text('${(percentComplete * 100).toInt()}'
              '%\nComplete'),
          progressColor: Colors.green,
        )
      ],
    );
  }
}
