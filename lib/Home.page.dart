import 'package:flutter/material.dart';
import 'bag.dart';
import 'package:untitled15/Book.dart';
import 'Details.dart';
import 'database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Book> selectedBooks = [];
  final TextEditingController _searchController = TextEditingController();
  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch all books initially
  }

  Future<void> fetchBooks({String query = ''}) async {
    List<Book> booksFromApi = await getBooksByName(query);
    setState(() {
      filteredBooks = booksFromApi; // Update filteredBooks with fetched data
    });
  }

  void _searchBooks() {
    final  String query = _searchController.text;
    fetchBooks(query: query); // Fetch books based on the search query
  }

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
                  ),
                ),
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
                controller: _searchController,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search for book',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black12,
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _searchBooks,
              child: Text('Search'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return Container(
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
                        filteredBooks[index].title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          filteredBooks[index].imageUrl,
                          width: 400,
                          height: 120,
                          fit: BoxFit.cover,
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
                                  builder: (context) => Details(
                                    book: filteredBooks[index],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.book),
                          ),
                          Checkbox(
                            value: selectedBooks.contains(filteredBooks[index]),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  selectedBooks.add(filteredBooks[index]);
                                } else {
                                  selectedBooks.remove(filteredBooks[index]);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
