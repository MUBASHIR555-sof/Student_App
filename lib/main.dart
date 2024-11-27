import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_ui/db/model/data_model.dart';
import 'package:student_ui/widget/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ui/widget/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(studentModelAdapter().typeId)) {
    Hive.registerAdapter(studentModelAdapter());
  }

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}
class MyApp extends StatelessWidget{
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Homepage() : LoginPage(),
    );
  }
}
