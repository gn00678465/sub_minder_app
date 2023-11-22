import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'settings.g.dart';

@JsonSerializable()
class NotificationSettings extends Equatable {
  const NotificationSettings({required this.days, required this.enabled});

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final bool enabled;
  final int days;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSettingsToJson(this);

  NotificationSettings copyWith({int? days, bool? enabled}) {
    return NotificationSettings(
        days: days ?? this.days, enabled: enabled ?? this.enabled);
  }

  @override
  List<Object> get props => [enabled, days];

  static int _toJson(bool value) => value ? 1 : 0;
  static bool _fromJson(int value) => value == 1 ? true : false;
}

@JsonSerializable()
class DisplaySettings extends Equatable {
  const DisplaySettings({required this.darkMode});

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final bool darkMode;

  factory DisplaySettings.fromJson(Map<String, dynamic> json) =>
      _$DisplaySettingsFromJson(json);
  Map<String, dynamic> toJson() => _$DisplaySettingsToJson(this);

  DisplaySettings copyWith({bool? darkMode}) =>
      DisplaySettings(darkMode: darkMode ?? this.darkMode);

  @override
  List<Object> get props => [darkMode];

  static int _toJson(bool value) => value ? 1 : 0;
  static bool _fromJson(int value) => value == 1 ? true : false;
}
