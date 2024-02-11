import 'package:driver_app/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String address = "";
  String zipCode = "";
  String city = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        nameController.text =
            selectedDate.toString().split(" ")[0].replaceAll("-", "/");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextFields for names
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Name is required" : null,
                  decoration: const InputDecoration(labelText: "First Name"),
                  onSaved: (value) => firstName = value!,
                  inputFormatters: [InputFormatter.alphabetic],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Middle Name (Optional)"),
                  onSaved: (value) => middleName = value!,
                  inputFormatters: [InputFormatter.alphabetic],
                ),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Name is required" : null,
                  decoration: const InputDecoration(labelText: "Last Name"),
                  onSaved: (value) => lastName = value!,
                  inputFormatters: [InputFormatter.alphabetic],
                ),

                // Date Picker Button and Field
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "DOB is required" : null,
                  decoration: InputDecoration(
                      labelText: "Date of Birth",
                      suffixIcon: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_month_outlined))),
                  controller: nameController,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                    DateFormater(),
                  ],
                ),

                // Address Fields
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "City is required" : null,
                        decoration: const InputDecoration(
                          labelText: "City",
                        ),
                        onSaved: (value) => city = value!,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Zip Code is required" : null,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Zip Code",
                        ),
                        onSaved: (value) => zipCode = value!,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Address is required" : null,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "Street, House/Apprtment No.",
                  ),
                  onSaved: (value) => address = value!,
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
                    InputFormatter.alphanumeric,
                    LengthLimitingTextInputFormatter(
                        12), // Limit to a maximum of 12 characters
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your driver license number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    const Text("Upload Document: "),
                    TextButton.icon(
                      onPressed: () => _pickDocument(),
                      icon: const Icon(Icons.upload),
                      label: const Text("Select Document"),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Submit information using firstName, middleName, lastName, selectedDate, uploadedFile
                      // Implement your submission logic here
                    }
                  },
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 20)
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
