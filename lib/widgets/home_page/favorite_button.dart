import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
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
  late AnimationController _controller1;
  late AnimationController _controller2;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setFavorite();
    audioPlayer.audioCache = AudioCache(prefix: '');
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
        icon: Swing(
          manualTrigger: true,
          controller: (controller) => _controller1 = controller,
          duration: const Duration(milliseconds: 700),
          child: Pulse(
            manualTrigger: true,
            controller: (controller) => _controller2 = controller,
            duration: const Duration(milliseconds: 500),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
          ),
        ),
        label: const Text(
          "Add to Favorites",
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
      ),
    );
  }

  void _toggleFavorite() async {

    if(!_isFavorite){
      audioPlayer.play(AssetSource("sounds/pop.mp3"));
      _controller1.reset();
      _controller2.reset();
      _controller1.forward();
      _controller2.forward();

    }else{

      _controller1.reverse(from:_controller1.upperBound);
      _controller2.reverse(from:_controller2.upperBound);
    }

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

  @override
  void dispose() {
    super.dispose();

    audioPlayer.dispose();
  }
}
