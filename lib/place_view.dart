import 'package:flutter/cupertino.dart';
import 'place_data.dart';

class PlaceView extends StatefulWidget {

  final Place _place;

  PlaceView(this._place);

  PlaceViewState createState() => PlaceViewState(_place);
}

class PlaceViewState extends State<PlaceView> {

  Place _place;

  PlaceViewState(this._place);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}