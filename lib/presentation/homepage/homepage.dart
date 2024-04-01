import 'package:code_geeks_web/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks_web/presentation/homepage/widgets/homescreen.dart';
import 'package:code_geeks_web/presentation/homepage/widgets/lang_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeLoadingEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.uid),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch(state.runtimeType){
            case HomePageLoadingState :
              return CircularProgressIndicator();
            case HomePageLoadedState :
              return HomeScreen();
            case HomePageErrorState :
              return Text("Error loading page");
          }
          return HomeScreen();
        },
      ),
    );
  }
}