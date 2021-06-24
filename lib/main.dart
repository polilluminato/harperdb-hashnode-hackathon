import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:harperdb_hashnode_hackathon/pages/home_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HarperDB Hashnode Hackathon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.indigo,
      ),
      home: MyHomePage(title: 'HarperDB Hashnode Hackathon'),
    );
  }
}