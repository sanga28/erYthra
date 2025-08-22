import 'package:flutter/material.dart';
import '../routes.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({Key? key, this.currentIndex = 0}) : super(key: key);

  void _onTap(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushNamed(context, Routes.request);
        break;
      case 2:
        Navigator.pushNamed(context, Routes.matches);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Request'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Matches'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
