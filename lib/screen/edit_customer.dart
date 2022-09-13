import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quanly_khachhang/models/khachhang.dart';
import 'package:quanly_khachhang/screen/customer_management_page.dart';
import 'package:quanly_khachhang/service/service_customer.dart';
class EditCustomer extends StatefulWidget {
  const EditCustomer({Key? key, required this.khachHang}) : super(key: key);

  final KhachHang khachHang;

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var birthdayController = TextEditingController();

  Future editCustomer(BuildContext context, String id, String username, String email, String phone, String address, String birthday) async {
    ServiceCustomer.updateCustomer(id, username, email, phone, address, birthday).then((value)  {
      if(value == 'success') {
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CustomerManagementPage()), (route) => true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerManagementPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit customer"),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: widget.khachHang.username,
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                      prefixIcon: const Icon(Icons.person, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: widget.khachHang.email,
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                      prefixIcon: const Icon(Icons.email, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: widget.khachHang.phone,
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
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: widget.khachHang.address,
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 20),
                      prefixIcon: const Icon(Icons.location_on, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: birthdayController,
                    decoration: InputDecoration(
                      hintText: widget.khachHang.birthday,
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
                      String id = widget.khachHang.idCustomer;
                      String username = usernameController.text == "" ? widget.khachHang.username : usernameController.text;
                      String email = emailController.text == "" ? widget.khachHang.email : emailController.text;
                      String phone = phoneController.text == "" ? widget.khachHang.phone : phoneController.text;
                      String address = addressController.text == "" ? widget.khachHang.address : addressController.text;
                      String birthday = birthdayController.text == "" ? widget.khachHang.birthday : birthdayController.text;
                      editCustomer(context, id, username, email, phone, address, birthday);
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
