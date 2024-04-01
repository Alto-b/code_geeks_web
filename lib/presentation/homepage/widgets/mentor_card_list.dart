
import 'package:code_geeks_web/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks_web/presentation/mentors%20page/mentors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MentorCardHPWidget extends StatelessWidget {
  const MentorCardHPWidget({
    super.key,
    required this.runtimeType,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  final Type runtimeType;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
         if(state is HomeContentLoadedState){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Meet our mentors",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,),),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MentorsPage(),));
                  }, icon: const Icon(Icons.keyboard_arrow_right_rounded))
                ],
              ),
              SizedBox(
                            height: (screenHeight/4)+20,
                            width: screenWidth,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.mentorList.length ,
                              itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Card(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(width: 1,color: Colors.grey.shade800),),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: SizedBox(
                                    height: screenHeight/4,
                                    width: screenWidth/7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: screenHeight/6,
                                          width: screenWidth/7,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                          ),
                                          child: Image.network(state.mentorList[index].photo,fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Text(state.mentorList[index].name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(state.mentorList[index].qualification,overflow: TextOverflow.ellipsis,),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },)
                          ),
            ],
          );
          
        }
        return const SizedBox();
      },
    );
  }
}
