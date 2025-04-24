import 'dart:convert';

TaskResponseModel taskResponseModelFromJson(String str) =>
    TaskResponseModel.fromJson(json.decode(str));

String taskResponseModelToJson(TaskResponseModel data) =>
    json.encode(data.toJson());

List<TaskResponseModel> taskResponseModeListlFromJson(String str) =>
    List<TaskResponseModel>.from(
        json.decode(str).map((x) => TaskResponseModel.fromJson(x)));

String taskResponseModelListToJson(List<TaskResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskResponseModel {
  int? numerologyNumber;
  int? index;
  String? remedyTitle;
  String? remedyDesc;
  int? createdAt;
  int? completedAt;

  TaskResponseModel({
    this.numerologyNumber,
    this.index,
    this.remedyTitle,
    this.remedyDesc,
    this.createdAt,
    this.completedAt,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      TaskResponseModel(
        numerologyNumber: json["numerologyNumber"],
        index: json["index"],
        remedyTitle: json["remedyTitle"],
        remedyDesc: json["remedyDesc"],
        createdAt: json["created_AT"],
        completedAt: json["completed_AT"],
      );

  Map<String, dynamic> toJson() => {
        "numerologyNumber": numerologyNumber,
        "index": index,
        "remedyTitle": remedyTitle,
        "remedyDesc": remedyDesc,
        "created_AT": createdAt,
        "completed_AT": completedAt,
      };
}
