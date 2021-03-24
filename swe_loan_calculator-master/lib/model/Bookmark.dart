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
  final id = FirebaseAuth.instance.currentUser.metadata;

  void saveBookmark(BookMarkInfo bookMarkInfo) {
    databaseReference.child('bookmark/'+user).remove();
    var id = databaseReference.child('bookmark/'+user).set(bookMarkInfo.toJson());


  }
 /*  updateBookmarkList(){

    var listToUpdate = databaseReference.child('bookmark/'+user).get();
    return listToUpdate;
  }*/





  /*getAllBookMarks() async {
    var dataSnapshot = await databaseReference.child('bookmark/author').equalTo(user);
    var list = [];
    for(var i in dataSnapshot.ke)

    }
    return list;
  }*/


}



