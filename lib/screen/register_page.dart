import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  //Function register
  Future register(BuildContext context) async {
    var url = "http://192.168.1.151/ql_khachhang/register.php";
    var response = await http.post(Uri.parse(url), body: {
      "username" : usernameController.text,
      "email" : emailController.text,
      "phone" : phoneController.text,
      "address" : addressController.text,
      "password" : passwordController.text,
    });

    var data = json.decode(response.body);
    if(data == "Error") {
      Fluttertoast.showToast(
        msg: "This User Already Exists!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 1,
        fontSize: 18,
      );
    } else {
      await Future.delayed(const Duration(seconds: 1),() {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 1,
          fontSize: 18,
        );
      },);

    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue.shade400,
                    Colors.blue.shade300,
                  ]
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40))),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15, top: 50),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) => value!.isEmpty ? "Please enter User name" : null,
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: "User name",
                                hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                                prefixIcon: const Icon(Icons.person, color: Colors.black,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 7,),
                            TextFormField(
                              validator: (value) {
                                if(value!.isEmpty) {
                                  return "Please enter Email";
                                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                  return "Invalid Email";
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                                prefixIcon: const Icon(Icons.email, color: Colors.black,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 7,),
                            TextFormField(
                              validator: (value) {
                                if(value!.isEmpty) {
                                  return "Please enter Password";
                                } else if(value.length < 6) {
                                  return "Password must be at least 6 characters long";
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                                prefixIcon: const Icon(Icons.lock, color: Colors.black,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 7,),
                            TextFormField(
                              validator: (value) {
                                if(value!.isEmpty) {
                                  return "Please enter Password";
                                } else if(value != passwordController.text) {
                                  return "Confirm Password not match";
                                } else {
                                  return null;
                                }
                              },
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                                prefixIcon: const Icon(Icons.lock, color: Colors.black,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                if(_formKey.currentState!.validate()){
                                  register(context);
                                }
                              },
                              child: Container(
                                height: 51,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.deepPurple.shade600,
                                          Colors.deepPurple.shade400,
                                          Colors.deepPurple.shade300,
                                        ]
                                    )
                                ),
                                child: const Center(child: Text('Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 const Text("Already have an account ?",style: TextStyle(fontSize: 18),),
                                TextButton(
                                  child: const Text("Register", style: TextStyle(fontSize: 18),),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
