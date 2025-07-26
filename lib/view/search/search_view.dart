import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
