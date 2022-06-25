import 'package:flutter/material.dart';
import 'package:ego/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NeuSummaryCard extends StatelessWidget {
  final String textType;
  final int percentage;
  final double arrowDirection;
  final bool isPositive;

  const NeuSummaryCard({
    Key? key,
    required this.textType,
    required this.percentage,
    required this.arrowDirection,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color foreColor = isPositive ? kGreen : kRed;
    Color bgColor = isPositive ? kBgGreen : kBgRed;
    final cardIcon = isPositive
        ? SvgPicture.asset(
            "assets/images/up_arrow.svg",
            color: foreColor,
            semanticsLabel: 'An up arrow',
          )
        : SvgPicture.asset(
            "assets/images/down_arrow.svg",
            color: foreColor,
            semanticsLabel: 'A down arrow',
          );

    double getPercentage(double percentage) => (percentage / 100) * 180;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.2),
            ]),
        boxShadow: kBoxShadow,
      ),
      child: Row(
        children: [
          RotationTransition(
            // ignore: todo
            // TODO: Add dynamic icon rotation based on transaction %tage.
            turns: AlwaysStoppedAnimation(getPercentage(arrowDirection) / 180),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: cardIcon,
            ),
          ),
          const SizedBox(width: 6.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "+$percentage%",
                style: TextStyle(
                  color: foreColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                textType,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
