import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Review_Intern extends StatefulWidget {
  const Review_Intern({super.key});

  @override
  State<Review_Intern> createState() => _Review_InternState();
}

class _Review_InternState extends State<Review_Intern> {

   List <Map<String,dynamic>> internList=[];

   void fetchInterns() async{

     try{
       final data=await FirebaseFirestore.instance.collection("interns")
           .orderBy('timestamp',descending: true)
           .get();

       setState(() {
         internList=data.docs.map((e)=> e.data() as Map<String,dynamic>).toList();
       });

     }catch(e){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:$e")));

     }
   }

  @override
  void initState() {
    super.initState();
    fetchInterns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🎓 Review Interns",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[700]),
              ),
              SizedBox(height: 20),
              internList.isEmpty
                  ? Expanded(
                child: Center(child: Text("No Interns Found")),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: internList.length,
                  itemBuilder: (context, index) {
                    final intern = internList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.teal[100],
                            child: Text(
                              intern['name'][0].toUpperCase(),
                              style: TextStyle(fontSize: 24, color: Colors.teal[900]),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  intern['name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text("📧 ${intern['email']}"),
                                Text("📱 ${intern['phone']}"),
                                Text("📘 ${intern['course']}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
