# Lab 2

## Login UI

### 1. Open VSC

![Screenshot 2024-01-04 145935](https://github.com/addff/2310-ICT602/assets/128471264/b53a4700-1955-4887-bd9b-8317c8426fae)

### 2. Create new Flutter project.

![Screenshot 2024-01-04 145950](https://github.com/addff/2310-ICT602/assets/128471264/2557ca73-24fe-412b-81da-3e933f7072c9)

### 3. Select Folder

![Screenshot 2024-01-04 150113](https://github.com/addff/2310-ICT602/assets/128471264/56b4a4bf-13c9-4553-9b73-05864188bca4)

### 4. Create file name, LoginPage.dart

![Screenshot 2024-01-04 150205](https://github.com/addff/2310-ICT602/assets/128471264/a8b09a02-f30d-441b-b25b-8cbe136c2fb2)

### 5. Write the code for the login.

'''
mport 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey[850],
appBar: AppBar(
backgroundColor: Colors.black,
title: const Text('Login Page'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: <Widget>[
TextFormField(
decoration: const InputDecoration(
labelText: 'Email',
labelStyle: TextStyle(color: Colors.white),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.white),
),
),
style: const TextStyle(color: Colors.white),
),
const SizedBox(height: 16.0),
TextFormField(
obscureText: true,
decoration: const InputDecoration(
labelText: 'Password',
labelStyle: TextStyle(color: Colors.white),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.white),
),
),
style: const TextStyle(color: Colors.white),
),
const SizedBox(height: 20), // Added SizedBox for spacing
ElevatedButton(
onPressed: () {
// Add login logic here
// Assuming login is successful, navigate to the dashboard
Navigator.pushReplacementNamed(context, '/dashboard');
},
style: ElevatedButton.styleFrom(
foregroundColor: Colors.white, primary: Colors.grey[700],
// text color
elevation: 5,
padding: const EdgeInsets.all(16.0),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8.0),
),
),
child: const Text('Login'),
),
const SizedBox(height: 20), // Added SizedBox for spacing
ElevatedButton(
onPressed: () {
Navigator.pushNamed(context, '/registration');
},
style: ElevatedButton.styleFrom(
foregroundColor: Colors.white, primary: Colors.grey[700],
// text color
elevation: 5,
padding: const EdgeInsets.all(16.0),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8.0),
),
),
child: const Text('Register'),
),
],
),
),
);
}
}
'''
