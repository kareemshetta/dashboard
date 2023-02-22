class UserModel {
  final String email;
  final String name;
  final String uId;
  final String phone;
  int age;
  final String avatarImage;
  UserModel(
      {required this.phone,
      required this.name,
      required this.age,
      required this.avatarImage,
      required this.email,
      required this.uId});

  factory UserModel.fromJson(dynamic data) {
    final phone = data['phone'];
    final name = data['name'];
    final age = data['age'];
    final avatarImage = data['image'];
    final email = data['email'];
    final uId = data['u_id'];
    return UserModel(
        phone: phone,
        name: name,
        age: age,
        avatarImage: avatarImage,
        email: email,
        uId: uId);
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name,
      'age': age,
      'image': avatarImage,
      'email': email,
      'u_id': uId
    };
  }
}
