import 'package:api_learn/modules/post/bloc.dart';
import 'package:api_learn/modules/post/create.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class PostDetail extends StatefulWidget{
  final int id;

  const PostDetail({Key? key,required this.id}) : super(key: key);
  @override
  PostDetailState createState()=>PostDetailState();
}

class PostDetailState extends State<PostDetail>{
  late SinglePostBloc bloc;
  String title = "";
  String body="";
  int id = 0;
  bool loaded = false;
  @override
  void initState(){
    super.initState();
    bloc = SinglePostBloc(this);
  }

  void postDeleted(bool deleted){
    if (deleted){
        Navigator.pop(context);
    }
  }

  void loadPost(Post rPost){
      if(mounted){
        setState(() {
          title = rPost.title;
          body = rPost.body;
          id=rPost.id;
        });
      }
  }

  void onBuild(BuildContext context){
    if(!loaded){
      bloc.getSinglePost(widget.id);
      //widget.id contains all the field of super field
    }
    loaded=true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    WidgetsBinding.instance?.addPostFrameCallback((_)=>onBuild(context));
    return Scaffold(
      appBar: AppBar(
        title:Text(title),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        shadowColor: Colors.black38,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.cyan
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Card(
              elevation: 60,
              shadowColor: Colors.black38,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(5),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text("Title",textAlign: TextAlign.left,style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                  )
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: Text(title,textAlign: TextAlign.left,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                    width: double.infinity,
                    child: Text(body,textAlign: TextAlign.left,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: Colors.black54
                    ),
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){
                      Post post = Post(id,title,body);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>CreatePost(post: post)), (route) => true);
                    },
                    child: const Text("Update",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                    ),)),
                TextButton(onPressed: (){
                  bloc.deletePost(id);
                    }, child: const Text("Delete",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                ),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}