import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled15/Home.page.dart';

final String _baseUrl = "shopp2.atwebpages.com";

Future<void> signInUser(BuildContext context,String username, String password) async {
  final url = Uri.http(_baseUrl, 'validate_user.php');
  final response = await http.post(
    url,
    body: {
      'username': username,
      'password': password,
    },
  ).timeout(const Duration(seconds: 10));

  if (response.statusCode == 200) {
    print('Response: ${response.body}');
    if (response.body == 'Sign-in successful!') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      print('User signed in successfully');
    } else {
      print('Sign-in failed: ${response.body}');
      // Handle sign-in error, e.g., show an error message
    }
  } else {
    print('Failed to sign in: ${response.body}');
  }
}
Future getBooks()async{
  final url = Uri.http(_baseUrl, 'getBook.php');
  final response = await http.post(
    url,
    body: {

    },
  ).timeout(const Duration(seconds: 10));


}