import 'package:flutter/material.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.addTransaction})
      : super(key: key);
  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  bool _income = false;
  bool _expense = false;
  bool _debt = false;
  String _txType = "";

  @override
  Widget build(BuildContext context) {
    var iconColor = kSwatch5.withOpacity(0.40);
    return Container(
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              kSwatch3.withOpacity(0.9),
              kSwatch0.withOpacity(0.9),
            ]),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Input(
                    icon: Icons.money,
                    hintText: "00.00",
                    iconColor: iconColor,
                    inputValidator: amountValidator,
                    editingController: _amountController,
                    inputType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                  ),
                ),
                kSpaceWidget,
                SizedBox(
                  width: 250,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputType(
                        value: _income,
                        onChanged: (value) {
                          setState(() {
                            _income = value;
                            if (_income) {
                              _expense = !value;
                              _debt = !value;
                              _txType = Transaction.income;
                            }
                          });
                        },
                      ),
                      InputType(
                          text: "Expense",
                          value: _expense,
                          onChanged: (value) {
                            setState(() {
                              _expense = value;
                              if (_expense) {
                                _income = !value;
                                _debt = !value;
                                _txType = Transaction.expense;
                              }
                            });
                          }),
                      InputType(
                          text: "Debt",
                          value: _debt,
                          onChanged: (value) {
                            setState(() {
                              _debt = value;
                              if (_debt) {
                                _income = !value;
                                _expense = !value;
                                _txType = Transaction.debt;
                              }
                            });
                          }),
                    ],
                  ),
                ),
                kSpaceWidget,
                Input(
                  hintText: "Enter a transaction Title",
                  iconColor: iconColor,
                  inputValidator: titleValidator,
                  editingController: _titleController,
                  inputType: TextInputType.text,
                ),
                kSpaceWidget,
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(2),
                backgroundColor: MaterialStateProperty.all(kAccentColor),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ignore: todo
                  // TODO: Add validation for checkboxes
                  if (_txType.isEmpty) return;
                  widget.addTransaction(
                    _titleController.text,
                    _txType,
                    double.parse(_amountController.text),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      elevation: 2,
                      backgroundColor: kSwatch5,
                      content: Text(
                        'Transaction Added Successfully!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );

                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? amountValidator(value) {
    if (value == null || value.isEmpty) return 'Please enter an Amount';
    if (double.tryParse(value) == null) return 'Amount must be numbers';

    return null;
  }

  String? titleValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a transaction title';
    }
    return null;
  }
}

class InputType extends StatelessWidget {
  const InputType({
    Key? key,
    this.text = "Income",
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String text;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
          value: value,
          onChanged: (value) => onChanged(value),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    Key? key,
    this.icon = Icons.abc,
    required this.hintText,
    required this.iconColor,
    required this.inputType,
    required this.editingController,
    required this.inputValidator,
  }) : super(key: key);

  final TextInputType inputType;
  final String hintText;
  final Color iconColor;
  final IconData icon;
  final TextEditingController editingController;
  final String? Function(String?)? inputValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          size: 32,
          color: iconColor,
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        border: const OutlineInputBorder(
          // borderSide: BorderSide(width: 6),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            width: 3,
            color: iconColor,
          ),
        ),
      ),
      keyboardType: inputType,
      validator: inputValidator,
    );
  }
}
