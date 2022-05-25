//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../NetworkHandler.dart';

class CreatProfile extends StatefulWidget {
  // const CreatProfile({ Key? key }) : super(key: key);

  @override
  State<CreatProfile> createState() => _CreatProfileState();
}

class _CreatProfileState extends State<CreatProfile> {
  final networkHandler = NetworkHandler();
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            SizedBox(height: 20),
            nameTextField(),
            SizedBox(height: 20),
            professionTextField(),
            SizedBox(height: 20),
            dobField(),
            SizedBox(height: 20),
            titleTextField(),
            SizedBox(height: 20),
            aboutTextField(),
            SizedBox(height: 20),
            InkWell(
              onTap: ()async{
                if(_globalkey.currentState.validate()){

                  Map<String, String> data = {
                    "name": _name.text,
                    "profession": _profession.text,
                    "dob": _dob.text,
                    "title": _title.text,
                    "about": _about.text
                  };
                  var response = await networkHandler.post("/profile/add", data);
                  print(response.statusCode);
                }
              },
              child: Center(
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
              radius: 80.0,
              backgroundImage: _imageFile == null
                  ? AssetImage("assets/profile.jpeg")
                  : FileImage(File(_imageFile.path))),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
                onTap: () {
                  //showModalBottomSheet is flutter default widget for showing bottomSheet
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                child: Icon(Icons.camera_alt, color: Colors.teal, size: 20)),
          )
        ],
      ),
    );
  }
//bottomSheet widget to choose either for camera or gallery image pickup

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "choose profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

//function to take a photo
  void takePhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = PickedFile;
    });
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";
        return null;
      },
      decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2)),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Name",
          helperText: "Name can't be empty",
          hintText: "User Name"),
    );
  }

  Widget professionTextField() {
    return TextFormField(
      controller: _profession,
      validator: (value) {
        if (value.isEmpty) return "Profession can't be empty";
        return null;
      },
      decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2)),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Profession",
          helperText: "Profession can't be empty",
          hintText: "User Profession"),
    );
  }

  Widget dobField() {
    return TextFormField(
      controller: _dob,
      validator: (value) {
        if (value.isEmpty) return "DOB can't be empty";
        return null;
      },
      decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2)),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Date of Birth",
          helperText: "DOB can't be empty",
          hintText: "2000/1/1"),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        if (value.isEmpty) return "Title can't be empty";
        return null;
      },
      decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2)),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Title",
          helperText: "It can't be empty",
          hintText: "Flutter Developer"),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _about,
      validator: (value) {
        if (value.isEmpty) return "About section can't be empty";
        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2)),
          labelText: "About",
          hintText: "User Name about section"),
    );
  }
}
