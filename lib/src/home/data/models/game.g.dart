// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      gameId: json['game_id'] as String,
      time: Game._timeFromJson(json['time'] as String),
      timeStatus: json['time_status'] as String,
      home: Team.fromJson(json['home'] as Map<String, dynamic>),
      away: Team.fromJson(json['away'] as Map<String, dynamic>),
      isLive: json['is_live'] as bool,
      odd: json['odd'] == null
          ? null
          : Odd.fromJson(json['odd'] as Map<String, dynamic>),
      oddOption: $enumDecodeNullable(_$OddOptionEnumMap, json['odd_option']) ??
          OddOption.pure,
    );

const _$OddOptionEnumMap = {
  OddOption.pure: 'pure',
  OddOption.home: 'home',
  OddOption.draw: 'draw',
  OddOption.away: 'away',
};
