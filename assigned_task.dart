import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssignedTaskPage extends StatefulWidget {
  const AssignedTaskPage({super.key});

  @override
  State<AssignedTaskPage> createState() => _AssignedTaskPageState();
}

class _AssignedTaskPageState extends State<AssignedTaskPage> {
  List<Map<String, dynamic>> taskList = [];
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    fetchTasksFromAllCollections();
  }

  void fetchTasksFromAllCollections() async {
    try {
      List<Map<String, dynamic>> allTasks = [];

      List<String> collections = ['tasks', 'projectTasks', 'urgentTasks'];

      for (String collection in collections) {
        final snapshot = await FirebaseFirestore.instance
            .collection(collection)
            .where('assignedTo', isEqualTo: userEmail)
            .get();

        for (var doc in snapshot.docs) {
          Map<String, dynamic> taskData = doc.data();
          taskData['source'] = collection;
          allTasks.add(taskData);
        }
      }

      setState(() {
        taskList = allTasks;
      });
    } catch (e) {
      print(" Error fetching tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2F1),
      appBar: AppBar(
        title: Text("📋 Assigned Tasks"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: taskList.isEmpty
          ? Center(
        child: Text(
          "😕 No tasks assigned yet!",
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.task_alt, color: Colors.teal),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task['taskTitle'] ?? 'No Title',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.description, color: Colors.grey[600]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task['taskDetails'] ?? 'No details provided.',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey[600]),
                      SizedBox(width: 8),
                      Text(
                        "Deadline: ${task['deadline']}",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[700]),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          task['status'] ?? 'Pending',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor:
                        (task['status'] == 'Completed')
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  if (task.containsKey('source'))
                    Text(
                      "📁 Source: ${task['source']}",
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[600]),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
