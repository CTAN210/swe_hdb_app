import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/model/Bookmark.dart';


class BookMarkPage extends StatefulWidget{

  BookMarkInfo hdbListings;
  final List checkList;

  // ignore: sort_constructors_first
  BookMarkPage(this.hdbListings,this.checkList);

  Future<List<locations.HDBListing>> update(checkList) async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    for(final listing in HDBData.items){
      for(final i in this.checkList){
        if(listing.ID  == i ) {
          finalList.add(listing);
        }
      }
    }
    return finalList;
  }


  @override
  BookMarkPageState createState() => BookMarkPageState();
}

class BookMarkPageState extends State<BookMarkPage>{
  Widget build(BuildContext context) {
     var BookmarkList =  widget.update(widget.checkList);

     return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarks'),
        ),
        body: Container(
          child: FutureBuilder<List<locations.HDBListing>>(
            future: BookmarkList,
            builder: (context, snapshot){
              var BookmarkList1 = snapshot.data;
              var max = snapshot.data.length;
              return ListView.builder(


                padding: EdgeInsets.all(16),

                physics: BouncingScrollPhysics(),
                itemCount: max,
                itemBuilder: (context, index) {

                  final user = BookmarkList1[index];

                  return ListTile(

                    onTap: () { Navigator.pushNamed(context, '/third', arguments: user) ;},
                    title: Text(user.address + ", ID: " + user.ID.toString()),
                    subtitle: Text(user.resale_price.toString()),

                  );
                },
              );
            },
          )
        )
    );
  }
}
