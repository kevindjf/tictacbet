import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';

class HomePageIndicator extends StatelessWidget {
  const HomePageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingL,
        vertical: AppDimensions.spacingS,
      ),
      decoration: BoxDecoration(
        color: onSurface.withAlpha(13),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: onSurface.withAlpha(25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(pageCount, (index) {
          final isActive = index == currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: AppDimensions.spacingM - 6,
            height: AppDimensions.spacingM - 6,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : AppDimensions.spacingM,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.neonBlue
                  : onSurface.withAlpha(50),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.neonBlue.withAlpha(180),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
          );
        }),
      ),
    );
  }
}
