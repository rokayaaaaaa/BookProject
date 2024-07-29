// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:untitled15/Home.page.dart';
//
// void main() {
//   runApp(UserValidationApp());
// }
//
// class UserValidationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User Validation',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: UserValidationScreen(),
//     );
//   }
// }
//
// class UserValidationScreen extends StatefulWidget {
//
//   @override
//   _UserValidationScreenState createState() => _UserValidationScreenState();
// }
//
// class _UserValidationScreenState extends State<UserValidationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _responseMessage = '';
//
//   Future<void> _validateUser() async {
//     final response = await http.post(
//       Uri.parse('http://shopp2.atwebpages.com/validate_user.php'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'username': _usernameController.text,
//         'password': _passwordController.text,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       if (responseData['success']) {
//         setState(() {
//           _responseMessage = responseData['message'];
//         });
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Home()),
//         );
//       } else {
//         setState(() {
//           _responseMessage = responseData['errors'].toString();
//         });
//       }
//     } else {
//       setState(() {
//         _responseMessage = 'Server error: ${response.statusCode}';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Validation'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a username';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _validateUser();
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 20),
//               Text(_responseMessage),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => RegistrationScreen()),
//                   );
//                 },
//                 child: Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class RegistrationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registration'),
//       ),
//       body: Center(
//         child: Text('Registration Page'),
//       ),
//     );
//   }
// }