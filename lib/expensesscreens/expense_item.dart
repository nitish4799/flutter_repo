import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expenseItem,
    required this.deleteExpense,
  });
  final Expense expenseItem;
  final VoidCallback deleteExpense;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 18, 91, 146),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DitchText(
                    text: expenseItem.title,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                    onPressed: deleteExpense,
                    icon: Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DitchText(
                    text: 'Rs. ${expenseItem.amount.toString()}',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  DitchText(
                    icon: categoryIcons[expenseItem.category],
                    text: expenseItem.formattedDate,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
