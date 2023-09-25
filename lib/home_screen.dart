import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Lading Page",
              style: TextStyle(color: Colors.yellowAccent)),
            centerTitle: true,
            backgroundColor: Colors.redAccent,
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text(
              "Landing Page",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
            )),
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
              child: Text(
                "Welcome ${widget.userEmail}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
              ),
              )
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Logout"),
          ),
        ],
      )
    );
  }
}

