import 'package:http/http.dart' as http;

final String _baseUrl = "shopp2.atwebpages.com";

Future<void> signInUser(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://your_server_address/signin.php'),
    body: {
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    print('Response: ${response.body}');
    if (response.body == 'Sign-in successful!') {
      print('User signed in successfully');
      // Handle successful sign-in, e.g., navigate to the home screen
    } else {
      print('Sign-in failed: ${response.body}');
      // Handle sign-in error, e.g., show an error message
    }
  } else {
    print('Failed to sign in: ${response.body}');
  }
}