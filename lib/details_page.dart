import 'package:flutter/material.dart';

import 'models/model.dart';

class DetailsPage extends StatelessWidget {
  Model model;
  DetailsPage(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.purple[400],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
        ),
        child: Text(model.body),
      ),
    );
  }
}
