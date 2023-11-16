import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'currency.g.dart';

@JsonSerializable()
class CurrencyModel extends Equatable {
  final int? id;
  final String name;
  final String code;
  final String symbol;

  const CurrencyModel({
    this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);

  @override
  List<Object> get props => [name, code, symbol];
}
