import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedCountry;
  final List<String> _countries = [
    'India',
    'United States',
    'United Kingdom',
    'Canada',
    // Add more countries as needed
  ];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _mailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender;

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic (mocked)
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You are registered successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationForm()),
                ); // Replace current page with a new instance of RegistrationForm
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = '${_selectedDate!.toLocal()}'.split(' ')[0]; // Format date as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildTextField(_firstNameController, 'First Name'),
                        SizedBox(height: 16),
                        _buildTextField(_lastNameController, 'Last Name'),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dobController,
                              decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                hintText: 'Select your date of birth',
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select your date of birth'
                                      : null,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: _inputDecoration('Gender'),
                          items: ['Male', 'Female', 'Other'].map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) => value == null
                              ? 'Please select your gender'
                              : null,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(_phoneController, 'Phone Number',
                            keyboardType: TextInputType.phone),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedCountry,
                          decoration: _inputDecoration('Country'),
                          items: _countries.map((country) {
                            return DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCountry = value;
                            });
                          },
                          validator: (value) => value == null
                              ? 'Please select your country'
                              : null,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(_stateController, 'State'),
                        SizedBox(height: 16),
                        _buildTextField(_cityController, 'City'),
                        SizedBox(height: 16),
                        _buildTextField(_pincodeController, 'Pincode',
                            keyboardType: TextInputType.number),
                        SizedBox(height: 16),
                        _buildTextField(_mailIdController, 'Mail ID',
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(height: 16),
                        _buildTextField(_passwordController, 'Password',
                            obscureText: true),
                        SizedBox(height: 16),
                        _buildTextField(
                            _confirmPasswordController, 'Confirm Password',
                            obscureText: true),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.purpleAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ElevatedButton(
                            onPressed: _register,
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .transparent, // Set the background color to transparent
                              shadowColor:
                                  Colors.transparent, // Remove button shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(label),
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter your $label' : null,
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '© ${DateTime.now().year} Nithish Kumar S L',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
    );
  }
}
