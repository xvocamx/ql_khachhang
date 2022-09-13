import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //Ham login
  Future login(BuildContext context) async {
    var url = "http://192.168.1.151/ql_khachhang/login.php";
    var response = await http.post(Uri.parse(url),body: {
      "email" : emailController.text,
      "password" : passwordController.text,
    });
    if(response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', emailController.text);
      var data = json.decode(response.body);
      if(data == "success") {
        await Future.delayed(const Duration(seconds: 1),() {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          Fluttertoast.showToast(
            msg: "Login Successful",
            timeInSecForIosWeb: 1,
          );
        },);
        if(!mounted) return;
      } else {
        Fluttertoast.showToast(
          msg: "The username or password is incorrect",
          timeInSecForIosWeb: 2,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.blue.shade700,
                      Colors.blue.shade400,
                      Colors.blue.shade300,
                    ]
                )
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 40),)),
                      )
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Column(
                          children:  [
                            Image.asset("assets/images/logo.jpg",width: 240,height: 140,),
                            const SizedBox(height: 15,),
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
                                prefixIcon: const Icon(Icons.person, color: Colors.black,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              validator: (value) => value!.isEmpty ? "Please enter Password" : null,
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            InkWell(
                              onTap: () {
                                if(_formKey.currentState!.validate()) {
                                  login(context);
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
                                child: const Center(child: Text('Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                )),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text("Forget Password ?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1),fontSize: 18),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children : [
                                const Text("Don't have a account ?", style: TextStyle(fontSize: 18),),
                                TextButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: const Text("Register", style: TextStyle(fontSize: 18),))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
