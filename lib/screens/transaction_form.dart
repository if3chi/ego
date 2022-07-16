import 'dart:math';
import 'package:ego/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/services/notify.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/models/category.dart';
import 'package:ego/widgets/ego_text.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/widgets/form_button.dart';
import 'package:ego/services/date_service.dart';
import 'package:ego/screens/category_modal.dart';
import 'package:ego/services/string_casing_ext.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.actionFunction,
      {Key? key, this.transaction, this.formType = 'create'})
      : super(key: key);

  final String formType;
  final Function actionFunction;
  final Transaction? transaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  bool get isUpdating => widget.formType == Transaction.update;

  bool _expense = false;
  bool _income = false;
  bool _debt = false;
  String _txType = "";
  bool hasDate = false;
  late DateTime _chosenDate;
  bool dateErrorText = false;
  bool typeErrorText = false;
  bool _categoryIdErrorText = false;

  String? formButtonText;
  String? formActionText;
  String? formHeadlineText;

  int? _categoryId;
  String _categoryName = "Select Transaction Category";

  void setFormTexts() {
    if (isUpdating) {
      formButtonText = 'Update';
      formActionText = 'Updated';
      formHeadlineText = 'Update Transaction';
    } else {
      formButtonText = 'Add';
      formActionText = 'Added';
      formHeadlineText = 'Add Transaction';
    }
  }

  @override
  void initState() {
    super.initState();
    if (isUpdating) {
      _amountController.text = widget.transaction!.amount.toString();
      _titleController.text = widget.transaction!.title;
      _categoryId = widget.transaction!.categoryId;
      _chosenDate = widget.transaction!.date;
      hasDate = true;
      _txType = widget.transaction!.type;
      _debt = _txType == Transaction.debt;
      _income = _txType == Transaction.income;
      _expense = _txType == Transaction.expense;
      _categoryName = categoryName(Category.getCategoryName(_categoryId!));
    }
  }

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

  void _openCategoryForm() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => CategoryModal(
              setCategory: setSelectCategory,
            ));
  }

  void setSelectCategory(Category selectedCategory) {
    setState(() {
      _categoryId = selectedCategory.id;
      _categoryName = categoryName(selectedCategory.name);
      _categoryIdErrorText = false;
    });
  }

  String categoryName(category) => "Category: $category";

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
    if (_categoryId == null) {
      setState(() {
        _categoryIdErrorText = true;
      });
    }
    return;
  }

  void submitData() {
    validator();
    if (_formKey.currentState!.validate()) {
      if (!hasDate || _txType.isEmpty || _categoryId == null) return;

      int transactionId =
          isUpdating ? widget.transaction!.id : Random(2022).nextInt(100);

      widget.actionFunction(Transaction(
          id: transactionId,
          categoryId: _categoryId!,
          title: _titleController.text.toTitleCase(),
          type: _txType,
          amount: double.parse(_amountController.text),
          date: _chosenDate));

      Navigator.of(context).pop();
      Notify.show(
          context: context,
          action: formActionText!,
          title: _titleController.text.toTitleCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    setFormTexts();
    var iconColor = kSwatch5.withOpacity(0.40);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 32,
            right: 12,
            left: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [kSwatch0.withOpacity(0.9), kSwatch6]),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          EgoText.headline(formHeadlineText!),
          vSpaceNormal,
          vSpaceForm,
          Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Input(
                        icon: Icons.money,
                        hintText: "00.00",
                        iconColor: iconColor,
                        inputValidator: amountValidator,
                        editingController: _amountController,
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                      ),
                      vSpaceForm,
                      Input(
                          hintText: "Enter a transaction Title",
                          iconColor: iconColor,
                          inputValidator: titleValidator,
                          editingController: _titleController,
                          inputType: TextInputType.text),
                      vSpaceForm,
                      FormButton(
                          buttonAction: _openCategoryForm,
                          text: _categoryName,
                          color: kDarkGreyColor.withOpacity(0.6),
                          outlined: true),
                      _categoryIdErrorText
                          ? EgoText.error("Kindly select a category")
                          : shrikSpace,
                      vSpaceForm,
                      checkBoxes(),
                      vSpaceTiny,
                      vSpaceSmall,
                      dateWidget(),
                      vSpaceForm,
                    ]),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormButton(
                              color: kDarkGreyColor.withOpacity(0.6),
                              outlined: true),
                          hSpaceNormal,
                          FormButton(
                              text: formButtonText!,
                              color: kSwatch5,
                              buttonAction: submitData)
                        ],
                      ),
                    )
                  ]))
        ]),
      ),
    );
  }

  Column dateWidget() {
    return Column(children: [
      EgoText.caption(hasDate
          ? "Chosen Date: ${DateService.dateFormat.format(_chosenDate)}"
          : 'Pick a Date:'),
      vSpaceTiny,
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormButton(
                text: 'Today?',
                color: kSwatch2.withOpacity(0.3),
                buttonAction: () {
                  setState(() {
                    _chosenDate = DateTime.now();
                    hasDate = true;
                    dateErrorText = !hasDate;
                  });
                }),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                child: EgoText.body('or', color: Colors.white)),
            FormButton(
                text: 'Choose Date',
                color: kSwatch2.withOpacity(0.2),
                buttonAction: _openDatePicker)
          ]),
      dateErrorText
          ? EgoText.error("Choose a Date for this Transaction.")
          : shrikSpace
    ]);
  }

  Column checkBoxes() {
    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputType(
                value: _income,
                checkColor: kGreenColor,
                onChanged: (value) {
                  setState(() {
                    _income = value;
                    if (_income) {
                      _expense = !value;
                      _debt = !value;
                      _txType = Transaction.income;
                      typeErrorText = !value;
                    } else {
                      _txType = '';
                    }
                  });
                }),
            InputType(
                text: "Expense",
                checkColor: kRedColor,
                value: _expense,
                onChanged: (value) {
                  setState(() {
                    _expense = value;
                    if (_expense) {
                      _income = !value;
                      _debt = !value;
                      _txType = Transaction.expense;
                      typeErrorText = !value;
                    } else {
                      _txType = '';
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
                    } else {
                      _txType = '';
                    }
                  });
                }),
          ]),
      vSpaceSmall,
      typeErrorText
          ? EgoText.error("The transaction type is required.", color: kRedColor)
          : shrikSpace
    ]);
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
    return Row(children: [
      Checkbox(
        value: value,
        activeColor: checkColor,
        onChanged: (value) => onChanged(value),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      EgoText.caption(text),
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
          errorStyle: errorStyle,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 3, color: iconColor)),
        ),
        keyboardType: inputType,
        validator: inputValidator);
  }
}
