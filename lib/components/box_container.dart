import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: const Color(0xff122334),
          width: 1,
        ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(5, 5),
            color: Color(0xff122334),
          ),
        ],
      ),
      child: child,
    );
  }
}
