import 'dart:developer';
import 'package:flutter/material.dart';

String apiEndPoint = "https://jsonplaceholder.typicode.com/";



class GlobalData{
  // This function is used to store the userID of the user for attaching to request later.
  static String userId="";
}

Map<String,String> addUserID(Map<String,dynamic> data){
  return {
    "userId":"1",
    ...data
  };
}