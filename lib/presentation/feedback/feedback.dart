// ignore_for_file: use_build_context_synchronously

import 'package:code_geeks_web/application/feedback_bloc/feedback_bloc.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackPage extends StatelessWidget {
   FeedBackPage({super.key});

  final TextEditingController _feedbackController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feedback"),),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              const Text("Write to us !"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key:_key,
                  child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      
                        controller: _feedbackController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                                    
                          )
                        ),
                        maxLines: 15,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ActionChip(label: const Icon(Icons.send),onPressed: () {
                      if(_key.currentState!.validate()){
                        sendFeedback(context);
                      }
                    },)
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendFeedback(BuildContext context)async{
    Map<String,String?> data = {
      "Email" : FirebaseAuth.instance.currentUser?.email,
      "Feedback" : _feedbackController.text.trim()
    };
    context.read<FeedbackBloc>().add(FeedbackSentEvent(data: data));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Feedback send"),backgroundColor: Colors.green,duration: Duration(seconds: 1),));
      await Future.delayed(const Duration(seconds:2));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SidebarPage()),
      (route) => false,
    );

  }

}