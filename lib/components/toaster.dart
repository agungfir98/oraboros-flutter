import 'package:flutter/material.dart';

class _CustomSnackBar {
  final BuildContext context;

  _CustomSnackBar(this.context);

  void show({
    required Widget child,
    Duration? duration,
    Color? backgroundColor = Colors.transparent,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 4),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        elevation: 0,
        padding: const EdgeInsets.all(5),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(offset: Offset(3, 5), color: Color(0xff122334)),
            ],
            color: backgroundColor,
            border: Border.all(
              width: 1,
              color: const Color(0xff122334),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class Toast {
  final BuildContext context;

  Toast(this.context);

  success(String message) {
    _CustomSnackBar(context).show(
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xff122334),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.green[300],
    );
  }

  danger(String message) {
    _CustomSnackBar(context).show(
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xff122334),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.red[300],
    );
  }
}
