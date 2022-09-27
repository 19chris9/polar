library polar.globals;

import 'models/sleep.dart';
import 'models/user.dart';

String? access_token;
bool is_logged_in = false;
int? x_user_id;
Future<BasicUser>? user;
Future<Sleep>? sleepData;
