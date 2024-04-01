import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:CodeFascia/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:code_geeks_web/application/profile_setp_bloc/profile_setup_bloc.dart';
import 'package:code_geeks_web/application/user_bloc/user_bloc.dart';
import 'package:code_geeks_web/domain/user_model.dart';
import 'package:code_geeks_web/presentation/sidebar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    // ignore: unused_field
    final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final List<String> skillItems = [
    'Student','Working IT','Working Non IT'
  ];

  String? selectedSkill;

  Uint8List? newImage;


  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(LoadUserEvent());
    final user = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(
        title: Text("My profile",style: GoogleFonts.orbitron(fontSize: 15,fontWeight: FontWeight.w600,letterSpacing: 4,color: Colors.grey),),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: screenWidth/2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if(state is UserLoadedState){
                    UserModel data = state.userList;
                     _nameController.text = user!.displayName!;
                    _emailController.text = user.email!;
                    selectedSkill = data.profession;
                    return Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    //back box
                    child: SingleChildScrollView(
                      child: SizedBox(
                              // color: Colors.blue,
                              height: screenHeight-150,
                              width: screenWidth-20,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30,),
                         //image picker
                         BlocBuilder<ProfileSetupBloc,ProfileSetupState>(
                      builder: (context,statee){
                        if(statee is ImageUpdateState){
                          newImage = statee.imageFile;
                          return GestureDetector(
                            onTap: () => context.read<ProfileSetupBloc>().add(ImageUpdateEvent()),
                            child: CircleAvatar(
                              child: Image.memory(statee.imageFile,filterQuality: FilterQuality.high,fit: BoxFit.cover,),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () => context.read<ProfileSetupBloc>().add(ImageUpdateEvent()),
                          child: CircleAvatar(radius: 50,
                            child: Image.network(state.userList.profile),
                          ),
                        );
                      }
                      ),
                                    const SizedBox(height: 20,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(child: Column(
                                        children: [
                                          TextFormField(
                                             controller: _nameController,
                                             decoration: const InputDecoration(
                                             border: OutlineInputBorder(),
                                            label: Text("Name")
                                          ),
                                       ),
                                       const SizedBox(height: 20,),
                                        TextFormField(
                                             controller: _emailController,
                                             readOnly: true,
                                             decoration: const InputDecoration(
                                             border: OutlineInputBorder(),
                                            label: Text("email")
                                          ),
                                       ),
                                       const SizedBox(height: 20,),
                                       DropdownButtonFormField2<String>(
                                          validator: (value) {
                                            if(value == null){
                                              return 'Please enter your profession';
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          value: data.profession,
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(0),
                                            )
                                          ),
                                          hint: const Text("Select your profession"),
                                          items: skillItems.map((item) => 
                                          DropdownMenuItem(
                                            value: item,
                                            child: Text(item))).toList(),
                                            onChanged: (value) {
                                              selectedSkill = value.toString();
                                            },
                                            onSaved: (value) {
                                              selectedSkill = value.toString();
                                            },
                                          ),
                                        const SizedBox(height: 30,),
                                        ElevatedButton(onPressed: (){
                                                updateProfile(context);
                                             }, child: const Text("Update"))
                                        // BlocBuilder<ImagePickerBloc, ImagePickerState>(
                                        //   builder: (context, state) {
                                        //     return 
                                        //     ElevatedButton(onPressed: (){
                                        //         updateProfile(context,state.file!.path.toString());
                                        //      }, child: const Text("Update"));
                                        //   },
                                        // )
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                  }
                  else{
                    return Center(child: Lottie.asset('lib/assets/loader.json',height: 120,width: 120));
                  }
                },
              ),
            
            ),
          ),
        ),
      ),
    );
  }
 Future<void> updateProfile(BuildContext context)async{
  // File file = File(newImg);
    firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("profilepic${FirebaseAuth.instance.currentUser!.uid}");
    firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
    try {
    await uploadTask;
    var downloadUrl = await ref.getDownloadURL();
     Map<String, String> data = {
    "id": FirebaseAuth.instance.currentUser!.uid,
    "Name": _nameController.text,
    "Profession": selectedSkill!,
    "Email": _emailController.text,
    "profile": downloadUrl // Use imageLink here
  };

    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(data)
      .then((_) {
    // Navigate to BnbPage after Firestore operation is complete
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SidebarPage()),
      (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Profile updated"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
      });
  } catch (error) {
    debugPrint("Error uploading file: $error");
  }

 }
}