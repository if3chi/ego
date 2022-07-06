import 'package:flutter/material.dart';

import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/screens/ego_home.dart';

void main() => runApp(const EgoApp());

class EgoApp extends StatelessWidget {
  const EgoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  kSwatch0,
                  kPrimaryColor,
                ]),
          ),
          child: SafeArea(
            child: EgoHome(),
          ),
        ),
      ),
    );
  }
}
