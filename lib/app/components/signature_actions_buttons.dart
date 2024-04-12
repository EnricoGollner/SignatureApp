import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signature/signature.dart';

class SignatureActionsButtons extends StatelessWidget {
  final SignatureController signatureController;

  const SignatureActionsButtons({super.key, required this.signatureController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => signatureController.undo(),
          icon: const Icon(Icons.undo),
        ),
        IconButton(
          onPressed: () => signatureController.redo(),
          icon: const Icon(Icons.redo),
        ),
      ],
    );
  }
}
