import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:state_management/model/post_model.dart';
import 'package:state_management/pages/post_detail_page.dart';
import 'package:state_management/pages/update_page.dart';
import 'package:state_management/services/http_service.dart';

import 'create_page.dart';

class HomePage extends StatefulWidget {
  static final String id="home_page";
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool isLoading =false;
  List<Post> items=new List();
  void _apiPostList()async{
    setState(() {
      isLoading=true;
    });
    var response=await Network.GET(Network.API_LIST, Network.paramsEmpty());
 setState(() {
   if(response!=null){
     items=Network.parsePostList(response);
   }else{
     items=new List();
   }
   isLoading=false;
 });
  }
  void _apiPostDelete(Post post)async{
    setState(() {
      isLoading=true;
    });
    var response =await Network.DEL(Network.API_DELETE+post.id.toString(), Network.paramsEmpty());
    if(response!=null){
      _apiPostList();
    }
    isLoading=false;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setstate"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index){
              return itemOfPost(items[index]);
            },

          ),
          isLoading  ?
              Center(
                child: CircularProgressIndicator(),
              ):SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.pushNamed(context, CreatePage.id);

        },
        child: Icon(Icons.add),
      ),

    );
  }
  Widget itemOfPost(Post post){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(itemOfList: post.id),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20, top:20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title.toUpperCase(),style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(height: 5,),
              Text(post.body)

            ],
          ),
        ),
      ),
      actions:<Widget> [
        IconSlideAction(
          caption: "Update",
          color: Colors.indigo,
          icon:Icons.edit,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title, body: post.body)));
            },
        )

      ],
      secondaryActions:<Widget> [
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){
            _apiPostDelete(post);
            },
        )

      ],
    );
  }

}
