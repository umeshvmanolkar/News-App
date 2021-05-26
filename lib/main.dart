import 'dart:convert';

import 'package:news_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'News.dart';
import 'package:flutter/material.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(home: email == null ? LoginPage() : NewsPage()));

}

