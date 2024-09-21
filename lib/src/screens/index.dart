import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("22-110 MSIT"),
        backgroundColor: Colors.red[100],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg/adduccfc.png"),
            fit: BoxFit.cover,
          ),         
        ),
        child: Text("Child Widget Text"),
      ),

    );
  }
}