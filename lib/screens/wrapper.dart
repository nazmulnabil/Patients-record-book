
import 'package:firebase_flutter/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}



  