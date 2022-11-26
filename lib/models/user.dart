class User {
  final String id;
  final String name;
  final String age;


  User({required this.id, required this.name, required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': name,
    'email': age,
  };
}