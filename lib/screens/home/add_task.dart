
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/addUser.dart';
import 'package:firebase_flutter/services/auth.dart';


class Addtask extends StatefulWidget {

  @override
  State<StatefulWidget> createState() =>_AddtaskState();
}


class _AddtaskState extends State<Addtask>{
  bool name_validate = false;
  bool disease_validate = false;
  AuthService authService=AuthService();
  String name,disease ;
  TextEditingController nameController = TextEditingController();
  TextEditingController disease_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .subtitle1;


    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('Add patient info',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white

        ),),
        backgroundColor: Colors.blueGrey[800],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top:queryData.size.height/5,left:queryData.size.width/8  ,
              right: queryData.size.width/8),

          child: Center(
            
         child: Column(
           children:<Widget> [
             TextField(
               controller: nameController,
               style: textStyle,
               onChanged: (value) {
                 this.name  =nameController.text;
               },
               decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(4)),
                     borderSide: BorderSide(width: 1,color: Colors.blueGrey[100]),
                   ),

                   focusedErrorBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(4)),
                       borderSide: BorderSide(width: 1,color: Colors.blueGrey[800])
                   ),

                   labelText: 'Enter name ',
                   labelStyle: textStyle,
                   errorText: name_validate==true? 'Name Can\'t Be Empty' : null,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0))),
             ),

             SizedBox(height: 20.0),

             TextField(

               controller: disease_Controller,
               style: textStyle,
               onChanged: (value) {
                 this.disease  = disease_Controller.text;
               },
               decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(4)),
                     borderSide: BorderSide(width: 1,color: Colors.blueGrey[100]),
                   ),
                   focusedErrorBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(4)),
                       borderSide: BorderSide(width: 1,color: Colors.blueGrey[800])
                   ),
                   labelText: 'Enter disease',
                   labelStyle: textStyle,
                   errorText: disease_validate==true ? 'Disease name Can\'t Be Empty' : null,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0))),
             ),

             SizedBox(height: 20.0),
             
             ElevatedButton(

                 style: ElevatedButton.styleFrom(
                   primary: Colors.blueGrey[800], // background
                   onPrimary: Colors.white, // foreground
                 ),
                 onPressed: (){
                   setState(() async{

                await nameController.text.isEmpty ? name_validate = true : name_validate = false;
                 await  disease_Controller.text.isEmpty ? disease_validate = true : disease_validate = false;

                 if(name_validate==true||disease_validate==true)
                   {
                    showsnackbar('please check input fields');
                    return;
                   }

                  else{
                   addPatient();
                 }


                   });

                    },
                 child: Text('Add patient info')


             )

             
             
           ],
           
         ),
            

          ),
          


        ),
      ),

    );
  }

  void addPatient() {
    if(name.trim()!=null&&disease.trim()!=null)
      {
        AddUser addpatient=AddUser(name, disease);
        authService.addUser(addpatient);
       showsnackbar('Patient added successfully');

      }

  }

  void showsnackbar(String message ) {

    final snackBar = SnackBar(content: Text(message,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),)
      ,backgroundColor: Colors.blueGrey[800],);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }





}



