import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import '../appbar/custom_appbar.dart';
import 'filter_menus.dart';

// class SearchBarCustom extends StatefulWidget {
//   const SearchBarCustom({super.key});
//
//   @override
//   State<SearchBarCustom> createState() => _SearchBarCustomState();
// }
//
// class _SearchBarCustomState extends State<SearchBarCustom> {
//   @override
//   Widget build(BuildContext context) {
//     return SearchAnchor(
//     builder: (BuildContext context, SearchController controller) {
//       return SearchBar(
//         controller: controller,
//         padding: const MaterialStatePropertyAll<EdgeInsets>(
//             EdgeInsets.symmetric(horizontal: 16.0)),
//         onTap: () {
//           controller.openView();
//         },
//         onChanged: (_) {
//           controller.openView();
//         },
//         leading: const Icon(Icons.search),
//         // trailing: <Widget>[
//         // ],
//       );
//     },
//     suggestionsBuilder: (BuildContext context,
//         SearchController controller) {
//       return List<ListTile>.generate(5, (int index) {
//         final String item = 'item $index';
//         return ListTile(
//           title: Text(item),
//           onTap: () {
//             setState(() {
//               controller.closeView(item);
//             });
//           },
//         );
//       });
//     });
//   }
// }



class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({Key? key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  late TextEditingController _searchController;
  bool _isListVisible = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.purple.shade50,
          ),
          child: TextField(
            controller: _searchController,
            onTap: () {
              setState(() {
                _isListVisible = true;
              });
            },
            onChanged: (value) {
              // Implement filtering logic here
              // You can filter restaurants by name using the value entered in the TextField
              // You may need to update the ListRestaurants widget with the filtered list
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by name...',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Visibility(
          visible: _isListVisible,
          child: Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.purple.shade50,
            ),
            child: FilterRestaurants(),
          ),
        ),
        // Hidden text field used for opening the keyboard when the search bar is tapped
        Opacity(
          opacity: 0.0,
          child: TextField(
            controller: _searchController,
          ),
        ),
      ],
    );
  }
}




