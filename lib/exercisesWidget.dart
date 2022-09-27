import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'models/exercise.dart';
import 'models/sleep.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'ExWidget.dart';

class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget({Key? key}) : super(key: key);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: 8),
            Text(
              'Sleep Tracker',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 20),
            buildExercises(context),
          ],
        ),
      ),
    );
  }

  Widget buildExercises(BuildContext context) => FutureBuilder<Sleep>(
        future: get_sleep_data(),
        builder: (BuildContext context, AsyncSnapshot<Sleep> snapshot) {
          if (snapshot.hasData) {
            List<Widget> l = [];
            List<Night> nights = [];
            for (var data in snapshot.data!.nights) {
              nights.add(data);
            }
            if (nights.isEmpty) {
              return Text("No Sleep Data recorded");
            }
            nights.sort(
              (a, b) => b.date.compareTo(a.date),
            );
            for (var data in nights) {
              l.add(Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ExWidget(night: data)));
            }
            return Column(
              children: l,
            );
          } else
            return Text('');
        },
      );

  Future<Sleep> get_sleep_data() async {
    http.Response response = await http.get(
      Uri.parse('https://www.polaraccesslink.com/v3/users/sleep'),
      headers: <String, String>{
        'Authorization': 'Bearer ${globals.access_token}',
        'Accept': 'application/json'
      },
    );
    //String r = await getTestData();
    print(globals.is_logged_in);
    return sleepFromJson(response.body);
  }

  Future<String> getTestData() async {
    final String response =
        await rootBundle.loadString('assets/sleepData.json');
    return response;
  }
}
