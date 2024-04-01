import 'dart:ui';

import 'package:code_geeks_web/application/feedback_bloc/feedback_bloc.dart';
import 'package:code_geeks_web/application/history_bloc/history_bloc.dart';
import 'package:code_geeks_web/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks_web/application/join_mentor/join_mentor_bloc.dart';
import 'package:code_geeks_web/application/post_bloc/post_bloc.dart';
import 'package:code_geeks_web/application/profile_setp_bloc/profile_setup_bloc.dart';
import 'package:code_geeks_web/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_web/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks_web/application/user_bloc/user_bloc.dart';
import 'package:code_geeks_web/infrastructure/language_repo.dart';
import 'package:code_geeks_web/infrastructure/mentor_repo.dart';
import 'package:code_geeks_web/infrastructure/post_repo.dart';
import 'package:code_geeks_web/infrastructure/subscription_repo.dart';
import 'package:code_geeks_web/infrastructure/user_repo.dart';
import 'package:code_geeks_web/login_check.dart';
import 'package:code_geeks_web/presentation/welcome%20page/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: "AIzaSyC6lX-_LJBYd8u_iDGm4auwfgIyqWL2vao",
      authDomain: "code-geeks-ff98c.firebaseapp.com",
      databaseURL: "https://code-geeks-ff98c-default-rtdb.firebaseio.com",
      projectId: "code-geeks-ff98c",
      storageBucket: "code-geeks-ff98c.appspot.com",
      messagingSenderId: "688360665265",
      appId: "1:688360665265:web:f01423d98b66db0251f290",
      measurementId: "G-1DCJCWCPRG"
      )
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
          create: (context) => HomeBloc(LanguageRepo(),MentorRepo()),
    
        ),
            BlocProvider(
          create: (context) => ProfileSetupBloc(),
    
        ),
            BlocProvider(
                create: (context) => SidebarBloc(),
            ),
            BlocProvider(
                create: (context) => PostBloc(PostRepo()),
            ),
            BlocProvider(
                create: (context) => SubscriptionBloc(SubscriptionRepo(),UserRepo()),
            ),
            BlocProvider(
                create: (context) => HistoryBloc(SubscriptionRepo()),
            ),
            BlocProvider(
                create: (context) => FeedbackBloc(),
            ),
            BlocProvider(
                create: (context) => UserBloc(UserRepo()),
            ),
            BlocProvider(
                create: (context) => JoinMentorBloc(),
            ),
        ],
              child: MaterialApp(
                scrollBehavior: MaterialScrollBehavior().copyWith(dragDevices:{PointerDeviceKind.mouse}),
              debugShowCheckedModeBanner: false,
              title: 'CodeGeeks',
              theme: ThemeData(
        
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home:  LoginCheckPage()
            ),
    );
  }
}
