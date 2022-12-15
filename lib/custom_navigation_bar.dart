import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<Widget> _destinations = [
    const NavigationDestination(icon: Icon(Icons.home), label: 'Home')
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(destinations: _destinations);
  }
}
