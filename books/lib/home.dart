// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:books/helper/utils/drawer.dart';
import 'package:books/model/list.dart';
import 'package:books/view/about.dart';
import 'package:books/view/category.dart';
import 'package:books/view/setting.dart';
import 'package:flutter/material.dart';

class CodeOfCivilProcedureList extends StatefulWidget {
  final void Function() onToggleDarkMode;
  final bool isDarkMode;

  const CodeOfCivilProcedureList({
    Key? key,
    required this.onToggleDarkMode,
    required this.isDarkMode,
  }) : super(key: key);

  @override
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
            selectedLanguage: '',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            widget.isDarkMode ? Colors.black : const Color(0xFF8B4513),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 0 ? 1.3 : 1.0,
              child: const Icon(Icons.home),
            ),
            label: 'Home',
            activeIcon: Transform.scale(
              scale: 1.3,
              child: const Icon(Icons.home, color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 1 ? 1.3 : 1.0,
              child: const Icon(Icons.category),
            ),
            label: 'Category',
            activeIcon: Transform.scale(
              scale: 1.3,
              child: const Icon(Icons.category, color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 2 ? 1.3 : 1.0,
              child: const Icon(Icons.settings),
            ),
            label: 'Settings',
            activeIcon: Transform.scale(
              scale: 1.3,
              child: const Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            widget.isDarkMode ? 'assets/black.png' : 'assets/old1.png',
            fit: BoxFit.cover,
          ),
        ),
        ListView.separated(
          itemCount: _filteredSections.length,
          separatorBuilder: (context, index) => Divider(
            color: widget.isDarkMode ? Colors.white30 : Colors.black26,
            thickness: 1.0,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _filteredSections[index]['title']!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  if (_filteredSections[index]['subtitle']!.isNotEmpty)
                    Text(
                      _filteredSections[index]['subtitle']!,
                      style: TextStyle(
                        fontSize: 14.0,
                        color:
                            widget.isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
