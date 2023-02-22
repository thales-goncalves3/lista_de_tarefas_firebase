// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lista_tarefas_firebase/pages/login_page.dart';

class FirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  getUserId() {
    return _auth.currentUser!.uid;
  }

  getUser() {
    return _auth.currentUser;
  }

  getEmail() {
    return _auth.currentUser!.email;
  }

  signOut() async {
    await _auth.signOut();
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        return "The account already exist for that email.";
      }
    }
  }

  createTask(String title, String description) {
    _db.collection(getUserId()).add({
      "title": title,
      "description": description,
      "finished": false,
    });
  }

  deleteTask(String id) {
    _db.collection(getUserId()).doc(id).delete();
  }

  updateTask(String id, Map<String, bool> map) {
    _db.collection(getUserId()).doc(id).update(map);
  }
}
