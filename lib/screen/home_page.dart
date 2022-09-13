import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/category_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String email = '';

  Future checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context, '/logout', (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        elevation: 0.0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black,),
            );
          },
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(email.length > 0 ? email[0].toUpperCase() : '',style: const TextStyle(fontSize: 40.0),),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(email,style: const TextStyle(fontSize: 20, color: Colors.white),),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              title: const Text("Đổi mật khẩu"),
              onTap: (){
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log out"),
              onTap: (){
                logout();
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildHeader(screenHeight),
          _buildContext(screenHeight),
        ],
      )
    );
  }


  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          )
        ),
        child: Column(
          children: [
            const Text("Welcome to My App", style: TextStyle(fontSize: 25, color: Colors.black),),
            Image.asset("assets/images/header.png"),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContext(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: .90,
          children: [
            CategoryCard(
              image: "assets/images/management.png",
              title: "User management",
              press: (){
                Navigator.pushNamed(context, '/customer_management');
              },
            ),CategoryCard(
              image: "assets/images/more.png",
              title: "More",
              press: (){},
            )
          ],
        ),
      ),
    );
  }
}

