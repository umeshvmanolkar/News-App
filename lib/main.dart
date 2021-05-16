import 'dart:convert';

import 'package:news_app/login_page.dart';

import 'Favorite.dart';
import 'News.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LoginPage());
}

class NewsApp extends StatefulWidget {

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
    int _currentIndex = 0;
    final List _children = [
      NewsPage(),
      Favorite()
    ];

    void onTappedBar(int index)
    {
      setState(() {
        _currentIndex = index;
      });
    }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:_children[_currentIndex],
    //     bottomNavigationBar: BottomNavigationBar(
    //     onTap: onTappedBar,
    //       currentIndex:  _currentIndex,
    //
    //       type: BottomNavigationBarType.fixed,
    //       backgroundColor: Colors.grey[400],
    //       selectedFontSize: 15,
    //
    //       items :[
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.list),
    //             title:Text('News'),
    //             backgroundColor: Colors.green
    // ),
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.favorite, color: Colors.red[400],),
    //             title:Text('Favorite'),
    //             backgroundColor: Colors.orange
    //         ),
    //       ],
    //
    //     ),
      ),
    );
  }


}

