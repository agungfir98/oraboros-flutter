import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget(
      {super.key,
      required this.title,
      required this.onOk,
      required this.content});

  final String title;
  final Widget content;
  final Function() onOk;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          border: Border.all(color: const Color(0xff122334), width: 1),
          boxShadow: const [
            BoxShadow(color: Color(0xff122334), offset: Offset(5, 5)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              content,
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          border: Border.all(
                            color: const Color(0xff122334),
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff122334),
                              offset: Offset(3, 5),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        child: Text(
                          "cancel",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: onOk,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          border: Border.all(
                            color: const Color(0xff122334),
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff122334),
                              offset: Offset(3, 5),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        child: Text(
                          'confirm',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
