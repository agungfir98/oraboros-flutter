import 'package:flutter/material.dart';

class TransactionFilter extends StatefulWidget {
  const TransactionFilter({super.key});

  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Filter transactions'),
    );
  }
}
