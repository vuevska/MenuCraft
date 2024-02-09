import 'package:flutter/material.dart';
import 'package:menu_craft/widgets/appbar/custom_appbar.dart';
import 'package:menu_craft/widgets/search_page/search_input.dart';
import '../widgets/search_page/filter_menus.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         color: Theme.of(context).primaryColor,
//         child: const Column(
//           children: [
//             SearchBarCustom(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).primaryColor,
        child: const Column(
          children: [
            SearchBarCustom(),
            // Expanded(
            //   child: FilterRestaurants(),
            // ),
          ],
        ),
      ),
    );
  }
}
