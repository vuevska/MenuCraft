class UserModel {
  late String userId;
  late String email;
  late String name;
  late String surname;
  late String imageUrl;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.surname,
    required this.imageUrl,
  });

  // Factory method to create a user model from Firestore data
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['uid'],
      email: data['email'],
      name: data['name'],
      surname: data['surname'] ?? "",
      imageUrl: data['imageUrl'] ?? "",
    );
  }

  // Convert the user model to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'surname': surname,
      'imageUrl': imageUrl,
      // Add other user-related fields as needed
    };
  }
}
