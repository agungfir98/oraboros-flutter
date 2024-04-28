import 'package:flutter/material.dart';

class CustomDropDownFormField extends StatefulWidget {
  const CustomDropDownFormField({
    super.key,
    required this.onChanged,
    required this.value,
    required this.items,
    this.hint,
    this.errorMessage,
    this.validator,
  });
  final void Function(Object? value)? onChanged;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final Widget? hint;
  final String? errorMessage;
  final String? Function(Object?)? validator;

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  @override
  Widget build(BuildContext context) {
    String errorMessage = widget.errorMessage ?? "";
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xff122334)),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(3, 5),
                  color: Color(0xff122334),
                ),
              ],
            ),
            child: DropdownButtonFormField(
              value: widget.value,
              validator: widget.validator,
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xff122334),
                  ),
                ),
                errorStyle: TextStyle(height: 0),
              ),
              isExpanded: true,
              autovalidateMode: AutovalidateMode.disabled,
              onChanged: widget.onChanged,
              isDense: true,
              style: Theme.of(context).textTheme.bodySmall,
              hint: widget.hint,
              items: widget.items,
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
