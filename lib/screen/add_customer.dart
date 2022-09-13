import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:quanly_khachhang/service/service_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/khachhang.dart';
import 'customer_management_page.dart';

class AddCustomerPage extends StatefulWidget {
   const AddCustomerPage({Key? key}) : super(key: key);


  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var birthdayController = TextEditingController();




  void addCustomer(BuildContext context) async {
    var uuid = const Uuid();
    var id = uuid.v1();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String byUser = preferences.getString('email')!;
    ServiceCustomer.addCustomer(
        id,
        usernameController.text,
        emailController.text,
        phoneController.text,
        addressController.text,
        birthdayController.text,
        byUser,
    ).then((value) {
      if(value == "success"){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CustomerManagementPage()), (route) => false);
        Fluttertoast.showToast(
          msg: "Add customer successful",
        );
      } else {
        Fluttertoast.showToast(
          msg: "This Email Already Exists!",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Add customer"),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "Please enter UserName" : null,
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
                  const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please enter Phone";
                      } else if(value.length != 10) {
                        return "Invalid Phone";
                      } else {
                        return null;
                      }
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                      prefixIcon: const Icon(Icons.phone, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "Please enter Address" : null,
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                      prefixIcon: const Icon(Icons.location_on, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "Please enter Birthday" : null,
                    controller: birthdayController,
                    decoration: InputDecoration(
                      labelText: "Birthday",
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                      prefixIcon: const Icon(Icons.calendar_today, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if(pickedDate != null) {
                        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                        setState(() {
                          birthdayController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 50,),
                  InkWell(
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        addCustomer(context);
                      }
                    },
                    child: Container(
                      height: 51,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade400,
                                Colors.green.shade300,
                              ]
                          )
                      ),
                      child: const Center(child: Text('Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      )),
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

