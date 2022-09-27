import 'package:meta/meta.dart';
import 'dart:convert';

class UserDetailsModel {
    UserDetailsModel({
        required this.id,
        required this.name,
        required this.photo,
    });

    final String id;
    final String name;
    final String photo;

    factory UserDetailsModel.fromRawJson(String str) => UserDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
    };
}
