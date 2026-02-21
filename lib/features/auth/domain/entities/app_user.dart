import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

@freezed
sealed class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? displayName,
  }) = _AppUser;
}
