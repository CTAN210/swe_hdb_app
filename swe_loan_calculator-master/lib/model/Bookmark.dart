import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BookMark{
  String ID;
  BookMark(this.ID);
}

class BookMarkInfo {
  String author;
  var bookMarkedList = [];
  DatabaseReference _id;

  // ignore: sort_constructors_first
  BookMarkInfo(this.bookMarkedList, this.author);

  void clickBookMark(BookMark bookmark) {
    if (bookMarkedList.contains(bookmark)) {
      bookMarkedList.remove(bookmark);
    } else {
      bookMarkedList.add(bookmark);
    }
  }

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





