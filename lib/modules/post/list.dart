

import 'package:api_learn/modules/post/detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';
import 'model.dart';

class PostList extends StatefulWidget{
  const PostList({Key? key}) : super(key: key);

  @override
  PostListState createState()=>PostListState();
}

class PostListState extends State<PostList> {
  bool postLoaded = false;
  late PostBloc bloc;
  late BuildContext tContext;
  List<Post> posts=[];

  @override
  void initState(){
    bloc = PostBloc(this);
    super.initState();
  }

  void loadPost(List<Post> result){
    if(mounted){
      if (result.isNotEmpty){
        setState(() {
          posts = result;
        });
      }
    }
  }

  void onBuild(BuildContext context){
    if(!postLoaded){
      bloc.getAllPost();
    }
    postLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    tContext = context;
    WidgetsBinding.instance?.addPostFrameCallback((_)=>onBuild(context));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.pushNamed(context, "/post/create");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child:ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap:(){
                  if (kDebugMode) {
                    print("Clicked");
                  }
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>PostDetail(id: posts[index].id)), (route) => true);
                },
                child:Card(
                    elevation: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${posts[index].title}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child:Text(
                            "${posts[index].body}",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w100
                            ),
                            textAlign: TextAlign.start,
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                ),
              );
            }
        )
      ),
      // Column(
      //   children: [
      //
      //     Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           TextButton(onPressed: (){
      //             Navigator.pushNamed(context, "/");
      //           }, child: const Text("Users")),
      //           TextButton(onPressed: (){
      //             Navigator.pushNamed(context, "/posts");
      //           }, child: const Text("Posts")),
      //         ]
      //     )
      //   ],
      // ),
    );
  }
}