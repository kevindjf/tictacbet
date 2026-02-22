import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/victory_coin_section.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/victory_trophy_section.dart';

class TutorialVictoryReward extends StatefulWidget {
  const TutorialVictoryReward({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  State<TutorialVictoryReward> createState() => _TutorialVictoryRewardState();
}

class _TutorialVictoryRewardState extends State<TutorialVictoryReward>
    with SingleTickerProviderStateMixin {
  late final AnimationController _coinController;
  late final Animation<int> _coinAnimation;

  @override
  void initState() {
    super.initState();
    _coinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _coinAnimation = IntTween(begin: 0, end: 1000).animate(
      CurvedAnimation(parent: _coinController, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _coinController.forward();
    });
  }

  @override
  void dispose() {
    _coinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: AppPatternBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingXL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const VictoryTrophySection(),
                const SizedBox(height: AppDimensions.spacingXL),
                VictoryCoinSection(coinAnimation: _coinAnimation),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onComplete,
                    child: Text(context.l10n.tutorialStartPlaying),
                  ),
                )
                    .animate()
                    .slideY(
                      begin: 0.4,
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    )
                    .fadeIn(delay: const Duration(milliseconds: 1000)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
