import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NeuSummaryCard extends StatelessWidget {
  final double total;
  final String textType;
  final bool isPositive;
  final double percentage;

  const NeuSummaryCard({
    Key? key,
    required this.textType,
    required this.percentage,
    required this.total,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color foreColor = isPositive ? kGreen : kRed;
    Color bgColor = isPositive ? kBgGreen : kBgRed;
    final cardIcon = isPositive
        ? SvgPicture.asset(
            "assets/images/up_arrow.svg",
            width: 16,
            color: foreColor,
            semanticsLabel: 'An up arrow',
          )
        : SvgPicture.asset(
            "assets/images/down_arrow.svg",
            width: 16,
            color: foreColor,
            semanticsLabel: 'A down arrow',
          );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              RotationTransition(
                // ignore: todo
                // TODO: Add dynamic icon rotation based on transaction %tage.
                turns: const AlwaysStoppedAnimation(20 / 180),
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  margin: const EdgeInsets.only(top: 6.0),
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: cardIcon,
                ),
              ),
              Text(
                "${isPositive ? '+' : '-'}${percentage.toStringAsFixed(2)}%",
                style: TextStyle(
                  color: foreColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "₵ ${compactFromat.format(total)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                textType,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
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
