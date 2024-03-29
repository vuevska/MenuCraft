import 'package:flutter/material.dart';

import 'filter_menus.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({super.key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  late TextEditingController _searchController;
  bool _isListVisible = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.purple.shade50,
          ),
          child: TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            onTap: () {
              setState(() {
                _isListVisible = true;
              });
              // Open the keyboard
              _focusNode.requestFocus();
            },
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by name...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Visibility(
          visible: _isListVisible,
          child: Container(
            height: 500,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.purple.shade50.withOpacity(0.0),
            ),
            child: FilterRestaurants(searchQuery: _searchController.text),
          ),
        ),
      ],
    );
  }
}
