import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update_Intern extends StatefulWidget {
  const Update_Intern({super.key});

  @override
  State<Update_Intern> createState() => _Update_InternState();
}

class _Update_InternState extends State<Update_Intern> {
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController courseController=TextEditingController();

  String ? documentId;
  bool showCard=false;
  bool showEditFields=false;

  void showMessage(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  }


  void searchIntern()async{
    String email=emailController.text;

    if(email.isEmpty){
   showMessage("No Email Found");
   return;
    }

    try{
      var query=await FirebaseFirestore.instance.collection("interns")
      .where("email",isEqualTo: email)
      .get();

      if(query.docs.isEmpty){
        showMessage("No intern Found");
        setState(() {
          showCard=false;
          showEditFields=false;
        });
      }else{
        var intern=query.docs[0];
        var data=intern.data();

        setState(() {
          documentId=intern.id;
          nameController.text=data['name']?? '';
          phoneController.text=data['phone']??'';
          courseController.text=data['course']??'';
          showCard=true;
          showEditFields=false;
        });
      }


    }catch(e){
     showMessage("Error${e}");
    }
  }

  void updateIntern()async{
    if(documentId==null){
      showMessage("Search First");
    }
    try{
      await FirebaseFirestore.instance.collection("interns").doc(documentId).update(
          {
            'name':nameController.text.trim(),
            'phone':phoneController.text.trim(),
            'course':courseController.text.trim(),
          });
         showMessage("Intern Updated Successfully");
         setState(() {
           showEditFields=false;
         });
    }catch(e){
      showMessage("Update Failed: $e");

    }
  }
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    courseController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text("Update Intern", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Search by Email",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: searchIntern,
                  child: Text("Search"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB2DFDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // 👤 Show Intern Card After Search
              if (showCard)
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(child: Text(nameController.text.isNotEmpty ? nameController.text[0] : '?')),
                    title: Text(nameController.text),
                    subtitle: Text(phoneController.text),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.teal),
                      onPressed: () {
                        setState(() {
                          showEditFields = true;
                        });
                      },
                    ),
                  ),
                ),

              if (showEditFields) ...[
                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: courseController,
                  decoration: InputDecoration(labelText: "Course", border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: updateIntern,
                    child: Text("Update"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
