import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/game_mode_card.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/home_card_slot.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/home_hero_title.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/home_top_bar.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

const _backgrounds = [
  'assets/images/background_ranked.png',
  'assets/images/background_human_vs_ia.png',
  'assets/images/background_local_players.png',
];

const _accentColors = [
  AppColors.neonRed,
  AppColors.neonBlue,
  AppColors.neonGold,
];

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 0.85);
  late final AnimationController _backgroundMotionController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _backgroundMotionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundMotionController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final difficulty = ref.watch(difficultyControllerProvider);
    final heroTitles = _buildHomeHeroDataList(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = screenHeight * 0.44;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _HomeBackgroundCrossfade(
            pageController: _pageController,
            backgroundMotionController: _backgroundMotionController,
            currentPage: _currentPage,
            backgrounds: _backgrounds,
          ),
          const _HomeDarkOverlay(),
          Column(
            children: [
              HomeTopBar(accentColor: _accentColors[_currentPage]),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _HomeHeroTitleCarousel(
                      pageController: _pageController,
                      currentPage: _currentPage,
                      heroTitles: heroTitles,
                    ),
                    SizedBox(
                      height: carouselHeight,
                      child: _HomeGameModeCarousel(
                        pageController: _pageController,
                        difficulty: difficulty,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                      ),
                    ),
                    SizedBox(
                      height:
                          MediaQuery.of(context).padding.bottom +
                          AppDimensions.spacingL,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeBackgroundCrossfade extends StatelessWidget {
  const _HomeBackgroundCrossfade({
    required this.pageController,
    required this.backgroundMotionController,
    required this.currentPage,
    required this.backgrounds,
  });

  final PageController pageController;
  final AnimationController backgroundMotionController;
  final int currentPage;
  final List<String> backgrounds;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([pageController, backgroundMotionController]),
      builder: (context, _) {
        final page = pageController.hasClients
            ? (pageController.page ?? currentPage.toDouble())
            : currentPage.toDouble();
        final t = backgroundMotionController.value;

        return Stack(
          fit: StackFit.expand,
          children: [
            for (var i = 0; i < backgrounds.length; i++)
              Opacity(
                opacity: _backgroundOpacityForPage(page, i),
                child: Transform.translate(
                  offset: _backgroundOffsetForPage(page, i, t),
                  child: Transform.scale(
                    scale: _backgroundScaleForPage(i, t),
                    child: Image.asset(
                      backgrounds[i],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  double _backgroundOpacityForPage(double page, int index) {
    final distance = (page - index).abs();
    if (distance >= 1) return 0;
    final t = 1 - distance;
    return Curves.easeInOut.transform(t.clamp(0.0, 1.0));
  }

  Offset _backgroundOffsetForPage(double page, int index, double timeT) {
    final distance = page - index;
    final parallaxX = distance * 46;
    final phase = (timeT * 2 * math.pi) + (index * 0.9);
    final driftX = math.sin(phase) * 14;
    final driftY = math.cos(phase * 0.7) * 10;

    return Offset(parallaxX + driftX, driftY);
  }

  double _backgroundScaleForPage(int index, double timeT) {
    final phase = (timeT * 2 * math.pi) + (index * 0.6);
    return 1.14 + (math.sin(phase * 0.8) * 0.028);
  }
}

class _HomeDarkOverlay extends StatelessWidget {
  const _HomeDarkOverlay();

  @override
  Widget build(BuildContext context) {
    final scrim = Theme.of(context).colorScheme.scrim;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [scrim.withAlpha(120), scrim.withAlpha(200)],
        ),
      ),
    );
  }
}

class _HomeHeroTitleCarousel extends StatelessWidget {
  const _HomeHeroTitleCarousel({
    required this.pageController,
    required this.currentPage,
    required this.heroTitles,
  });

  final PageController pageController;
  final int currentPage;
  final List<HomeHeroTitleData> heroTitles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingM),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, _) {
          final page = pageController.hasClients
              ? (pageController.page ?? currentPage.toDouble())
              : currentPage.toDouble();

          return Stack(
            alignment: Alignment.center,
            children: [
              for (var i = 0; i < heroTitles.length; i++)
                Opacity(
                  opacity: _titleOpacityForPage(page, i),
                  child: IgnorePointer(
                    child: HomeHeroTitle(data: heroTitles[i]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  double _titleOpacityForPage(double page, int index) {
    final distance = (page - index).abs();
    if (distance >= 1) return 0;
    final t = 1 - distance;
    return Curves.easeOut.transform(t.clamp(0.0, 1.0));
  }
}

class _HomeGameModeCarousel extends StatelessWidget {
  const _HomeGameModeCarousel({
    required this.pageController,
    required this.difficulty,
    required this.onPageChanged,
  });

  final PageController pageController;
  final dynamic difficulty;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      children: [
        HomeCardSlot(
          child: GameModeCard(
            tagline: context.l10n.cashBattleTagline,
            description: context.l10n.cashBattleDesc,
            buttonLabel: context.l10n.cashBattlePlay,
            accentColor: AppColors.neonRed,
            onTap: () => context.pushNamed('lobby'),
          ),
        ),
        HomeCardSlot(
          child: GameModeCard(
            tagline: context.l10n.cyberBotTagline,
            description: context.l10n.cyberBotDesc,
            buttonLabel: context.l10n.cyberBotPlay,
            accentColor: AppColors.neonBlue,
            onTap: () => context.pushNamed(
              'game',
              extra: GameMode.vsAi(difficulty: difficulty),
            ),
          ),
        ),
        HomeCardSlot(
          child: GameModeCard(
            tagline: context.l10n.duel1v1Tagline,
            description: context.l10n.duel1v1Desc,
            buttonLabel: context.l10n.duel1v1Play,
            accentColor: AppColors.neonGold,
            onTap: () =>
                context.pushNamed('game', extra: const GameMode.vsLocal()),
          ),
        ),
      ],
    );
  }
}

List<HomeHeroTitleData> _buildHomeHeroDataList(BuildContext context) => [
  _buildHomeHeroData(
    title: context.l10n.cashBattle,
    description: context.l10n.cashBattleDesc,
    accent: AppColors.neonGold,
    secondary: AppColors.neonRedLight,
    bolt: true,
  ),
  _buildHomeHeroData(
    title: context.l10n.cyberBot,
    description: context.l10n.cyberBotDesc,
    accent: AppColors.neonBlue,
    secondary: AppColors.neonBlueLight,
    bolt: false,
  ),
  _buildHomeHeroData(
    title: context.l10n.duel1v1,
    description: context.l10n.duel1v1Desc,
    accent: AppColors.neonGold,
    secondary: AppColors.neonGoldLight,
    bolt: false,
  ),
];

HomeHeroTitleData _buildHomeHeroData({
  required String title,
  required String description,
  required Color accent,
  required Color secondary,
  required bool bolt,
}) {
  final lines = title.split('\n');
  final line1 = lines.isNotEmpty ? lines.first : title;
  final line2 = lines.length > 1 ? lines.sublist(1).join(' ') : '';
  final subtitleWords = description.split(' ');
  final splitIndex = subtitleWords.length > 4 ? 4 : subtitleWords.length;

  return HomeHeroTitleData(
    line1: line1,
    line2: line2,
    subtitleLine1: subtitleWords.take(splitIndex).join(' '),
    subtitleLine2: subtitleWords.skip(splitIndex).join(' '),
    accentColor: accent,
    secondaryAccentColor: secondary,
    showBolt: bolt,
  );
}
