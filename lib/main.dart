import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/screens/ego_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(const EgoApp());
}

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
              end: Alignment.topCenter,
              colors: [
                kPrimaryColor,
                kSwatch0,
                kSwatch6,
                kSwatch0,
                kPrimaryColor,
                kPrimaryColor,
                kSwatch6
              ],
            ),
          ),
          child: SafeArea(
            child: EgoHome(),
          ),
        ),
      ),
    );
  }
}
