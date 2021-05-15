
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/screens/loading.dart';

class UserInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_UserInformationState();
  }





class _UserInformationState extends State<UserInformation>{

  bool name_validate = false;
  bool disease_validate = false;
  String label_name,label_disease;
  AuthService _authService=AuthService();

  String name,disease ;
  TextEditingController nameController = TextEditingController();
  TextEditingController disease_Controller = TextEditingController();


  Map<String,dynamic> newValues;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

   // CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(

             title:  Text(document.data()['full_name']),

             subtitle:  Text(document.data()['disease']),

              trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[


                //update
                GestureDetector(onTap: ()async{
                  String id= document.id;
                  await  users.doc(id).get().then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                     label_name =  documentSnapshot.data()['full_name'];
                     label_disease =  documentSnapshot.data()['disease'];
                  print('Document data: ${documentSnapshot.data()}');
                  } else {
                  print('Document does not exist on the database');
                  }
                  });
                  nameController.text=label_name;
                disease_Controller.text=label_disease;

                  updateDialog(context,id);
                },child: Icon(Icons.edit,
                color: Colors.blueAccent,)), // icon-1
                
                
                GestureDetector(onTap: (){
                  String id= document.id;
                  deleteDialog(context,id);
                },child: Icon(Icons.delete,
                color: Colors.redAccent,)), // icon-2
              ],
            ),

            );
          }).toList(),
        );
      },
    );
  }

   updateDialog(BuildContext context,String id) {

    return showDialog(context: context,
        builder: (context){
            return AlertDialog(
              title: Text('Update',
              style: TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
                  color: Colors.cyan[900]
              ),),


              content:
              SingleChildScrollView(
                child: Column(

                   children: [

                     Textfield_edit_name(),
                     SizedBox(height: 10),

                     Textfield_edit_disease()


                   ],





                ),
              ),





              //actions
              actions:<Widget> [

                TextButton(onPressed: ()async{
                  await nameController.text.isEmpty ? name_validate = true : name_validate = false;
                  await  disease_Controller.text.isEmpty ? disease_validate = true : disease_validate = false;
                  if(name_validate==true||disease_validate==true)
                    return;
                  else{
                    if(name.trim().length>=1&&disease.trim().length>=1)
                      setState(() {
                        update_entry(id);
                      });

                    else{

                      showsnackbar('please check input fields');
                    }

                  }



                },
              child: Text('Yes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900]

                ),),),


                TextButton(onPressed: (){
                  Navigator.pop(context);


                },
                  child: Text('No',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[900]
                    ),),)

              ],

            );
        }) ;



  }



  deleteDialog(BuildContext context,String id) {
       // _authService.deleteUser(id);
    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Delete entry?',

              style: TextStyle(
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[900]
              ),),
             content: Text('If you press yes the entry will be deleted permanently '),
            //actions
            actions:<Widget> [

              TextButton(onPressed: (){

                _authService.deleteUser(id);
                Navigator.pop(context);
                showsnackbar('Entry successfully deleted.');

              },
                child: Text('Yes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[900]

                  ),),),


              TextButton(onPressed: (){
                   Navigator.pop(context);


              },
                child: Text('No',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[900]
                  ),),)

            ],

          );
        }) ;

  }


//update_entry
  update_entry(String id) async{
        newValues={

          'full_name': this.name, // John Doe
          'disease': this.disease, // Stokes and Sons

        };
    await  _authService.updatedUser(id, newValues);
          Navigator.pop(context);
        showsnackbar('Entry successfully updated.');

  }

 Widget Textfield_edit_name() {



       return  TextField(

         controller: nameController,
         style: TextStyle(

         ),
         onChanged: (value) {

           this.name  =nameController.text;
         },
         decoration: InputDecoration(
           focusedBorder:  OutlineInputBorder(
             borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.blueGrey[800]),
        ),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(4)),
               borderSide: BorderSide(width: 1,color: Colors.blueGrey[300]),
             ),
             focusedErrorBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(4)),
                 borderSide: BorderSide(width: 1,color: Colors.redAccent)
             ),
             labelText: 'Name',

             errorText: name_validate? 'Name Can\'t Be Empty' : null,
             labelStyle: TextStyle(

             ),
             border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5.0))),
       );
    }

  Textfield_edit_disease() {


    return  TextField(

      controller: disease_Controller,
      style: TextStyle(

      ),
      onChanged: (value) {

          this.disease  =disease_Controller.text;



      },
      decoration: InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.blueGrey[800]),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.blueGrey[300]),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1,color: Colors.redAccent)
          ),
          labelText: 'Disease',


          errorText: name_validate? 'Disease name Can\'t Be Empty' : null,
          labelStyle: TextStyle(
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0))),
    );



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








