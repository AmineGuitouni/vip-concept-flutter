import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo or Image
            Image.asset(
              'lib/assets/vipconcept.png', // Replace with your logo image path
              width: 500,
              height: 500,
              // Adjust width and height as needed
            ),
            const SizedBox(height: 20),
            // Login Button
            Padding(
              padding: const EdgeInsets.all(10.0), // Padding around the button
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to login screen or perform login action
                  },
                  child: const Text('Login'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Permissions Button
            Padding(
              padding: const EdgeInsets.all(10.0), // Padding around the button
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Navigate to permissions screen or perform permissions action
                  },
                  child: const Text(
                    'Terms and Conditions - Get Help!',
                    style: TextStyle(
                        color: Colors.blue), // Customize text color if needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
