import 'package:flutter/material.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenWidthPercent(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

double screenHeightPercent(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;
