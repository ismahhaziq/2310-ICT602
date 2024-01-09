LAB 2 – DESIGN A LOGIN PAGE

Step 1 : Open your Visual Studio Code 
<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%202/image/lab2a.png?raw=true" alt="image" width="auto" height="auto">

Step 2 : Click Ctrl + Shift + P, then type and click Flutter: New Project.
<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%202/image/lab2b.png?raw=true" alt="image" width="auto" height="auto">

Step 3 : Select a folder.
<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%202/image/lab2c.png?raw=true" alt="image" width="auto" height="auto">
 
Step 4 : Create a new name for login application. For example, we created name 
<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%202/image/lab2d.png?raw=true" alt="image" width="auto" height="auto">
 
Step 5 : Copy and paste both of the codes.

•	login_page.dart
import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

•	main.dart
import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

Step 6 : Run the codes.
<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%202/image/lab2e.png?raw=true" alt="image" width="auto" height="auto">

Step 7 : Output was displayed as below.

<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%202/image/lab2f.png?raw=true" alt="image" width="auto" height="auto">


FAQ LAB WORK 2

Q: What is the purpose of creating a login page in Flutter?
A: A login page is a commonly used UI component that allows users to authenticate themselves before accessing the features of an app. This is crucial for protecting sensitive information and ensuring that only authorized users can access certain parts of the app.

Q: How do I run the code?
A: Use a code editor like Visual Studio Code with the Flutter extension and a connected emulator or device to run the Flutter app.

Q: What should I do if I encounter errors?
A: Carefully read the error messages and try to identify the cause of the issue. Check for typos, missing dependencies, or incorrect code structure. You can also search for help online or consult the Flutter documentation.

Q: How can I customize the login page further?
A: You can experiment with different layouts, colors, fonts, and add features like password visibility toggle, remember me functionality, or social login integration.



 
