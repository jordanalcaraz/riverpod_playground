import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.itemId}) : super(key: key);

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Text('DetailsPage: $itemId');
  }
}
