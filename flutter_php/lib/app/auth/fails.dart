
import 'package:flutter/material.dart';

class Fails extends StatefulWidget {
  const Fails({super.key});

  @override
  State<Fails> createState() => _FailsState();
}

class _FailsState extends State<Fails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("فشل فى تسجيل الدخول",
              style: TextStyle(fontSize: 20),
            ),
          ),
        MaterialButton(
            onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil("Signup", (route) => false);
            },
            child: Text("Please Sign Up Again"),
        )
        ],
      ),
    );
  }
}
