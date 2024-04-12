import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature_app/app/core/utils/app_routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages,
          initialRoute: PagesRoutes.signatureZooming,
        );
      },
    );
  }
}
