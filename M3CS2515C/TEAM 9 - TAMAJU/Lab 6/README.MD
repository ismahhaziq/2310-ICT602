# Lab Work 6

## CRUD

1. Group of 3
2. Using VS Code create the update page.
3. Using Firebase as a Database.
4. Speed Code Video + Music.
5. Create Update Page for User Information.
6. Create Update Page for other information (e.g. Product, Transaction, Course or Department)
7. Run on Smartphone
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.

## LINK

https://youtu.be/H6F2WqNody0

## CODE SNIPPET

### Update User Information

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

### Update Catering Page

```
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textFieldController = TextEditingController();

  //create food item
  Future<void> _addDataToFirestore(String data, double price) async {
    try {
      await _firestore.collection('caterings').add({
        'field1': data,
        'field2': 'Food',
        'isAvailable': true,
        'price': price, // Add the price to the document
      });
      _textFieldController.clear();
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<void> _updateDataInFirestore(String documentId, String currentField1, bool? isAvailable) async {
    final TextEditingController _updateField1Controller = TextEditingController(text: currentField1);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _updateField1Controller,
                decoration: InputDecoration(labelText: 'Food Name'),
              ),
              Text('Is Available: ${isAvailable ?? false}'), // Display the current availability status
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedField1 = _updateField1Controller.text;
                await _firestore.collection('caterings').doc(documentId).update({
                  'field1': updatedField1,
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () async {
                await _firestore.collection('caterings').doc(documentId).update({
                  'isAvailable': !(isAvailable ?? false), // Toggle the availability status in Firestore
                });
                Navigator.of(context).pop();
              },
              child: Text('Toggle Availability'),
            ),
          ],
        );
      },
    );
  }

  void _showPriceDialog(String documentId, double currentPrice) {
    final TextEditingController _priceController = TextEditingController(text: currentPrice.toStringAsFixed(2));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Price'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'New Price'),
                keyboardType: TextInputType.number, // Allowing only numbers
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newPrice = double.tryParse(_priceController.text);
                if (newPrice != null) {
                  _updatePriceInFirestore(documentId, newPrice);
                  Navigator.of(context).pop();
                } else {
                  // Handle invalid input or display a message to the user.
                }
              },
              child: Text('Update Price'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updatePriceInFirestore(String documentId, double newPrice) async {
    await _firestore.collection('caterings').doc(documentId).update({
      'price': newPrice,
    });
  }

  Future<void> _deleteDataFromFirestore(String documentId) async {
    await _firestore.collection('caterings').doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catering'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Add Catering',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addDataToFirestore(_textFieldController.text, 0.0); // Initialize with a price of 0.0
              },
              child: Text('Add Data'),
            ),
            SizedBox(height: 20),
            Text(
              'Firestore Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('caterings').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final document = data[index].data() as Map<String, dynamic>;
                        final documentId = data[index].id;
                        final currentPrice = document['price'] ?? 0.0; // Get the price or default to 0.0
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(document['field1']),
                            subtitle: Text(document['field2']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _updateDataInFirestore(documentId, document['field1'], document['isAvailable']);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.attach_money), // Add an icon for changing the price
                                  onPressed: () {
                                    _showPriceDialog(documentId, currentPrice);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteDataFromFirestore(documentId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Update Service Page

```
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textFieldController = TextEditingController();

  //create drink item
  Future<void> _addDataToFirestore(String data, double price) async {
    try {
      await _firestore.collection('addon').add({
        'field1': data,
        'field2': 'Service',
        'isAvailable': true,
        'price': price, // Add the price to the document
      });
      _textFieldController.clear();
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<void> _updateDataInFirestore(String documentId, String currentField1, bool? isAvailable) async {
    final TextEditingController _updateField1Controller = TextEditingController(text: currentField1);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _updateField1Controller,
                decoration: InputDecoration(labelText: 'Add-On Name'),
              ),
              Text('Is Available: ${isAvailable ?? false}'), // Display the current availability status
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedField1 = _updateField1Controller.text;
                await _firestore.collection('addon').doc(documentId).update({
                  'field1': updatedField1,
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () async {
                await _firestore.collection('addon').doc(documentId).update({
                  'isAvailable': !(isAvailable ?? false), // Toggle the availability status in Firestore
                });
                Navigator.of(context).pop();
              },
              child: Text('Toggle Availability'),
            ),
          ],
        );
      },
    );
  }

  void _showPriceDialog(String documentId, double currentPrice) {
    final TextEditingController _priceController = TextEditingController(text: currentPrice.toStringAsFixed(2));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Price'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'New Price'),
                keyboardType: TextInputType.number, // Allowing only numbers
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newPrice = double.tryParse(_priceController.text);
                if (newPrice != null) {
                  _updatePriceInFirestore(documentId, newPrice);
                  Navigator.of(context).pop();
                } else {
                  // Handle invalid input or display a message to the user.
                }
              },
              child: Text('Update Price'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updatePriceInFirestore(String documentId, double newPrice) async {
    await _firestore.collection('addon').doc(documentId).update({
      'price': newPrice,
    });
  }

  Future<void> _deleteDataFromFirestore(String documentId) async {
    await _firestore.collection('addon').doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add-On'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Add Service',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addDataToFirestore(_textFieldController.text, 0.0); // Initialize with a price of 0.0
              },
              child: Text('Add Data'),
            ),
            SizedBox(height: 20),
            Text(
              'Firestore Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('addon').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final document = data[index].data() as Map<String, dynamic>;
                        final documentId = data[index].id;
                        final currentPrice = document['price'] ?? 0.0; // Get the price or default to 0.0
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(document['field1']),
                            subtitle: Text(document['field2']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _updateDataInFirestore(documentId, document['field1'], document['isAvailable']);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.attach_money), // Add an icon for changing the price
                                  onPressed: () {
                                    _showPriceDialog(documentId, currentPrice);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteDataFromFirestore(documentId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```
