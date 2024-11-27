import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_ui/db/function/db_function.dart';
import 'package:student_ui/db/model/data_model.dart';
import 'package:student_ui/widget/home.dart';

class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({Key? key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  final _numberController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  File? pickedimage;

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  getimage();
                },
                child: CircleAvatar(
                  radius: 50,
                  child: pickedimage != null
                      ? Image.file(pickedimage!)
                      : Icon(Icons.camera),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Age',
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
               maxLength:3 ,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _classController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Class',
                  labelText: 'Class',
                  prefixIcon: Icon(Icons.school),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Number',
                  labelText: 'Number',
                  prefixIcon: Icon(Icons.phone),
                  prefixText: '+91',
                ),
                maxLength: 10,
              ),
              SizedBox(height: 15),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      onAddStudentButtonClicked(context);
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Add",
                        style: TextStyle(color: Colors.black),
                      ),
                      Gap(20),
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      )
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _class = _classController.text.trim();
    final _number = _numberController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _class.isEmpty || _number.isEmpty) {
      return;
    }

    final _student = studentModel(
      name: _name,
      age: _age,
      cls: _class,
      Adress: _number,
      image: pickedimage?.path ?? '',
    );
    addStudent(_student);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  Future<void> getimage() async {
    var img = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedimage = File(img!.path);
    });
  }
}
