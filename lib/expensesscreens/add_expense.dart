import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_elevated_button.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/ditch_text_button.dart';
import 'package:flutter_repo/ditch_text_field.dart';
import 'package:flutter_repo/models/expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addExpenseItem});
  final void Function(Expense item) addExpenseItem;
  @override
  State<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends State<AddExpense> {
  // String title = '';
  // var amount = ''; // both of these initialisation are same
  // void _saveTitleChanges(String expenseTitle) {
  //   title = expenseTitle;
  // }

  // void _saveAmountChanges(String expenseAmount) {
  //   amount = expenseAmount;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _categoryController = Category.food;
  // var selectedDate = 'Selected Date';
  DateTime? selectedDate;

  // Method 1
  // void triggerDatePicker() {
  //   final now = DateTime.now();
  //   final firstDate = DateTime(now.year - 1, now.month, now.day);
  //   showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: firstDate,
  //     lastDate: now,
  //   ).then((value) {
  //     setState(() {
  //       selectedDate = '${value?.day}/${value?.month}/${value?.year}';
  //     });
  //   });
  // }

  // Method 2
  void triggerDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void onSubmitHandler() {
    final doubleAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        doubleAmount == null ||
        doubleAmount <= 0 ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: DitchText(text: 'Invalid Input(s)!', fontSize: 20),
              backgroundColor: const Color.fromARGB(255, 33, 105, 139),
              content: DitchText(
                text: 'Please make sure alll values are valid.',
                fontSize: 15,
              ),
              actions: [
                DitchTextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  label: 'Okay',
                ),
              ],
            ),
      );
      return;
    }
    widget.addExpenseItem(
      Expense(
        date: selectedDate!,
        title: _titleController.text,
        amount: double.tryParse(_amountController.text)!,
        category: _categoryController,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          DitchTextField(
            textEditingController: _titleController,
            label: 'Title',
          ),
          Row(
            children: [
              Expanded(
                child: DitchTextField(
                  textEditingController: _amountController,
                  label: 'Amount',
                  keyboardType: TextInputType.number,
                  prefixText: '₹',
                ),
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  DitchText(
                    text:
                        selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(selectedDate!),
                    fontSize: 15,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: triggerDatePicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _categoryController,
                dropdownColor: Colors.black26,
                items:
                    Category.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: DitchText(
                              text: e.name.toUpperCase(),
                              fontSize: 15,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _categoryController = value;
                  });
                },
              ),
              DitchTextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: 'Cancel',
              ),
              SizedBox(width: 40),
              // ElevatedButton(onPressed: onSubmitHandler, child: DitchText(text: 'Add expense'))
              DitchElevatedButton(
                onClickHandler: onSubmitHandler,
                label: 'Add Expense',
                buttonWidth: 120,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
