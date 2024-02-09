import 'package:flutter/material.dart';

import 'filter_menus.dart';



class SearchBarCustom extends StatefulWidget {
   const SearchBarCustom({Key? key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  late TextEditingController _searchController;
  bool _isListVisible = false;
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
                _isListVisible = !_isListVisible;
              });
              // Open the keyboard
              _focusNode.requestFocus();
            },
            onChanged: (value) {
              //TODO: Implement filtering logic here
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by name...',
              border: InputBorder.none,
              // Style customization for the text field
              hintStyle: TextStyle(color: Colors.black54),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Visibility(
          visible: _isListVisible,
          child: Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.purple.shade50.withOpacity(0.0),
            ),
            child: const FilterRestaurants(),
          ),
        ),
      ],
    );
  }
}
