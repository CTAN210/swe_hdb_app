import 'package:firebase_database/firebase_database.dart';

///BookmarkInfo is the object that is saved into the database.
class BookMarkInfoModel {
  ///Display Name of user's google account
  String author;
  ///list to store indexes of the items that the user bookmarked.
  var bookMarkedList = [];
  DatabaseReference _id;

  // ignore: sort_constructors_first
  ///constructor of BookMarkInfoModel
  BookMarkInfoModel(this.bookMarkedList, this.author);

  ///method to set the databasereference ID
  void setId(DatabaseReference id) {
    _id = id;
  }
  ///method that builds the json format to be uploaded to the database.
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'bookMarkList': bookMarkedList.toList(),
    };
  }
}