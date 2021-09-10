import 'package:flutter/material.dart';
import 'package:state_management/model/post_model.dart';
import 'package:state_management/services/http_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = 'detail_page';
  var itemOfList;
  DetailPage({this.itemOfList, Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  Post post = Post();
  _apiPost(int id) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST + '/${widget.itemOfList}', Network.paramsEmpty());
    setState(() {
      if (response != null) {
        post = Network.parsePost(response);
      }
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _apiPost(widget.itemOfList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPage'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title.toUpperCase(),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text(post.body),
              ],
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
        ],
      ),
    );
  }
}