import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_ui/db/function/db_function.dart';
import 'package:student_ui/db/model/data_model.dart';
import 'package:student_ui/widget/add.dart';
import 'package:student_ui/widget/edit.dart';
import 'package:student_ui/widget/studentdet.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<Homepage> {
  TextEditingController searchController = TextEditingController();
  List<studentModel> studentList = [];
  List<studentModel> filteredStudentList = [];
  bool isSearching = false;


  @override
  void initState(){
    super.initState();
    getAllStudents();
  }

  void filterStudents(String search) {
    if (search.isEmpty) {
  
      setState(() {
        filteredStudentList = List.from(studentList);
      });
    } else {
      setState(() {
        filteredStudentList = studentList
            .where((student) =>
                student.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
     getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: isSearching ? buildSearchField() : Text("Student List"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              tooltip: "Search",
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    filteredStudentList = List.from(studentList);
                  }
                });
              },
              icon: Icon(isSearching ? Icons.cancel : Icons.search),
            ),
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout),
              tooltip: "logout",
            ),
          ],
        ),
        body: Center(
          child: isSearching
              ? filteredStudentList.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = filteredStudentList[index];
                        return buildStudentCard(data, index);
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: filteredStudentList.length,
                    )
                  : Center(
                      child: Text("No results found."),
                    )
              : buildStudentList(),
        ),

        floatingActionButton: FloatingActionButton.extended(
          tooltip: "Add Student",
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStudentWidget(),
              ),
            );
          },
          icon: Icon(Icons.add,color: Colors.black,),
          label: Text("Add Student",style: TextStyle(color: Colors.black),),

        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (query) {
        filterStudents(query);
      },
      autofocus: true,
      style: TextStyle(
        color: Colors.white, 
      ),
      decoration: InputDecoration(
        hintText: "Search students...",
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7), 
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget buildStudentCard(studentModel data, int index) {
    return Card(
      child: ListTile(
        onTap: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>featails(name: data.name, age:data.age, cls: data.cls, address:data.Adress, imagePath:data.image)));
          });
        },
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage:
           FileImage(File(data.image)),

        ),
        title: Text(
          data.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data.age,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: "Edit",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(
                      index: index,
                      name: data.name,
                      age: data.age,
                      clas: data.cls,
                      image: data.image,
                      Adress: data.Adress,
                    
                    ),
                  ),
                );
              },
              icon: Icon(Icons.edit),
              color: Colors.green,
            ),
            IconButton(
              tooltip: "Delete",
              onPressed: () {
                deleteStudent(index);
              },
              icon: Icon(Icons.delete_rounded),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudentList() {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext ctx, List<studentModel> studentlist, Widget? child) {
        // Update studentList 
        studentList = studentlist;
        filteredStudentList = List.from(studentList);

        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return buildStudentCard(data, index);
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
