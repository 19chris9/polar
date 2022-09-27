import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:polar/models/exercise.dart';
import 'models/sleep.dart';
import 'sleepDetails.dart';

class ExWidget extends StatelessWidget {
  final Night night;

  const ExWidget({Key? key, required this.night}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SleepDetails(night: night))),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: night.backgroundcolor,
            borderRadius: BorderRadius.circular(16)),
        height: 100,
        child: Row(
          children: [
            Expanded(flex: 3, child: buildText()),
            Expanded(
                child: LinearProgressIndicator(value: night.sleepScore / 100))
          ],
        ),
      ),
    );
  }

  Widget buildText() {
    var date = DateTime(night.date.year, night.date.month, night.date.day);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sleep Score: ${night.sleepScore}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        SizedBox(
          height: 10,
        ),
        Text('${date.day}-${date.month}-${date.year}')
      ],
    );
  }
}
