import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dashboard.dart';
import 'models/sleep.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlSpot>>(
        future: create_sleep_list(),
        builder: (BuildContext context, AsyncSnapshot<List<FlSpot>> snapshot) {
          if (snapshot.hasData) {
            return LineChart(
              LineChartData(
                minX: 0,
                maxX: 31,
                minY: 0,
                maxY: 100,
              ),
            );
          }
          return Text('lol');
        });
  }

  Future<List<FlSpot>> create_sleep_list() async {
    List<FlSpot> list = [];
    DateTime now = DateTime.now();
    DateTime currentMonth = DateTime(now.month);
    Sleep sleepData = await get_sleep_data();
    for (var night in sleepData.nights) {
      if (night.date.month == currentMonth) {
        list.add(
            FlSpot(night.date.day.toDouble(), night.sleepScore.toDouble()));
      }
    }
    return list;
  }

  Future<Sleep> get_sleep_data() async {
    http.Response response = await http.get(
      Uri.parse('https://www.polaraccesslink.com/v3/users/sleep'),
      headers: <String, String>{
        'Authorization': 'Bearer ${globals.access_token}',
        'Accept': 'application/json'
      },
    );
    return sleepFromJson(response.body);
  }
}
