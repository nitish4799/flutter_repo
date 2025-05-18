import 'package:flutter/material.dart';
import 'package:flutter_repo/expensesscreens/add_expense.dart';
import 'package:flutter_repo/gradient_container.dart';
import 'package:flutter_repo/models/expense.dart';

class ExpenseOverlay extends StatefulWidget {
  const ExpenseOverlay({super.key, required this.addExpenseItem});
  final void Function(Expense item) addExpenseItem;
  @override
  State<ExpenseOverlay> createState() {
    return _ExpenseOverlay();
  }
}

class _ExpenseOverlay extends State<ExpenseOverlay> {
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      gradientColor: [
        const Color.fromARGB(255, 212, 217, 222),
        const Color.fromARGB(255, 38, 82, 130),
      ],
      columnWidgets: [AddExpense(addExpenseItem: widget.addExpenseItem)],
    );
  }
}
