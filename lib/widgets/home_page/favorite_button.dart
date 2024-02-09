import 'package:flutter/material.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../../models/providers/favorite_provider.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.purple[50],
        ),
        onPressed: () {
          _toggleFavorite();
        },
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.black,
        ),
        label: const Text(
          "Add to Favorites",
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
      ),
    );
  }

  void _toggleFavorite() async {
    await context.read<FavoriteProvider>().toggleFavorite(
        widget.restaurantId, AuthService.user?.uid ?? 'local', _isFavorite);

    setState(() {
      _isFavorite = !_isFavorite;
    }); //TODO: animacija na srceto
  }

  Future<void> _setFavorite() async {
    final fav = await context
        .read<FavoriteProvider>()
        .isFavorite(widget.restaurantId, AuthService.user?.uid ?? 'local');

    setState(() {
      _isFavorite = fav;
    });
  }
}
