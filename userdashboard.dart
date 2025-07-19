import 'package:first_project/user_dashboard/assigned_task.dart';
import 'package:first_project/user_dashboard/progress.dart';
import 'package:first_project/userdrawer.dart';
import 'package:flutter/material.dart';

import 'custom_drawer.dart';

class User_Dashboard extends StatefulWidget {
  const User_Dashboard({super.key});

  @override
  State<User_Dashboard> createState() => _User_DashboardState();
}

class _User_DashboardState extends State<User_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: User_Drawer(),
      ),

      body: SingleChildScrollView(
        child: Container(
          color:Color(0xFFECEFF1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, size: 30, color: Colors.black87),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "User Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              Container(
                height: 160,
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade200, Colors.teal.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome, Intern 👋",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Have a productive day!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),


                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/internee.png"),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignedTaskPage()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/internee.png'), // Replace with your image
                      radius: 30,
                    ),
                    title: Text(
                      "Assigned Task",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      "Flutter Intern",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProgressPage()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/internee.png"),
                      radius: 30,
                    ),
                    title: Text("Progress",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    subtitle: Text("Flutter Intern",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,size: 16,),
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
