import 'package:code_geeks_web/application/home_page_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MentorsPage extends StatelessWidget {
  const MentorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),

      body: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
         if(state is HomeContentLoadedState){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                      const Text("Meet our mentors",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,),),
            
                      const SizedBox(height: 20,),
              
                  SizedBox(
                                height: (screenHeight)-150,
                                width: screenWidth,
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisExtent: screenHeight/2), 

                                  itemCount: state.mentorList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        height: screenHeight/2,
                                        width: screenWidth/3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey
                                          ),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: screenHeight/3,
                                          width: screenWidth/3,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                          ),
                                          child: Image.network(state.mentorList[index].photo,fit: BoxFit.cover,
                                          ),
                                        ),
                                        // Text(state.mentorList[index].name)
                                        ListTile(
                                          title: Text(state.mentorList[index].name,style: const TextStyle(fontWeight: FontWeight.w600)),
                                          subtitle: Text(state.mentorList[index].qualification,style: const TextStyle(fontWeight: FontWeight.w500)),
                                        )
                                          ],
                                        ),
                                      ),
                                    );
                                  },)
                              )
                ],
              ),
            ),
          );
          
        }
        return const SizedBox();
      },
    )

    );
  }
}