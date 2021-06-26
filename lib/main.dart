import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:harperdb_hashnode_hackathon/pages/home_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  setPathUrlStrategy();
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
        textTheme: GoogleFonts.ubuntuTextTheme(
              Theme.of(context).textTheme,
            ),
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo
      ),
      home: MyHomePage(title: 'HarperDB Hashnode Hackathon'),
    );
  }
}