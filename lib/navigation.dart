import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'pages/home_page.dart';
import 'pages/book_page.dart';
import 'pages/history_page.dart';
import 'pages/profile_page.dart';

class GoogleBottomBar extends StatefulWidget {
  const GoogleBottomBar({Key? key}) : super(key: key);

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearchVisible
            ? _buildSearchField()
            : const Text(
                'Navigation Book'), // Menampilkan kotak pencarian atau judul aplikasi sesuai keadaan pencarian
        actions:
            _buildAppBarActions(), // Menampilkan tombol pencarian atau tombol kembali jika sedang dalam mode pencarian
      ),
      body: Center(
        // child: navBarItems[_selectedIndex].title,
        child: _getPage(_selectedIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: navBarItems,
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search...',
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearchVisible) {
      return [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              _isSearchVisible =
                  false; // Mengubah keadaan pencarian menjadi false saat tombol kembali ditekan
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _performSearch(_searchController
                .text); // Menjalankan fungsi pencarian saat tombol pencarian ditekan
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearchVisible =
                  true; // Mengubah keadaan pencarian menjadi true saat tombol pencarian ditekan
            });
          },
        ),
      ];
    }
  }

  void _performSearch(String query) {
    query = query.toLowerCase();

    List<String> pageTitles = [
      'home',
      'book',
      'history',
      'profile',
    ];

    int index = pageTitles.indexWhere((title) => title == query);
    if (index != -1) {
      setState(() {
        _selectedIndex = index;
        _isSearchVisible = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No matching result found.')),
      );
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return BookPage();
      case 2:
        return HistoryPage();
      case 3:
        return ProfilePage();
      default:
        return Container();
    }
  }

  final List<SalomonBottomBarItem> navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.purple,
      unselectedColor: Colors.grey,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.book_online_outlined),
      title: const Text("Book"),
      selectedColor: Colors.pink,
      unselectedColor: Colors.grey,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.history_outlined),
      title: const Text("History"),
      selectedColor: Colors.orange,
      unselectedColor: Colors.grey,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person),
      title: const Text("Profile"),
      selectedColor: Colors.teal,
      unselectedColor: Colors.grey,
    ),
  ];
}
