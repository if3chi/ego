import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/widgets/ego_text.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/services/date_service.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.txName,
    required this.txDate,
    required this.type,
    required this.amount,
  }) : super(key: key);

  final String txName;
  final DateTime txDate;
  final String type;
  final double amount;

  @override
  Widget build(BuildContext context) {
    bool isIncome = Transaction.isIncome(type);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              EgoText.desc(txName, overflow: TextOverflow.ellipsis),
              vSpaceMicro,
              EgoText.alert(
                DateService.dateFormat.format(txDate),
                color: Colors.grey.shade300,
              )
            ]),
          ),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(right: 4.0),
            child: Column(
              children: type == Transaction.debt
                  ? [
                      AmountText(isIncome: isIncome, amount: amount),
                      vSpaceMicro,
                      EgoText.alert(type, color: kSwatch5.withOpacity(0.5))
                    ]
                  : [AmountText(isIncome: isIncome, amount: amount)],
            ),
          ))
        ],
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  const AmountText({
    Key? key,
    required this.isIncome,
    required this.amount,
  }) : super(key: key);

  final bool isIncome;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return EgoText.alert(
        "${isIncome ? "+" : "-"}\$${DateService.numberFormat.format(amount)}",
        overflow: TextOverflow.ellipsis,
        color: isIncome ? kGreenColor : kRedColor);
  }
}
