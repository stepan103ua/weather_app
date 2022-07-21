import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/providers/favorite_cities_provider.dart';
import 'package:weather_app/widgets/general/custom_progress_indicator.dart';

class FavoriteGridItemRemove extends StatefulWidget {
  const FavoriteGridItemRemove(
      {Key? key, required this.width, required this.height, required this.id})
      : super(key: key);
  final double width, height;
  final String id;

  @override
  State<FavoriteGridItemRemove> createState() => _FavoriteGridItemRemoveState();
}

class _FavoriteGridItemRemoveState extends State<FavoriteGridItemRemove> {
  var _isRemoving = false;

  void remove() async {
    setState(() {
      _isRemoving = true;
    });
    await Provider.of<FavoriteCitiesProvider>(context, listen: false)
        .removeItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24.0),
          splashColor: Colors.pink,
          onTap: remove,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.pink,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24.0),
            ),
            padding: EdgeInsets.all(widget.width * 0.1),
            child: Container(
              height: widget.width * 0.3,
              width: widget.width * 0.3,
              alignment: Alignment.center,
              child: _isRemoving
                  ? const CustomProgressIndicator()
                  : Icon(
                      Icons.delete_rounded,
                      color: Colors.pink,
                      size: widget.width * 0.2,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
