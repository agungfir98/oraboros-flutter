import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oraboros/components/button.dart';
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

  final Map<String, dynamic> _budgetState = {
    "name": null,
    "icon": null,
    "amount": ''
  };

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(_onFocusChange);
    _amountFocusNode.addListener(_onFocusChange);
    _controller['name'] = TextEditingController(text: _budgetState['name']);
    _controller['amount'] =
        TextEditingController(text: _budgetState['amount'].toString());
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_onFocusChange);
    _amountFocusNode.removeListener(_onFocusChange);
    _nameFocusNode.dispose();
    _amountFocusNode.dispose();
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
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const Center(child: Text('new budget')),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff122334),
                                offset: Offset(3, 5),
                              )
                            ],
                          ),
                          child: TextFormField(
                            controller: _controller['name'],
                            focusNode: _nameFocusNode,
                            decoration: const InputDecoration(
                              label: Text("name"),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Color(0xff122334),
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Color(0xff122334),
                                  width: 1,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _budgetState['name'] = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
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
                            Text(
                              _budgetState['icon'] ?? "pick an emoji",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    _budgetState['icon'] != null ? 24 : 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff122334),
                                offset: Offset(3, 5),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _controller['amount'],
                            focusNode: _amountFocusNode,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Color(0xff122334),
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Color(0xff122334),
                                  width: 1,
                                ),
                              ),
                              label: Text("amount"),
                              prefix: Text('Rp.'),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _budgetState['amount'] = "";
                                } else {
                                  _budgetState['amount'] = int.parse(value);
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 48),
                        CustomButtonWidget(
                          child: const Center(
                            child: Text('submit'),
                          ),
                          onTap: () {
                            try {
                              BudgetService().newBudget(_budgetState).then(
                                (value) {
                                  Navigator.of(context).pop();
                                  Toast(context)
                                      .success("budget successfully created");
                                },
                              );
                            } catch (e) {
                              print('error nih: ${e.toString()}');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !_showEmojiPicker,
              child: EmojiPicker(
                scrollController: _emojiScrollController,
                textEditingController: _emojiController,
                onEmojiSelected: (category, emoji) {
                  setState(() {
                    _budgetState['icon'] = emoji.emoji;
                  });
                },
                onBackspacePressed: () {
                  setState(() {
                    _budgetState['icon'] = null;
                  });
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
