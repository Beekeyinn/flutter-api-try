import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:api_learn/modules/post/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'users/model.dart';
import '../common/globals.dart' as globals;

class ApiProvider {
  http.Client client = http.Client();

  String makeRequestURL(String uri){
    return globals.apiEndPoint+uri;
  }




  Future<List<User>> doGetUser(String uri) async{
    String hitPoint = makeRequestURL(uri);
    // if (kDebugMode) {
    //   print(hitPoint);
    // }

    var response = await client.get(
        Uri.parse(hitPoint), // This will create the url link that needs to be hit by application
        headers: <String,String>{
          'Content-Type':"application/json"
        }
    );
    // if (kDebugMode) {
    //   print(response.body);

    // }
    if (response.statusCode==200){
      var jsonData = jsonDecode(response.body);
      List<User> users = [];
      for( var usr in jsonData){
        User user = User(usr['name'],usr['email'],usr['username']);
        users.add(user);
      }
      // if (kDebugMode) {
      //   print(users.length);
      // }
      return users;
    }
    else{
      throw Exception("Failed to Fetch data.");
    }
  }

  Future<List<Post>> doGetPosts(String uri) async{
    String hitPoint = makeRequestURL(uri);
    // if (kDebugMode) {
    //   print(hitPoint);
    // }
    var response = await client.get(
        Uri.parse(hitPoint), // This will create the url link that needs to be hit by application
        headers: <String,String>{
          'Content-Type':"application/json"
        }
    );
    // if (kDebugMode) {
    //   print(response.body);

    // }
    if (response.statusCode==200){
      var jsonData = jsonDecode(response.body);
      List<Post> posts = [];
      for( var pst in jsonData){
        Post post = Post(pst['id'],pst['title'],pst['body']);
        posts.add(post);
      }
      // if (kDebugMode) {
      //   print(users.length);
      // }
      return posts;
    }
    else{
      throw Exception("Failed to Fetch data.");
    }
  }

  Future<bool> createPost(String uri, PostInsert post)async{
    String hitPoint = makeRequestURL(uri);
    var data= globals.addUserID(post.toJson());
    var response = await client.post(
      Uri.parse(hitPoint),
      headers:<String,String>{
        'Content-Type':"application/json; charset=UTF-8",
      },
      body:jsonEncode(data)
    );
    var jsonResponse = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
      print(jsonResponse);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode==201){
      return true;
    }
    return false;
  }

  Future <Post> getSinglePost(String uri, int id)async{
    String url = "$uri/$id";
    String hitPoint = makeRequestURL(url);
    var response = await client.get(
      Uri.parse(hitPoint),
      headers: <String,String>{
        "Content-Type":"application/json"
      }
    );

    if(response.statusCode==200){
      var json = jsonDecode(response.body);
      Post post = Post(json['id'], json['title'],json['body']);
      return post;
    }else{
      throw Exception("Failed to get data");
    }
  }

  Future <bool> updatePost(String uri, int id, PostInsert post) async{
    String urlx = "$uri/$id";
    String hitPoint = makeRequestURL(urlx);
    var data = globals.addUserID(post.toJson());
    var response = await client.put(
      Uri.parse(hitPoint),
      headers: <String,String>{
        "Content-Type":"application/json"
      },
      body: jsonEncode(data)
    );
    if (kDebugMode) {
      print(response.statusCode);

    }
    if(response.statusCode==200){
      return true;
    }
    else {
      throw Exception("Failed to update");
    }
  }

  Future<bool> deletePost(String uri, int id)async{
    String urlx = "$uri/$id";
    String hitPoint = makeRequestURL(urlx);

    var response = await client.delete(Uri.parse(hitPoint),headers: <String,String>{"Content-Type":"application/json"});
    if (kDebugMode) {
      print(response.statusCode);
    }
    if(response.statusCode==200){
      return true;
    }
    else{
      throw Exception("Failed to delete");
    }
  }
}