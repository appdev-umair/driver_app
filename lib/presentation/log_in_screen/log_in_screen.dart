import 'package:driver_app/presentation/form_screen/form_screen.dart';
import 'package:driver_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/core/app_export.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _login() async {
    final String phone = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      // Show an error message if email or password is empty
      return;
    }

    // Call the login method from ApiService
    final bool loggedIn = await LogInService.login(phone, password);

    if (loggedIn) {
      // If login is successful, navigate to the next screen
      _finishLogin();
    } else {
      // If login fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  void _finishLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LeadScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30),
          children: [
            Image.asset(
              ImageConstant.imgLogo,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Log in'),
            ),
            const SizedBox(height: 20.0),
            const Align(
              child: Text(
                "OR",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: const FormScreen(),
                      type: PageTransitionType.bottomToTop),
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 20.0),
            // SocialButtons(), // Assuming SocialButtons widget is defined elsewhere
          ],
        ),
      ),
    );
  }
}
