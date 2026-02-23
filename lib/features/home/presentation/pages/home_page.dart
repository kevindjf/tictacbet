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
import 'package:tic_tac_bet/features/home/presentation/widgets/home_page_indicator.dart';
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
    final difficulty = ref.watch(difficultySettingProvider);
    final scrim = Theme.of(context).colorScheme.scrim;
    final heroTitles = _heroDataList(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = screenHeight * 0.44;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background crossfade driven by slider position (same idea as title block)
          AnimatedBuilder(
            animation: Listenable.merge([
              _pageController,
              _backgroundMotionController,
            ]),
            builder: (context, _) {
              final page = _pageController.hasClients
                  ? (_pageController.page ?? _currentPage.toDouble())
                  : _currentPage.toDouble();
              final t = _backgroundMotionController.value;

              return Stack(
                fit: StackFit.expand,
                children: [
                  for (var i = 0; i < _backgrounds.length; i++)
                    Opacity(
                      opacity: _backgroundOpacityForPage(page, i),
                      child: Transform.translate(
                        offset: _backgroundOffsetForPage(page, i, t),
                        child: Transform.scale(
                          scale: _backgroundScaleForPage(i, t),
                          child: Image.asset(
                            _backgrounds[i],
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
          ),
          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [scrim.withAlpha(120), scrim.withAlpha(200)],
              ),
            ),
          ),
          // Content
          Column(
            children: [
              const HomeTopBar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppDimensions.spacingM,
                      ),
                      child: AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, _) {
                          final page = _pageController.hasClients
                              ? (_pageController.page ??
                                    _currentPage.toDouble())
                              : _currentPage.toDouble();

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              for (var i = 0; i < heroTitles.length; i++)
                                Opacity(
                                  opacity: _titleOpacityForPage(page, i),
                                  child: IgnorePointer(
                                    ignoring: true,
                                    child: HomeHeroTitle(data: heroTitles[i]),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: carouselHeight,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        children: [
                          HomeCardSlot(
                            child: GameModeCard(
                              title: context.l10n.cashBattle,
                              description: context.l10n.cashBattleDesc,
                              buttonLabel: context.l10n.cashBattlePlay,
                              accentColor: AppColors.neonRed,
                              onTap: () => context.pushNamed('lobby'),
                            ),
                          ),
                          HomeCardSlot(
                            child: GameModeCard(
                              title: context.l10n.cyberBot,
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
                              title: context.l10n.duel1v1,
                              description: context.l10n.duel1v1Desc,
                              buttonLabel: context.l10n.duel1v1Play,
                              accentColor: AppColors.neonGold,
                              onTap: () => context.pushNamed(
                                'game',
                                extra: const GameMode.vsLocal(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppDimensions.spacingXL,
                        top: AppDimensions.spacingM,
                      ),
                      child: HomePageIndicator(
                        currentPage: _currentPage,
                        pageCount: 3,
                      ),
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

  List<HomeHeroTitleData> _heroDataList(BuildContext context) => [
    _buildHeroData(
      title: context.l10n.cashBattle,
      description: context.l10n.cashBattleDesc,
      accent: AppColors.neonGold,
      secondary: const Color(0xFFFFE082),
      bolt: true,
    ),
    _buildHeroData(
      title: context.l10n.cyberBot,
      description: context.l10n.cyberBotDesc,
      accent: AppColors.neonBlue,
      secondary: const Color(0xFFA7F3FF),
      bolt: false,
    ),
    _buildHeroData(
      title: context.l10n.duel1v1,
      description: context.l10n.duel1v1Desc,
      accent: AppColors.neonGold,
      secondary: const Color(0xFFFFF2A8),
      bolt: false,
    ),
  ];

  HomeHeroTitleData _buildHeroData({
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

  double _titleOpacityForPage(double page, int index) {
    final distance = (page - index).abs();
    if (distance >= 1) return 0;
    final t = 1 - distance;
    return Curves.easeOut.transform(t.clamp(0.0, 1.0));
  }

  double _backgroundOpacityForPage(double page, int index) {
    final distance = (page - index).abs();
    if (distance >= 1) return 0;
    final t = 1 - distance;
    return Curves.easeInOut.transform(t.clamp(0.0, 1.0));
  }

  Offset _backgroundOffsetForPage(double page, int index, double timeT) {
    final distance = page - index;

    // Parallax tied to the slider movement (image lags behind foreground)
    final parallaxX = distance * 46;

    // Slow Ken Burns drift (per-image phase offset to avoid identical motion)
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
