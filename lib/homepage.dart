import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'dashboard.dart';
import 'chatpage.dart';
import 'groups.dart';
import 'services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState(){
    super.initState();
    tabController=new TabController(length: 4, vsync: this);
  }
  
  @override
  Widget build(BuildContext contet){
    return new Scaffold(
    bottomNavigationBar: new Material(
    color: Colors.green,
      child: TabBar(
        controller: tabController,
        tabs: <Widget>[
          new Tab(icon: Icon(Icons.home,)),
          new Tab(icon: Icon(Icons.chat,)),
          new Tab(icon: Icon(Icons.group,)),
          new Tab(icon: Icon(Icons.person,)),
        ],
      ),
    ),
      body: new TabBarView(
       controller: tabController,
       children: <Widget>[
        DashboardPage(),
        ChatPage(),
        GroupsPage(),
        ProfilePage(),
       ],
      ),
    );
  }
}