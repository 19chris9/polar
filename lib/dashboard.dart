import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/user.dart';
import 'models/sleep.dart';
import 'ChartWidget.dart';
import 'exercisesWidget.dart';
import 'AuthenticationService.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? fbToken = " ";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<void>(
        future: AuthenticationService(FirebaseAuth.instance).signIn(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                buildAppBar(context),
                ExerciseWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        stretch: true,
        title: Text("POLAR"),
        centerTitle: true,
        actions: [
          FloatingActionButton.small(
            child: Icon(Icons.logout),
            onPressed: () {
              signOut();
            },
          ),
          SizedBox(width: 12),
        ],
      );

  String token1 = "";
  getTokenNotification() async {
    token1 = (await FirebaseMessaging.instance.getToken())!;
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc("User1").set({
      'token': token,
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        fbToken = token;
      });
      saveToken(token!);
    });
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', "");
    prefs.setInt('x_user_id', 0);
    globals.access_token = "";
    globals.is_logged_in = false;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
