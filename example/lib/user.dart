import 'package:your_project/utils/parsing_helper.dart';

class Hobbies {
  final List<String>? music;

  Hobbies({this.music, });

  factory Hobbies.fromJson(Map<String, dynamic> json) {
    return Hobbies(
      music: ParsingHelper.parseListMethod<dynamic, String>(json['music']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['music'] = music;
    return data;
  }
}


class User {
  final String? userId;
  final String? phone;
  final bool? isActive;
  final Hobbies? hobbies;

  User({this.userId, this.phone, this.isActive, this.hobbies, });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: ParsingHelper.parseStringNullableMethod(json['user_id']),
      phone: ParsingHelper.parseStringNullableMethod(json['phone']),
      isActive: ParsingHelper.parseBoolNullableMethod(json['is_active']),
      hobbies: json['hobbies'] != null ? Hobbies.fromJson(json['hobbies']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['phone'] = phone;
    data['is_active'] = isActive;
    if (hobbies != null) data['hobbies'] = hobbies!.toJson();
    return data;
  }
}


