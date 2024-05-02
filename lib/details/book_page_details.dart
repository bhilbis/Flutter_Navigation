import 'package:flutter/material.dart';
import '../pages/book_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  
  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(book.imageUrl),
          const SizedBox(height: 20),
          Text('Rating: ${book.rating}'),
        ],
      ),
    );
  }
}
