import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.prefix,
    this.label,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.errorMessage,
    required this.placeholder,
  });

  final Widget? prefix;
  final Widget? label;
  final void Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final String? errorMessage;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String placeholder;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final String errorMessage = widget.errorMessage ?? "";
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: const Color(0xff122334)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff122334),
                  offset: Offset(3, 5),
                ),
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.placeholder,
                label: widget.label,
                prefix: widget.prefix,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorStyle: const TextStyle(height: 0),
              ),
              style: Theme.of(context).textTheme.bodySmall,
              inputFormatters: widget.inputFormatters,
            ),
          ),
          Offstage(
            offstage: errorMessage.isEmpty,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
