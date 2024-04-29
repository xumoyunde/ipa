import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ftest/data/models/questions_model.dart';

class DataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveQuestions(QuestionModel question) async {
    final docRef = firestore.collection('questions').doc();
    await docRef.set(question.toJson());
    String documentId = docRef.id;
    await docRef.update({'qid': documentId});
  }

  Future<List<QuestionModel>> getQuestions() async {
    try {
      var questions = <QuestionModel>[];
      final querySnapshot = await firestore.collection('questions').get();
      for (var doc in querySnapshot.docs) {
        questions.add(QuestionModel.fromJson(doc.data()));
      }
      for(var q in questions){
        if(q.correctAnswerIndex > 4){
          print("/////////");
          print("${q.qid} : ${q.correctAnswerIndex}");
        } else {
          print("${q.correctAnswerIndex}");
        }
      }
      return questions;
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }

  Future<void> updateQuestion(String qid, QuestionModel question) async {
    var snapshot = await firestore
        .collection('questions')
        .where("qid", isEqualTo: qid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      print(question.toJson());
      firestore.collection('questions').doc(qid).update(question.toJson());
    }
  }

  Future<QuestionModel?> searchQuestion(String qid) async {
    var snapshot = await firestore
        .collection('questions')
        .where("qid", isEqualTo: qid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return QuestionModel.fromJson(snapshot.docs[0].data());
    }
    return null;
  }
}
