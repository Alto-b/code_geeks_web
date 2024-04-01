// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_web/application/join_mentor/join_mentor_bloc.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;

// ignore: must_be_immutable
class MentorJoinPage extends StatelessWidget {
   MentorJoinPage({super.key});

  final _key = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final TextEditingController _contact = TextEditingController();
   Uint8List? cv ;

  @override
  Widget build(BuildContext context) {

    _name.text = FirebaseAuth.instance.currentUser!.displayName!;
    _email.text = FirebaseAuth.instance.currentUser!.email!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Us"),
        titleTextStyle:GoogleFonts.orbitron(fontSize: 15,fontWeight: FontWeight.w600,letterSpacing: 3,color: Colors.grey),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Card(
                  child: Form(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: _name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: const Text("Full name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        TextFormField(
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: const Text("Email id"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        TextFormField(
                          controller: _contact,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: const Text("Contact"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        TextFormField(
                          controller: _about,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 10,
                          decoration: InputDecoration(
                            label: const Text("About"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        BlocBuilder<JoinMentorBloc, JoinMentorState>(
                          builder: (context, state) {
                            if(state is FilePickedState){
                              cv = state.filePath;
                              // String fileName = cv.;
                              // return TextButton.icon(onPressed: (){
                              //   context.read<JoinMentorBloc>().add(FilePickerEvent());
                              // }, icon: const Icon(Icons.edit), label:Text(fileName));//i need name of file here
                              return GestureDetector(
                                onTap: () {
                                  context.read<JoinMentorBloc>().add(FilePickerEvent());
                                },
                                child: Container(
                                  height: 200,width: 100,
                                  child: Image.memory(cv!),
                                ),
                              );
                            }
                             return TextButton.icon(onPressed: (){
                                         context.read<JoinMentorBloc>().add(FilePickerEvent());
                                        }, icon: const Icon(Icons.file_copy_outlined), label: const Text("upload CV"));
                          },
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          sendRequestToJoinAsMEntor(context);
                        },style: ButtonStyle(
                          backgroundColor:MaterialStatePropertyAll(Colors.green[400])
                        ), child: const Text("Submit",style: TextStyle(
                          color: Colors.white
                        ),),),
                        const SizedBox(height: 20,),
                      ],
                      ),
                    )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendRequestToJoinAsMEntor(BuildContext context)async{
    if(cv==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("CV is required"),backgroundColor: Colors.blue,));
    }
    else if(_key.currentState!.validate() && cv!=null){
      firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref().child("cv_${_name.text}.pdf");
      firebasestorage.UploadTask uploadTask = ref.putData(cv!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,duration: Duration(seconds: 2),));
      await uploadTask;
      var downloadUrl = await ref.getDownloadURL();

      final reqId = FirebaseFirestore.instance.collection("mentor_requests").doc().id;
      
      Map<String,dynamic> data ={
        "reqId" : reqId,
        "Name" : _name.text.trim(),
        "Email" : _email.text.trim(),
        "Contact" : _contact.text.trim(),
        "About" : _about.text.trim(),
        "CV" : downloadUrl,
        "dateTime" : DateTime.now().toString()
      };
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request placed!"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
     context.read<JoinMentorBloc>().add(PlaceRequestEvent(data: data, reqId: reqId)); 
     Future.delayed(const Duration(seconds: 2));
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SidebarPage(),), (route) => false);
    }
  }
}