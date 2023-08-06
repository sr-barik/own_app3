import 'package:flutter/material.dart';
import 'package:own_app3/models/expense.dart';
import 'package:own_app3/widget/expense_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, {super.key, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
