import 'package:flutter/material.dart';

class ContentTemplate extends StatelessWidget {
  final String title;
  final Widget child;

  ContentTemplate({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(child:child),
    );
  }
}
