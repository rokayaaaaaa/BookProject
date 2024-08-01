import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled15/Book.dart';
import 'package:untitled15/Home.page.dart';

final String _baseUrl = "shopp2.atwebpages.com";


Future<void> signInUser(
    BuildContext context, String username, String password) async {
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


List<Book> books = [];
Future getBooks() async {

  final url = Uri.http(_baseUrl, 'getBook.php');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> bookJson = jsonDecode(response.body);
      books.clear(); // Clear the list before adding new items
      for (var row in bookJson) {
        // Map JSON fields to Book class
        Book b = Book(
            row['Title'],         // Title
            row['imageURL'],      // imageURL
            row['Description'],   // Description
            row['Author'],        // Author
            double.tryParse(row['Price'].toString()) ?? 0.0 // Price
        );
        books.add(b);
        print('Books: $books');
      }
    } else {
      // Error response
      print('Failed to load books. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}







