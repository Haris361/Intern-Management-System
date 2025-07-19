import 'package:first_project/custom_drawer.dart';
import 'package:first_project/dashboard.dart';
import 'package:flutter/material.dart';

class Intern_Page extends StatefulWidget {
  const Intern_Page({super.key});

  @override
  State<Intern_Page> createState() => _Intern_PageState();
}

class _Intern_PageState extends State<Intern_Page> {
  TextEditingController _usercontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _coursecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Drawer connected
      drawer: Drawer(
        child: Custom_Drawer(),
      ),

      body: Container(
        color: Color(0xFFECEFF1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: ListView(
            children: [
              // ✅ Manual Drawer Icon
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
                    "Intern Form",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 30),

              // ✅ Username
              TextField(
                controller: _usercontroller,
                decoration: InputDecoration(
                  labelText: "Enter Username",
                  hintText: "User",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // ✅ Email
              TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // ✅ Course
              TextField(
                controller: _coursecontroller,
                decoration: InputDecoration(
                  labelText: "Enter Course",
                  hintText: "Course",
                  prefixIcon: Icon(Icons.computer),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // ✅ Register Button
              Center(
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard_Page(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor: Color(0xFFB2DFDB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style:
                      TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
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
