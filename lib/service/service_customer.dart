import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quanly_khachhang/models/khachhang.dart';
import 'package:uuid/uuid.dart';

class ServiceCustomer {
  static const url = "http://192.168.1.151/ql_khachhang/customer_management.php";
  static const getAllAction = "GET_ALL";
  static const addCustomerAction = "ADD_CUSTOMER";
  static const updateCustomerAction = "UPDATE_CUSTOMER";
  static const deleteCustomerAction = "DELETE_CUSTOMER";

  // Method to get all customer
  static Future<List<KhachHang>> getCustomer(String byUser) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = getAllAction;
      map['byUser'] = byUser;
      final response = await http.post(Uri.parse(url),body: map);
      if(response.statusCode == 200) {
        // Use the compute function to run parseResponse in a separate isolate
        return compute(parseResponse, response.body);
      } else {
        return <KhachHang>[];
      }
    } catch (e) {
      return <KhachHang>[];
    }
  }

  // A Function that converts a response body into a List<KhachHang>
  static List<KhachHang> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<KhachHang>((json) => KhachHang.fromJson(json)).toList();
  }

  // Method to add customer in the database
  static Future<String> addCustomer(String id,String username, String email, String phone, String address, String birthday, String byUser) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = addCustomerAction;
      map['id_customer'] = id;
      map['username'] = username;
      map['email'] = email;
      map['phone'] = phone;
      map['address'] = address;
      map['birthday'] = birthday;
      map['byUser'] = byUser;

      final response = await http.post(Uri.parse(url), body: map);
      print(response.body);
      if(response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return e.toString();
    }

  }

  // Method to update an customer from the database
  static Future<String> updateCustomer(String id,String username, String email, String phone, String address, String birthday) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = updateCustomerAction;
      map['id_customer'] = id;
      map['username'] = username;
      map['email'] = email;
      map['phone'] = phone;
      map['address'] = address;
      map['birthday'] = birthday;

      final response = await http.post(Uri.parse(url), body: map);
      if(response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Method to update an customer from the database
  static Future<String> deleteCustomer(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = deleteCustomerAction;
      map['id_customer'] = id;
      final response = await http.post(Uri.parse(url), body: map);
      if(response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}