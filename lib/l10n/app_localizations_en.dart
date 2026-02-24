// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Bet';

  @override
  String get training => 'Training';

  @override
  String get trainingDescription => 'Practice without stakes';

  @override
  String get competition => 'Competition';

  @override
  String get competitionDescription => 'Bet coins and compete online';

  @override
  String get vsAi => 'vs AI';

  @override
  String get vsLocal => 'vs Local Player';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get yourTurn => 'Your turn!';

  @override
  String get opponentTurn => 'Opponent\'s turn';

  @override
  String opponentTurnNamed(String name) {
    return '$name\'s turn';
  }

  @override
  String get playerXTurn => 'Player X\'s turn';

  @override
  String get playerOTurn => 'Player O\'s turn';

  @override
  String get youWin => 'You win!';

  @override
  String get youLose => 'You lose!';

  @override
  String get draw => 'It\'s a draw!';

  @override
  String get playerXWins => 'Player X wins!';

  @override
  String get playerOWins => 'Player O wins!';

  @override
  String get playAgain => 'Play again';

  @override
  String get backToHome => 'Back to home';

  @override
  String coins(int amount) {
    return '$amount coins';
  }

  @override
  String betAmount(int amount) {
    return 'Bet: $amount coins';
  }

  @override
  String get balance => 'Balance';

  @override
  String multiplier(String value) {
    return 'x$value';
  }

  @override
  String get placeBet => 'Place Bet';

  @override
  String minimumBet(int amount) {
    return 'Minimum bet: $amount';
  }

  @override
  String get insufficientBalance => 'Insufficient balance';

  @override
  String get history => 'History';

  @override
  String get statistics => 'Statistics';

  @override
  String get noGamesYet => 'No games yet';

  @override
  String get winRate => 'Win rate';

  @override
  String get gamesPlayed => 'Games played';

  @override
  String get wins => 'Wins';

  @override
  String get losses => 'Losses';

  @override
  String get draws => 'Draws';

  @override
  String get settings => 'Settings';

  @override
  String get rulesSectionTitle => 'Rules';

  @override
  String get rulesSectionIntro => 'Quick reminder of match outcomes:';

  @override
  String get rulesWinDescription =>
      'Align 3 of your symbols before your opponent.';

  @override
  String get rulesLossDescription =>
      'Your opponent aligns 3 symbols before you.';

  @override
  String get rulesDrawDescription =>
      'The board is full and no player aligned 3 symbols.';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get lightMode => 'Light mode';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'French';

  @override
  String get replayTutorial => 'Replay tutorial';

  @override
  String get replayTutorialConfirmTitle => 'Replay tutorial?';

  @override
  String get replayTutorialConfirmMessage =>
      'This will reset the tutorial progress and open onboarding again.';

  @override
  String get lobby => 'Lobby';

  @override
  String get createMatch => 'Create Match';

  @override
  String get proposeMatch => 'Propose a match';

  @override
  String get acceptMatch => 'Accept';

  @override
  String get cancelMatch => 'Cancel';

  @override
  String get waitingForOpponent => 'Waiting for opponent...';

  @override
  String get matchAccepted => 'Match accepted!';

  @override
  String get simulateOpponent => 'Simulate opponent';

  @override
  String get noProposals => 'No matches available';

  @override
  String get login => 'Log in';

  @override
  String get signUp => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get logout => 'Log out';

  @override
  String get welcomeTitle => 'Welcome to Tic Tac Bet!';

  @override
  String get onboardingBoard => 'This is the board. Tap a cell to play.';

  @override
  String get onboardingGame => 'Take turns placing your marks to win!';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get started';

  @override
  String get readyToCompete => 'Ready to bet? Switch to competition!';

  @override
  String get selectMode => 'Select a mode';

  @override
  String get selectDifficulty => 'Select difficulty';

  @override
  String get startGame => 'Start Game';

  @override
  String get quit => 'Quit';

  @override
  String get restart => 'Restart';

  @override
  String get abandon => 'Abandon';

  @override
  String get abandonMatchTitle => 'Abandon the match?';

  @override
  String get abandonMatchMessage =>
      'You will forfeit the match and lose your bet.';

  @override
  String get won => 'Won';

  @override
  String get lost => 'Lost';

  @override
  String get versus => 'vs';

  @override
  String aiOpponent(String difficulty) {
    return 'AI ($difficulty)';
  }

  @override
  String get localOpponent => 'Local Player';

  @override
  String get onlineOpponent => 'Online';

  @override
  String coinsWon(int amount) {
    return '+$amount coins';
  }

  @override
  String coinsLost(int amount) {
    return '-$amount coins';
  }

  @override
  String get bankrupt => 'You\'re out of coins!';

  @override
  String bailout(int amount) {
    return 'Here\'s $amount coins to get back in the game!';
  }

  @override
  String get tutorialSimulationTitle => 'Let\'s play a game!';

  @override
  String get tutorialSimulationSubtitle =>
      'Follow the guide and tap the highlighted cells';

  @override
  String get tutorialHint1Title => 'Place your X!';

  @override
  String get tutorialHint1Body =>
      'Tap this cell to start your winning line along the top row.';

  @override
  String get tutorialHint2Title => 'Extend your line!';

  @override
  String get tutorialHint2Body => 'One more X here — keep going!';

  @override
  String get tutorialHint3Title => 'Win right here!';

  @override
  String get tutorialHint3Body => 'Complete the top row for a perfect victory!';

  @override
  String get tutorialVictoryTitle => 'You won your first game!';

  @override
  String tutorialRewardCoins(int amount) {
    return '+$amount coins';
  }

  @override
  String get tutorialRewardSubtitle => 'Here are your 1,000 starting coins!';

  @override
  String get tutorialStartPlaying => 'Start playing!';

  @override
  String get cashBattle => 'CASH\nBATTLE';

  @override
  String get cashBattleTagline => 'All In';

  @override
  String get cashBattleDesc => 'Bet your coins against real opponents.';

  @override
  String get cashBattlePlay => 'Participate';

  @override
  String get liveJackpot => 'Live Jackpot';

  @override
  String get cyberBot => 'CYBER\nBOT';

  @override
  String get cyberBotTagline => 'Solo Training';

  @override
  String get cyberBotDesc => 'Sharpen your skills against the AI.';

  @override
  String get cyberBotPlay => 'Challenge the Bot';

  @override
  String get duel1v1 => 'DUEL\n1 VS 1';

  @override
  String get duel1v1Tagline => 'Face to Face';

  @override
  String get duel1v1Desc => 'Two players, one screen, no mercy.';

  @override
  String get duel1v1Play => 'Start the duel';
}
