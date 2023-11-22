// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSettings _$NotificationSettingsFromJson(
        Map<String, dynamic> json) =>
    NotificationSettings(
      days: json['days'] as int,
      enabled: NotificationSettings._fromJson(json['enabled'] as int),
    );

Map<String, dynamic> _$NotificationSettingsToJson(
        NotificationSettings instance) =>
    <String, dynamic>{
      'enabled': NotificationSettings._toJson(instance.enabled),
      'days': instance.days,
    };

DisplaySettings _$DisplaySettingsFromJson(Map<String, dynamic> json) =>
    DisplaySettings(
      darkMode: DisplaySettings._fromJson(json['darkMode'] as int),
    );

Map<String, dynamic> _$DisplaySettingsToJson(DisplaySettings instance) =>
    <String, dynamic>{
      'darkMode': DisplaySettings._toJson(instance.darkMode),
    };
