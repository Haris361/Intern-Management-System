import 'package:first_project/dashboard.dart';
import 'package:first_project/intern_page.dart';
import 'package:first_project/login_page.dart';
import 'package:first_project/taskpage.dart';
import 'package:flutter/material.dart';

class Custom_Drawer extends StatelessWidget {
  const Custom_Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB2DFDB),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/internee.png"),
                  radius: 30,
                ),
                SizedBox(height: 10),

                Text(
                  "Internee.PK",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Internship Program",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),


              ],
            ),
          ),


          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.teal),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.computer, color: Colors.teal),
            title: Text("Add Intern"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Intern_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.task, color: Colors.teal),
            title: Text("Add Tasks"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Task_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart, color: Colors.teal),
            title: Text("All Interns"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.teal),
            title: Text("Logout"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login_Page()),
              );
            },
          ),

        ],
      ),
    );
  }
}
