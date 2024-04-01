import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_web/domain/post_model.dart';
import 'package:flutter/material.dart';

class PostRepo{
  Future<List<PostModel>> getFeeds()async{

    List<PostModel> postList = [];

    try{
      final datas = await FirebaseFirestore.instance.collection("post")
        .orderBy('date')
        .get();

        for (var element in datas.docs) {
          final data = element.data();
          final feed = PostModel(
            author: data['author'], 
            author_avatar: data['author_avatar'], 
            content: data['content'], 
            description: data['description'], 
            id: data['id'], 
            title: data['title'],
            date: data['date']);

            postList.add(feed);
        }
        return postList;
    }
    on FirebaseException catch(e){
      debugPrint("exception while loading feeds ${e.message}");
    }
    return postList;
  }
}