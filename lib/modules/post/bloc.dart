

import 'package:api_learn/modules/post/create.dart';
import 'package:api_learn/modules/post/detail.dart';
import 'package:api_learn/modules/repository.dart';

import '../bloc.dart';
import 'list.dart';
import 'model.dart';

class PostBloc extends AppBloc{
  late PostListState state;

  PostBloc(PostListState postListState){
    state = postListState;
  }

  getAllPost() async{
    List<Post> posts = await repository().getPosts();
    state.loadPost(posts);
  }



}

class PostCreateBloc extends AppBloc{
  late CreatePostState state;

  PostCreateBloc(CreatePostState createPostState){
    state=createPostState;
  }
  void createPost(PostInsert post) async{
    bool created = await repository().createPost(post);
    if (created){
        state.postCreated(created);
    }
  }

  void updatePost(PostInsert post, int id)async{
    bool updated = await repository().updatePost(post,id);
    if (updated){
      state.postCreated(updated);
    }
  }


}

class SinglePostBloc extends AppBloc{
  late PostDetailState state;
  SinglePostBloc(PostDetailState postDetailState){
    state=postDetailState;
  }

  void getSinglePost(int id)async{
    Post post =  await repository().getSinglePost(id);
    state.loadPost(post);
  }
  void deletePost(int id) async{
    bool deleted = await repository().deletePost(id);
    if (deleted){
      state.postDeleted(deleted);
    }
  }
}