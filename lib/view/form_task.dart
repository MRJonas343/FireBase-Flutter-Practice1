// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewTaskScreen extends StatefulWidget{
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen>{
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor: Colors.lightGreen,
      ),
      
      
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name'
                ), 
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Number'
                ), 
              ),
            ),
            ElevatedButton(onPressed: (){
              final task = <String, dynamic>{
                'name': nameController.text,
                'number': int.parse(numberController.text)
              };

              final db = FirebaseFirestore.instance;

              db.collection('toDoList').add(task).then(
                (DocumentReference doc) {
                  Navigator.pop(context);
                  print('Task added with ID: ${doc.id}');
                }
              );
            }, child: const Text('Add new Task'))
          ],),
      ),
    );
  }
}