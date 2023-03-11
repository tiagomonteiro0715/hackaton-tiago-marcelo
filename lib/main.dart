/// Importing the packages that are needed for the app to run.
import 'package:flutter/material.dart';
import 'package:apptiago/src/chatGPT.dart';
import 'package:apptiago/src/profile.dart';
import 'package:apptiago/src/mediguide.dart';

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

/// `NavigationRailPage` is a `StatefulWidget` that creates a `_NavigationRailPageState` state object
class NavigationRailPage extends StatefulWidget {
  const NavigationRailPage({Key? key}) : super(key: key);

  @override
  State<NavigationRailPage> createState() => _NavigationRailPageState();
}

/// Creating a list of BottomNavigationBarItems.
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

/*
It defines a stateful widget called _NavigationRailPageState.
The widget renders a navigation bar with different items representing pages.
When the user clicks on an item, the corresponding page is displayed on the screen.
The navigation bar is either a BottomNavigationBar or a NavigationRail depending on the screen size.
The _selectedIndex variable is updated when the user clicks on a navigation item.
The body property of the Scaffold widget contains a Row widget that holds the NavigationRail or BottomNavigationBar and the main content of the page.
The main content is displayed in an Expanded widget, which expands to fill the remaining space in the row after the NavigationRail or BottomNavigationBar has been rendered.
*/
class _NavigationRailPageState extends State<NavigationRailPage> {
  /// Setting the default page to the first page in the list.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// Checking the size of the screen and setting the screen size to a variable.
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isLargeScreen = width > 800;

    /// Returning a Scaffold widget that contains a BottomNavigationBar or a NavigationRail and a Row
    /// widget.
    return Scaffold(
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              items: _navBarItems,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(
                  () {
                    _selectedIndex = index;
                  },
                );
              },
            )
          : null,
      body: Row(
        children: <Widget>[
          if (!isSmallScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              backgroundColor: Color.fromARGB(255, 235, 235, 235),
              onDestinationSelected: (int index) {
                setState(
                  () {
                    _selectedIndex = index;
                  },
                );
              },
              extended: isLargeScreen,
              destinations: _navBarItems
                  .map(
                    (item) => NavigationRailDestination(
                      icon: IconTheme(
                        data: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
                        child: item.icon,
                      ),
                      selectedIcon: IconTheme(
                        data: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
                        child: item.activeIcon,
                      ),
                      label: Text(
                        item.label!,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          const VerticalDivider(thickness: 1, width: 1),

          /// A switch statement that returns a widget depending on the label of the selected item in the
          /// navigation bar.
          Expanded(
            child: Center(
              child: (() {
                /// A switch statement that returns a widget depending on the label of the selected item in the
                /// /// navigation bar.
                switch (_navBarItems[_selectedIndex].label) {
                  case "DoctorAI":
                    return ChatGPTAnswer();
                  case "Profile":
                    return ProfilePage1();
                  case "Mediguide":
                    return MediGuideChatBot();
                  default:
                    return Text("${_navBarItems[_selectedIndex].label} Page");
                }
              })(),
            ),
          )
        ],
      ),
    );
  }
}
