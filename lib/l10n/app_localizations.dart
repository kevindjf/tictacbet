import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Bet'**
  String get appTitle;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @trainingDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice without stakes'**
  String get trainingDescription;

  /// No description provided for @competition.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get competition;

  /// No description provided for @competitionDescription.
  ///
  /// In en, this message translates to:
  /// **'Bet coins and compete online'**
  String get competitionDescription;

  /// No description provided for @vsAi.
  ///
  /// In en, this message translates to:
  /// **'vs AI'**
  String get vsAi;

  /// No description provided for @vsLocal.
  ///
  /// In en, this message translates to:
  /// **'vs Local Player'**
  String get vsLocal;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @yourTurn.
  ///
  /// In en, this message translates to:
  /// **'Your turn!'**
  String get yourTurn;

  /// No description provided for @opponentTurn.
  ///
  /// In en, this message translates to:
  /// **'Opponent\'s turn'**
  String get opponentTurn;

  /// No description provided for @playerXTurn.
  ///
  /// In en, this message translates to:
  /// **'Player X\'s turn'**
  String get playerXTurn;

  /// No description provided for @playerOTurn.
  ///
  /// In en, this message translates to:
  /// **'Player O\'s turn'**
  String get playerOTurn;

  /// No description provided for @youWin.
  ///
  /// In en, this message translates to:
  /// **'You win!'**
  String get youWin;

  /// No description provided for @youLose.
  ///
  /// In en, this message translates to:
  /// **'You lose!'**
  String get youLose;

  /// No description provided for @draw.
  ///
  /// In en, this message translates to:
  /// **'It\'s a draw!'**
  String get draw;

  /// No description provided for @playerXWins.
  ///
  /// In en, this message translates to:
  /// **'Player X wins!'**
  String get playerXWins;

  /// No description provided for @playerOWins.
  ///
  /// In en, this message translates to:
  /// **'Player O wins!'**
  String get playerOWins;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get playAgain;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'{amount} coins'**
  String coins(int amount);

  /// No description provided for @betAmount.
  ///
  /// In en, this message translates to:
  /// **'Bet: {amount} coins'**
  String betAmount(int amount);

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @multiplier.
  ///
  /// In en, this message translates to:
  /// **'x{value}'**
  String multiplier(String value);

  /// No description provided for @streakCount.
  ///
  /// In en, this message translates to:
  /// **'{count} wins'**
  String streakCount(int count);

  /// No description provided for @placeBet.
  ///
  /// In en, this message translates to:
  /// **'Place Bet'**
  String get placeBet;

  /// No description provided for @minimumBet.
  ///
  /// In en, this message translates to:
  /// **'Minimum bet: {amount}'**
  String minimumBet(int amount);

  /// No description provided for @insufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get insufficientBalance;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @noGamesYet.
  ///
  /// In en, this message translates to:
  /// **'No games yet'**
  String get noGamesYet;

  /// No description provided for @winRate.
  ///
  /// In en, this message translates to:
  /// **'Win rate'**
  String get winRate;

  /// No description provided for @gamesPlayed.
  ///
  /// In en, this message translates to:
  /// **'Games played'**
  String get gamesPlayed;

  /// No description provided for @wins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// No description provided for @losses.
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get losses;

  /// No description provided for @draws.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get draws;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @replayTutorial.
  ///
  /// In en, this message translates to:
  /// **'Replay tutorial'**
  String get replayTutorial;

  /// No description provided for @lobby.
  ///
  /// In en, this message translates to:
  /// **'Lobby'**
  String get lobby;

  /// No description provided for @createMatch.
  ///
  /// In en, this message translates to:
  /// **'Create Match'**
  String get createMatch;

  /// No description provided for @proposeMatch.
  ///
  /// In en, this message translates to:
  /// **'Propose a match'**
  String get proposeMatch;

  /// No description provided for @acceptMatch.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptMatch;

  /// No description provided for @cancelMatch.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelMatch;

  /// No description provided for @waitingForOpponent.
  ///
  /// In en, this message translates to:
  /// **'Waiting for opponent...'**
  String get waitingForOpponent;

  /// No description provided for @matchAccepted.
  ///
  /// In en, this message translates to:
  /// **'Match accepted!'**
  String get matchAccepted;

  /// No description provided for @noProposals.
  ///
  /// In en, this message translates to:
  /// **'No matches available'**
  String get noProposals;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Tic Tac Bet!'**
  String get welcomeTitle;

  /// No description provided for @onboardingBoard.
  ///
  /// In en, this message translates to:
  /// **'This is the board. Tap a cell to play.'**
  String get onboardingBoard;

  /// No description provided for @onboardingGame.
  ///
  /// In en, this message translates to:
  /// **'Take turns placing your marks to win!'**
  String get onboardingGame;

  /// No description provided for @onboardingBetting.
  ///
  /// In en, this message translates to:
  /// **'Now let\'s spice things up. You have 1000 coins!'**
  String get onboardingBetting;

  /// No description provided for @onboardingStreaks.
  ///
  /// In en, this message translates to:
  /// **'Chain victories to multiply your gains!'**
  String get onboardingStreaks;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @readyToCompete.
  ///
  /// In en, this message translates to:
  /// **'Ready to bet? Switch to competition!'**
  String get readyToCompete;

  /// No description provided for @selectMode.
  ///
  /// In en, this message translates to:
  /// **'Select a mode'**
  String get selectMode;

  /// No description provided for @selectDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Select difficulty'**
  String get selectDifficulty;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// No description provided for @quit.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get quit;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @won.
  ///
  /// In en, this message translates to:
  /// **'Won'**
  String get won;

  /// No description provided for @lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lost;

  /// No description provided for @versus.
  ///
  /// In en, this message translates to:
  /// **'vs'**
  String get versus;

  /// No description provided for @aiOpponent.
  ///
  /// In en, this message translates to:
  /// **'AI ({difficulty})'**
  String aiOpponent(String difficulty);

  /// No description provided for @localOpponent.
  ///
  /// In en, this message translates to:
  /// **'Local Player'**
  String get localOpponent;

  /// No description provided for @onlineOpponent.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get onlineOpponent;

  /// No description provided for @coinsWon.
  ///
  /// In en, this message translates to:
  /// **'+{amount} coins'**
  String coinsWon(int amount);

  /// No description provided for @coinsLost.
  ///
  /// In en, this message translates to:
  /// **'-{amount} coins'**
  String coinsLost(int amount);

  /// No description provided for @bankrupt.
  ///
  /// In en, this message translates to:
  /// **'You\'re out of coins!'**
  String get bankrupt;

  /// No description provided for @bailout.
  ///
  /// In en, this message translates to:
  /// **'Here\'s {amount} coins to get back in the game!'**
  String bailout(int amount);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
