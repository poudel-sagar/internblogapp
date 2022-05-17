import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Text(
          "+",
          style: TextStyle(fontSize: 30),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                  onPressed: null,
                  iconSize: 35,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: null,
                  iconSize: 35,
                )
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("Welcome on blog app"),
      ),
    );
  }
}
