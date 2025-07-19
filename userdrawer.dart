import 'package:first_project/taskpage.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'intern_page.dart';

class User_Drawer extends StatefulWidget {
  const User_Drawer({super.key});

  @override
  State<User_Drawer> createState() => _User_DrawerState();
}

class _User_DrawerState extends State<User_Drawer> {
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
            title: Text("My Tasks"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Intern_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.task, color: Colors.teal),
            title: Text("Edit Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Task_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart, color: Colors.teal),
            title: Text("Logout"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard_Page()),
              );
            },
          ),

        ],
      ),
    );
  }
}
