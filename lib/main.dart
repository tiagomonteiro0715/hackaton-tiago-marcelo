/// Importing the packages that are needed for the app to run.
import 'package:flutter/material.dart';
import 'package:app/src/chatGPT.dart';
import 'package:app/src/profile.dart';
import 'package:app/src/mediguide.dart';

void main() => runApp(const MyApp());

/// This class is a StatelessWidget that returns a MaterialApp with a title and a home page
class MyApp extends StatelessWidget {
  /// A constructor that is called when the widget is first created.
  const MyApp({Key? key}) : super(key: key);

  /// A variable that is called when the widget is first created.
  static const String _title = 'Flutter Code Sample';

  /// The build function returns a MaterialApp widget that contains a ChatGPTAnswer widget
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  ///
  /// Returns:
  ///   A MaterialApp widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: NavigationRailPage(),
    );
  }
}

class NavigationRailPage extends StatefulWidget {
  const NavigationRailPage({Key? key}) : super(key: key);

  @override
  State<NavigationRailPage> createState() => _NavigationRailPageState();
}

//ChatGPTAnswer();

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'DoctorAI',
  ),
    BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Mediguide',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Historic',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'Profile',
  ),
];

class _NavigationRailPageState extends State<NavigationRailPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              items: _navBarItems,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              })
          : null,
      body: Row(
        children: <Widget>[
          if (!isSmallScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              //backgroundColor: Colors.black,//Mudar outras cores para ficar tudo bem
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              extended: isLargeScreen,
              destinations: _navBarItems
                  .map((item) => NavigationRailDestination(
                      icon: item.icon,
                      selectedIcon: item.activeIcon,
                      label: Text(
                        item.label!,
                      )))
                  .toList(),
            ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: _navBarItems[_selectedIndex].label == "DoctorAI"
                  ? ChatGPTAnswer()
                  : _navBarItems[_selectedIndex].label == "Profile"
                      ? ProfilePage1()
                  : _navBarItems[_selectedIndex].label == "Mediguide"
                      ? MediGuideChatBot()
                        : Text("${_navBarItems[_selectedIndex].label} Page"),
            ),
          )
        ],
      ),
    );
  }
}
