import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/widget/background_painter.dart';
import 'package:swe_loan_calculator/widget/sign_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:swe_loan_calculator/controller/LoginController.dart' as logincontroller;
import 'package:swe_loan_calculator/controller/MainController.dart' as maincontroller;


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create: (context) => logincontroller.LoginController(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<logincontroller.LoginController>(context);

          if (provider.isSigningIn) {
            return buildLoading();
          }
          else if (snapshot.hasData) {
            return maincontroller.MainController();
          }
          else {
            return SignUpWidget();
          }
        },
      ),
    ),
  );

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      CustomPaint(painter: BackgroundPainter()),
      Center(child: CircularProgressIndicator()),
    ],
  );
}

