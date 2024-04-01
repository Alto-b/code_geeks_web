
class UserModel{
  String id;
  String name;
  String email;
  String profile;
  String profession;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.profession
  });
}
  // UserModel copyWith({
  //   String? id,
  //   String? name,
  //   String? email,
  //   String? profile,
  //   String? profession
  // }){
  //   return UserModel(
  //     id: id ?? this.id, 
  //     name: name ?? this.name, 
  //     email: email ?? this.email, 
  //     profile: profile ?? this.profile,
  //     profession: profession ?? this.profession);
  // }

//   factory UserModel.fromJson(Map<String,dynamic>json){
//     return UserModel(
//       id: json['id'], 
//       name: json['name'], 
//       email: json['email'], 
//       profile: json['profile'], 
//       profession: json['profession']
//       );
//   }

//   Map<String,dynamic> toJson(){
//     final Map<String,dynamic> data = new Map<String,dynamic>();
//     data['uid'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['profile'] = this.profile;
//     data['profession'] = this.profession;
//     return data;
//   }

// }