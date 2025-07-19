import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class FirebaseCheck extends StatefulWidget {
  const FirebaseCheck({super.key});

  @override
  State<FirebaseCheck> createState() => _FirebaseCheckState();
}

class _FirebaseCheckState extends State<FirebaseCheck> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Center(child: Text("✅ Firebase Connected!")),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("❌ Error: ${snapshot.error}")),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
