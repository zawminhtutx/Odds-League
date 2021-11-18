import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query.g.dart';

@JsonSerializable(createFactory: false, ignoreUnannotated: true)
class Query extends Equatable {
  @JsonKey(ignore: false, name: 'p', toJson: _pageToJson)
  final int page;

  const Query({this.page = 1});

  Map<String, dynamic> toJson() => _$QueryToJson(this);

  static String _pageToJson(int page) {
    return page.toString();
  }

  @override
  List<Object?> get props => [page];
}
