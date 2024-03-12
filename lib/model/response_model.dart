// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  final ResponseClass? response;

  Response({
    this.response,
  });

  Response copyWith({
    ResponseClass? response,
  }) =>
      Response(
        response: response ?? this.response,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        response: json["response"] == null
            ? null
            : ResponseClass.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class ResponseClass {
  final String? en;
  final String? graph;
  final String? hu;

  ResponseClass({
    this.en,
    this.graph,
    this.hu,
  });

  ResponseClass copyWith({
    String? en,
    String? graph,
    String? hu,
  }) =>
      ResponseClass(
        en: en ?? this.en,
        graph: graph ?? this.graph,
        hu: hu ?? this.hu,
      );

  factory ResponseClass.fromJson(Map<String, dynamic> json) => ResponseClass(
        en: json["en"],
        graph: json["graph"],
        hu: json["hu"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "graph": graph,
        "hu": hu,
      };
}
