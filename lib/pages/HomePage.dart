//import 'dart:html';

import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:blogapp/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  int currentState=0;
  List<Widget> widgets=[
    HomeScreen(),
    ProfileScreen( )
  ];
  List<String> titlestring=["Home Page","Profile Page"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(height: 10),
                Text("@username"),
              ],
            ),
            ),
            ListTile(
              title: Text("All Posts"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(titlestring[currentState]),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: null,
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState==0?Colors.white:Colors.white54,
                  onPressed: (){
                    setState(() {
                      currentState=0;
                    });
                  },
                  iconSize: 35,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                 color: currentState==1?Colors.white:Colors.white54,
                  onPressed: (){
                    setState(() {
                      currentState=1;
                    });
                  },
                  iconSize: 35,
                )
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState]
    );
  }
}
