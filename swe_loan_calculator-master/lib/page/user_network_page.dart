import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/api/users_api.dart';
import 'package:swe_loan_calculator/model/user.dart';
import 'package:swe_loan_calculator/page/user_page.dart';

class UserNetworkPage extends StatefulWidget {
  @override
  _UserNetworkPageState createState() => _UserNetworkPageState();
}

class _UserNetworkPageState extends State<UserNetworkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bookmarks page"),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Text("I dislike flutter :(((, losing so much hair",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    Container(
                      child: FutureBuilder<List<User>>(

                        future: UsersApi.getUsers(),
                        builder: (context, snapshot) {
                          final users = snapshot.data;

                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              if (snapshot.hasError) {
                                return Center(child: Text('Some error occurred!'));
                              } else {
                                return buildUsers(users);
                              }
                          }
                        },
                      ),
                    )
                  ],
                ))));
  }


  Widget buildUsers(List<User> users) => Expanded(child: ListView.builder(


    padding: EdgeInsets.all(16),

    physics: BouncingScrollPhysics(),
    itemCount: users.length,
    itemBuilder: (context, index) {

      final user = users[index];

      return ListTile(

       // onTap: () => Navigator.of(context).push(MaterialPageRoute(
       //   builder: (BuildContext context) => UserPage(user: user),
        //)),
        title: Text(user.street),
        subtitle: Text(user.block),
        //trailing: IconButton(icon: (Icons.bookmark_border, onPressed: null ,)

        //icon: (_isFavorited ? Icon(Icons.bookmark_border) : Icon(Icons.bookmark)),
        // onPressed: _toggleFavorite,
        //),

      )
      ;
    },
  ));
}