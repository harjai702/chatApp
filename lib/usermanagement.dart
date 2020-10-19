import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserManagement{
  storeNewUser(user, context,dispname,photourl){
    FirebaseFirestore.instance.collection('/users').add({
      'email':user.email,
      'uid':user.uid,
      'displayName': dispname,
      'photoUrl': photourl
    }).then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e){
       print(e);
    });
  }
  Future updateProfilePic(picUrl){
    String uiduser=FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('/users').where('uid',isEqualTo: uiduser)
    .get().then((docs){
      FirebaseFirestore.instance.doc('/users/${docs.docs[0].id}').update({'photoUrl': picUrl}).then((val){
        print('updated');
      }).catchError((e){print(e);});
    });
  }
}