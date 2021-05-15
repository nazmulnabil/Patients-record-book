

import 'package:firebase_flutter/screens/authenticate/register.dart';
import 'package:firebase_flutter/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';



class Authenticate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_AuthenticateState();




}

 class _AuthenticateState extends State<Authenticate>{

   bool showSignIn = true;
   void toggleView(){

     setState(() => showSignIn = !showSignIn);
   }

  @override
  Widget build(BuildContext context) {

    return showSignIn==true?SignIn(toggleView: toggleView):Register(toggleView: toggleView);

     }

  }




