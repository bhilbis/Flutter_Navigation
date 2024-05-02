import 'package:flutter/material.dart';
import '../details/book_page_details.dart';

class Book {
  final String title;
  final String imageUrl;
  final double rating;

  Book({
    required this.title,
    required this.imageUrl,
    required this.rating,
  });
}

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
            6,
            (index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                                book: Book(
                                    title: 'Book $index',
                                    imageUrl: ' /',
                                    rating: 4.5))));
                  },
                )),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final int index;

  const CardItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Add your onTap action here
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.category, size: 50),
            const SizedBox(height: 10),
            Text('Item $index', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
