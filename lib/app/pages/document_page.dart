import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:signature_app/app/pages/show_image_page.dart';

class DocumentPage extends StatefulWidget {
  final Uint8List signatureBytes;
  final File imageFile;

  const DocumentPage({
    super.key,
    required this.signatureBytes,
    required this.imageFile,
  });

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  late LindiController _lindiController;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _lindiController = LindiController(
      showDone: true,
      showClose: true,
      showFlip: false,
      showStack: false,
      showLock: false,
      showAllBorders: true,
      shouldScale: true,
      shouldRotate: false,
      shouldMove: true,
      minScale: 0.5,
      maxScale: 4,
    );
    _lindiController.addWidget(Image.memory(
      widget.signatureBytes,
      height: 80,
      width: 80,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document'),
        actions: [
          IconButton(
            onPressed: _savePng,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: LindiStickerWidget(
            controller: _lindiController,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.file(widget.imageFile),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _savePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowImagePage(pngBytes: pngBytes)));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
