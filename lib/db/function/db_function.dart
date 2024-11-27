import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ui/db/model/data_model.dart';
import 'package:student_ui/widget/login.dart';

ValueNotifier<List<studentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(studentModel value) async {
  final studentdb = await Hive.openBox<studentModel>('student_db');
  await studentdb.add(value);
   getAllStudents();
}

Future<void> getAllStudents() async {
  final studentdb = await Hive.openBox<studentModel>('student_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentdb.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentdb = await Hive.openBox<studentModel>('student_db');
  studentdb.deleteAt(index);
  getAllStudents();

}
void editstudent(index,studentModel value) async {
  final studentdb = await Hive.openBox<studentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentdb.values);
  studentdb.putAt(index, value);
    
  }
   Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Clear login state

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
