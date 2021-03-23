import 'package:firebase_database/firebase_database.dart';

class BookMarkInfo {
  String author;
  var bookMarkedList = [];
  DatabaseReference _id;

  // ignore: sort_constructors_first
  BookMarkInfo(this.bookMarkedList, this.author);


  void setId(DatabaseReference id) {
    _id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'bookMarkList': bookMarkedList.toList(),
    };
  }
}





