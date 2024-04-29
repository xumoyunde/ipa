import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ftest/data/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get auth => _firebaseAuth;

  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<bool> isUser(User user) async {
    var userQuerySnapshot = await _firestore
        .collection('users')
        .where("email", isEqualTo: user.email)
        .get();
    var userList = userQuerySnapshot.docs;
    if (userList.isNotEmpty) {
      var userData = userList[0];
      return true;
    }
    return false;
  }

  Future<bool> isAdmin(User user) async {
    var userQuerySnapshot = await _firestore
        .collection('admin')
        .where("email", isEqualTo: user.email)
        .get();
    var userList = userQuerySnapshot.docs;
    if (userList.isNotEmpty) {
      var userData = userList[0];
      return true;
    }
    return false;
  }

  UserModel? user;
  bool admin = false;

  Future<UserModel?> signIn(
      {required String username, required String password}) async {
    try {
      var userQuerySnapshot = await _firestore
          .collection('users')
          .where("username", isEqualTo: username)
          .get();
      print("length");
      print(userQuerySnapshot.docs.length);
      if (userQuerySnapshot.docs.isEmpty) {
        userQuerySnapshot = await _firestore
            .collection('admin')
            .where("username", isEqualTo: username)
            .get();
        print("length 2");
        print(userQuerySnapshot.docs.length);
        admin = true;
      } else {
        admin = false;
      }

      var userData = userQuerySnapshot.docs.first.data();
      print(userData);
      user = UserModel.fromJson(userData);

      await _firebaseAuth.signInWithEmailAndPassword(
          email: user!.email, password: password);

      return user;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException with auth: ${e.plugin}/${e.code}");
      throw FirebaseAuthException(code: e.code);
    } on FirebaseException catch (e) {
      print("FirebaseException with auth: ${e.plugin}/${e.code}");
      throw FirebaseException(plugin: e.plugin);
    } catch (e) {
      print("Catch $e");
    }
  }

  Future<void> setNickName(String nickname) async {
    if (nickname.trim().isNotEmpty) {
      bool admin = false;
      var snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: currentUser()?.email)
          .get();
      if (snapshot.docs.isEmpty) {
        snapshot = await _firestore
            .collection('admin')
            .where('email', isEqualTo: currentUser()?.email)
            .get();
        admin = true;
      }
      var user = UserModel.fromJson(snapshot.docs[0].data());
      if (user.nickname != nickname) {
        admin
            ? await _firestore
                .collection('admin')
                .doc(user.uid)
                .update({"nickname": nickname})
            : await _firestore
                .collection('users')
                .doc(user.uid)
                .update({"nickname": nickname});
      }
    }
  }

  Future<String?> getNickName(String email, String? nickname) async {
    var snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    print(UserModel.fromJson(snapshot.docs[0].data()).username);
    if (snapshot.docs.isEmpty) {
      snapshot = await _firestore
          .collection('admin')
          .where('email', isEqualTo: email)
          .get();
      print(UserModel.fromJson(snapshot.docs[0].data()).nickname);
    }
    return UserModel.fromJson(snapshot.docs[0].data()).nickname;

    // if (nickname != null) {
    //   var snapshot = await _firestore
    //       .collection('users')
    //       .where("email", isEqualTo: email)
    //       .get();
    //   if (snapshot.docs.isEmpty) {
    //     snapshot = await _firestore
    //         .collection('admin')
    //         .where("email", isEqualTo: email)
    //         .get();
    //     await _firestore
    //         .collection('users')
    //         .doc()
    //         .update({"nickname": nickname});
    //     return null;
    //   }
    //   _firestore.collection('admin').doc().update({"nickname": nickname});
    //   return null;
    // }
    // var snapshot = await _firestore
    //     .collection('users')
    //     .where("email", isEqualTo: email)
    //     .get();
    // if (snapshot.docs.isEmpty) {
    //   snapshot = await _firestore
    //       .collection('admin')
    //       .where("email", isEqualTo: email)
    //       .get();
    //   return UserModel.fromJson(snapshot.docs[0].data()).nickname;
    // }
    // return UserModel.fromJson(snapshot.docs[0].data()).nickname;
  }

  Future<UserModel?> getUserFromUserModel() async {
    if (admin) {
      print(admin);
      var snapshot = await _firestore
          .collection('admin')
          .where("email", isEqualTo: currentUser()?.email)
          .get();
      UserModel.fromJson(snapshot.docs[0].data());
    } else {
      print(admin);
      var snapshot = await _firestore
          .collection('users')
          .where("email", isEqualTo: currentUser()?.email)
          .get();
      UserModel.fromJson(snapshot.docs[0].data());
    }
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> createUser(UserModel user) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password!);
      _firestore.doc("users").set(user.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
