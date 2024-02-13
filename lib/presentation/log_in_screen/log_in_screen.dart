import 'package:animate_gradient/animate_gradient.dart';
import 'package:driver_app/presentation/form_screen/form_screen.dart';
import 'package:driver_app/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _finishLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LeadScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Conditionally show or hide the app bar based on device orientation

    return AnimateGradient(
      primaryColors: const [
        Color.fromARGB(255, 31, 76, 151),
        Color.fromARGB(255, 39, 153, 189),
      ],
      secondaryColors: const [
        Color.fromARGB(255, 140, 0, 206),
        Color.fromARGB(255, 138, 203, 255),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text("Log in",
              style: TextStyle(fontWeight: FontWeight.bold)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 30.0),
                  Image.asset(
                    ImageConstant.imgLogo,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 50.0),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      // Optional: adjust padding

                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
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
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2394C1)),
                    onPressed: _login,
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: const FormScreen(),
                            type: PageTransitionType.fade),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20.0),
                  const SocialButtons(),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
