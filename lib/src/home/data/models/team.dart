import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Team extends Equatable {
  final String id;
  final String name;
  final String imageId;

  const Team({required this.id, required this.name, required this.imageId});

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  @override
  List<Object?> get props => [id, name, imageId];
}
