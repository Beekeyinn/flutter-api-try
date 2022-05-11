import 'package:api_learn/modules/post/bloc.dart';
import 'package:api_learn/modules/post/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final Post? post;

  const CreatePost({Key? key, this.post}) : super(key: key);

  @override
  CreatePostState createState() => CreatePostState();
}

class CreatePostState extends State<CreatePost> {
  late PostCreateBloc bloc;

  final _titleTextController = TextEditingController();
  final _bodyTextController = TextEditingController();
  String title = "Create";
  late BuildContext tContext;

  void postCreated(bool created, {dynamic errors = 0}) {
    if (created) {
      Navigator.pop(tContext);
    }
    if (kDebugMode) {
      print("Inside created");
    }
    if (!created && errors != 0) {
      if (kDebugMode) {
        print(errors);
      }
    }
  }

  @override
  void initState() {
    bloc = PostCreateBloc(this);
    super.initState();
    if (widget.post != null) {
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
          title: Text(
            "$title Post",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 300,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  elevation: 60,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: const Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: TextField(
                            controller: _titleTextController,
                            decoration: const InputDecoration(
                              hintText: "Enter your post Title",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Text(
                            "Body",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: TextField(
                            controller: _bodyTextController,
                            decoration: const InputDecoration(
                              hintText: "Enter your post body",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    PostInsert post = PostInsert(
                                        _titleTextController.text,
                                        _bodyTextController.text);
                                    if (widget.post != null) {
                                      bloc.updatePost(post, widget.post?.id);
                                    } else {
                                      bloc.createPost(post);
                                    }
                                  },
                                  child: const Text("Submit")),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
