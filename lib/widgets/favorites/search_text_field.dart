import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../providers/favorite_cities_provider.dart';
import '../general/custom_progress_indicator.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final _textController = TextEditingController();
  var _isSearchingCity = false;
  Future<void> _addFavoriteCity() async {
    String cityName = '';
    setState(() {
      cityName = _textController.text;
      _isSearchingCity = true;
    });

    await Provider.of<FavoriteCitiesProvider>(context, listen: false)
        .addItem(cityName);

    setState(() {
      _isSearchingCity = false;
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      readOnly: _isSearchingCity,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search',
        suffix: _isSearchingCity
            ? const SizedBox(
                width: 20, height: 20, child: CustomProgressIndicator())
            : null,
      ),
      onSubmitted: (cityName) => _addFavoriteCity(),
    );
  }
}
