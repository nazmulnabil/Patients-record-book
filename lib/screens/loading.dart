import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.blueGrey[800] ,
      body:Center(
        child:SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,

        ) ,

      )
      ,


    );
  }
}