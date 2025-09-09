import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authentication/login_screen.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});
  Future<void> logout(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {logout(context);}, child: Text("logout")),
      ),
    );
  }
}
