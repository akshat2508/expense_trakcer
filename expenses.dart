// //main user interface
// import 'package:expense_tracker/widgets/chart/chart.dart';

// import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
// import 'package:expense_tracker/models/expense.dart';
// import 'package:expense_tracker/widgets/new_expense.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// // import 'package:flutter/scheduler.dart';

// class Expenses extends StatefulWidget {
//   const Expenses({super.key});

//   @override
//   State<Expenses> createState() {
//     return _ExpensesState();
//   }
// }

// class _ExpensesState extends State<Expenses> {

//   final List<Expense> _registeredExpenses = [
//     Expense(
//         title: 'Flutter course',
//         amount: 19.99,
//         date: DateTime.now(),
//         category: Category.work),
//         Expense(
//         title: 'cinema',
//         amount: 19.99,
//         date: DateTime.now(),
//         category: Category.leisure),
        
//   ];



 

//   void _openAddExpenseOverlay(){
//     showModalBottomSheet(useSafeArea: true,isScrollControlled:true,context:  context, builder: (ctx)=>  NewExpense(onAddExpense: _addExpense,));
//   }
  
//   void _addExpense(Expense expense){
//     setState(() {
//      _registeredExpenses.add(expense);
//     });
//   }

//   void _removeExpense(Expense expense){
//     final expenseIndex = _registeredExpenses.indexOf(expense);
//     setState(() {
//       _registeredExpenses.remove(expense);
//     });
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 3),
//         content: const Text('Expense deleted'), 
//         action: SnackBarAction(
//           label: 'Undo',
//           onPressed: (){
//             setState(() {
//               _registeredExpenses.insert(expenseIndex, expense);
//             });
//           },
//         ),
//         ),
//         );
//   }
//     double calculateTotalExpenses(List<Expense> expenses) {
//     double sum = 0;
//     for (final expense in expenses) {
//       sum += expense.amount;
//     }
//     return sum;
//   }

//   @override
//   Widget build(BuildContext context) {
//    final width = MediaQuery.of(context).size.width;

//         double totalExpenses = calculateTotalExpenses(_registeredExpenses);

//     Widget mainContent =const Center(child: Text('No expenses found. Start adding some! '),);
//     if(_registeredExpenses.isNotEmpty){
//       mainContent =  ExpensesList(expenses: _registeredExpenses,
//           onRemoveExpense: _removeExpense);

//     }

//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text('Expense Tracker'),
//         actions: [
//           IconButton(onPressed: _openAddExpenseOverlay, icon:const Icon(Icons.add))
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(30.0),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Total Spent: Rs ${totalExpenses.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body:width <600 ? Column(children: [
//         // const Text('the chart ')
//         Chart(expenses: _registeredExpenses) ,
//         Expanded(
//           child:mainContent
//           ),
//         ],
//       ):Row(children: [
//         Expanded (child : Chart(expenses: _registeredExpenses) ,),
//         Expanded(
//           child:mainContent
//           ),
//       ],),
//     );
//   }
// }


//main user interface
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _registeredExpenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    try {
      final expensesJson = prefs.getStringList('expenses') ?? [];
      _registeredExpenses = expensesJson
          .map((e) => Expense.fromJson(jsonDecode(e)))
          .toList();
    } catch (e) {
      print('Error loading expenses: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesJson = _registeredExpenses
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList('expenses', expensesJson);
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    _saveExpenses();
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    _saveExpenses();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
            _saveExpenses();
          },
        ),
      ),
    );
  }

  double calculateTotalExpenses(List<Expense> expenses) {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double totalExpenses = calculateTotalExpenses(_registeredExpenses);

    Widget mainContent = _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _registeredExpenses.isEmpty
            ? const Center(child: Text('No expenses found. Start adding some!'))
            : ExpensesList(
                expenses: _registeredExpenses,
                onRemoveExpense: _removeExpense,
              );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Spent: Rs ${totalExpenses.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}