import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
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
    _db.collection(_auth.currentUser!.uid.toString()).add({
      "title": title,
      "description": description,
      "finished": false,
    });
  }

  deleteTask(String id) {
    _db.collection(_auth.currentUser!.uid.toString()).doc(id).delete();
  }

  updateTask(String id, Map<String, bool> map) {
    _db.collection(_auth.currentUser!.uid.toString()).doc(id).update(map);
  }
}
