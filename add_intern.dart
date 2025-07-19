import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../dashboard.dart';

class Add_Intern extends StatefulWidget {
  const Add_Intern({super.key});

  @override
  State<Add_Intern> createState() => _Add_InternState();
}

class _Add_InternState extends State<Add_Intern> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? _selectedCourse;

  void registerIntern()async{
    if(_nameController.text.isEmpty||_emailController.text.isEmpty||_phoneController.text.isEmpty||_selectedCourse==null){
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content: Text("Please fill all Fields")));
      return;
    }
    try{
      await FirebaseFirestore.instance.collection("interns").add({
        'name':_nameController.text.trim(),
        'email':_emailController.text.trim(),
        'phone':_phoneController.text.trim(),
        'course':_selectedCourse,
        'timestamp':Timestamp.now()
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Page()));

    }catch(e){
      print("Error:$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong!')),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Intern", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
              SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Full Name',
                  hintText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                  hintText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  hintText: 'Phone',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                items: [
                  DropdownMenuItem(value: 'BSc Computer Science', child: Text('BSc Computer Science')),
                  DropdownMenuItem(value: 'BBA', child: Text('BBA')),
                  DropdownMenuItem(value: 'BS Software Engineering', child: Text('BS Software Engineering')),
                  DropdownMenuItem(value: 'BS IT', child: Text('BS IT')),
                  DropdownMenuItem(value: 'BS Data Science', child: Text('BS Data Science')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: registerIntern,
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor: Color(0xFFB2DFDB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
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
