import 'dart:async';

import 'package:Radios/pages/fav_radios_page.dart';
import 'package:Radios/pages/smart_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:Radios/models/radio.dart';
import 'package:Radios/services/player_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:Radios/pages/smart_screen.dart';

import 'now_playing_template.dart';
import 'radio_row_template.dart';

class RadioPage extends StatefulWidget {
  final bool isFavouriteOnly;
  RadioPage({Key key, this.isFavouriteOnly}) : super(key: key);

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;
  AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    var playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    playerProvider.initAudioPlugin();
    playerProvider.resetStreams();
    playerProvider.fetchAllRadios(isFavouriteOnly: this.widget.isFavouriteOnly);

    _searchQuery.addListener(_onSearchChanged);
  }

  // void _initAudioPlayer() {
  //   var audioPlayerBloc = Provider.of<PlayerProvider>(context, listen: false);

  //   if (audioPlayerBloc.getPlayerState() == RadioPlayerState.STOPPED) {
  //     _audioPlayer = new AudioPlayer();
  //   } else {
  //     _audioPlayer =
  //         Provider.of<PlayerProvider>(context, listen: false).getAudioPlayer();
  //   }
  // }

  _onSearchChanged() {
    var radiosBloc = Provider.of<PlayerProvider>(context, listen: false);

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      radiosBloc.fetchAllRadios(
        isFavouriteOnly: this.widget.isFavouriteOnly,
        searchQuery: _searchQuery.text,
      );
    });
  }

  RadioModel radioModel = new RadioModel(
    id: 1,
    radioName: "Test Radio 1",
    radioDesc: "Test Radio Desc",
    radioPic: "http://isharpeners.com/sc_logo.png",
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(227, 255, 229, 236),
      child: Container(
        child: Column(
          children: [
            _appBar(),
            _appLogo(),
            //_searchBar(),
            sections(),
            _radiosList(),
            _nowPlaying()
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Color.fromARGB(227, 255, 229, 236),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _appLogo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.radio,
                    size: 20,
                  ),
                  Text(
                    'Radio',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Color.fromARGB(226, 25, 23, 24),
          indent: 0,
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.search),
          new Flexible(
            child: new TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(5),
                hintText: 'Search Radio',
              ),
              controller: _searchQuery,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget sections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 2,
          thickness: 1,
          color: Color.fromARGB(0, 255, 229, 236),
          indent: 0,
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.solidHeart),
          title: Text(
            'Favorite Station',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RadioPage(isFavouriteOnly: true);
          })),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Color.fromARGB(226, 25, 23, 24),
          indent: 0,
        ),
        ListTile(
          leading: Icon(Icons.adf_scanner),
          title: Text(
            'Smart Scans',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SmartScreen();
          })),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Color.fromARGB(226, 18, 1, 6),
          indent: 0,
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Recently Played',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget _noData() {
    String noDataTxt = "";
    bool showTextMessage = false;

    if (this.widget.isFavouriteOnly ||
        (this.widget.isFavouriteOnly && _searchQuery.text.isNotEmpty)) {
      noDataTxt = "No Favorites";
      showTextMessage = true;
    } else if (_searchQuery.text.isNotEmpty) {
      noDataTxt = "No Radio Found";
      showTextMessage = true;
    }

    return Column(
      children: [
        new Expanded(
          child: Center(
            child: showTextMessage
                ? new Text(
                    noDataTxt,
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _radiosList() {
    return Consumer<PlayerProvider>(
      builder: (context, radioModel, child) {
        if (radioModel.totalRecords > 0) {
          return new Expanded(
            child: Padding(
              child: ListView(
                children: <Widget>[
                  ListView.separated(
                      itemCount: radioModel.totalRecords,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioRowTemplate(
                          radioModel: radioModel.allRadio[index],
                          isFavouriteOnlyRadios: this.widget.isFavouriteOnly,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      })
                ],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            ),
          );
        }

        if (radioModel.totalRecords == 0) {
          return new Expanded(
            child: _noData(),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _nowPlaying() {
    var playerProvider = Provider.of<PlayerProvider>(context, listen: true);

    return Visibility(
      visible: playerProvider.getPlayerState() == RadioPlayerState.PLAYING,
      child: NowPlayingTemplate(
        radioTitle: playerProvider.currentRadio.radioName,
        radioImageURL: playerProvider.currentRadio.radioPic,
      ),
    );
  }

  // Widget _radiosList() {
  //   return new FutureBuilder(
  //     future: DBDownloadService.fetchLocalDB(),
  //     builder: (BuildContext context, AsyncSnapshot<List<RadioModel>> radios) {
  //       if (radios.hasData) {
  //         return new Expanded(
  //           child: Padding(
  //             child: ListView(
  //               children: <Widget>[
  //                 ListView.separated(
  //                     itemCount: radios.data.length,
  //                     physics: ScrollPhysics(),
  //                     shrinkWrap: true,
  //                     itemBuilder: (context, index) {
  //                       return RadioRowTemplate(radioModel: radios.data[index]);
  //                     },
  //                     separatorBuilder: (context, index) {
  //                       return Divider();
  //                     })
  //               ],
  //             ),
  //             padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
  //           ),
  //         );
  //       }

  //       return CircularProgressIndicator();
  //     },
  //   );
  // }
}
