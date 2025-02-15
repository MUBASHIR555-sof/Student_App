import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_ui/db/function/db_function.dart';
import 'package:student_ui/db/model/data_model.dart';
import 'package:student_ui/widget/home.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.clas,
      required this.Adress,
      required this.image,
      required this.index
      });
  final String name;
  final String age;
  final String Adress;
  final String clas;
  final dynamic image;
  final int index;

  @override
  State<EditScreen> createState() => _EditScreen();
}

class _EditScreen extends State<EditScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController clasController =TextEditingController();
  final TextEditingController numberController = TextEditingController();
  File? selectedimage;

  @override
  void initState() {
    namecontroller.text = widget.name;
    agecontroller.text = widget.age;
    clasController.text = widget.clas;
    numberController.text=widget.Adress;
    selectedimage = widget.image != null ? File(widget.image) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   getAllStudents();
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.green,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'S T U D E N T',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 300),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                      }, icon: Icon(Icons.arrow_back))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          CircleAvatar(
                              radius: 100,
                              backgroundImage: selectedimage != null
                                  ? FileImage(selectedimage!)
                                  : AssetImage("assets/profile.png")
                                      ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.green)),
                                  onPressed: () {
                                    fromgallery();
                                  },
                                  child: Text('G A L L E R Y',style: TextStyle(color: Colors.black),)),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.green)),
                                  onPressed: () {
                                    fromcam();
                                  },
                                  child: Text('C A M E R A',style: TextStyle(color: Colors.black),)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: namecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'N A M E',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: agecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'A G E',
                              ),
                            ),
                          ),
                          
                          
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: clasController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'C L A S S',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: numberController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'N U M B E R',
                              ),
                            
                              
                            maxLength: 10,
                            ),
                          ),
                      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue)),
                                onPressed: () {
                                  update();
                                },
                                child: Text('U P D A T E',style: TextStyle(color: Colors.black),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  update() async {
    final edited_name = namecontroller.text.trim();
    final edited_age = agecontroller.text.trim();
    final edited_clas = clasController.text.trim();
    final edited_Adress = numberController.text.trim();
    
    
    final edited_image = selectedimage?.path;

    if (edited_name.isEmpty ||
        edited_age.isEmpty ||
        edited_clas.isEmpty ||
        edited_Adress.isEmpty 
      
       ) {
      return;
    }
    final updated = studentModel(
        name: edited_name,
        age: edited_age,
        cls:edited_clas,
        Adress: edited_Adress,
        image: edited_image!);

    editstudent(widget.index, updated);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Updated Successfully'),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>Homepage(),
    ));
  }

  fromgallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }

  fromcam() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }
}