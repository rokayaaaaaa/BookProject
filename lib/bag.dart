import 'package:flutter/material.dart';
import 'Book.dart';
import 'package:untitled15/Home.page.dart';


class Bag extends StatefulWidget {

  final List<Book> selectedBooks;
Bag({required this.selectedBooks});

   @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }
  void calculateTotalPrice() {
    setState(() {
      totalPrice = widget.selectedBooks.fold(0.0, (sum, book) => sum + book.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Books'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedBooks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(widget.selectedBooks[index].imageUrl),
                  title: Text(widget.selectedBooks[index].title),
                  subtitle: Text(widget.selectedBooks[index].decrption),
                );
              },
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}





