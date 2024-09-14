import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: const Color.fromARGB(143, 29, 232, 131),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index])),
    );
  }
}
