import "dart:developer";
import 'package:devstash/models/request/favoriteRequest.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteButton extends StatefulWidget {
  bool found;
  final String id;
  final int index;
  final dynamic onDelete;
  FavoriteButton(
      {required this.id,
      required this.found,
      required this.onDelete,
      required this.index});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  void toggleFound() {
    setState(() {
      widget.found = !widget.found;
      if (widget.onDelete != null) {
        if (!widget.found) {
          widget.onDelete(widget.index);
          Navigator.pop(context);
        }
      }
    });
  }

  Future<void> _updateFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      String action = "add";
      if (widget.found) {
        action = "remove";
      }
      await FavoriteServices()
          .updateFavorite(FavoriteRequest(action, widget.id), token)
          .then((value) => {toggleFound()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(11)),
        color: Color.fromARGB(255, 174, 183, 254),
      ),
      child: GestureDetector(
        onTap: () {
          _updateFavorite();
        },
        child: Icon(
          Icons.star_rounded,
          color: widget.found
              ? const Color.fromARGB(255, 254, 237, 89)
              : const Color.fromARGB(223, 223, 220, 220),
          size: 40,
        ),
      ),
    );
  }
}
