import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ui/db/function/db_function.dart';
import 'package:student_ui/widget/home.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // username and password
    if (username == "Mubashir" && password == "mubashir2468") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Save login 

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            
            title: Text("Invalid Login"),
            content: Text("Please check your username and password."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(onPressed: (){logout(context);}, icon: Icon(Icons.restart_alt)),
      )],),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset("assets/login first page.jpg",height: 290,width: 300,)
                ],),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: "Username",
                   filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  )),
                ),
                Gap(10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password",
                   filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,elevation: 5,),
                  onPressed: () => login(context),
                  child: Text("Login",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
