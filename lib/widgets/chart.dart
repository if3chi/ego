import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get sevenDaysTransactions =>
      List.generate(7, (index) {
        final today = DateTime.now();
        final dayFormat = DateFormat.E();
        final weekDay = dayFormat.format(today.subtract(Duration(days: index)));
        double totalDaySum = 0.0;
        bool isToday = weekDay == dayFormat.format(today);

        for (var tx = 0; tx < recentTransactions.length; tx++) {
          if (dayFormat.format(recentTransactions[tx].date) == weekDay) {
            totalDaySum += recentTransactions[tx].amount;
          }
        }

        return {'day': weekDay, 'amount': totalDaySum, 'isToday': isToday};
      });

  double get totalAmount => sevenDaysTransactions.fold(0.0, (sum, tx) {
        return sum + (tx['amount'] as double);
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...sevenDaysTransactions.reversed.map((tx) {
            return ChartBar(
              label: tx['day'].toString(),
              amount: compactFromat.format(tx['amount']),
              isToday: tx['isToday'] as bool,
              pctOfAmount: totalAmount == 0.0
                  ? 0.0
                  : (tx['amount'] as double) / totalAmount,
            );
          })
        ],
      ),
    );
  }
}

class ChartBar extends StatelessWidget {
  const ChartBar({
    Key? key,
    required this.label,
    required this.amount,
    required this.isToday,
    required this.pctOfAmount,
  }) : super(key: key);

  final String label;
  final String amount;
  final bool isToday;
  final double pctOfAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 10,
          height: 80,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.6),
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FractionallySizedBox(
                heightFactor: pctOfAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: kSwatch5,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
        vSpaceTiny,
        Text(
          amount,
          style: TextStyle(
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          label,
          style: TextStyle(
              color: isToday ? kSwatch4 : Colors.white,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
