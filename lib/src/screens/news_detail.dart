import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Text("Helo guis, I am item $itemId"),
    );
  }
}
