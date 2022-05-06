import 'package:api_learn/modules/post/create.dart';
import 'package:api_learn/modules/post/detail.dart';
import 'package:api_learn/modules/post/list.dart';
import 'package:api_learn/modules/users/list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "API Testing",
      theme:ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/',
      routes: <String,WidgetBuilder>{
        '/':(BuildContext context)=>const UserList(),
        '/posts':(BuildContext context)=> const PostList(),
        '/post/create':(BuildContext context)=> const CreatePost(),
      },
      
    );
  }
}



// class DataFromAPI extends StatefulWidget{
//   const DataFromAPI({Key? key}) : super(key: key);
//
//   @override
//   _DataFromAPIState createState() => _DataFromAPIState();
// }
//
// class _DataFromAPIState extends State<DataFromAPI>{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "API Testing",
//         theme:ThemeData(
//           primarySwatch: Colors.lightBlue,
//         ),
//       initialRoute: '/',
//       routes: <String,WidgetBuilder>{
//           '/':(BuildContext context)=>UserList(),
//     },);
//
//   }
// }

