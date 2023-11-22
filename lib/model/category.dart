import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  final int? id;
  final String name;

  const CategoryModel({
    this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  List<Object> get props => [name];
}
