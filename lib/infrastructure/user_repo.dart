import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_web/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserRepo{

  

  Future<UserModel> getUser()async{
  try{
    User? user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    final usera = data.data();
    final users = UserModel(id: usera!['id'], name: usera['Name'], email: usera['Email'], profile: usera['profile'], profession: usera['Profession']);
    return users;
  }
  on FirebaseException catch(e){
    if(kDebugMode){
      print("failed with error ${e.code} : ${e.message}");
    }
    return UserModel(id: "", name: "", email: "", profile: "", profession: "");
  }
  catch(e){
    throw Exception(e.toString());
  }
}



}