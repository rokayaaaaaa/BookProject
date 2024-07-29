class Book {
  String title;
  String imageUrl;
  String description;
  String author;
  double price;
  bool selected = false;

  Book(this.title, this.imageUrl, this.description, this.author, this.price);

  @override
  String toString() {
    return 'Book{title: $title, imageUrl: $imageUrl, description: $description, author: $author, price: $price, selected: $selected}';
  }
}
