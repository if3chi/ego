import 'package:flutter/material.dart';
import 'package:ego/util/app_colors.dart';

const appName = 'Ego';

const SizedBox hSpaceNormal = SizedBox(width: 10.0);

const SizedBox vSpaceMicro = SizedBox(height: 2.0);
const SizedBox vSpaceTiny = SizedBox(height: 4.0);
const SizedBox vSpaceSmall = SizedBox(height: 8.0);
const SizedBox vSpaceNormal = SizedBox(height: 10.0);
const SizedBox vSpaceForm = SizedBox(height: 16.0);
const SizedBox vSpaceMedium = SizedBox(height: 24.0);
const SizedBox vSpaceLarge = SizedBox(height: 32.0);
const SizedBox vSpaceXLarge = SizedBox(height: 64.0);

const SizedBox shrikSpace = SizedBox.shrink();

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
