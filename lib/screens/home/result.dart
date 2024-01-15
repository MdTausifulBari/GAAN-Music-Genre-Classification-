import 'package:flutter/material.dart';
import 'package:gaan/shared/loading.dart';

class Result extends StatelessWidget {

  bool loading = false;

  String label;

  Result({required this.label});

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Genre"),
      ),
      body: Center(
          child: Text(
            label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
      ),

    );
  }
}
