import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';

class HomeCardSlot extends StatelessWidget {
  const HomeCardSlot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingS),
      child: Align(alignment: Alignment.bottomCenter, child: child),
    );
  }
}
