import 'package:flutter/material.dart';

class NewBudgetSheet extends StatefulWidget {
  const NewBudgetSheet({super.key});

  @override
  State<NewBudgetSheet> createState() => _NewBudgetSheetState();
}

class _NewBudgetSheetState extends State<NewBudgetSheet> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("new budgets"),
    );
  }
}
