
import 'package:code_geeks_web/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_web/presentation/community/community_chat.dart';
import 'package:code_geeks_web/presentation/feed%20page/feed.dart';
import 'package:code_geeks_web/presentation/homepage/homepage.dart';
import 'package:code_geeks_web/presentation/settings%20page/settings.dart';
import 'package:code_geeks_web/presentation/subscriptions/subscriptions.dart';
import 'package:code_geeks_web/presentation/welcome%20page/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarPage extends StatelessWidget {
   SidebarPage({Key? key}) : super(key: key);
  int index = 0;

  final screens = [
    HomePage(),
    PostViewPage(),
    SubscriptionsPage(),
    CommunityPage(),
    SettingsPage(),
    //  ActiveSubsPage(),
    // AddLanguagePage(),
    // SubscriptionPage(),
    // FeedbackView(),
  ];

  final AssetImage _avatarImg = const AssetImage('lib/assets/logo.png');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body :CollapsibleSidebar(
        isCollapsed: true,
        items: [
    CollapsibleItem(
      text: 'Home',
      icon: Icons.home,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index));
      },
      isSelected: true,
    ),
    CollapsibleItem(
      text: 'Feed',
      icon: Icons.feed,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+1));
      },
    ),
    CollapsibleItem(
      text: 'Subscriptions',
      icon: Icons.subscriptions,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+2));
      },
    ),
    CollapsibleItem(
      text: 'Community',
      icon: Icons.chat,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+3));
      },
    ),
    CollapsibleItem(
      text: 'Settings',
      icon: Icons.settings,
      onPressed: () {
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+4));
      }
    ),
    // CollapsibleItem(
    //   text: 'Languages',
    //   icon: Icons.language,
    //   onPressed: () {
    //     BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+5));
    //   }
    // ),
    // CollapsibleItem(
    //   text: 'Subscriptions',
    //   icon: Icons.subscriptions,
    //   onPressed: (){
    //     BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+6));
    //   }
    // ),
    // CollapsibleItem(
    //   text: 'Feedback',
    //   icon: Icons.feedback_outlined,
    //   onPressed: (){
    //     BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+7));
    //   }
    // ),
  ],
        avatarImg: _avatarImg,
        title: 'Admin',

        body:  BlocBuilder<SidebarBloc, SidebarState>(
          builder: (context, state) {
            print(state);
            if(state is SidebarInitial ){
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize:const Size(200, 80),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const WebAppBar())),
                body: screens[state.index],
                );
            }
            return screens[0];
          },
        ),
        
        backgroundColor: Colors.white,
        selectedTextColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedTextColor: Colors.grey,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [],
        collapseOnBodyTap: true,
        fitItemsToBottom: true,
        itemPadding: 10,
        selectedIconBox: const Color.fromARGB(255, 30, 97, 151),
        selectedIconColor: Colors.white,
        showTitle: true,
        avatarBackgroundColor: Colors.grey,
        
      ),
    );
  }

}

class WebAppBar extends StatelessWidget {
  const WebAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return AppBar(
      backgroundColor: Colors.grey,
      title:  Text("Welcome Back ${user!.displayName} !",style: TextStyle(color: Colors.white),),
                 actions:  [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),)),
                    child: CircleAvatar(backgroundColor: Colors.grey,
                    child: Image.network(user.photoURL!,fit: BoxFit.cover,),),
                  ),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){logOutBox(context);}, icon: Icon(Icons.logout)),
                  SizedBox(width: 10,),
                 ],
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5,
                 toolbarHeight: 70,
    );
  }

    // alert box start n 

    void logOutBox(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              signout(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }



  // alert box end




  signout(BuildContext ctx) async{

    // final _sharedPrefs= await SharedPreferences.getInstance();
    // await _sharedPrefs.clear();

    // Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
    // _sharedPrefs.setBool(SAVE_KEY_NAME, false);
    print(FirebaseAuth.instance.currentUser?.uid ?? "nil");
    await FirebaseAuth.instance.signOut();
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>WelcomePage()), (route) => false);
    print(FirebaseAuth.instance.currentUser?.uid ?? "nil");
  }

}
