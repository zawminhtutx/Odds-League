import 'package:equatable/equatable.dart';

class 
HomeViewParam extends Equatable {
  final DateTime date;
  final bool isTopOdds;

  const HomeViewParam({required this.date, this.isTopOdds = false});

  @override
  List<Object> get props => [date, isTopOdds];
}
