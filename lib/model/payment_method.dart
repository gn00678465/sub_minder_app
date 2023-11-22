import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethodModel extends Equatable {
  final int? id;
  final String name;
  final String icon;

  const PaymentMethodModel({
    this.id,
    required this.name,
    required this.icon,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);

  @override
  List<Object> get props => [name, icon];
}
