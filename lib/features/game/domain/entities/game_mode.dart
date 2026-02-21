import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';

part 'game_mode.freezed.dart';

@freezed
sealed class GameMode with _$GameMode {
  const factory GameMode.vsAi({required Difficulty difficulty}) = GameModeVsAi;
  const factory GameMode.vsLocal() = GameModeVsLocal;
  const factory GameMode.online() = GameModeOnline;
}
