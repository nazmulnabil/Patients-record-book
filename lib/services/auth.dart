
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/screens/authenticate/authenticate.dart';
import 'package:firebase_flutter/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_flutter/models/user.dart';
import 'package:firebase_flutter/models/addUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthService{

  static FirebaseAuth _auth = FirebaseAuth.instance;



  // auth change user stream
   Stream<MyUser>get user {
     return _auth.authStateChanges()
     //.map((FirebaseUser user) => _userFromFirebaseUser(user));
         .map(_userFromFirebaseUser);
  }



  // create user obj based on firebase user
  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }




  //Regestration

  Future regestration(String email,String password ) async{

       try {
         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
             email: email,
             password: password
         );
       } on FirebaseAuthException catch (e) {
         if (e.code == 'weak-password') {
           print('The password provided is too weak.');
         } else if (e.code == 'email-already-in-use') {
           print('The account already exists for that email.');
         }
       } catch (e) {
         print(e);
       }


     }





  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }




  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  //save patient info

  Future<void> addUser(AddUser addpatient ) async{


    CollectionReference users = await FirebaseFirestore.instance.collection('users');







    // Call the user's CollectionReference to add a new use
    return users.add({
      'full_name': addpatient.fullName, // John Doe
      'disease': addpatient.disease, // Stokes and Sons

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  //update  patient info

  Future<void> updatedUser(String id,Map<String,dynamic> newValues)async{
     await FirebaseFirestore
        .instance
        .collection('users')
        .doc(id)
         .update(newValues)
        .then((value) => print("User Updated"))
        .catchError((e){
          print(e);
    });



  }


  Future<void> deleteUser(String id) async{

    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((e){
      print(e);
    });


  }

 }