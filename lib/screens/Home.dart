import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Note.dart';
import '../components/BottomBar.dart';
import '../configs/Consts.dart' as Consts;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  List<Note> _state = [];
  int _lastIndex = 0;
  final dataKey = new GlobalKey();
  final _scrollController = ScrollController();
  AnimationController _hideFabAnimation;
  Animation<Offset> _offsetAnimation;
  File _image;
  final picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    _loadState();
    _hideFabAnimation = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 2.0),
    ).animate(CurvedAnimation(
      parent: _hideFabAnimation,
      curve: Curves.easeInSine,
    ));
    _hideFabAnimation.reverse();
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Like - Dislike', textAlign: TextAlign.right,),
              backgroundColor: Colors.deepPurple,
              automaticallyImplyLeading: false
          ),
          body: Padding(
            padding: EdgeInsets.only(top:0),
            child: ListView(
              children: _listBuilder(),
              controller: _scrollController,
            ),
          ),
          floatingActionButton: SlideTransition(
            child: _floatingButton(),
            position: _offsetAnimation,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomBar(currentIndex: Consts.HOME, refresh: _refresh),
        )
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
      onPressed: () => {
        _addNewEntry()
      },
      tooltip: 'Floating button',
      child: Icon(
          Icons.add
      ),
      backgroundColor: Colors.deepPurple,
    );
  }

  List<Widget>_listBuilder() {
    List<Widget> _list = this._state.asMap().entries.map((MapEntry entry) {
      return _listTileBuilder(entry.key);
    }).toList();
    return _list;
  }

  Widget _listBuilderv2() {
    return ListView.separated(
      itemCount: this._state.length,
      itemBuilder: (context, index) {
        return _listTileBuilderv2(index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          indent: 20,
          endIndent: 20,
        );
      },
    );
  }

  Widget _listTileBuilder(int i) {
    return Dismissible(
      child: Card(
        child: ListTile(
          leading: RawMaterialButton(
            onPressed: () => {
              _like(i)
            },
            child: Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            fillColor: Colors.deepPurple,
            shape: CircleBorder(),
            constraints: BoxConstraints.tight(Size(40, 40)),
          ),
          title: Text('This is line number ${this._state[i].index}'),
          subtitle: Text('Liked ${this._state[i].count} times'),
          trailing: Wrap(
            spacing: 10,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () => {
                  _dislike(i)
                },
                child: Icon(
                  Icons.thumb_down,
                  color: Colors.white,
                ),
                fillColor: Colors.redAccent,
                shape: CircleBorder(),
                constraints: BoxConstraints.tight(Size(40,40)),
              ),
              RawMaterialButton(
                onPressed: () => _openImagePicker(),
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                fillColor: Colors.grey,
                shape: CircleBorder(),
                constraints: BoxConstraints.tight(Size(40,40)),
              )
            ],
          ),
        ),
      ),
      key: new GlobalKey(),
      onDismissed: (d) => {
        _delete(i)
      },
    );
  }

  Widget _listTileBuilderv2(int i) {
    return Dismissible(
      child: ListTile(
        leading: RawMaterialButton(
          onPressed: () => {
            _like(i)
          },
          child: Icon(
            Icons.thumb_up,
            color: Colors.white,
          ),
          fillColor: Colors.deepPurple,
          shape: CircleBorder(),
          constraints: BoxConstraints.tight(Size(40, 40)),
        ),
        title: Text('This is line number ${this._state[i].index}'),
        subtitle: Text('Liked ${this._state[i].count} times'),
        trailing: Wrap(
          spacing: 10,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => {
                _dislike(i)
              },
              child: Icon(
                Icons.thumb_down,
                color: Colors.white,
              ),
              fillColor: Colors.redAccent,
              shape: CircleBorder(),
              constraints: BoxConstraints.tight(Size(40,40)),
            ),
            RawMaterialButton(
              onPressed: () => {
                _delete(i)
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              fillColor: Colors.red,
              shape: CircleBorder(),
              constraints: BoxConstraints.tight(Size(40,40)),
            )
          ],
        ),
      ),
      key: new GlobalKey(),
      onDismissed: (d) => {
        _delete(i)
      },
    );
  }

  _refresh() => _loadState();

  _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final String _stateString = prefs.getString('_state');
    final int _lastIndex = prefs.getInt('_lastIndex');
    if (!['', null].contains(_stateString)) {
      var _state = Note.decodeNotes(_stateString);
      this.setState(() {
        this._state = _state;
        this._lastIndex = _lastIndex != null ? _lastIndex : 0;
      });
    }
  }

  _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    String _state = jsonEncode(this._state);
    prefs.setString('_state', _state);
    prefs.setInt('_lastIndex', _lastIndex);
  }

  _like(int i) {
    this.setState(() => _state[i].count++);
    _saveState();
  }

  _dislike(int i) {
    if (_state[i].count > 0) {
      this.setState(() => _state[i].count--);
    } else {
      _showAlertDislike();
    }
    _saveState();
  }

  _delete(int i) {
    this.setState(() {
      _state.removeAt(i);
    });
    _saveState();
  }

  _addNewEntry() {
    this.setState(() {
      _state = _state..add(new Note(_lastIndex + 1, 0));
      _lastIndex++;
      _saveState();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.linear
      );
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
        _hideFabAnimation.reverse();
      } else {
        _hideFabAnimation.forward();
      }
    });
  }

  Future _openImagePicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _showPickedImage();
    }
  }

//  _reset() => this.setState(() => this._lastIndex = 0);

  Future _showAlertDislike() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Like is already at 0'),
            content: Image.asset('assets/images/pony.gif'),
          );
        }
    );
  }

  Future _showPickedImage() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: Text('Selected image'),
              content: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image(
                  image: FileImage(
                    _image,
                  ),
                ),
              )
          );
        }
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
          case ScrollDirection.reverse:
            _hideFabAnimation.forward();
            break;
          case ScrollDirection.idle:
            if (_scrollController.offset != _scrollController.position.maxScrollExtent) {
              _hideFabAnimation.reverse();
            } else {
              _hideFabAnimation.forward();
            }
            break;
        }
      }
    }
    return false;
  }
}