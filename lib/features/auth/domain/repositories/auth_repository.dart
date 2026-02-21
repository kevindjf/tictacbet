import 'package:tic_tac_bet/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> get authStateChanges;
  Future<AppUser?> get currentUser;
  Future<AppUser> signIn(String email, String password);
  Future<AppUser> signUp(String email, String password);
  Future<void> signOut();
}
