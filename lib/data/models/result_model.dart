class Results {
  final String uid;
  final String qid;
  final int selectedIndex;
  final int correctAnswerIndex;
  final DateTime dateTime;

  Results({
    required this.uid,
    required this.qid,
    required this.selectedIndex,
    required this.correctAnswerIndex,
    required this.dateTime,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
      uid: json['uid'],
      qid: json['qid'],
      selectedIndex: json['selectedIndex'],
      correctAnswerIndex: json['correctAnswerIndex'],
      dateTime: json['dateTime']);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "qid": qid,
        "selectedIndex": selectedIndex,
        "correctAnswerIndex": correctAnswerIndex,
        "dateTime": dateTime
      };
}
