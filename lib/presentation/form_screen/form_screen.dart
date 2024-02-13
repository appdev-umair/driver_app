import 'package:animate_gradient/animate_gradient.dart';
import 'package:driver_app/core/app_export.dart';
import 'package:driver_app/services/register_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:driver_app/core/utils/formatters.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isFileUploaded = false;
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
  FilePickerResult? fileData;

  String fileName = "";

  Future<void> _register() async {
    {
      if (_formKey.currentState!.validate()) {
        if (_isFileUploaded) {
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
              fileData: fileData,
              fileName: fileName);
          if (registered) {
            _navigateToLoginScreen();
          } else {
            _displaySnackBar("Registration failed. Please try again.");
          }
        } else {
          _displaySnackBar("Please Upload Driving License");
        }
      }
    }
  }

  _displaySnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  _navigateToLoginScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const LogInScreen(), type: PageTransitionType.fade),
        (route) => false);
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
          title: const Text("Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
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
              child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 30.0),

                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "First Name is required" : null,
                      decoration:
                          const InputDecoration(labelText: "First Name"),
                      onSaved: (value) => firstName = value!,
                    ),
                    const SizedBox(height: 10.0),

                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Middle Name (Optional)"),
                      onSaved: (value) => middleName = value!,
                    ),
                    const SizedBox(height: 10.0),

                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Last Name is required" : null,
                      decoration: const InputDecoration(labelText: "Last Name"),
                      onSaved: (value) => lastName = value!,
                    ),
                    const SizedBox(height: 10.0),

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
                    const SizedBox(height: 10.0),

                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Driver License Number'),
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
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Phone is required" : null,
                      decoration: const InputDecoration(labelText: "Phone"),
                      onSaved: (value) => phone = value!,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10.0),
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
                    const SizedBox(height: 10.0),
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
                    const SizedBox(height: 10.0),
                    // role
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Role is required" : null,
                      decoration: const InputDecoration(labelText: "Role"),
                      onSaved: (value) => role = value!,
                    ),
                    const SizedBox(height: 10.0),

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
                    const SizedBox(height: 10.0),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text("Driving License: "),
                        Spacer(),
                        TextButton.icon(
                          onPressed: () => _pickDocument(),
                          icon:
                              Icon(_isFileUploaded ? Icons.done : Icons.upload),
                          label: Text(
                              _isFileUploaded ? "Uploaded " : "Select File"),
                        ),
                      ],
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Uploaded File: ")),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(fileName.isEmpty ? "No File" : fileName),
                    ),
                    const SizedBox(height: 20),
                    // Submit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2394C1)),
                      onPressed: _register,
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pickDocument() async {
    fileData = await FilePicker.platform.pickFiles();
    if (fileData != null) {
      setState(() {
        fileName = fileData!.files.single.name;

        _isFileUploaded = true;
      });
    }
  }
}
