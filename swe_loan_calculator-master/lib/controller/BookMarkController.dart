import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe_loan_calculator/model/BookMarkInfoModel.dart' as model;

///controller class to interact with the database.
class BookMarkController{
  ///reference of the path in the database
  final databaseReference = FirebaseDatabase.instance.reference();
  ///user id key of the current user
  final user = FirebaseAuth.instance.currentUser.uid;

  ///method to update the BookMarkInfo in the database.
  void saveBookmark(model.BookMarkInfoModel bookMarkInfo) {
    databaseReference.child('bookmark/'+user).remove();
    databaseReference.child('bookmark/'+user).set(bookMarkInfo.toJson());
  }


}