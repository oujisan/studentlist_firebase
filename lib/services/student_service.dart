import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentlist_firebase/models/student.dart';

class StudentService {
  final CollectionReference _collections = FirebaseFirestore.instance.collection('students');

  Stream<List<Student>> fetchData() => _collections.snapshots().map((snapshot) => snapshot.docs.map((doc) {
        return Student.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList());

  Future<void> deleteItem(String itemId) async {
    try {
      await _collections.doc(itemId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addItem(Student student) async {
    try {
      await _collections.add(student.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateItem(Student student) async {
    try {
      await _collections.doc(student.id).update(student.toMap());
    } catch (e) {
      print(e);
    }
  }
}
