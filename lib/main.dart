import 'package:flutter/material.dart';
import 'package:quanly_khachhang/screen/add_customer.dart';
import 'package:quanly_khachhang/screen/customer_management_page.dart';
import 'package:quanly_khachhang/screen/detail_customer.dart';
import 'package:quanly_khachhang/screen/home_page.dart';
import 'package:quanly_khachhang/screen/login_page.dart';
import 'package:quanly_khachhang/screen/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  runApp(MyApp(email: email,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.email}) : super(key: key);
  final String? email;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/customer_management': (context) => const CustomerManagementPage(),
        '/add_customer': (context) => const AddCustomerPage(),
        '/logout': (context) => const LoginPage(),
      },
      home: email == null ? const LoginPage() : const HomePage(),
    );
  }
}


