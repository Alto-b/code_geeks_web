import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_web/domain/mentor_model.dart';
import 'package:flutter/material.dart';

class MentorRepo{
  Future<List<MentorModel>> getMentor()async{
    List<MentorModel> mentorList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection('mentors').orderBy('name').get();
      for (var element in datas.docs) {
        final data = element.data();
        final mentor = MentorModel(
          photo: data['photo'], 
          name: data['name'], 
          contact: data['contact'], 
          email: data['email'], 
          qualification: data['qualification'], 
          gender: data['gender'], 
          dob: data['dob']);

          mentorList.add(mentor);
      }
      return mentorList;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting mentor. : ${e.message}");
    }
    return mentorList;
  }
}