import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:signature_app/app/components/custom_drawer.dart';
import 'package:signature_app/app/core/utils/app_routes.dart';
import 'package:signature_app/app/pages/signature_zoom/show_image_page.dart';
import 'package:sizer/sizer.dart';

class SignatureZoomingPage extends StatefulWidget {
  const SignatureZoomingPage({super.key});

  @override
  State<SignatureZoomingPage> createState() => _SignatureZoomingPageState();
}

class _SignatureZoomingPageState extends State<SignatureZoomingPage> {
  late SignatureController _signatureController;
  Uint8List? signatureBytes;
  double _scale = 1.0;
  Offset _offset = Offset.zero;

  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _signatureController = SignatureController(
      disabled: true,
      penStrokeWidth: 0.7,
      penColor: Colors.black,
      exportBackgroundColor: Colors.transparent,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _signatureController.clear();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    context.orientation;

    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      drawer: CustomDrawer(
        selectedItemIndex: 0,
        signatureZoomingOnTap: () => Get.back(),
        signatureWithPadOnTap: () => Get.offNamed(PagesRoutes.signaturePad),
      ),
      appBar: AppBar(
        title: const Text('Signature Zooming'),
        actions: [
              IconButton(
                icon: const Icon(Icons.cleaning_services_outlined),
                onPressed: _cleanSignature,
              ),
              Visibility(
                visible: _scale != 1,
                replacement: IconButton(
                  onPressed: () async {
                    if (_signatureController.isEmpty) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const SizedBox(),
                        messageText: const Text(
                          'Please, sign the document before saving it!',
                        ),
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }
                    await _savePng();
                  },
                  icon: const Icon(Icons.save),
                ),
                child: IconButton(
                  onPressed: _ajustarZoom,
                  icon: const Icon(Icons.done),
                ),
              ),
            ],
      ),
      body: GestureDetector(
        onTapDown: _scale == 1
            ? (details) {
                _offset = details.localPosition;
                _ajustarZoom();
              }
            : null,
        child: Transform.scale(
          alignment: _getAlignment(context),
          origin: _offset,
          scale: _scale,
          child: RepaintBoundary(
            key: _globalKey,
            child: Stack(
              alignment: Alignment.center,
              children: _buildDocumentToSign(),
            ),
          ),
        ),
      ),
    );
  }

  void _handleOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  AlignmentGeometry _getAlignment(context) {
    double altura = MediaQuery.of(context).size.height / 1.8;
    double largura = MediaQuery.of(context).size.width / 2;

    if (_offset.dx <= largura) {
      return _offset.dy <= altura ? Alignment.topLeft : Alignment.centerLeft;
    } else {
      return _offset.dy <= altura ? Alignment.topCenter : Alignment.center;
    }
  }

  void _ajustarZoom() {
    setState(() {
      bool zoomIsDisabled = _scale != 1.0;
      _scale = zoomIsDisabled ? 1.0 : 1.8;
      _signatureController.disabled = zoomIsDisabled;
    });
  }

  Future<void> _savePng() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowImagePage(pngBytes: pngBytes)));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _cleanSignature() {
    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Nenhuma assinatura para limpar!'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar'),
        content: const Text('Deseja limpar a(s) assinaturas?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              _signatureController.clear();
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDocumentToSign() {
    final bool isPortrait = SizerUtil.orientation == Orientation.portrait;
    
    final double height = isPortrait ? 65.h : 45.h;
    final double width = isPortrait ? 75.5.w : 58.w;

    return [
      Image.asset(
        height: height,
        'assets/document.png',
        fit: BoxFit.contain,
      ),
      Signature(
        height: height,
        width: width,
        controller: _signatureController,
        backgroundColor: Colors.transparent,
      ),
    ];
  }
}
