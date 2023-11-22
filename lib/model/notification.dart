import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final int? id;
  final String name;

  const NotificationModel({
    this.id,
    required this.name,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object> get props => [name];
}
