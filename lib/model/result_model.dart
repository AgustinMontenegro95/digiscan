// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  ResultModel({
    required this.confidence,
    required this.index,
    required this.label,
  });

  double confidence;
  int index;
  int label;

  ResultModel copyWith({
    double? confidence,
    int? index,
    int? label,
  }) =>
      ResultModel(
        confidence: confidence ?? this.confidence,
        index: index ?? this.index,
        label: label ?? this.label,
      );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        confidence: json["confidence"]?.toDouble(),
        index: json["index"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "confidence": confidence,
        "index": index,
        "label": label,
      };
}
