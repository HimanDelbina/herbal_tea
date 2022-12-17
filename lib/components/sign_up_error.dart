import 'package:flutter/material.dart';

class SignUpError extends StatelessWidget {
  const SignUpError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: const [
          Spacer(),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("data"))
        ],
      ),
    );
  }
}
