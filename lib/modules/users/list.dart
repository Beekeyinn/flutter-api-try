import 'package:api_learn/modules/users/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'bloc.dart';

class UserList extends StatefulWidget{
  const UserList({Key? key}) : super(key: key);

  @override
  UserListState createState() => UserListState();
}

class UserListState extends State<UserList>{
  bool stateChanged = false;
  late UserBloc bloc;
  late BuildContext tContext;
  List<User> users =[];
  @override
  void initState(){
    bloc = UserBloc(this);
    super.initState();
  }

  void fetchData(List<User> result){
    // Navigator.pop(tContext);
    if(result.isNotEmpty){
      setState(() {
        users=result;
        if (kDebugMode) {
          print("data received");
          // print(users);
        }
      });
    }
  }
  void onBuild(BuildContext context){
    if (kDebugMode) {
      print("building View");
    }
    if (!stateChanged){
      bloc.getAllUsers();
    }
    stateChanged = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    tContext = context;

    WidgetsBinding.instance!.addPostFrameCallback((_) => onBuild(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users List"),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: const TextStyle(color:Colors.red),
      ),
      body:Column(
        children: [
          SafeArea(
              child:SingleChildScrollView(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: const Icon(Icons.list),
                      trailing: const Text("Detail",style: TextStyle(color:Colors.greenAccent,fontSize: 15),),
                      title: Text("Email: ${users[index].email}"),
                    );
                  },
                ),
              )
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                  TextButton(onPressed: (){
                   if (ModalRoute.of(context)?.settings.name != '/'){
                     Navigator.pushNamed(context, "/");
                   }

                  }, child: const Text("Users")),
                  TextButton(
                      onPressed: (){
                    Navigator.pushNamed(context, "/posts");
                  },
                      child: const Text("Posts")),
            ]
          )
        ],
      )
    );
  }

}


