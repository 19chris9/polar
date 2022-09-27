import 'dart:async';
import 'dart:ui';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polar/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  late StreamSubscription _onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
  String authenticationString = "";
  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {});

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
    });

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() async {
          if (url.startsWith('http')) {
            final code = Uri.parse(url).queryParameters['code'];
            http.Response response = await authenticate(code);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Map<String, dynamic> map = json.decode(response.body);
            prefs.setString('access_token', map['access_token']);
            prefs.setInt('x_user_id', map['x_user_id']);
            globals.access_token = map['access_token'];
            globals.x_user_id = map['x_user_id'];
            if (globals.access_token != "") globals.is_logged_in = true;
            flutterWebviewPlugin.close();
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: globals.is_logged_in
            ? Dashboard()
            : WebviewScaffold(
                url:
                    'https://flow.polar.com/oauth2/authorization?response_type=code&client_id=4e10cd39-560c-459f-9c6a-436e90d4d76b',
                clearCache: true,
                clearCookies: true,
                appBar: AppBar(
                  title: const Text("Login to Polar Flow"),
                ),
              ));
  }

  Future<http.Response> authenticate(final code) async {
    return http.post(
      Uri.parse('https://polarremote.com/v2/oauth2/token'),
      headers: <String, String>{
        'Authorization': 'Basic $authenticationString',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json;charset=UTF-8'
      },
      body: <String, String>{'grant_type': 'authorization_code', 'code': code},
    );
  }
}
