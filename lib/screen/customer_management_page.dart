import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quanly_khachhang/screen/detail_customer.dart';
import 'package:quanly_khachhang/screen/edit_customer.dart';
import 'package:quanly_khachhang/screen/home_page.dart';
import 'package:quanly_khachhang/service/service_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/khachhang.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class CustomerManagementPage extends StatefulWidget {
  const CustomerManagementPage({Key? key}) : super(key: key);

  @override
  State<CustomerManagementPage> createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  final StreamController<List<KhachHang>> khachHangStreamController = StreamController<List<KhachHang>>();
  List<KhachHang> listCustomer = [];

  void getCustomer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String byUser = preferences.getString('email')!;
    ServiceCustomer.getCustomer(byUser).then((customer) {
      setState(() {
        listCustomer = customer;
      });
    });
  }

  void deleteCustomer(String id) {
    ServiceCustomer.deleteCustomer(id).then((value) {
      if(value == "success") {
        getCustomer();
        Fluttertoast.showToast(msg: "Delete succesful");
      }
    });
  }



  @override
  void initState() {
    super.initState();
    getCustomer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer management"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: listCustomer.length,
        itemBuilder: (BuildContext context, int index) {
          return listCustomer.isEmpty ? const Center(child: CircularProgressIndicator()) : Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: "Edit",
                  onPressed: (context) {
                    var khachHang =  KhachHang(idCustomer: listCustomer[index].idCustomer,
                        username: listCustomer[index].username,
                        email: listCustomer[index].email,
                        phone: listCustomer[index].phone,
                        address: listCustomer[index].address,
                        birthday: listCustomer[index].birthday,
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCustomer(khachHang: khachHang)));
                  },
                ),
                SlidableAction(
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Delete",
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Thông báo"),
                        content: Text("Bạn có muốn xóa khách hàng này không?"),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              deleteCustomer(listCustomer[index].idCustomer);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            child: const Text("OK"),
                          ),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: const Text("Cancel")
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ],
            ),
            child: InkWell(
              onTap: (){
                var khachHang =  KhachHang(idCustomer: listCustomer[index].idCustomer,
                    username: listCustomer[index].username,
                    email: listCustomer[index].email,
                    phone: listCustomer[index].phone,
                    address: listCustomer[index].address,
                    birthday: listCustomer[index].birthday
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailCustomer(khachHang: khachHang)));
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 32, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tên khách hàng: ${listCustomer[index].username}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            "Email: ${listCustomer[index].email}",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/add_customer');
        },
      ),
    );
  }
}

