import 'package:code_geeks_web/presentation/homepage/homepage.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  bool isMobile = false;

  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar( title: Text(isMobile.toString()),),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight,
              width: screenWidth/3,
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    // const SizedBox(height: 100),
                 //logo
                isMobile ?  Card(
                color: Colors.white,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('lib/assets/logo.png',fit: BoxFit.cover,height: 100,width: 100,),
                ),
              ) : SizedBox(height: 80,),
              const SizedBox(height: 30,),
              Text("Login",style: GoogleFonts.orbit(
                fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black54
              ),),
               const SizedBox(height: 30,),
              //email field
                    Card(
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(     
                              validator: validateEmail,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                border: OutlineInputBorder(
                                )
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30,),
                  //password field
                    Card(
                          child: Container(
                            color: Colors.white,
                            child: PasswordField(
                              controller: _passwordController,
                              color: Colors.blue,
                              passwordConstraint: r'^(?=.*[@$#.*])(?=.*[0-9])[A-Za-z\d@$#.*]{6,}$',
                              hintText: 'Password',
                              border: PasswordBorder(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.red.shade200),
                                ),
                              ),
                              errorMessage:
                                  'must include special character & 6 characters',
                            ),
                          ),
                        ),
                    const SizedBox(height: 30,),
                  //login button
                     SizedBox(
                  width: double.infinity,
                  child: LoadingBtn(
                      height: 40,
                      borderRadius: 8,
                      animate: true,
                      color: const Color.fromARGB(255, 110, 132, 214),
                      width: MediaQuery.of(context).size.width * 0.45,
                      loader: Container(
                          padding: const EdgeInsets.all(10),
                          width: 40,
                          height: 40,
                          child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                      ),
                      child: const Text("Login",style: TextStyle(color: Colors.white),),
                      onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.idle) {
                              startLoading();
                              if(_key.currentState!.validate()){
                                            signIn(context);
                                            }
                              await Future.delayed(const Duration(seconds: 2));
                              stopLoading();
                          }
                      },
                  ),
                ),  
                Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){forgotPassword(_emailController.text);}, child: const Text("Forgot password?",style: TextStyle(fontSize: 12),),)),
                        const SizedBox(height: 30,),     
                  ],
                )
                ),
            ),SizedBox(width: 50,),
            !isMobile?
              Card(
                color: Colors.white,
                child: SizedBox(
                  height: 500,
                  width: 500,
                  child: Image.asset('lib/assets/logo.png',fit: BoxFit.cover,height: 300,width: 300,),
                ),
              )
            :SizedBox()
          ],
        ),
      )
    );
  }

    Future signIn(BuildContext context) async{
   try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Welcome aboard !"),backgroundColor: Colors.green,duration: Duration(seconds: 1),));
      await Future.delayed(const Duration(seconds:2));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => SidebarPage() ), (route) => false);
   }
   on FirebaseAuthException catch(e){  
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${e.message}"),backgroundColor: Colors.red));
    debugPrint(e.message);
   }
  }

   forgotPassword(String email)async{

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
   }


       //to validate email
String? validateEmail(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; 
}
}