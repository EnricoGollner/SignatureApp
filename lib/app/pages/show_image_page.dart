import 'dart:typed_data';

import 'package:flutter/material.dart';

class ShowImagePage extends StatelessWidget {
  final Uint8List? pngBytes;

  const ShowImagePage({super.key, this.pngBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Image'),
      ),
      body: Center(
        child: Image.memory(pngBytes!),
      ),
    );
  }
}
