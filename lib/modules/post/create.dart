


import 'package:api_learn/modules/post/bloc.dart';
import 'package:api_learn/modules/post/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget{
  final Post? post;
  const CreatePost({Key? key, this.post}) : super(key: key);

  @override
  CreatePostState createState() =>CreatePostState();

}


class CreatePostState extends State<CreatePost>{

  late PostCreateBloc bloc ;
  final  _titleTextController = TextEditingController();
  final  _bodyTextController = TextEditingController();
  String title = "Create";
  late BuildContext tContext;
 void postCreated (bool created,{dynamic errors=0}){
   if(created){
     Navigator.pop(tContext);
   }
   if (kDebugMode) {
     print("Inside created");
   }
   if (!created && errors!=0){
      if (kDebugMode) {
        print(errors);
      }
   }
 }

  @override
  void initState(){
    bloc=PostCreateBloc(this);
    super.initState();
    if(widget.post!=null){
      title = "Update";
      _titleTextController.text = widget.post?.title;
      _bodyTextController.text = widget.post?.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    tContext = context;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("$title Post",style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 0),
      child:Column(
        children: <Widget>[
          const Text("Title",style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child:TextField(
              controller: _titleTextController,
              decoration: const InputDecoration(
                hintText: "Enter your post Title.",
                border: OutlineInputBorder(),
              ),
            ),),
          const SizedBox(
            height: 10,
          ),
          const Text("Body",style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child:TextField(
              controller: _bodyTextController,
              decoration: const InputDecoration(
                hintText: "Enter your post body.",
                border: OutlineInputBorder(),
              ),
            ),),
          const SizedBox(
            height: 10,
          ),
         ElevatedButton(
             onPressed: ()async{
               PostInsert post = PostInsert(_titleTextController.text,_bodyTextController.text);
               if(widget.post != null){
                  bloc.updatePost(post, widget.post?.id);
               }else{
                 bloc.createPost(post);
               }
             },
             child: const Text("Submit"))
        ],

      ),)
    );
  }

}