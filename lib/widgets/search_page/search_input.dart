import 'package:flutter/material.dart';
import 'package:menu_craft/models/restaurant_model.dart';
import '../appbar/custom_appbar.dart';

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
  bool _isListVisible = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isListVisible = !_isListVisible;
            });
            if (_isListVisible) {
              Future.delayed(Duration(milliseconds: 100), () {
                FocusScope.of(context).requestFocus(_focusNode);
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
              color: Colors.purple.shade50,
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                SizedBox(width: 8.0),
                Text('Search...'),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Visibility(
          visible: _isListVisible,
          child: Container(
            height: 300, // Adjust height according to your need
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
              color: Colors.purple.shade50,
            ),
            child: ListView.builder(
              itemCount: 10, // Adjust itemCount according to your list
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                  onTap: () {
                    // Handle item tap
                  },
                );
              },
            ),
          ),
        ),
        // Hidden text field used for opening the keyboard
        // when the search bar is tapped
        Opacity(
          opacity: 0.0,
          child: TextField(
            focusNode: _focusNode,
          ),
        ),
      ],
    );
  }
}


