import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_demo/SortedCollection.dart';
import 'SortedCollection.dart';

class RandomWords extends StatefulWidget {
  @override
  State createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  var _suggestions = <WordPair>[];
  var _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
//    return new Text(new WordPair.random().asCamelCase);
    int sort(Object a, Object b) => 0;
    SortedCollection coll = SortedCollection(sort);

//    if (coll.compare is Function) {
//      print('coll.compare is Function');
//    }

    if(coll.compare is Function){
      print('coll.compare is Function');
    }
    if(coll.compare is Compare){
      print('coll.compare is Compare');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('start up'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                var _tiles = _saved.map((pair) {
                  return ListTile(
                      title: Text(
                    pair.asCamelCase,
                    style: TextStyle(fontSize: 18),
                  ));
                });
                var _divided =
                    ListTile.divideTiles(tiles: _tiles, context: context)
                        .toList();
                return Scaffold(
                  appBar: AppBar(
                    title: Text('saved suggestions'),
                  ),
                  body: ListView(
                    children: _divided,
                  ),
                );
              }));
            },
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _buildPush() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      var _tiles = _saved.map((pair) {
        return ListTile(
            title: Text(
          pair.asCamelCase,
          style: TextStyle(fontSize: 18),
        ));
      });
      var _divided =
          ListTile.divideTiles(tiles: _tiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('saved suggestions'),
        ),
        body: ListView(
          children: _divided,
        ),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          var _index = i ~/ 2;
          if (_index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          var _pair = _suggestions[_index];
          var _alreadySaved = _saved.contains(_pair);
          return ListTile(
            title: Text(
              _pair.asCamelCase,
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(
              _alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: _alreadySaved ? Colors.red : null,
            ),
            onTap: () {
              setState(() {
                _alreadySaved ? _saved.remove(_pair) : _saved.add(_pair);
              });
            },
          );
        });
  }
}
