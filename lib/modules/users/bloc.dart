

import 'package:api_learn/modules/bloc.dart';
import 'package:api_learn/modules/users/list.dart';
import 'package:api_learn/modules/users/model.dart';
import 'package:flutter/foundation.dart';

class UserBloc extends AppBloc {
  late UserListState state;
  UserBloc(UserListState userListState){
    state=userListState;
  }

  getAllUsers() async{
    List<User> users = await repository().getUsers();
    // if (kDebugMode) {
    //   print(users);
    // }
    state.fetchData(users);
  }

}