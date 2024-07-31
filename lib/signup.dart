import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

 final String _baseUrl = "shopp2.atwebpages.com";


class Adduser extends StatefulWidget {
  const Adduser({super.key});

  @override
  State<Adduser> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<Adduser> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _responseMessage = '';
  EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

  //
  bool _loading = false;

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: () {
            _encryptedData.remove('myKey').then((success) =>
                Navigator.of(context).pop());
          }, icon: const Icon(Icons.logout))
        ],
          title: const Text('Add Category'),
          centerTitle: true,
          // the below line disables the back button on the AppBar
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Form(
          key: _formKey, // key to uniquely identify the form when performing validation
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _usernameController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter ID',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter id';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password again',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter to confirm';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              ElevatedButton(
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading ? null : () { // disable button while loading
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    adduser(update, _confirmPasswordController .text.toString(),_usernameController.text.toString());
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              Visibility(visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        )));
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }


// below function sends the cid, name and key using http post to the REST service
  void adduser(Function(String text) update, String password, String name) async {
    try {
      // we need to first retrieve and decrypt the key
      String myKey = await _encryptedData.getString('myKey');
      // send a JSON object using http post
      final url = Uri.https(_baseUrl, 'signup.php');
      final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // 'Authorization': 'Bearer $myKey',
          }, // convert the cid, name and key to a JSON object
          body: convert.jsonEncode(<String, String>{
            'password': '$password', 'name': name, 'key': myKey
          })).timeout(const Duration(seconds: 5));
      // call the update function
      update(response.body);
    }
    catch (e) {
      update("connection error");
    }
  }
}