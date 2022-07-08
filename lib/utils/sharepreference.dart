import 'package:shared_preferences/shared_preferences.dart';

setFirstName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('firstname', name);
}

setLastName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('lastname', name);
}

setProfileimg(String img) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userimg', img);
}

setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('auth_token', token);
}

setLogin(bool login) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', login);
}

setUserId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userid', id);
}
