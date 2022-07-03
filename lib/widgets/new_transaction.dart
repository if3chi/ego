import 'package:flutter/material.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:ego/services/string_casing_ext.dart';

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
  bool hasDate = false;
  bool dateErrorText = false;
  bool typeErrorText = false;
  late DateTime _chosenDate;

  void _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _chosenDate = value;
        hasDate = true;
        dateErrorText = !hasDate;
      });
    });
  }

  void validator() {
    if (!hasDate) {
      setState(() {
        dateErrorText = !hasDate;
      });
    }
    if (_txType.isEmpty) {
      setState(() {
        typeErrorText = _txType.isEmpty;
      });
    }
    return;
  }

  void submitData() {
    validator();
    if (_formKey.currentState!.validate()) {
      if (!hasDate || _txType.isEmpty) return;

      widget.addTransaction(_titleController.text.toTitleCase(), _txType,
          double.parse(_amountController.text), _chosenDate);

      Navigator.of(context).pop();
      notify(context: context, title: _titleController.text.toTitleCase());
    }
  }

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
            colors: [kSwatch3.withOpacity(0.9), kSwatch0.withOpacity(0.9)]),
      ),
      child: Column(children: [
        const Text("Add Transaction",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato")),
        kSpaceWidget,
        Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(
                        width: 200,
                        child: Input(
                          icon: Icons.money,
                          hintText: "00.00",
                          iconColor: iconColor,
                          inputValidator: amountValidator,
                          editingController: _amountController,
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                        )),
                    kSpaceWidget,
                    checkBoxes(),
                    kSpaceWidget,
                    dateWidget(),
                    kSpaceWidget,
                    Input(
                        hintText: "Enter a transaction Title",
                        iconColor: iconColor,
                        inputValidator: titleValidator,
                        editingController: _titleController,
                        inputType: TextInputType.text),
                    kSpaceWidget,
                  ]),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor:
                            MaterialStateProperty.all(kAccentColor),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8)),
                      ),
                      onPressed: submitData,
                      child: const Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                ]))
      ]),
    );
  }

  Column dateWidget() {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(hasDate
                ? "Chosen Date: ${dateFormat.format(_chosenDate)}"
                : 'Pick a Date:'),
            TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kAccentColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return kAccentColor.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return kAccentColor.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    })),
                onPressed: _openDatePicker,
                child: const Text('Choose Date'))
          ])),
      Text(dateErrorText ? "Choose a Date for this Transaction." : '',
          style: const TextStyle(
              color: kRed, fontSize: 12, fontWeight: FontWeight.w600))
    ]);
  }

  SizedBox checkBoxes() {
    return SizedBox(
      width: 250,
      child: Column(children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InputType(
                  value: _income,
                  checkColor: kGreen,
                  onChanged: (value) {
                    setState(() {
                      _income = value;
                      if (_income) {
                        _expense = !value;
                        _debt = !value;
                        _txType = Transaction.income;
                        typeErrorText = !value;
                      }
                    });
                  }),
              InputType(
                  text: "Expense",
                  checkColor: kRed,
                  value: _expense,
                  onChanged: (value) {
                    setState(() {
                      _expense = value;
                      if (_expense) {
                        _income = !value;
                        _debt = !value;
                        _txType = Transaction.expense;
                        typeErrorText = !value;
                      }
                    });
                  }),
              InputType(
                  text: "Debt",
                  checkColor: Colors.amber,
                  value: _debt,
                  onChanged: (value) {
                    setState(() {
                      _debt = value;
                      if (_debt) {
                        _income = !value;
                        _expense = !value;
                        _txType = Transaction.debt;
                        typeErrorText = !value;
                      }
                    });
                  }),
            ]),
        const SizedBox(height: 8.0),
        Text(typeErrorText ? "The transaction type is required." : '',
            style: const TextStyle(
                color: kRed, fontSize: 12, fontWeight: FontWeight.w600))
      ]),
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
    if (value.length < 3) return "title cannot be less than 3 characters.";
    return null;
  }
}

class InputType extends StatelessWidget {
  const InputType(
      {Key? key,
      this.text = "Income",
      required this.value,
      required this.onChanged,
      required this.checkColor})
      : super(key: key);

  final String text;
  final bool value;
  final Color checkColor;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Checkbox(
          value: value,
          activeColor: checkColor,
          onChanged: (value) => onChanged(value),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      Text(text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
    ]);
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
          prefixIcon: Icon(icon, size: 32, color: iconColor),
          errorStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(width: 3, color: iconColor)),
        ),
        keyboardType: inputType,
        validator: inputValidator);
  }
}

void notify({required BuildContext context, String title = ''}) {
  Flushbar(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(8),
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    backgroundGradient: const LinearGradient(
        colors: [kSecondaryColor, kPrimaryColor], stops: [0.6, 1]),
    boxShadows: const [
      BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    duration: const Duration(seconds: 5),
    flushbarPosition: FlushbarPosition.TOP,
    titleText: Text(title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        textAlign: TextAlign.center),
    messageText: const Text('Transaction Added Successfully!',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        textAlign: TextAlign.center),
  ).show(context);
}
