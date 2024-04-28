import 'package:flutter/material.dart';
import 'package:oraboros/DTO/transaction.dto.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/components/toaster.dart';
import 'package:oraboros/screens/dashboard/bottomsheets/transaction/widgets/form_item.dart';
import 'package:oraboros/services/transaction.service.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:provider/provider.dart';

class NewTransactionSheet extends StatefulWidget {
  const NewTransactionSheet({
    super.key,
  });

  @override
  State<NewTransactionSheet> createState() => _NewTransactionSheet();
}

class _NewTransactionSheet extends State<NewTransactionSheet> {
  List<Map<String, TextEditingController>> _controller = [];
  final List<TransactionDTO> _orders = [TransactionDTO()];
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> _formFieldError = [
    {"budget_id": "", "name": "", "amount": ""},
  ];

  @override
  void initState() {
    super.initState();
    _controller = _orders
        .map((item) => ({
              "name": TextEditingController(text: item.name),
              "amount": TextEditingController(
                  text: item.amount == null ? "" : item.amount.toString()),
            }))
        .toList();
  }

  @override
  void dispose() {
    for (var node in _controller) {
      node.forEach((_, value) => value.dispose());
    }
    _formFieldError.clear();
    // unfocusNode();
    super.dispose();
  }

  void validator(int index, String field, String value) {
    setState(() {
      if (index >= _formFieldError.length) return;
      switch (field) {
        case "name":
          _formFieldError[index]['name'] = value;
          break;
        case "amount":
          _formFieldError[index]['amount'] = value;
          break;
        case "budget_id":
          _formFieldError[index]['budget_id'] = value;
      }
    });
  }

  void _handleChange(int index, String field, String value) {
    setState(() {
      if (index >= _orders.length) return;
      switch (field) {
        case "name":
          _orders[index].name = value;
          break;
        case "amount":
          _orders[index].amount = value.isEmpty ? 0 : int.parse(value);
          break;
        case "budget_id":
          _orders[index].budgetid = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<ProfileProvider>(context).profile['id'];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: const Center(child: Text('New transactions')),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onDoubleTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _orders.add(
                      TransactionDTO(),
                    );
                    _controller.add({
                      "name": TextEditingController(),
                      "amount": TextEditingController()
                    });
                  });
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _orders.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onDoubleTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _orders.removeAt(index);
                                  _controller.removeAt(index);
                                });
                              },
                              child: FormItem(
                                itemController: _controller[index],
                                order: _orders[index],
                                onChanged: (field, value) {
                                  _handleChange(index, field, value);
                                },
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 20),
                        ),
                      ),
                      const SizedBox(height: 80),
                      const Text(
                        'double tap on empty space to add more item, and double tap on the item to remove an item',
                        style: TextStyle(color: Colors.black45, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButtonWidget(
              child: const Center(child: Text('submit')),
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                try {
                  TransactionService()
                      .newTransaction(userId, _orders)
                      .then((value) {
                    Navigator.of(context).pop();
                    Toast(context).success("transaction recorded.");
                  });
                } catch (e) {
                  Toast(context).danger('something wrong happened');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
