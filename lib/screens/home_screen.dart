import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: screens[pageIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 205, 205, 205),
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black,
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.fastfood,
                    size: 30,
                  ),
                  label: "Order"),
                  BottomNavigationBarItem(
                  icon: Icon(
                    Icons.wallet,
                    size: 30,
                  ),
                  label: "Wallet"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  label: "Profile"),
            ]),
      ),
    );
  }
}
