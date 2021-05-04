import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_call_practice/details_page.dart';
import 'dart:convert';

import 'package:network_call_practice/models/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget loadingIndicator = SizedBox();
  List<Widget> _listItems = [];
  _networkCall() async {
    _enableLoading();
    //String url = 'https://jsonplaceholder.typicode.com/posts';
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    Response response = await get(url);
    //print(response.body);
    _responseDecoder(response.body);
    _disableLoading();
  }

  _enableLoading() {
    setState(() {
      loadingIndicator = LinearProgressIndicator();
    });
  }

  _disableLoading() {
    setState(() {
      loadingIndicator = SizedBox();
    });
  }

  _responseDecoder(String body) {
    List list = jsonDecode(body);
    //print(list[0]);
    //print(list[0]['title']);
    List<Widget> tempList = [];

    for (int i = 0; i < list.length; i++) {
      Map eachElement = list[i];
      Model model = Model(
        title: eachElement['title'],
        body: eachElement['body'],
        userId: eachElement['userId'],
        id: eachElement['id'],
      );
      tempList.add(_card(model));
    }
    _listItems = tempList;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _networkCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Network Call using http",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(child: loadingIndicator),
              _titleList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: ListView(
        //shrinkWrap: true,
        children: _listItems,
      ),
    );
  }

  Widget _card(model) {
    return GestureDetector(
      onTap: () {
        //print("Tapped");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsPage(model)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ),
        child: Text(model.title),
      ),
    );
  }
}
