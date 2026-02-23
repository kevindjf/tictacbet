// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Bet';

  @override
  String get training => 'Entraînement';

  @override
  String get trainingDescription => 'Entraîne-toi sans risque';

  @override
  String get competition => 'Compétition';

  @override
  String get competitionDescription => 'Mise des coins et affronte des joueurs';

  @override
  String get vsAi => 'vs IA';

  @override
  String get vsLocal => 'vs Joueur local';

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Moyen';

  @override
  String get hard => 'Difficile';

  @override
  String get difficulty => 'Difficulté';

  @override
  String get yourTurn => 'À toi de jouer !';

  @override
  String get opponentTurn => 'Tour de l\'adversaire';

  @override
  String get playerXTurn => 'Tour du joueur X';

  @override
  String get playerOTurn => 'Tour du joueur O';

  @override
  String get youWin => 'Victoire !';

  @override
  String get youLose => 'Défaite !';

  @override
  String get draw => 'Égalité !';

  @override
  String get playerXWins => 'Joueur X gagne !';

  @override
  String get playerOWins => 'Joueur O gagne !';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String coins(int amount) {
    return '$amount coins';
  }

  @override
  String betAmount(int amount) {
    return 'Mise : $amount coins';
  }

  @override
  String get balance => 'Solde';

  @override
  String get streak => 'Série';

  @override
  String multiplier(String value) {
    return 'x$value';
  }

  @override
  String streakCount(int count) {
    return '$count victoires';
  }

  @override
  String get placeBet => 'Miser';

  @override
  String minimumBet(int amount) {
    return 'Mise minimum : $amount';
  }

  @override
  String get insufficientBalance => 'Solde insuffisant';

  @override
  String get history => 'Historique';

  @override
  String get statistics => 'Statistiques';

  @override
  String get noGamesYet => 'Aucune partie jouée';

  @override
  String get winRate => 'Taux de victoire';

  @override
  String get gamesPlayed => 'Parties jouées';

  @override
  String get wins => 'Victoires';

  @override
  String get losses => 'Défaites';

  @override
  String get draws => 'Égalités';

  @override
  String get settings => 'Paramètres';

  @override
  String get theme => 'Thème';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get language => 'Langue';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get replayTutorial => 'Rejouer le tutoriel';

  @override
  String get lobby => 'Lobby';

  @override
  String get createMatch => 'Créer un match';

  @override
  String get proposeMatch => 'Proposer un match';

  @override
  String get acceptMatch => 'Accepter';

  @override
  String get cancelMatch => 'Annuler';

  @override
  String get waitingForOpponent => 'En attente d\'un adversaire...';

  @override
  String get matchAccepted => 'Match accepté !';

  @override
  String get simulateOpponent => 'Simuler un adversaire';

  @override
  String get noProposals => 'Aucun match disponible';

  @override
  String get login => 'Se connecter';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get welcomeTitle => 'Bienvenue sur Tic Tac Bet !';

  @override
  String get onboardingBoard => 'Voici le plateau. Touche une case pour jouer.';

  @override
  String get onboardingGame => 'Joue à tour de rôle pour aligner 3 symboles !';

  @override
  String get onboardingStreaks =>
      'Enchaîne les victoires pour multiplier tes gains !';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get getStarted => 'C\'est parti';

  @override
  String get readyToCompete => 'Prêt à miser ? Passe en compétition !';

  @override
  String get selectMode => 'Choisis un mode';

  @override
  String get selectDifficulty => 'Choisis la difficulté';

  @override
  String get startGame => 'Lancer la partie';

  @override
  String get quit => 'Quitter';

  @override
  String get restart => 'Recommencer';

  @override
  String get won => 'Gagné';

  @override
  String get lost => 'Perdu';

  @override
  String get versus => 'vs';

  @override
  String aiOpponent(String difficulty) {
    return 'IA ($difficulty)';
  }

  @override
  String get localOpponent => 'Joueur local';

  @override
  String get onlineOpponent => 'En ligne';

  @override
  String coinsWon(int amount) {
    return '+$amount coins';
  }

  @override
  String coinsLost(int amount) {
    return '-$amount coins';
  }

  @override
  String get bankrupt => 'Plus de coins !';

  @override
  String bailout(int amount) {
    return 'Voici $amount coins pour revenir dans la partie !';
  }

  @override
  String get tutorialSimulationTitle => 'On joue une partie !';

  @override
  String get tutorialSimulationSubtitle =>
      'Suis le guide et touche les cases en surbrillance';

  @override
  String get tutorialHint1Title => 'Place ton X !';

  @override
  String get tutorialHint1Body =>
      'Touche cette case pour commencer ta ligne gagnante sur la ligne du haut.';

  @override
  String get tutorialHint2Title => 'Prolonge ta ligne !';

  @override
  String get tutorialHint2Body => 'Encore un X ici — continue sur ta lancée !';

  @override
  String get tutorialHint3Title => 'Gagne ici !';

  @override
  String get tutorialHint3Body =>
      'Complète la ligne du haut pour une victoire parfaite !';

  @override
  String get tutorialVictoryTitle => 'Tu as gagné ta première partie !';

  @override
  String tutorialRewardCoins(int amount) {
    return '+$amount coins';
  }

  @override
  String get tutorialRewardSubtitle => 'Voilà tes 1 000 coins de départ !';

  @override
  String get tutorialStartPlaying => 'Jouer maintenant !';

  @override
  String get cashBattle => 'CASH\nBATTLE';

  @override
  String get cashBattleDesc => 'Affronte des joueurs réels et mise tes tokens.';

  @override
  String get cashBattlePlay => 'Jouer (1.00€)';

  @override
  String get liveJackpot => 'Live Jackpot';

  @override
  String get cyberBot => 'CYBER\nBOT';

  @override
  String get cyberBotDesc => 'Entraîne-toi contre l\'IA la plus puissante.';

  @override
  String get cyberBotPlay => 'Défier le Bot';

  @override
  String get duel1v1 => 'DUEL\n1 VS 1';

  @override
  String get duel1v1Desc => 'Le classique. À deux sur le même écran.';

  @override
  String get duel1v1Play => 'Lancer le duel';
}
