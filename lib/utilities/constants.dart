import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const appName = 'Ego';

final dateFormat = DateFormat("MMM, E d, yy.");
final numberFormat = NumberFormat("#,##0.00", "en_US");

const kPrimaryColor = Color(0xFF302D43);
const kSecondaryColor = Color(0xFF6953F7);
const kAccentColor = Color(0xFFCD4FF7);
const kSwatch0 = Color(0xFF08070e);
const kSwatch1 = Color(0xff3816e9);
const kSwatch2 = Color(0xff5b13e2);
const kSwatch3 = Color(0xff362352);
const kSwatch4 = Color.fromARGB(255, 255, 178, 145);
const kSwatch5 = Color.fromARGB(255, 245, 190, 177);
const kGreen = Color.fromARGB(255, 21, 207, 27);
const kBgGreen = Color.fromARGB(255, 204, 255, 206);
const kRed = Color.fromARGB(255, 255, 72, 72);
const kBgRed = Color.fromARGB(255, 255, 188, 188);

SizedBox kSpaceWidget = const SizedBox(height: 24.0);

List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.white.withOpacity(0.1),
    offset: const Offset(-3, -3),
    blurRadius: 4,
    spreadRadius: 1,
  ),
  const BoxShadow(
    color: kPrimaryColor,
    offset: Offset(4, 4),
    blurRadius: 4,
    spreadRadius: 1,
  ),
];
