import 'package:books/model/list.dart';
import 'package:flutter/material.dart';
import 'package:books/view/category.dart';
import 'package:books/view/setting.dart';
import 'package:books/view/about.dart';
import 'package:books/helper/utils/drawer.dart';

class CodeOfCivilProcedureList extends StatefulWidget {
  final void Function() onToggleDarkMode;
  final bool isDarkMode;

  const CodeOfCivilProcedureList({
    super.key,
    required this.onToggleDarkMode,
    required this.isDarkMode,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CodeOfCivilProcedureListState createState() =>
      _CodeOfCivilProcedureListState();
}

class _CodeOfCivilProcedureListState extends State<CodeOfCivilProcedureList>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  bool _isSearching = false;
  String _selectedLanguage = 'English';
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();

  List<Map<String, String>> _filteredSections = [];

  @override
  void initState() {
    super.initState();
    _filteredSections = _getSections();
    _searchController.addListener(_filterSections);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSections);
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; // Ensures the state is kept alive

  void _filterSections() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      _filteredSections = _getSections().where((section) {
        final title = section['title']!.toLowerCase();
        final subtitle = section['subtitle']!.toLowerCase();
        return title.contains(query) || subtitle.contains(query);
      }).toList();
    });
  }

  List<Map<String, String>> _getSections() {
    switch (_selectedLanguage) {
      case 'Marathi':
        return sectionsMarathi;
      case 'Hindi':
        return sectionsHindi;
      default:
        return sectionsEnglish;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSearchIconTapped() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filteredSections = _getSections();
      }
    });
  }

  void _onLanguageSelected(String language) {
    setState(() {
      _selectedLanguage = language;
      _filteredSections = _getSections();
    });
  }

  // ignore: unused_element
  void _navigateToAboutUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
              )
            : const Text(
                'Market',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: _onSearchIconTapped,
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor:
            widget.isDarkMode ? Colors.black : const Color(0xFF8B4513),
      ),
      drawer: DrewerScreen(
        isDarkMode: widget.isDarkMode,
        onToggleDarkMode: widget.onToggleDarkMode,
        onLanguageSelected: _onLanguageSelected, // Pass the callback
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          CategoryPage(
            isDarkMode: widget.isDarkMode,
            selectedLanguage: _selectedLanguage,
          ),
          SettingPage(
            isDarkMode: widget.isDarkMode,
            onToggleDarkMode: widget.onToggleDarkMode,
            selectedLanguage: _selectedLanguage, // Pass the selected language
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor:
            widget.isDarkMode ? Colors.black : const Color(0xFF8B4513),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomePage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          widget.isDarkMode
              ? 'assets/black.png'
              : 'assets/old.png', // Use different images based on dark mode
          fit: BoxFit.cover,
        ),
        // Content on top of the background
        ListView.separated(
          itemCount: _filteredSections.length,
          separatorBuilder: (context, index) => Divider(
            color: widget.isDarkMode
                ? Colors.white70
                : Colors.black26, // Change color based on dark mode
            thickness: 1,
            height: 20, // Adjust height for the gap between items
          ),
          itemBuilder: (context, index) {
            final section = _filteredSections[index];
            return ListTile(
              title: Text(
                section['title']!,
                style: TextStyle(
                    fontSize: 18,
                    color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
              subtitle: Text(
                section['subtitle']!,
                style: TextStyle(
                    fontSize: 16,
                    color: widget.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            );
          },
        ),
      ],
    );
  }
}
