// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Flashlist {
  final int id;
  final String title;
  List<String> items = [];

  Flashlist({required this.id, required this.title, List<String>? items});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'items': items,
    };
  }

  factory Flashlist.fromMap(Map<String, dynamic> map) {
    return Flashlist(
      id: map['id'] as int,
      title: map['title'] as String,
    )..items = List<String>.from(
        map['items'] as List<dynamic>,
      );
  }

  String toJson() => json.encode(toMap());

  factory Flashlist.fromJson(String source) =>
      Flashlist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Flashlist(id: $id, title: $title)';
}
