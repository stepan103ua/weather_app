import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/favorite_cities_provider.dart';
import 'package:weather_app/widgets/favorites/favorites_grid_item.dart';
import 'package:weather_app/widgets/favorites/search_text_field.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: EdgeInsets.only(
            left: constraints.maxWidth * 0.05,
            right: constraints.maxWidth * 0.05,
            top: constraints.maxHeight * 0.03,
          ),
          child: Column(
            children: [
              const SearchTextField(),
              SizedBox(height: constraints.maxHeight * 0.03),
              Expanded(
                child: Consumer<FavoriteCitiesProvider>(
                  builder: (context, value, child) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: constraints.maxWidth * 0.45,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      final cityData = value.items[index];
                      return FavoritesGridItem(
                        key: ValueKey(cityData.id),
                        id: cityData.id,
                        temperature: cityData.temperatureFormatted,
                        iconPath: cityData.iconPath,
                        city: cityData.city,
                        country: cityData.country,
                        humidity: cityData.humidity,
                        windSpeed: cityData.windSpeedFormatted,
                      );
                    },
                    itemCount: value.items.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
