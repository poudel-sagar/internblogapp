import 'package:flutter/material.dart';
import '../NetworkHandler.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool vis = true;
  //globalkey is used to trigger the validation, here generic is FormState
  final _globalkey = GlobalKey<FormState>();
  //Instance of object NetworkHandler class
  NetworkHandler networkHandler = NetworkHandler();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();

  String errorText;
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[200]],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Form(
          key: _globalkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up with email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              usernameTextField(),
              firstNameTextfromfield(),
              lastnameTextFormField(),
              emailTextField(),
              passwordTextField(),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async 
                 {
                  setState(() {
                    circular = true;
                  }); 
                  //await checkUser();
                 // if (_globalkey.currentState.validate() && validate ) {
                    //sending the data to rest server
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text,
                      "lastName":_lastnameController.text,
                      "firstName":_firstnameController.text
                    };
                    print(data);
                    var responseRegister =
                      await networkHandler.post("/auth/register", data);
                    print(responseRegister);

                    //Login Logic added here


                    // if (responseRegister.statusCode == 200 ||
                    //     responseRegister.statusCode == 201) {
                    //   Map<String, String> data = {
                    //     "username": _usernameController.text,
                    //     "password": _passwordController.text,
                    //   };
                    //   var response =
                    //       await networkHandler.post("/auth/login", data);

                    //   if (response.statusCode == 200 ||
                    //       response.statusCode == 201) {
                    //     Map<String, dynamic> output =
                    //         json.decode(response.body);
                    //     print(output["token"]);
                    //     await storage.write(
                    //         key: "token", value: output["token"]);
                    //     setState(() {
                    //       validate = true;
                    //       circular = false;
                    //     });
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => HomePage(),
                    //         ),
                    //         (route) => false);
                    //   } else {
                    //     // Scaffold.of(context).showSnackBar(
                    //     //     SnackBar(content: Text("Netwok Error")));
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text("Login failed")));
                    //   }
                    // }

                    //Login Logic end here

                    setState(() {
                      circular = false;
                    });
                  // } 
                  // else {
                  //   setState(() {
                  //     circular = false;
                  //   });
                  // }
                },
                child: circular
                    ? CircularProgressIndicator()
                    : Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff00A86B),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //checkusername to call get API to check the user
   
  checkUser() async {
    if (_usernameController.text.length == 0) {
      setState(() {
        circular = false;
        validate = false;
        errorText = "Username Can't be empty";
      });
    } else {

      //getting user if it is already present in our api/database 
      
      var response = await networkHandler
          .get("/users${_usernameController.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "Username already taken";
        });
      } else {
          validate = true;
        
      }
    }
  }

  Widget usernameTextField() {
    return customTextFormWIdgit(
      title: "Username",
      controller: _usernameController, validate: validate, errorText: errorText,);

  }

  Widget lastnameTextFormField(){
return customTextFormWIdgit(
      title: "Lastname",
      controller: _lastnameController, validate: validate, errorText: errorText,);

  }

  Widget firstNameTextfromfield(){
    return customTextFormWIdgit(
      title: "Firstname",
      controller: _firstnameController, validate: validate, errorText: errorText,);

  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Email"),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return "Email can't be empty";
              if (!value.contains("@")) return "Email is Invalid";
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
 
  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Password"),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              if (value.length < 8) return "Password lenght must have >=8";
              return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              helperText: "Password length should have >=8",
              helperStyle: TextStyle(
                fontSize: 14,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class customTextFormWIdgit extends StatelessWidget {
  const customTextFormWIdgit({
    Key key,
    @required this.controller,
    @required this.validate,
    @required this.errorText,
    @required this.title
  }): super(key: key);

  final TextEditingController controller;
  final bool validate;
  final String errorText;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text(title),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2, 
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}