// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, deprecated_member_use, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:ffi' hide Size;

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:demo_app/login_screen.dart';
import 'package:demo_app/dbHelper/mongodb.dart';
import 'package:demo_app/dbHelper/mongodbDraft.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var fnameController = TextEditingController();
  var mnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var contactNumController = TextEditingController();
  var remarksController = TextEditingController();
  var selectedRemarks = 'REGULAR'; // Default choice
  var branchController = TextEditingController(text: 'Branch');
  bool isActivate = false;

  String? fnameError;
  String? lnameError;
  String? addressError;
  String? contactNumError;
  String? usernameError;
  String? passwordError;
  String? confirmPassError;
  bool obsurePassword = true;
  bool obsureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    List<String> remarksChoices = ['REGULAR', 'RELIVER', 'PROVISIONARY', 'FIX'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Center(
          child: Container(
            height: 1100,
            width: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green[600]!,
                  Colors.green[800]!,
                  Colors.green[900]!,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'SIGN UP',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  value: selectedRemarks,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRemarks = newValue!;
                      remarksController.text = newValue;
                    });
                  },
                  items: remarksChoices
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Remarks',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  enabled: false, // Disable the TextField
                  controller: branchController,
                  decoration: InputDecoration(
                    hintText: 'Branch',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: false,
                  controller: fnameController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: fnameError,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: false,
                  controller: mnameController,
                  decoration: InputDecoration(
                    hintText: 'Middle Name (Optional)',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add space between fields
                TextField(
                  obscureText: false,
                  controller: lnameController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: lnameError,
                  ),
                ),
                const SizedBox(height: 20), // Add space between fields
                TextField(
                  obscureText: false,
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: addressError,
                  ),
                ),
                const SizedBox(height: 20), // Add space between fields
                TextField(
                  obscureText: false,
                  controller: contactNumController,
                  keyboardType:
                      TextInputType.number, // Set keyboard type to number
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    LengthLimitingTextInputFormatter(
                        11), // Limit to 11 characters
                  ],
                  decoration: InputDecoration(
                    hintText: 'Contact Number',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: contactNumError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      // You can add any additional logic here if needed
                    });
                  },
                ),
                const SizedBox(height: 20), // Add space between fields
                TextField(
                  obscureText: false,
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: usernameError,
                  ),
                ),
                const SizedBox(height: 20), // Add space between fields
                TextField(
                  obscureText: obsurePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: passwordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obsurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obsurePassword = !obsurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add space between fields
                TextField(
                  obscureText: obsureConfirmPassword,
                  controller: confirmPassController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: confirmPassError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obsureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obsureConfirmPassword = !obsureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 35), // Add space between fields
                ElevatedButton(
                  onPressed: () {
                    if (_validateFields()) {
                      if (passwordController.text ==
                          confirmPassController.text) {
                        _insertData(
                            fnameController.text,
                            mnameController.text,
                            lnameController.text,
                            addressController.text,
                            usernameController.text,
                            passwordController.text,
                            contactNumController.text,
                            branchController.text,
                            selectedRemarks,
                            isActivate);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.roboto(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.roboto(
                      color: Colors.blue[400],
                      fontWeight: FontWeight.bold,
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

  Future<void> _insertData(
      String fName,
      String mName,
      String lName,
      String emailAdd,
      String userN,
      String pass, // Plain text password
      String contact_num,
      String branch,
      String remarks,
      bool isActivate) async {
    var _id = M.ObjectId();
    final plainPassword = pass; // Store the plain text password for hashing

    // Hash the password using the hashPassword function
    final hashedPassword = await hashPassword(plainPassword);

    final data = MongoDemo(
      id: _id,
      firstName: fName,
      middleName: mName,
      lastName: lName,
      emailAddress: emailAdd,
      contactNum: contact_num,
      username: userN,
      password: hashedPassword,
      accountNameBranchManning: branch,
      remarks: remarks,
      isActivate: isActivate,
      // Store the hashed password
    );
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Inserted ID " + _id.$oid)),
    );
    _clearAll();
    Navigator.pop(context);
  }

  void _clearAll() {
    branchController.text = "";
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
    contactNumController.text = "";
    usernameController.text = "";
    passwordController.text = "";
    confirmPassController.text = "";
  }

  bool _validateFields() {
    bool isValid = true;

    if (fnameController.text.isEmpty) {
      setState(() {
        fnameError = "Please enter First Name";
      });
      isValid = false;
    } else {
      setState(() {
        fnameError = null;
      });
    }

    if (lnameController.text.isEmpty) {
      setState(() {
        lnameError = "Please enter Last Name";
      });
      isValid = false;
    } else {
      setState(() {
        lnameError = null;
      });
    }

    if (addressController.text.isEmpty) {
      setState(() {
        addressError = "Please enter Email";
      });
      isValid = false;
    } else {
      setState(() {
        addressError = null;
      });
    }

    if (contactNumController.text.isEmpty) {
      setState(() {
        contactNumError = "Please enter Contact Number";
      });
      isValid = false;
    } else if (contactNumController.text.length < 11) {
      // Check if contact number is at least 11 digits long
      setState(() {
        contactNumError = "Contact Number must be at least 11 digits long";
      });
      isValid = false;
    } else {
      setState(() {
        contactNumError = null;
      });
    }

    if (usernameController.text.isEmpty) {
      setState(() {
        usernameError = "Please enter Username";
      });
      isValid = false;
    } else if (usernameController.text.length < 6) {
      setState(() {
        usernameError = "Username must be at least 6 characters long";
      });
      isValid = false;
    } else {
      setState(() {
        usernameError = null;
      });
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = "Please enter Password";
      });
      isValid = false;
    } else if (passwordController.text.length < 6) {
      setState(() {
        passwordError = "Password must be at least 6 characters long";
      });
      isValid = false;
    } else {
      setState(() {
        passwordError = null;
      });
    }

    if (confirmPassController.text.isEmpty) {
      setState(() {
        confirmPassError = "Please enter Confirm Password";
      });
      isValid = false;
    } else if (confirmPassController.text.length < 6) {
      setState(() {
        confirmPassError =
            "Confirm password must be at least 6 characters long";
      });
      isValid = false;
    } else {
      setState(() {
        confirmPassError = null;
      });
    }

    return isValid;
  }

  bool _isValidContactNumber(String contactNumber) {
    // Check if the contact number consists only of numbers and has a length up to 11 digits
    return int.tryParse(contactNumber) != null && contactNumber.length <= 11;
  }
}
