// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificPostView extends StatelessWidget {
   SpecificPostView({
    super.key,
    required this.title,
    required this.author,
    required this.author_avatar,
    required this.content,
    required this.description
    });

    String title;
    String author;
    String author_avatar;
    String description;
    String content;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w600
              ),),
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(author_avatar),),
                  const SizedBox(width: 5,),
                  Text(author,style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Text(description),
              const SizedBox(height: 20,),
              Text(content),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      
    );
  }
}