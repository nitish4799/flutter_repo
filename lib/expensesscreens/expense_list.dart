import 'package:flutter/material.dart';
import 'package:flutter_repo/expensesscreens/expense_item.dart';
import 'package:flutter_repo/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.list, required this.deleteItem});
  final List<Expense> list;
  final void Function(Expense item) deleteItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder:
            (ctx, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Dismissible(
                key: ValueKey(list[index]),
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                  ),
                ),
                onDismissed: (direction) => deleteItem(list[index]),
                child: ExpenseItem(
                  expenseItem: list[index],
                  deleteExpense: () => deleteItem(list[index]),
                ),
              ),
            ),
      ),
    );
  }
}
