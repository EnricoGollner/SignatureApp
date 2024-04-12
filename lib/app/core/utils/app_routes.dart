import 'package:get/get.dart';
import 'package:signature_app/app/pages/signature_pad/signature_pad_page.dart';
import 'package:signature_app/app/pages/signature_zoom/signature_zooming_page.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.signatureZooming, page: () => const SignatureZoomingPage()),
    GetPage(name: PagesRoutes.signaturePad, page: () => const SignaturePadPage()),
  ];
}

abstract class PagesRoutes {
  static const String signatureZooming = '/signatureZooming';
  static const String signaturePad = '/signPad';
}
