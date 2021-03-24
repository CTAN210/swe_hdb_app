import 'package:firebase_auth/firebase_auth.dart';
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

class BookMarkController{
  final databaseReference = FirebaseDatabase.instance.reference();
  final user = FirebaseAuth.instance.currentUser.uid;

  DatabaseReference saveBookmark(BookMarkInfo bookMarkInfo) {
    databaseReference.child('bookmark/'+user).remove();
    var id = databaseReference.child('bookmark/'+user).push();
    id.set(bookMarkInfo.toJson());
    return id;
  }
  List updateBookmarkList(){

  }

}





