import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

/// Portfolio achievement synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Achievement {
  const Achievement({
    required this.award,
    required this.awardLabel,
    required this.category,
    required this.month,
    required this.year,
    required this.description,
    this.event = '',
    this.organization = '',
    this.id,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return _$AchievementFromJson(json);
  }

  @JsonKey(includeToJson: false)
  final String? id;

  final String award;
  final String awardLabel;
  final String category;

  /// Month number, 1 (January) through 12 (December).
  final int month;
  final int year;

  @JsonKey(defaultValue: '')
  final String event;

  @JsonKey(defaultValue: '')
  final String organization;

  final String description;

  Map<String, dynamic> toJson() {
    return _$AchievementToJson(this);
  }
}
