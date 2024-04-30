import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/DTO/transaction.dto.dart';
import 'package:oraboros/components/custom_dropdown.dart';
import 'package:oraboros/components/custom_text_form_field.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:oraboros/services/budget.service.dart';
import 'package:provider/provider.dart';

class FormItem extends StatefulWidget {
  const FormItem({
    super.key,
    required this.order,
    required this.onChanged,
    required this.itemController,
  });
  final TransactionDTO order;
  final void Function(String field, dynamic value) onChanged;
  final Map<String, TextEditingController> itemController;

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  final Map<String, String> _formFieldError = {
    "name": "",
    "budget_id": "",
    "amount": "",
  };

  @override
  void initState() {
    super.initState();
  }

  void _onChangeValidation(String field, String? value) {
    switch (field) {
      case "name":
        setState(() {
          if (value!.isEmpty) {
            _formFieldError[field] = "field can not be empty";
            return;
          } else {
            _formFieldError[field] = "";
            return;
          }
        });
        break;
      case "amount":
        setState(() {
          if (value!.isEmpty) {
            _formFieldError[field] = "field can not be empty";
            return;
          }
          if (int.parse(value) < 1) {
            _formFieldError[field] = "amount can't be zero";
            return;
          }
          _formFieldError[field] = "";
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    String userId = context.read<ProfileProvider>().profile[ProfileProvider.id];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            placeholder: "name",
            controller: widget.itemController['name'],
            onChanged: (value) {
              _onChangeValidation('name', value);
              if (mounted) {
                widget.onChanged("name", value);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  _formFieldError['name'] = "name can't be empty";
                });
                return "";
              }
              return null;
            },
            errorMessage: _formFieldError['name'] ?? "",
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: FutureBuilder<List<UserBudgetDTO>>(
                  future: BudgetService().getUserBudget(userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      List<UserBudgetDTO>? data = snapshot.data;
                      UserBudgetDTO? selectedItem;
                      if (widget.order.budgetid != null && data != null) {
                        selectedItem = data.firstWhere(
                            (item) => item.id == widget.order.budgetid);
                      }
                      return CustomDropDownFormField(
                        validator: (value) {
                          if (value == null) {
                            setState(() {
                              _formFieldError['budget_id'] =
                                  "this field can't be empty";
                            });
                            return "";
                          }
                          return null;
                        },
                        errorMessage: _formFieldError['budget_id'],
                        onChanged: (value) {
                          widget.onChanged('budget_id', value);
                          setState(() {
                            _formFieldError['budget_id'] = "";
                          });
                        },
                        value: widget.order.budgetid,
                        hint: Text(
                          selectedItem != null
                              ? "${selectedItem.icon} ${selectedItem.name}"
                              : "select an item",
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        items: snapshot.data?.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(value.icon!),
                                const SizedBox(width: 10),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    value.name!,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomTextFormField(
                  controller: widget.itemController['amount'],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  placeholder: "amount",
                  prefix: const Text("Rp. "),
                  onChanged: (value) {
                    _onChangeValidation('amount', value);
                    widget.onChanged("amount", value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _formFieldError['amount'] = "please input a number";
                      });
                      return "";
                    } else if (int.parse(value) < 1) {
                      setState(() {
                        _formFieldError['amount'] = "field cannot be zero";
                      });
                      return "";
                    }
                    return null;
                  },
                  errorMessage: _formFieldError['amount'] ?? "",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
