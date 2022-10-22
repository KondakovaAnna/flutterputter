import 'dart:async';
import 'package:flutter/material.dart';
import 'location.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          backgroundColor: const Color(0xFF89C09F),
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Text('История', style: TextStyle(fontSize: 22)),
          ),
        ),
      ),
      /*body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),*/
    );
  }
}
