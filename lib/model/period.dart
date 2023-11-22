import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'period.g.dart';

@JsonSerializable()
class PeriodModel extends Equatable {
  final int? id;
  final String name;

  const PeriodModel({
    this.id,
    required this.name,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodModelFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodModelToJson(this);

  @override
  List<Object> get props => [name];
}
