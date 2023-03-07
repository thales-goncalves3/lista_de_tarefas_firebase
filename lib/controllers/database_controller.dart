import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_tarefas_firebase/controllers/auth_controller.dart';

class DatabaseController {
  DatabaseController._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(AuthController.getUserId())
        .collection("tasks")
        .snapshots();
  }

  static createUser(String username, String email) {
    _db
        .collection("users")
        .doc(AuthController.getUserId())
        .collection("infos")
        .add({
      'username': username,
      'email': email,
    });
  }

  static createTask(String title, String description) {
    _db
        .collection("users")
        .doc(AuthController.getUserId())
        .collection("tasks")
        .add({
      "title": title,
      "description": description,
      "finished": false,
    });
  }

  static deleteTask(String id) {
    _db
        .collection("users")
        .doc(AuthController.getUserId())
        .collection("tasks")
        .doc(id)
        .delete();
  }

  static updateTask(String id, Map<String, bool> map) {
    _db
        .collection("users")
        .doc(AuthController.getUserId())
        .collection("tasks")
        .doc(id)
        .update(map);
  }
}
