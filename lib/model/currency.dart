import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency extends Equatable {
  final String name;
  final String code;
  final String symbol;

  Currency({
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  @override
  List<Object> get props => [name, code, symbol];
}
