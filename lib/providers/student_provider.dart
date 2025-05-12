import 'package:flutter/material.dart';
import 'package:studentlist_firebase/services/student_service.dart';
import 'package:studentlist_firebase/models/student.dart';

class StudentProvider extends ChangeNotifier {
  final StudentService _studentService = StudentService();

  // Mendapatkan data mahasiswa
  Stream<List<Student>> get studentData => _studentService.fetchData();

  // Menghapus mahasiswa
  void deleteItem(String itemId) => _studentService.deleteItem(itemId);

  // Menambahkan mahasiswa
  void addItem(Student student) => _studentService.addItem(student);

  // Mengupdate data mahasiswa
  void updateItem(Student student) => _studentService.updateItem(student);
}
