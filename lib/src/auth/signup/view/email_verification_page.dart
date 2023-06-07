import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  static Page<void> page() =>
      const MaterialPage<void>(child: EmailVerificationPage());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Align(
          // alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please verify your account!"),

              SizedBox(
                height: 8,
              ),

              // Submit verification
            ],
          ),
        ),
      ),
    );
  }
}
