import 'package:flutter/cupertino.dart';
import 'place_data.dart';

class PlacesView extends StatefulWidget {

  final Place _place;

  PlacesView(this._place);

  PlacesViewState createState() => PlacesViewState(_place);
}

class PlacesViewState extends State<PlacesView> {

  Place _place;

  PlacesViewState(this._place);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}