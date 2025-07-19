import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int totalTasks = 0;
  int completedTasks = 0;
  int pendingTasks = 0;
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    calculateProgress();
  }

  void calculateProgress() async {
    try {
      int total = 0;
      int completed = 0;

      List<String> collections = ['tasks', 'projectTasks', 'urgentTasks'];

      for (String collection in collections) {
        final snapshot = await FirebaseFirestore.instance
            .collection(collection)
            .where('assignedTo', isEqualTo: userEmail)
            .get();

        total += snapshot.docs.length;

        for (var doc in snapshot.docs) {
          if ((doc.data()['status'] ?? '').toString().toLowerCase() == 'completed') {
            completed++;
          }
        }
      }

      setState(() {
      });
        totalTasks = total;
        completedTasks = completed;
        pendingTasks = total - completed;
    } catch (e) {
      print("Error calculating progress: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = totalTasks == 0 ? 0 : completedTasks / totalTasks;

    return Scaffold(
      appBar: AppBar(
        title: Text("📊 Progress"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFF1F8E9),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              "Your Task Progress",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
            ),
            SizedBox(height: 12),
            Text(
              "${(progress * 100).toStringAsFixed(1)}% Completed",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    progressItem("✅ Completed Tasks", completedTasks, Colors.green),
                    progressItem("🕒 Pending Tasks", pendingTasks, Colors.orange),
                    Divider(),
                    progressItem("📋 Total Tasks", totalTasks, Colors.blueGrey),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget progressItem(String title, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 12, color: color),
          SizedBox(width: 10),
          Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
          Text(count.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
