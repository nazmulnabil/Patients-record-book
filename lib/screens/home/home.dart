

import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/screens/home/add_task.dart';
import 'package:firebase_flutter/screens/home/userInformation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget{

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: Colors.blueGrey[800],
           actions:<Widget> [

             ElevatedButton.icon(
                 style: ElevatedButton.styleFrom(
                   primary: Colors.blueGrey[800], // background
                   onPrimary: Colors.white, // foreground
                 ),

                 onPressed: (){

               _auth.signOut();
             }, icon:Icon(Icons.person), label: Text('logout'))



           ],


          ),

          body: UserInformation(),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey[800],
            child: Icon(
            Icons.add,
          ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Addtask()));
              
            }
            
          ),

        );
  }



}