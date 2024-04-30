import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/components/custom_text_form_field.dart';
import 'package:oraboros/components/toaster.dart';
import 'package:oraboros/services/budget.service.dart';

class NewBudgetSheet extends StatefulWidget {
  const NewBudgetSheet({super.key});

  @override
  State<NewBudgetSheet> createState() => _NewBudgetSheetState();
}

class _NewBudgetSheetState extends State<NewBudgetSheet> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _emojiController = TextEditingController();
  final _emojiScrollController = ScrollController();
  final Map<String, TextEditingController> _controller = {};
  bool _showEmojiPicker = false;
  bool _canPop = true;
  final Map<String, String> _formFieldError = {};
  final Map<String, dynamic> _budgetState = {
    NewBudgetDTO.nameKey: null,
    NewBudgetDTO.iconKey: null,
    NewBudgetDTO.amountKey: ''
  };

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(_onFocusChange);
    _amountFocusNode.addListener(_onFocusChange);
    _controller[NewBudgetDTO.nameKey] =
        TextEditingController(text: _budgetState[NewBudgetDTO.nameKey]);
    _controller[NewBudgetDTO.iconKey] =
        TextEditingController(text: _budgetState[NewBudgetDTO.iconKey]);
    _controller[NewBudgetDTO.amountKey] = TextEditingController(
        text: _budgetState[NewBudgetDTO.amountKey].toString());

    _budgetState.forEach(
      (key, value) {
        _formFieldError[key] = "";
      },
    );
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_onFocusChange);
    _amountFocusNode.removeListener(_onFocusChange);
    _nameFocusNode.dispose();
    _amountFocusNode.dispose();
    _controller.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      if (_nameFocusNode.hasFocus || _amountFocusNode.hasFocus) {
        _showEmojiPicker = false;
        _canPop = true;
      }
    });
  }

  void onChangeIcon(value) {
    setState(() {
      _budgetState[NewBudgetDTO.iconKey] = value;
      _controller[NewBudgetDTO.iconKey]?.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: (didPop) {
        if (!_canPop) {
          setState(() {
            _showEmojiPicker = !_showEmojiPicker;
            _canPop = !_canPop;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(child: Text('new budget')),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              placeholder: "name",
                              controller: _controller[NewBudgetDTO.nameKey],
                              focusNode: _nameFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    _formFieldError[NewBudgetDTO.nameKey] = '';
                                  }
                                  _budgetState[NewBudgetDTO.nameKey] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _formFieldError[NewBudgetDTO.nameKey] =
                                        "this field must not be empty";
                                  });
                                  return "";
                                }
                                return null;
                              },
                              errorMessage:
                                  _formFieldError[NewBudgetDTO.nameKey] ?? "",
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _nameFocusNode.unfocus();
                                    _amountFocusNode.unfocus();
                                    setState(() {
                                      _canPop = _showEmojiPicker;
                                      _showEmojiPicker = !_showEmojiPicker;
                                    });
                                  },
                                  icon: const Icon(
                                    size: 32,
                                    Icons.emoji_emotions_outlined,
                                    color: Color(0xff122334),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "pick an emoji";
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    readOnly: true,
                                    style: const TextStyle(fontSize: 24),
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      border: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 16),
                                      hintText: "emoji",
                                    ),
                                    controller:
                                        _controller[NewBudgetDTO.iconKey],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              placeholder: "amount",
                              prefix: const Text("Rp. "),
                              controller: _controller[NewBudgetDTO.amountKey],
                              focusNode: _amountFocusNode,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              ),
                              errorMessage:
                                  _formFieldError[NewBudgetDTO.amountKey] ?? "",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _formFieldError[NewBudgetDTO.amountKey] =
                                        "this field can't be empty";
                                  });
                                  return "";
                                } else if (int.parse(value) < 1) {
                                  setState(() {
                                    _formFieldError[NewBudgetDTO.amountKey] =
                                        "value must be greater than zero";
                                  });
                                  return "";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _budgetState[NewBudgetDTO.amountKey] = "";
                                  } else {
                                    _formFieldError[NewBudgetDTO.amountKey] =
                                        "";
                                    _budgetState[NewBudgetDTO.amountKey] =
                                        int.parse(value);
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 48),
                            CustomButtonWidget(
                              child: const Center(
                                child: Text('submit'),
                              ),
                              onTap: () {
                                try {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  BudgetService()
                                      .newBudget(
                                          NewBudgetDTO.fromJson(_budgetState))
                                      .then(
                                    (value) {
                                      Navigator.of(context).pop();
                                      Toast(context).success(
                                        "budget successfully created",
                                      );
                                    },
                                  );
                                } catch (e) {
                                  Toast(context).danger(
                                    "something went wrong with the server",
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Offstage(
              offstage: !_showEmojiPicker,
              child: EmojiPicker(
                scrollController: _emojiScrollController,
                textEditingController: _emojiController,
                onEmojiSelected: (category, emoji) {
                  onChangeIcon(emoji.emoji);
                },
                onBackspacePressed: () {
                  onChangeIcon(null);
                },
                config: Config(
                  height: 300,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 28 *
                        (defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.20
                            : 1.0),
                  ),
                  swapCategoryAndBottomBar: false,
                  skinToneConfig: const SkinToneConfig(),
                  categoryViewConfig: const CategoryViewConfig(
                    iconColorSelected: Color(0xff122334),
                    indicatorColor: Color(0xff122334),
                  ),
                  bottomActionBarConfig: const BottomActionBarConfig(
                    buttonColor: Colors.transparent,
                    backgroundColor: Color(0xFFEBEFF2),
                    buttonIconColor: Color(0xff122334),
                  ),
                  searchViewConfig: const SearchViewConfig(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
