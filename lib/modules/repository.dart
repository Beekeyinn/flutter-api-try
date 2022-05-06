
/*
*
* In this file we write the function that will call the provider (ApiProvider function)
* such as doGet method to get data from api (asynchronously)
*
* This acts as a url in django that gets hit function when called
*
* */

import 'package:api_learn/modules/post/model.dart';
import 'package:api_learn/modules/provider.dart';
import 'dart:async';

import 'package:api_learn/modules/users/model.dart';

class Repository{
  final apiProvider = ApiProvider();

  Future<List<User>> getUsers() => apiProvider.doGetUser("users/");
  Future<List<Post>> getPosts()=>apiProvider.doGetPosts("posts/") ;
  Future<bool> createPost(PostInsert post)=>apiProvider.createPost("posts", post);
  Future<Post> getSinglePost(int id)=>apiProvider.getSinglePost("posts/", id);
  Future<bool> updatePost(PostInsert post, int id)=>apiProvider.updatePost("posts/", id, post);
  Future<bool> deletePost(int id)=>apiProvider.deletePost("posts/",id);
}