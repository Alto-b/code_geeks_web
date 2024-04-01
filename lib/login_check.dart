import 'package:code_geeks_web/presentation/homepage/homepage.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:code_geeks_web/presentation/welcome%20page/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginCheckPage extends StatelessWidget {
  const LoginCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return const Center(child: Text("Something not right"));
          }
          else if(snapshot.hasData){
            return SidebarPage();
          }
          else{
            return  WelcomePage();
          } 
        },
      ),
    );
  }
}