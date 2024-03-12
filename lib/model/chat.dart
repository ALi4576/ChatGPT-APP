import 'package:ai/model/model.dart';

class Chat {
  final String? question;
  final ResponseClass? answer;
  final DateTime? createdAt;

  Chat({
    this.question,
    this.answer,
    this.createdAt,
  });

  Chat copyWith({
    String? question,
    ResponseClass? answer,
    DateTime? createdAt,
  }) =>
      Chat(
        question: question ?? this.question,
        answer: answer ?? this.answer,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
