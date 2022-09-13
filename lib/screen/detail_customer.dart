import 'package:flutter/material.dart';
import 'package:quanly_khachhang/models/khachhang.dart';

class DetailCustomer extends StatelessWidget {
  const DetailCustomer({Key? key,required this.khachHang}) : super(key: key);

  final KhachHang khachHang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Customer"),),
      body: Container(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 32, bottom: 32, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tên khách hàng: ${khachHang.username}",
                ),
                const SizedBox(height: 10,),
                Text(
                  "Email: ${khachHang.email}",
                ),
                const SizedBox(height: 10,),
                Text(
                  "Số điện thoại: ${khachHang.phone}",
                ),
                const SizedBox(height: 10,),
                Text(
                  "Địa chỉ: ${khachHang.address}",
                ),
                const SizedBox(height: 10,),
                Text(
                  "Birthday: ${khachHang.birthday}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
