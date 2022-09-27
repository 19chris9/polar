import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'models/sleep.dart';

class SleepDetails extends StatefulWidget {
  final Night night;
  var details = new Map();
  SleepDetails({Key? key, required this.night}) : super(key: key);

  @override
  State<SleepDetails> createState() => _SleepDetailsState();
}

class _SleepDetailsState extends State<SleepDetails> {
  @override
  void initState() {
    widget.details['Sleep Start Time'] =
        (widget.night.sleepStartTime.toString());
    widget.details['Sleep End Time'] = (widget.night.sleepEndTime.toString());
    widget.details['Light sleep'] =
        ((widget.night.lightSleep / 60).toInt().toString() + ' min');
    widget.details['Deep sleep'] =
        ((widget.night.deepSleep / 60).toInt().toString() + ' min');
    widget.details['Rem sleep'] =
        ((widget.night.remSleep / 60).toInt().toString() + ' min');
    widget.details['Total Interruption Duration'] =
        ((widget.night.totalInterruptionDuration / 60).toInt().toString() +
            ' min');
    widget.details['Short Interruption Duration'] =
        ((widget.night.shortInterruptionDuration / 60).toInt().toString() +
            ' min');
    widget.details['Long Interruption Duration'] =
        ((widget.night.longInterruptionDuration / 60).toInt().toString() +
            ' min');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage("assets/images/moon.jpg"),
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(40.0),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
                child: Center(
                  child: topContentText(),
                ),
              ),
              Positioned(
                left: 8.0,
                top: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              children: bottomContentText(),
            ),
          ),
        ],
      ),
    );
  }

  Widget topContentText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.bed,
          color: widget.night.backgroundcolor,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          '${widget.night.date.day}-${widget.night.date.month}-${widget.night.date.year}',
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: LinearProgressIndicator(
                    value: widget.night.sleepScore / 100)),
            Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${widget.night.sleepScore}',
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );
  }

  List<Widget> bottomContentText() {
    List<Widget> l = [];
    widget.details.forEach((k, v) => l.add(ListTile(
          title: Text(v),
          subtitle: Text(k),
        )));
    return l;
  }
}
