import 'package:first_project/admin_profile/add_intern.dart';
import 'package:first_project/admin_profile/review_intern.dart';
import 'package:first_project/custom_drawer.dart';
import 'package:first_project/update_intern.dart';
import 'package:flutter/material.dart';

class Dashboard_Page extends StatefulWidget {
  const Dashboard_Page({super.key});

  @override
  State<Dashboard_Page> createState() => _Dashboard_PageState();
}

class _Dashboard_PageState extends State<Dashboard_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: Drawer(
       child: Custom_Drawer(),
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
                    "Admin Dashboard",
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
                          "Welcome, Admin 👋",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Intern()));
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
                      "Add Intern",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_Intern()));
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
                    title: Text("Update Intern",
                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    subtitle: Text("Flutter Intern",
                    style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,size: 16,),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Review_Intern()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal:16,vertical: 8 ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/internee.png"),
                      radius: 30,
                    ),
                    title: Text("Review Intern Profile ",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    subtitle: Text("Flutter Intern",style: TextStyle(color: Colors.grey[700])
                      ,),
                    trailing: Icon(Icons.arrow_forward_ios,size: 16,),
                  ),
                
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
