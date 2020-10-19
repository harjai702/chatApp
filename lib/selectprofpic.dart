import 'dart:io';
import 'dart:math';
import 'package:chatapp/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class SelectProfilePage extends StatefulWidget {
  @override
  _SelectProfilePageState createState() => new _SelectProfilePageState();
}

class _SelectProfilePageState extends State<SelectProfilePage> {
  File newProfilePic;
  String downloadUrl='https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg';
  Future getImage() async{
    final tempImage=await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      newProfilePic=File(tempImage.path);
    });
  }
  Future uploadImage() async{
    var randomno=Random(25);
    final StorageReference ref= FirebaseStorage.instance.ref().child('profilepics/${randomno.nextInt(5000).toString()}.jpg');
    //StorageUploadTask task=firebaseStorageRef.putFile(newProfilePic);
    await ref.putFile(newProfilePic).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        //print(val);
        downloadUrl = val; //Val here is Already String
      }).catchError((e){print(e);});
    });
    userManagement.updateProfilePic(downloadUrl).then((val){
      Navigator.of(context).pushReplacementNamed('/homepage');
    });
  }
  UserManagement userManagement=new UserManagement();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: newProfilePic==null? getChooseButton() : getUploadButton());
  }
  Widget getChooseButton(){
    return new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.green.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                downloadUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 90.0),
                Text(
                  'You have signed in',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Choose a profile pic',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 75.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: getImage,
                            child: Center(
                              child: Text(
                                'Change pic',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Skip',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ))
      ],
    );
  }
  Widget getUploadButton(){
    return new Stack(
      children:<Widget>[
        ClipPath(
          child: Container(color: Colors.teal.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                downloadUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 90.0),
                Text(
                  'You have signed in',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Choose a profile pic',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 75.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: uploadImage,
                            child: Center(
                              child: Text(
                                'Upload pic',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ))
      ]
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}