import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/expensesscreens/chart.dart';
import 'package:flutter_repo/expensesscreens/expense_list.dart';
import 'package:flutter_repo/expensesscreens/expense_overlay.dart';
import 'package:flutter_repo/gradient_container.dart';
import 'package:flutter_repo/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _Expenses();
}

class _Expenses extends State<Expenses> {
  final List<Expense> _expenseList = [
    Expense(
      date: DateTime.now(),
      title: 'Momo',
      amount: 30,
      category: Category.work,
    ),
    Expense(
      date: DateTime(2024),
      title: 'Metro',
      amount: 400,
      category: Category.travel,
    ),
    Expense(
      date: DateTime(2025),
      title: 'Movies',
      amount: 800,
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseOverlay(addExpenseItem: _addExpenseItem),
    );
  }

  void _addExpenseItem(Expense expenseItem) {
    setState(() {
      _expenseList.add(expenseItem);
    });
  }

  void deleteExpenseItem(Expense expenseItem) {
    final int expenseIndex = _expenseList.indexOf(expenseItem);
    setState(() {
      _expenseList.remove(expenseItem);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const DitchText(
          text: 'Expense item deleted successfully.',
          fontSize: 20,
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenseList.insert(expenseIndex, expenseItem);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final bool isPortrait = orientation == Orientation.portrait;

    Widget expenseContent = Center(
      child: DitchText(text: 'No expense item found, Add some.', fontSize: 20),
    );

    if (_expenseList.isNotEmpty) {
      expenseContent = ExpenseList(
        list: _expenseList,
        deleteItem: deleteExpenseItem,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 112, 139),
        title: const DitchText(
          text: 'Expense Tracking App',
          color: Color.fromARGB(255, 239, 235, 235),
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 229, 224, 224),
            ),
          ),
        ],
      ),
      body: GradientContainer(
        gradientColor: const [
          Color.fromARGB(255, 212, 217, 222),
          Color.fromARGB(255, 38, 82, 130),
        ],
        columnWidgets: isPortrait
            ? [
                Chart(expenses: _expenseList),
                Expanded(child: expenseContent),
              ]
            : null,
        rowWidgets: !isPortrait
            ? [
                Expanded(child: Chart(expenses: _expenseList)),
                Expanded(child: expenseContent),
              ]
            : null,
      ),
    );
  }
}
