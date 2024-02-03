class QuestionEntity {
  final int correct;
  final bool isResolved;
  final String question;
  final List<String> responses;
  final String userId;
  final String id;

  QuestionEntity({
    required this.correct,
    required this.isResolved,
    required this.question,
    required this.responses,
    required this.userId,
    required this.id,
  });

  QuestionEntity copyWith({
    int? correct,
    bool? isResolved,
    String? question,
    List<String>? responses,
    String? userId,
    String? id,
  }) =>
      QuestionEntity(
        correct: correct ?? this.correct,
        isResolved: isResolved ?? this.isResolved,
        question: question ?? this.question,
        responses: responses ?? this.responses,
        userId: userId ?? this.userId,
        id: id ?? this.id,
      );

  factory QuestionEntity.fromJson(Map<String, dynamic> json) => QuestionEntity(
        correct: json["correct"],
        isResolved: json["isResolved"],
        question: json["question"],
        responses: List<String>.from(json["responses"].map((x) => x)),
        userId: json["userId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "correct": correct,
        "isResolved": isResolved,
        "question": question,
        "responses": List<dynamic>.from(responses.map((x) => x)),
        "userId": userId,
        "id": id,
      };
}
