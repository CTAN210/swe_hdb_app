import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/model/user.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart';

class UserPage extends StatelessWidget {
  final HDBListing user;

  const UserPage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(user.address),
    ),
    body: Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          Text(
            user.resale_price.toString(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            user.town,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 64),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: Colors.teal,
            child: Text(
              'Send Email',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}