import 'package:flutter/material.dart';
import 'bag.dart';
import 'package:untitled15/Book.dart';
import 'Details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Book> selectedBooks = [];

  double sum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          actions: [
            SizedBox(width: 5),
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bag(
                            selectedBooks: selectedBooks,
                          )),
                );
              },
            ),
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 18),
              Text(
                'Maliks',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                child: TextField(
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.blueAccent,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none),
                    hintText: 'Search for  book',
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.black12,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 10,
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          books[index].title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            books[index].imageUrl,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Details(book: books[index]),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.book),
                              ),
                              Checkbox(
                                value: selectedBooks.contains(books[index]),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedBooks.add(books[index]);
                                    } else {
                                      selectedBooks.remove(books[index]);
                                    }
                                  });
                                },
                              ),
                            ]),
                      ]),
                );
              },
            ),
          )
        ]));
  }
}
