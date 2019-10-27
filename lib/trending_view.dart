import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './place_data.dart';
import './place_view.dart';

class TrendingView extends StatefulWidget {
  @override
  TrendingViewState createState() => TrendingViewState();
}

class TrendingViewState extends State<TrendingView> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('places')
          .orderBy("upvotes", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final place = Place.fromSnapshot(data);
    // TODO FIX HANDLING EXPIRED OPTIONS - THIS IS A TERRIBLE WAY TO DO IT
    if(data["timeToExpire"] < DateTime.now().millisecondsSinceEpoch) {
      return new Container(width:0, height: 0);
    }
    return Padding(
      key: ValueKey(place.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(place.name),
          trailing: Text(place.upvotes.toString() + ((place.upvotes == 1) ? " upvote" : " upvotes")),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (PlaceView(place)),
                )
            );
          },
        ),
      ),
    );
  }
}