class QuestionModel {
  final String qid;
  final String question;
  final List<dynamic> options;
  final int correctAnswerIndex;

  QuestionModel({
    required this.qid,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    qid: json['qid'],
    question: json["question"],
    options: json["options"],
    correctAnswerIndex: json["correctAnswerIndex"],
  );

  Map<String, dynamic> toJson() => {
    "qid": qid,
    "question": question,
    "options": options,
    "correctAnswerIndex": correctAnswerIndex,
  };
}
