import 'package:flutter/material.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/fetcher/transaction.api.dart';
import 'package:oraboros/main.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:provider/provider.dart';

class BottomSheetModal extends StatefulWidget {
  const BottomSheetModal({
    super.key,
  });

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _orderList = [
    {"budget_id": null, "name": null, "amount": 0},
  ];

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<ProfileProvider>(context).profile['id'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          const Center(child: Text('New transactions')),
          const SizedBox(height: 30),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _orderList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            _orderList.removeAt(index);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xff122334),
                                            offset: Offset(3, 5))
                                      ]),
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero),
                                        borderSide: BorderSide(
                                            color: Color(0xff122334), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff122334), width: 1),
                                        borderRadius:
                                            BorderRadius.all(Radius.zero),
                                      ),
                                      labelStyle: TextStyle(
                                        color: Color(0xff122334),
                                        fontSize: 14,
                                      ),
                                      label: Text("name"),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                    ),
                                    onChanged: (value) {
                                      if (mounted) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          setState(() {
                                            _orderList[index]['name'] = value;
                                          });
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: const Color(0xff122334),
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color(0xff122334),
                                                offset: Offset(3, 5))
                                          ]),
                                      child: StreamBuilder<
                                          List<Map<String, dynamic>>>(
                                        stream: supabase
                                            .from("budgets")
                                            .stream(primaryKey: ['id']).eq(
                                          'user_id',
                                          Provider.of<ProfileProvider>(context)
                                              .profile[ProfileProvider.id],
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                "Error: ${snapshot.error}");
                                          } else {
                                            List<Map<String, dynamic>>? data =
                                                snapshot.data;

                                            Map<String, dynamic>? selectedItem;
                                            if (_orderList[index]
                                                        ['budget_id'] !=
                                                    null &&
                                                data != null) {
                                              selectedItem = data.firstWhere(
                                                  (item) =>
                                                      item['id'] ==
                                                      _orderList[index]
                                                          ['budget_id']);
                                            }
                                            return DropdownButton(
                                              onChanged: (value) {
                                                setState(() {
                                                  _orderList[index]
                                                      ['budget_id'] = value;
                                                });
                                              },
                                              value: _orderList[index]
                                                  ['budget_id'],
                                              isDense: true,
                                              hint: Text(selectedItem != null
                                                  ? "${selectedItem['icon']} ${selectedItem['name']}"
                                                  : "select an item"),
                                              items:
                                                  snapshot.data?.map((value) {
                                                return DropdownMenuItem(
                                                  value: value['id'],
                                                  child: Row(
                                                    children: [
                                                      Text(value['icon']),
                                                      const SizedBox(width: 10),
                                                      Text(value['name']),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xff122334),
                                                offset: Offset(3, 5))
                                          ]),
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          prefix: Text("Rp."),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero),
                                            borderSide: BorderSide(
                                                color: Color(0xff122334),
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff122334),
                                                width: 1),
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Color(0xff122334),
                                            fontSize: 14,
                                          ),
                                          label: Text("amount"),
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _orderList[index]['amount'] =
                                                int.parse(value);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          CustomButtonWidget(
            onTap: () {
              setState(() {
                _orderList.add(
                  {"budget_id": null, "name": null, "amount": 0},
                );
              });
            },
            child: const Center(child: Text("add")),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButtonWidget(
            child: const Center(child: Text('submit')),
            onTap: () {
              newTransaction(userId, _orderList).then((value) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'success',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green[400],
                          ),
                    ),
                  ),
                );
              }).catchError((err) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(err),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
