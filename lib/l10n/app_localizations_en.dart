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
  String get streak => 'Streak';

  @override
  String multiplier(String value) {
    return 'x$value';
  }

  @override
  String streakCount(int count) {
    return '$count wins';
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
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get lightMode => 'Light mode';

  @override
  String get language => 'Language';

  @override
  String get replayTutorial => 'Replay tutorial';

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
  String get onboardingBetting =>
      'Now let\'s spice things up. You have 1000 coins!';

  @override
  String get onboardingStreaks => 'Chain victories to multiply your gains!';

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
}
