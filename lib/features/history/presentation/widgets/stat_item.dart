import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXS),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
