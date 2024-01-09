# M3CS2515C:
- MUHAMMAD KHAIRUL ARIFFIN (2022821444)
- MUHAMMAD AIMAN NABIL (2022800658)
- RUSYDAN FAWWAZ (2022855926)
- AFIQ AIMAN (2022856056)

- [Lab Full (1-9) CRUD-google signin](https://github.com/ipinzr/firebase_demo.git)


Speedcode Video
[![Lab 9 - google sign in](https://img.youtube.com/vi/o4UBKcUDAZE/maxresdefault.jpg)](https://www.youtube.com/watch?v=o4UBKcUDAZEE)


Google sign in snippet code
``
Future<void> _handleGoogleSignIn() async {
    try {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the Google Sign-In process
        return;
      }

      // Get Google Sign-In authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using Google credentials
      await _auth.signInWithCredential(credential);

      // Pass the user's email to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(userEmail: _auth.currentUser?.email ?? ""),
        ),
      );
    } catch (e) {
      print('Google Sign-In error: $e');
    }
  }

  ``



 
