import 'package:flutter/material.dart';

class HomeCardSlot extends StatelessWidget {
  const HomeCardSlot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.bottomCenter, child: child);
  }
}
