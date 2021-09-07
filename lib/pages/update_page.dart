import 'dart:math';

import 'package:flutter/material.dart';
import 'package:state_management/model/post_model.dart';
import 'package:state_management/services/http_service.dart';

import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String title, body;
  UpdatePage({this.title, this.body, Key key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isLoading = false;
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _bodyTextEditingController = TextEditingController();

  _apiPostUpdate() async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(
        id: Random().nextInt(999),
        title: _titleTextEditingController.text,
        body: _bodyTextEditingController.text,
        userId: Random().nextInt(999));

    var response =
        await Network.PUT(Network.API_UPDATE , Network.paramsUpdate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, (route) => false);
      }

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _titleTextEditingController.text = widget.title;
    _bodyTextEditingController.text = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                // Title
                Container(
                  height: 100,
                  padding: EdgeInsets.all(5),

                  child: Center(
                    child: TextField(maxLines: 2,
                      controller: _titleTextEditingController,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        ),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),




                // Body
                Container(
                  height: 500,
                  padding: EdgeInsets.all(5),

                  child: TextField(
                    controller: _bodyTextEditingController,
                    style: TextStyle(fontSize: 20),
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Body',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          _apiPostUpdate();
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
