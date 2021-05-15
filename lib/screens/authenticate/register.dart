

import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget{

  Function toggleView;

  Register( {this.toggleView});
  @override
  State<StatefulWidget> createState() =>_RegisterState();


}

class _RegisterState extends State<Register>{

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
      backgroundColor:Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text('Register'),
        actions:<Widget> [

          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[800], // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: ()=> widget.toggleView()
              ,
              icon: Icon(Icons.person),
              label: Text('Sign In') )

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
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                   decoration: InputDecoration( labelText: 'Email:',
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
                         color: Colors.blueGrey[100],
                         width: 2.0,
                       ),
                     ),

                   ),),
                     SizedBox(height: 20.0),

                     TextFormField(
                       validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                       onChanged: (val) {
                         setState(() => password = val);
                       },
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
                             color: Colors.blueGrey[100],
                             width: 2.0,
                           ),
                         ),

                       ),),
                     SizedBox(height: 20.0),
                     
                     ElevatedButton(

                       style: ElevatedButton.styleFrom(
                         primary: Colors.blueGrey[800], // background
                         onPrimary: Colors.white, // foreground
                       ),
                     onPressed: ()async{
                       if(_formKey.currentState.validate()){

                     dynamic result= await   _auth.regestration(email, password);

                         if(result==null){

                           setState(() {

                             error = 'Please supply a valid email';

                           });
                         }



                         }
                       },
                       child: Text(
                       'Register',
                       style: TextStyle(color: Colors.white,
                       fontWeight: FontWeight.bold),
                     ),
                     )

                   ],



                 )),


        ),
      ) ,

    );
  }
  
  
  
}