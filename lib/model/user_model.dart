import 'dart:convert';
import 'package:cosmic_numeriics/model/task_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? numerologyNumber;
  String? profilePic;
  String? gender;
  DateTime? dob;
  String? name;
  int? createdAt;
  String? userId;
  String? email;
  String? searchName;
  List<TaskResponseModel>? completedTask;

  UserModel({
    this.numerologyNumber,
    this.profilePic,
    this.gender,
    this.dob,
    this.name,
    this.createdAt,
    this.userId,
    this.email,
    this.searchName,
    this.completedTask,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        numerologyNumber: json["numerologyNumber"],
        profilePic: json["profile-pic"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        name: json["name"],
        createdAt: json["created_AT"],
        userId: json["userId"],
        email: json["email"],
        searchName: json["searchName"],
        completedTask: json["completedTask"] == null
            ? []
            : List<TaskResponseModel>.from(json["completedTask"]!
                .map((x) => TaskResponseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "numerologyNumber": numerologyNumber,
        "profile-pic": profilePic,
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "name": name,
        "created_AT": createdAt,
        "userId": userId,
        "email": email,
        "searchName": searchName,
        "completedTask": completedTask == null
            ? []
            : List<dynamic>.from(completedTask!.map((x) => x.toJson())),
      };
}
