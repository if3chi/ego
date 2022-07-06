import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ego/util/app_colors.dart';

const appName = 'Ego';

final DateFormat dateFormat = DateFormat("MMM, E d, yy.");
final NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
final NumberFormat compactFromat = NumberFormat.compact();

const SizedBox vSpaceMicro = SizedBox(height: 2.0);
const SizedBox vSpaceTiny = SizedBox(height: 4.0);
const SizedBox vSpaceNormal = SizedBox(height: 8.0);
const SizedBox vSpaceMedium = SizedBox(height: 24.0);

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
