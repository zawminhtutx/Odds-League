import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:odds_league/src/utility.dart';

part 'query.g.dart';

@JsonSerializable(createFactory: false, ignoreUnannotated: true)
class Query extends Equatable {
  @JsonKey(ignore: false, name: 'p', toJson: _pageToJson)
  final int page;

  @JsonKey(ignore: false, toJson: _dayToJson)
  final DateTime day;

  const Query({this.page = 1, required this.day});

  Map<String, dynamic> toJson() => _$QueryToJson(this);

  static String _pageToJson(int page) {
    return page.toString();
  }

  static String _dayToJson(DateTime day) {
    final sameDay = isSameDay(dayOne: DateTime.now(), dayTwo: day);
    if (sameDay) {
      return 'today';
    } else {
      final format = DateFormat('yMMdd');
      return format.format(day);
    }
  }

  @override
  List<Object?> get props => [page];
}
