import 'package:flutter/material.dart';

class Task_Page extends StatefulWidget {
  const Task_Page({super.key});

  @override
  State<Task_Page> createState() => _Task_PageState();
}

class _Task_PageState extends State<Task_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Assign Task ",
              style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),),
          ),
          SizedBox(height: 20,),
          TextField(
            // controller: _titlecontroller,
            decoration: InputDecoration(
              labelText: "Enter Your Title",
              hintText: "Title",
              suffix: Icon(Icons.title),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
