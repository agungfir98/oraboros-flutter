import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget(
      {super.key, required this.child, required this.onTap});

  final Widget child;
  final Function()? onTap;

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isTapped = false;
        });
        widget.onTap!();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 29, 37, 48),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              _isTapped
                  ? const BoxShadow(
                      color: Color.fromARGB(255, 29, 37, 48),
                      offset: Offset(0, 0),
                    )
                  : const BoxShadow(
                      color: Color.fromARGB(255, 29, 37, 48),
                      offset: Offset(5, 5),
                    )
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
