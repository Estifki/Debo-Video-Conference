import '/screens/home.dart';
import '/screens/profile.dart';
import '/screens/recent_meeting.dart';
import 'package:flutter/material.dart';

import '/const/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedindex = 0;
  void onItemtap(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  List<Widget> allpages = [
    const HomePage(),
    RecentMeetings(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allpages.elementAt(_selectedindex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedFontSize: 12,
        selectedItemColor: Colors.white,
        backgroundColor: baseColor.withOpacity(0.8),
        currentIndex: _selectedindex,
        onTap: onItemtap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Recent"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
