
import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget{

 Function toggleView; 
  
  SignIn( {this.toggleView});


  @override
  State<StatefulWidget> createState() =>_SignInState();



}

class _SignInState extends State<SignIn>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.blueGrey[800],
       title: Text('Sign In',
        style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white),
       ),
        actions:<Widget> [
          
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[800], // background
                onPrimary: Colors.white, // foreground
              ),

              onPressed: ()=> widget.toggleView()
             ,
              icon: Icon(Icons.person),
              label: Text('Register') )
          
        ],



      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(

                children:<Widget> [
                  SizedBox(height: 20.0),
                  TextFormField(

                    decoration: InputDecoration( labelText: 'Email :',
                      fillColor: Colors.white,

                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.red)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800],
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color:Colors.blueGrey[100],
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val)=>val.isEmpty? 'Enter an email':null,
                    onChanged: (val) {
                      setState(() {
                        this.email=val;
                      });

                    },

                  ),
                  SizedBox(height: 20.0),

                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration( labelText: 'Password :',

                      fillColor: Colors.white,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.red)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800],
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color:Colors.blueGrey[100],
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val)=>val.length<5? 'Enter a 6 digit password ':null,
                    onChanged: (val) {
                      setState(() {
                        this.password=val;
                      });

                    },

                  ),

                  SizedBox(height: 20.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey[800], // background
                      onPrimary: Colors.white, // foreground
                    ),

                    onPressed: ()async{
                      if(_formKey.currentState.validate()){

                        dynamic result= await   _auth.signInWithEmailAndPassword(email, password);

                        if(result==null){

                          setState(() {

                            error = 'Please supply a valid email';

                          });
                        }



                      }
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold

                      ),
                    ),
                  )


                ],



              )),


        ),
      ) ,

    ); ;
  }



}

