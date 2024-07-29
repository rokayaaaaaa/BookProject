import 'package:flutter/material.dart';
import 'Book.dart';
import 'package:untitled15/Home.page.dart';
class Details extends StatelessWidget {

final Book book;

  Details({required this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Book'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  book.imageUrl,
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                book.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Author:${book.Author}',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text( '${book.decrption}',

                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),
              Text(

                'Price: ${book.price}',
                style: TextStyle(fontSize: 16,color: Colors.white,backgroundColor: Colors.amber),
                textAlign: TextAlign.center,
              ),




            ]
        ),
      ),
    );
  }
}
