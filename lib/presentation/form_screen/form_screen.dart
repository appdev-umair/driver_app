import 'package:driver_app/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:driver_app/core/utils/formatters.dart';
import 'package:driver_app/presentation/lead_screen/lead_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  TextEditingController dobController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String phone = "";
  String dob = "";
  String role = "";
  String address = "";
  String city = "";
  String zipCode = "";
  String licenseNumber = "";

  Future<void> _register() async {
    {
      _formKey.currentState!.save();
      // Call the register method from ApiService
      final bool registered = await RegistrationService.register(
        firstName: "$firstName $middleName",
        lastName: lastName,
        phone: phone,
        socialSecurity: ssnController.text.trim(),
        licenseNumber: licenseNumber,
        dob: dob,
        password: _passwordController.text.trim(),
        role: role,
        address: address,
      );

      if (registered) {
        // If registration is successful, navigate to the next screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LeadScreen()),
          (route) => false,
        );
      } else {
        // If registration fails, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text =
            selectedDate.toString().split(" ")[0].replaceAll("-", "/");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              children: [
                // TextFields for names
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "First Name is required" : null,
                  decoration: const InputDecoration(labelText: "First Name"),
                  onSaved: (value) => firstName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Middle Name (Optional)"),
                  onSaved: (value) => middleName = value!,
                ),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Last Name is required" : null,
                  decoration: const InputDecoration(labelText: "Last Name"),
                  onSaved: (value) => lastName = value!,
                ),
                // Social and Driver Number
                TextFormField(
                  controller: ssnController,
                  decoration: const InputDecoration(
                      labelText: 'Social Security Number'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    SSNFormatter(),
                  ],
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Driver License Number'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9]'),
                    ),
                    LengthLimitingTextInputFormatter(12),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your driver license number';
                    }
                    return null;
                  },
                  onSaved: (value) => licenseNumber = value!,
                ),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Phone is required" : null,
                  decoration: const InputDecoration(labelText: "Phone"),
                  onSaved: (value) => phone = value!,
                  keyboardType: TextInputType.phone,
                ),
                // Date Picker Button and Field
                TextFormField(
                  controller: dobController,
                  validator: (value) =>
                      value!.isEmpty ? "DOB is required" : null,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                    DateFormater(),
                  ],
                  onSaved: (value) => dob = value!,
                ),
                // password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                // role
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Role is required" : null,
                  decoration: const InputDecoration(labelText: "Role"),
                  onSaved: (value) => role = value!,
                ),

                // Address Fields
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Address is required" : null,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    labelText: "Address",
                  ),
                  onSaved: (value) => address = value!,
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Text("Upload Document: "),
                    TextButton.icon(
                      onPressed: () => _pickDocument(),
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Select Document"),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Submit Button
                ElevatedButton(
                  onPressed: _register,
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDocument() async {
    // Use file_picker or image_picker to handle document selection
    // Store the selected file data or path somewhere appropriate
    setState(() {});
  }
}
