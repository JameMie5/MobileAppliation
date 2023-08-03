import 'package:app_project/pages/product.dart';
import 'package:flutter/material.dart';
import '../page/inbox.dart';
import '../page/profile.dart';
import '../page/story.dart';
import '../database/database_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  void _navigateToPage(int index) {
    //onTap
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    UserStoryPage(dbHelper: DatabaseHelper()),
    UserProfilePage(dbHelper: DatabaseHelper()),
    ProductScreen(dbHelper: DatabaseHelper()),
    UserInboxPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          //type: BottomNavigationBarType.fixed,
          onTap: _navigateToPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black, size: 25),
                label: 'Home',
                backgroundColor: Color.fromARGB(255, 7, 61, 240)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add, color: Colors.black, size: 25),
                label: 'Add',
                backgroundColor: Color.fromARGB(255, 18, 72, 248)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black, size: 25),
                label: 'Student',
                backgroundColor: Color.fromARGB(255, 47, 93, 247)),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts, color: Colors.black, size: 25),
                label: 'Contact',
                backgroundColor: Color.fromARGB(255, 79, 119, 250)),
          ],
        ));
  }
}
