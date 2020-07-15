import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/models/AppState.dart';
import 'package:test/redux/actions.dart';

import '../models/Note.dart';
//import 'package:test/models/NoteProvider.dart';
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
//    _loadState();
    _hideFabAnimation = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 3.0),
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
            child: _listBuilderv2(),
//            child: Container(),
          ),
          floatingActionButton: SlideTransition(
            child: _floatingButton(),
            position: _offsetAnimation,
          ),
          bottomNavigationBar: BottomBar(currentIndex: Consts.HOME, refresh: _refresh),
        )
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
      onPressed: () => _addNewEntry(),
      tooltip: 'Floating button',
      child: Icon(
          Icons.add
      ),
      backgroundColor: Colors.deepPurple,
    );
  }

  Widget _listBuilderv2() {
    return StoreConnector<AppState, List<Note>>(
      converter: (store) => store.state.notes,
      builder: (context, notes) {
        List<Widget> _list = notes.map(
            (note) => _listTileBuilder(note)
        ).toList();
        return ListView(
          children: _list,
          controller: _scrollController,
        );
      },
    );
  }

  Widget _listTileBuilder(Note note) {
    return Dismissible(
      child: Card(
        child: ListTile(
          leading: RawMaterialButton(
            onPressed: () => _like(note.index),
            child: Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            fillColor: Colors.deepPurple,
            shape: CircleBorder(),
            constraints: BoxConstraints.tight(Size(40, 40)),
          ),
          title: Text('This is line number ${note.index}'),
          subtitle: Text('Liked ${note.count} times'),
          trailing: Wrap(
            spacing: 10,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () => _dislike(note.index),
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
      onDismissed: (d) => _delete(note.index),
    );
  }

  Widget _listTileBuilderv2(int i) {
    return Dismissible(
      child: ListTile(
        leading: RawMaterialButton(
          onPressed: () => {
            null
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
                null
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
                null
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
        null
      },
    );
  }

  _refresh() => null;

  _addNewEntry() {
    final store = StoreProvider.of<AppState>(context);
    final int lastIndex = store.state.lastIndex;
    store.dispatch(AddNoteAction(Note(lastIndex + 1, 0)));
    store.dispatch(UpdateLastIndexAction());
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

  _like(int index) {
    StoreProvider.of<AppState>(context).dispatch(LikeNoteAction(index));
  }

  _dislike(int index) {
    StoreProvider.of<AppState>(context).dispatch(DislikeNoteAction(index));
  }

  _delete(int index) {
    StoreProvider.of<AppState>(context).dispatch(DeleteNoteAction(index));
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