import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/dashboard.dart';
import 'package:first_project/userdashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
  }

  void loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _emailController.text = prefs.getString('email') ?? '';
    _passwordController.text = prefs.getString('password') ?? '';
  }

  Future<void> saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<String?> getUserRole(String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data()['role'];
      }
    } catch (e) {
      print("Error fetching role: $e");
    }
    return null;
  }

  Future<void> loginIntern() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in both email and password.")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters.")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Try to login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? role = await getUserRole(email);
      await saveCredentials(email, password);

      if (role == 'admin') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => Dashboard_Page()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => User_Dashboard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Register the user
        try {
          UserCredential newUser = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: email, password: password);

          await FirebaseFirestore.instance.collection('users').add({
            'email': email,
            'role': 'user',
            'createdAt': Timestamp.now(),
          });

          await saveCredentials(email, password);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => User_Dashboard()));
        } on FirebaseAuthException catch (regError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration failed: ${regError.message}")),
          );
        }
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Incorrect password.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFECEFF1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/login.png", height: 250),
              SizedBox(height: 20),
              Text("Login Page",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black)),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Your Email",
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Your Password",
                  suffixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  onPressed: loginIntern,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB2DFDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style:
                    TextStyle(fontSize: 18, color: Colors.grey[800]),
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
