
import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_geeks_web/application/home_page_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
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
          return Center(
            child: Container(
              // color: Colors.red,
                          height: screenHeight/6,
                          width: screenWidth/2,
                          child: ListView.builder(
                            itemCount: state.languageList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                            return  Padding(
                              padding: const EdgeInsets.all(12),
                              child:GestureDetector(
                                onTap: () {
                                },
                                child:InkWell(
                                  onTap: () {
                                    ///////////////
                                    showModalSheet(context, state, index);
                                    //////////////
                                  },
                                  child: ClipOval(
                                      child: Container(
                                        width: 50,
                                        height: 50, // Set a specific height to ensure it's a perfect circle
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 0.1,color: Colors.grey),
                                          shape: BoxShape.circle,
                                        ),
                                        child:CachedNetworkImage(
                                          filterQuality: FilterQuality.high,
                                          fadeOutDuration: const Duration(seconds: 1),
                                          imageUrl: state.languageList[index].photo),
                                      ),
                                    ),
                                ),
                          
                              )
                            );
                          },),
                        ),
          );
        }
        //circle avatar is loading
        else if (state is LanguageLoadingState){
          return SizedBox(
                        // color: Colors.grey[300],
                        height: screenHeight/6,width: screenWidth,
                        child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.all(12),
                            //shimmer
                            child:Shimmer.fromColors(
                              baseColor: Colors.transparent,
                              highlightColor: Colors.grey,
                              direction: ShimmerDirection.ltr,
                              period: const Duration(seconds: 2),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey.withOpacity(0.5),
                                radius: 40,
                              ),
                            )
                          );
                        },),
                      ); 
        }
        return const SizedBox();
      },
    );
  }

  Future<void> showModalSheet(BuildContext context, HomeContentLoadedState state, int index) {
    return showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 5,
                                            clipBehavior: Clip.antiAlias,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: screenHeight,
                                                // color: Colors.amber,
                                                child: Center(
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          // Text(state.languageList[index].name),
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage(state.languageList[index].photo),
                                                          ),
                                                          const SizedBox(height: 20,),
                                                           Text(state.languageList[index].description,style: const TextStyle(fontSize: 20),),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
  }
}