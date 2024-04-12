import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final int selectedItemIndex;
  final void Function() signatureZoomingOnTap;
  final void Function() signatureWithPadOnTap;

  const CustomDrawer({
    super.key,
    required this.selectedItemIndex,
    required this.signatureZoomingOnTap,
    required this.signatureWithPadOnTap,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Text(
              'Signature',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          ListTile(
            selected: widget.selectedItemIndex == 0,
            title: const Text(
              'Signature Zooming',
              style: TextStyle(fontSize: 18),
            ),
            onTap: widget.signatureZoomingOnTap,
          ),
          ListTile(
            selected: widget.selectedItemIndex == 1,
            title: const Text(
              'Signature with Pad',
              style: TextStyle(fontSize: 18),
            ),
            onTap: widget.signatureWithPadOnTap,
          ),
        ],
      ),
    );
  }
}
