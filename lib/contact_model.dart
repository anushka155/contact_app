import 'dart:convert';

class Contact {
  String? name;
  String? number;
  Contact({
    required this.name,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'title': name});
    }
    if (number != null) {
      result.addAll({'desc': number});
    }

    return result;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['title'],
      number: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));
}
