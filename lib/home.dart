import 'package:flutter/material.dart'; // Importing Flutter's material design package
import 'main.dart'; // Importing the main.dart file
import 'profile.dart'; // Importing the profile.dart file
import 'settings.dart'; // Importing the settings.dart file

// HomePage is the main screen of the app, displaying recipes and navigation options
class HomePage extends StatelessWidget {
  HomePage({super.key}); // Constructor for the HomePage class
  static bool isFirstTime =
      true; // Tracks if the user is visiting for the first time

  final String username =
      LoginScreen.correctUsername; // Username from the login screen

  // List of recipe items with their images and titles
  final List<Map<String, String>> items = [
    {'image': 'assets/Chicken_Nuggets.png', 'title': 'Crispy Chicken Nuggets'},
    {
      'image': 'assets/chocolate-indulgence.png',
      'title': 'Chocolate Indulgence',
    },
    {
      'image': 'assets/crispy-comte-cheeseburgers.png',
      'title': 'Crispy Comte Cheeseburgers',
    },
    {'image': 'assets/fries_recipe.png', 'title': 'Fries'},
    {'image': 'assets/Pizza-Rolls-Recipe.png', 'title': 'Pizza Rolls'},
    {'image': 'assets/secret-burger-sauce.png', 'title': 'Secret Burger Sauce'},
  ];

  @override
  Widget build(BuildContext context) {
    // Show a welcome popup only the first time the user visits the page
    if (isFirstTime) {
      isFirstTime = false; // Ensure the popup is only shown once
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false, // Prevent user from dismissing early
          builder:
              (context) => AlertDialog(
                title: Text('Welcome!'), // Title of the dialog
                content: Text(
                  'Hello, $username 👋', // Welcome message with username
                  style: TextStyle(fontSize: 25), // Styling the text
                ),
              ),
        );

        // Auto close the dialog after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Close the dialog
        });
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Recipe App', // Title of the app bar
            style: TextStyle(
              fontSize: 24, // Font size of the title
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
          backgroundColor: Colors.orange[800], // Set the app bar color
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, // Remove padding from the list
            children: [
              // Drawer header with user information
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange[800],
                ), // Background color
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items to the start
                  children: [
                    CircleAvatar(
                      radius: 30, // Size of the avatar
                      backgroundColor: Colors.white, // Background color
                      child: Icon(
                        Icons.person, // Icon inside the avatar
                        color: Colors.orange[800], // Icon color
                        size: 40, // Icon size
                      ),
                    ),
                    SizedBox(height: 10), // Spacing
                    Text(
                      username, // Display username
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ), // Styling the text
                    ),
                    SizedBox(height: 5), // Spacing
                    Text(
                      '$username@mail.com', // Display email
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ), // Styling the text
                    ),
                  ],
                ),
              ),
              // Navigation options in the drawer
              ListTile(
                leading: Icon(Icons.home), // Icon for home
                title: Text('Home'), // Label for home
                onTap: () {}, // Stay on the home page
              ),
              ListTile(
                leading: Icon(Icons.person), // Icon for profile
                title: Text('Profile'), // Label for profile
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ), // Navigate to profile page
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings), // Icon for settings
                title: Text('Settings'), // Label for settings
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ), // Navigate to settings page
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout), // Icon for logout
                title: Text('Logout'), // Label for logout
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ), // Navigate to login screen
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Section for latest recipes
              Padding(
                padding: EdgeInsets.all(10), // Padding around the text
                child: Text(
                  'Latest Recipes', // Section title
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ), // Styling the text
                ),
              ),
              // Horizontal scrollable list of recipe items
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  children:
                      items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(
                            10,
                          ), // Padding around each item
                          child: Container(
                            width: 150, // Width of each recipe card
                            decoration: BoxDecoration(
                              color: Colors.orange[100], // Background color
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center, // Center align items
                              children: [
                                // Recipe image
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      10,
                                    ), // Rounded top corners
                                  ),
                                  child: Image.network(
                                    item['image']!, // Recipe image URL
                                    height: 100, // Image height
                                    width: double.infinity, // Image width
                                    fit: BoxFit.cover, // Fit image to cover
                                  ),
                                ),
                                // Recipe title
                                Padding(
                                  padding: const EdgeInsets.all(
                                    8.0,
                                  ), // Padding around the title
                                  child: Text(
                                    item['title']!, // Recipe title
                                    textAlign:
                                        TextAlign.center, // Center align text
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, // Bold text
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(), // Convert items to a list of widgets
                ),
              ),
              SizedBox(height: 20), // Spacing
              // Section for popular recipes
              Padding(
                padding: EdgeInsets.all(10), // Padding around the text
                child: Text(
                  'Popular Recipes', // Section title
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ), // Styling the text
                ),
              ),
              // List of popular recipes
              ListTile(
                title: Text('Regular Chicken Nuggets'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(), // Divider between items
              ListTile(
                title: Text('Chicken Nuggets with Cheese'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              ListTile(
                title: Text('Egg and cheese sandwich'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              ListTile(
                title: Text('Bacon'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              ListTile(
                title: Text('Home made fries'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              ListTile(
                title: Text('Guacamole'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              ListTile(
                title: Text('Jalapeno poppers'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              ListTile(
                title: Text('Buffalo wings'), // Recipe title
                onTap: () {}, // Action for this recipe
              ),
              Divider(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Center align items
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            100,
                          ), // Circular shape
                          color: Colors.grey, // Background color
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add), // Add icon
                          tooltip: 'Add recipe', // Tooltip text
                          onPressed: () {},
                        ),
                      ),
                      Text('Add recipe'), // Label below the button
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            100,
                          ), // Circular shape
                          color: Colors.grey, // Background color
                        ),
                        child: IconButton(
                          icon: Icon(Icons.search), // Add icon
                          tooltip: 'Search recipe', // Tooltip text
                          onPressed: () {},
                        ),
                      ),
                      Text('Search recipe'), // Label below the button
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            100,
                          ), // Circular shape
                          color: Colors.grey, // Background color
                        ),
                        child: IconButton(
                          icon: Icon(Icons.delete), // Add icon
                          tooltip: 'Delete recipe', // Tooltip text
                          onPressed: () {},
                        ),
                      ),
                      Text('Delete recipe'), // Label below the button
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Footer with copyright information
              Text(
                '© 2023 Recipe App. All rights reserved.', // Copyright text
                style: TextStyle(
                  fontSize: 12, // Font size
                  color: Colors.grey, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
