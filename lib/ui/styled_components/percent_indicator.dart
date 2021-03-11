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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 7.0,
          percent: index / total,
          center: Text(
            '${index + 1}/$total',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          header: Text(
            'Screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          progressColor: Colors.blue[900],
        ),
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 7.0,
          percent: percentComplete,
          center: Text(
            '${(percentComplete * 100).toInt()}%',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          header: Text(
            'Answered',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          progressColor: Colors.blue[900],
        )
      ],
    );
  }
}
