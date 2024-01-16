# Lab Work 5

## CRUD

1. Group of 3
2. Using VS Code create the information page detail form.
3. Using Firebase as a Database.
4. Speed Code Video + Music.
5. Create Page for User Information.
6. Create Page for other information (e.g. Product, Transaction, Course or Department)
7. Run on AVD
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.

## LINK

https://youtu.be/MAP8BU-mesg

## CODE SNIPPET

User Information Page
```
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfileScreen extends StatefulWidget {
  final User user;

  UserProfileScreen({required this.user});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;

  @override
  void initState() {
    super.initState();
    // Fetch the user's profile data from Firestore
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(widget.user.uid).get();

      if (userDoc.exists) {
        final userProfile = userDoc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = userProfile['name'] ?? '';
          mobileController.text = userProfile['mobile'] ?? '';
        });
      }
    } catch (e) {
      // Handle errors, e.g., display an error message
      print('Error fetching user profile data: $e');
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      await _firestore.collection('users').doc(widget.user.uid).set({
        'name': nameController.text,
        'mobile': mobileController.text,
      }, SetOptions(merge: true));
      // Handle successful update, e.g., show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile updated successfully'),
      ));
    } catch (e) {
      // Handle errors, e.g., display an error message
      print('Error updating profile: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
  onTap: _pickImage,
  child: CircleAvatar(
    radius: 60,
    backgroundImage: _image != null
        ? FileImage(_image!) as ImageProvider<Object>?
        : NetworkImage('https://th.bing.com/th/id/OIP.Xul8xb_RKpJd0BhazsiY3QHaHa?rs=1&pid=ImgDetMain') as ImageProvider<Object>?,
  ),
),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateUserProfile();
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Catering & Add-On Page
```
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'catering.dart';
import 'service.dart';

class MenuItem {
  final String name;
  final String description;
  final double price;
  final bool isAvailable;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable, // Include the availability status
  });
}


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItem> cateringList = [];
  List<MenuItem> serviceList = [];
  int _currentIndex = 0; // To track the selected tab

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    _loadMenuData();
  }

  Future<void> _loadMenuData() async {
    await _loadMenu('caterings', cateringList);
    await _loadMenu('addon', serviceList);
  }

  Future<void> _loadMenu(String collection, List<MenuItem> menu) async {
  final firestore = FirebaseFirestore.instance;
  firestore.collection(collection).snapshots().listen((snapshot) {
    final menuItems = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return MenuItem(
        name: data['field1'],
        description: data['field2'],
        price: data['price'], // You can add a price field in your Firestore data
        isAvailable: data['isAvailable'] ?? true, // Include the availability status
      );
    }).toList();

    setState(() {
      menu.clear();
      menu.addAll(menuItems);
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: _currentIndex == 0 ? _buildMenu(cateringList) : _buildMenu(serviceList),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Catering',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Add-On',
          ),
        ],
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
  // Get the current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Check if the current user is an admin
  bool isAdmin = currentUser?.email == 'admin@gmail.com';

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Service Options',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.restaurant_menu),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(userEmail: currentUser?.email ?? '')),
            );
          },
        ),
        if (isAdmin) // Show only if the user is an admin
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Catering List'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodPage()),
              );
            },
          ),
        if (isAdmin) // Show only if the user is an admin
          ListTile(
            leading: Icon(Icons.local_drink),
            title: Text('Add-On List'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServicePage()),
              );
            },
          ),
      ],
    ),
  );
}


  Widget _buildMenu(List<MenuItem> menu) {
  // Filter out items that are not available
  final availableMenu = menu.where((item) => item.isAvailable).toList();

  return ListView.builder(
    itemCount: availableMenu.length,
    itemBuilder: (context, index) {
      final item = availableMenu[index];
      return Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Text('\$${item.price.toStringAsFixed(2)}'),
        ),
      );
    },
  );
}

}
```
