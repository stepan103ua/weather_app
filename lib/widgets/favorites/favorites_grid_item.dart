import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/favorites/favorite_grid_item_info.dart';
import 'package:weather_app/widgets/favorites/favorite_grid_item_remove.dart';
import 'package:weather_app/widgets/general/icon_with_text.dart';
import 'package:weather_icons/weather_icons.dart';

class FavoritesGridItem extends StatefulWidget {
  const FavoritesGridItem({
    Key? key,
    required this.temperature,
    required this.iconPath,
    required this.city,
    required this.country,
    required this.humidity,
    required this.windSpeed,
    required this.id,
  }) : super(key: key);

  final String id;
  final String temperature;
  final String iconPath;
  final String city;
  final String country;
  final String humidity;
  final String windSpeed;

  @override
  State<FavoritesGridItem> createState() => _FavoritesGridItemState();
}

class _FavoritesGridItemState extends State<FavoritesGridItem> {
  var _isRemoveMode = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: BoxDecoration(
          color: Constants.gridContainerColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24.0),
            splashColor: Colors.black38,
            onLongPress: () {
              setState(() {
                _isRemoveMode = !_isRemoveMode;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(constraints.maxWidth * 0.1),
              child: _isRemoveMode
                  ? FavoriteGridItemRemove(
                      id: widget.id,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight)
                  : FavoriteGridItemInfo(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      temperature: widget.temperature,
                      iconPath: widget.iconPath,
                      city: widget.city,
                      country: widget.country,
                      humidity: widget.humidity,
                      windSpeed: widget.windSpeed,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
