import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/fetcher/transaction.api.dart';
import 'package:oraboros/main.dart';
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
  List<FocusNode> _focusNameNode = [];
  List<FocusNode> _focusAmountNode = [];
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _orderList = [
    {"budget_id": null, "name": null, "amount": null},
  ];

  @override
  void initState() {
    super.initState();
    _focusNameNode = List.generate(_orderList.length, (index) => FocusNode());
    _focusAmountNode = List.generate(_orderList.length, (index) => FocusNode());
    _controller = _orderList
        .map((item) => ({
              "name": TextEditingController(text: item['name']),
              "amount": TextEditingController(text: item['amount'])
            }))
        .toList();
  }

  void unfocusNode() {
    for (var node in _focusNameNode) {
      if (node.hasFocus) node.unfocus();
    }
    for (var node in _focusAmountNode) {
      if (node.hasFocus) node.unfocus();
    }
  }

  @override
  void dispose() {
    for (var node in _controller) {
      node.forEach((_, value) => value.dispose());
    }
    unfocusNode();
    super.dispose();
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
            const SizedBox(height: 30),
            const Center(child: Text('New transactions')),
            const SizedBox(height: 30),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onDoubleTap: () {
                  unfocusNode();
                  setState(() {
                    _focusNameNode.add(FocusNode());
                    _focusAmountNode.add(FocusNode());
                    _controller.add({
                      "name": TextEditingController(text: null),
                      "amount": TextEditingController(text: null)
                    });
                    _orderList
                        .add({"budget_id": null, "name": null, "amount": null});
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
                          itemCount: _orderList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  unfocusNode();
                                  _focusNameNode.removeAt(index);
                                  _focusAmountNode.removeAt(index);
                                  _controller.removeAt(index);
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
                                          controller: _controller[index]
                                              ['name'],
                                          focusNode: _focusNameNode[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
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
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "field cannot be empty";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (mounted) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                setState(() {
                                                  _orderList[index]['name'] =
                                                      value;
                                                });
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: StreamBuilder<
                                              List<Map<String, dynamic>>>(
                                            stream: supabase
                                                .from("budgets")
                                                .stream(primaryKey: ['id']).eq(
                                              'user_id',
                                              Provider.of<ProfileProvider>(
                                                      context)
                                                  .profile[ProfileProvider.id],
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    "Error: ${snapshot.error}");
                                              } else {
                                                List<Map<String, dynamic>>?
                                                    data = snapshot.data;
                                                Map<String, dynamic>?
                                                    selectedItem;
                                                if (_orderList[index]
                                                            ['budget_id'] !=
                                                        null &&
                                                    data != null) {
                                                  selectedItem =
                                                      data.firstWhere((item) =>
                                                          item['id'] ==
                                                          _orderList[index]
                                                              ['budget_id']);
                                                }
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: Offset(3, 5),
                                                        color:
                                                            Color(0xff122334),
                                                      ),
                                                    ],
                                                  ),
                                                  child:
                                                      DropdownButtonFormField(
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "please pick a category";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5,
                                                      ),
                                                      isDense: true,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color:
                                                              Color(0xff122334),
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color:
                                                              Color(0xff122334),
                                                        ),
                                                      ),
                                                    ),
                                                    isExpanded: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _orderList[index]
                                                                ['budget_id'] =
                                                            value;
                                                      });
                                                    },
                                                    value: _orderList[index]
                                                        ['budget_id'],
                                                    isDense: true,
                                                    hint: Text(
                                                      selectedItem != null
                                                          ? "${selectedItem['icon']} ${selectedItem['name']}"
                                                          : "select an item",
                                                      style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    items: snapshot.data
                                                        ?.map((value) {
                                                      return DropdownMenuItem(
                                                        value: value['id'],
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(value['icon']),
                                                            const SizedBox(
                                                                width: 10),
                                                            Flexible(
                                                              fit:
                                                                  FlexFit.loose,
                                                              child: Text(
                                                                value['name'],
                                                                style:
                                                                    const TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                );
                                              }
                                            },
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
                                              controller: _controller[index]
                                                  ['amount'],
                                              focusNode:
                                                  _focusAmountNode[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                decimal: false,
                                                signed: false,
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                prefix: Text("Rp."),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.zero),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff122334),
                                                      width: 1),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xff122334),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                labelStyle: TextStyle(
                                                  color: Color(0xff122334),
                                                  fontSize: 14,
                                                ),
                                                label: Text("amount"),
                                                floatingLabelAlignment:
                                                    FloatingLabelAlignment
                                                        .start,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "please input a number";
                                                } else if (int.parse(value) <
                                                    1) {
                                                  return "field cannot be zero";
                                                }
                                                return null;
                                              },
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value.isEmpty) {
                                                    _orderList[index]
                                                        ['amount'] = 0;
                                                  } else {
                                                    _orderList[index]
                                                            ['amount'] =
                                                        int.parse(value);
                                                  }
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
                _formKey.currentState!.validate();
                if (_orderList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      dismissDirection: DismissDirection.horizontal,
                      content: Text(
                        'At least one item on the field',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 100),
                    ),
                  );
                  return;
                }
                newTransaction(userId, _orderList).then((value) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 100),
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 100),
                      content: Text(err),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
