// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_history_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameHistoryEntryModelAdapter extends TypeAdapter<GameHistoryEntryModel> {
  @override
  final typeId = 0;

  @override
  GameHistoryEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHistoryEntryModel(
      id: fields[0] as String,
      playedAt: fields[1] as DateTime,
      modeType: fields[2] as String,
      outcomeIndex: (fields[3] as num).toInt(),
      playerSideIndex: (fields[4] as num).toInt(),
      moveRows: (fields[5] as List).cast<int>(),
      moveCols: (fields[6] as List).cast<int>(),
      movePlayers: (fields[7] as List).cast<int>(),
      difficultyIndex: (fields[8] as num?)?.toInt(),
      betAmount: (fields[9] as num?)?.toInt(),
      coinsWon: (fields[10] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, GameHistoryEntryModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.playedAt)
      ..writeByte(2)
      ..write(obj.modeType)
      ..writeByte(3)
      ..write(obj.outcomeIndex)
      ..writeByte(4)
      ..write(obj.playerSideIndex)
      ..writeByte(5)
      ..write(obj.moveRows)
      ..writeByte(6)
      ..write(obj.moveCols)
      ..writeByte(7)
      ..write(obj.movePlayers)
      ..writeByte(8)
      ..write(obj.difficultyIndex)
      ..writeByte(9)
      ..write(obj.betAmount)
      ..writeByte(10)
      ..write(obj.coinsWon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHistoryEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
