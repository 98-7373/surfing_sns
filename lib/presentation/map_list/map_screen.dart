import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          // _zoomminusfunction(),
          // _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.zoom_out, color: Color(0xfff30a0a)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.zoom_in, color: Color(0xfff30a0a)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(35.679888, 139.703203), zoom: zoomVal,
    )));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(35.679888, 139.703203), zoom: zoomVal,
    )));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: _boxes(
                  "https://cdn-ak.f.st-hatena.com/images/fotolife/O/ONOYUGO/20140831/20140831223644.jpg",
                  35.534457,
                  140.462551,
                  "片貝漁港"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes2(
                  "http://blog-imgs-43.fc2.com/s/u/r/surf810/P1030124.jpg",
                  35.531354,
                  140.458156,
                  "片貝新堤"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes3(
                  "https://bosoalternativelife.com/wp-content/uploads/64A49FE9F1ABD54999CDFA9C89AD710E.jpg",
                  35.336133,
                  140.396002,
                  "志田下(オリンピック会場)"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _boxes2(String _image, double lat, double long,
      String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer2(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _boxes3(String _image, double lat, double long,
      String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer3(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName,
                style: TextStyle(
                    color: Color(0xffd20f0f),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.5",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(1173)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "初級者にオススメ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "東京方面からのアクセスが\n最も良いポイントの一つ",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget myDetailsContainer2(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName,
                style: TextStyle(
                    color: Color(0xffd20f0f),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "3.5",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(247)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "中級者にオススメ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "片貝全般に癖の少ないイージーなブレイクが中心で\n"
                  "波もコンスタントにあり\n各種テクニックの練習に適している。",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget myDetailsContainer3(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName,
                style: TextStyle(
                    color: Color(0xffd20f0f),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(3428)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "上級者にオススメ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "別名｢釣が崎｣とも。千葉の｢波乗り道場｣\nと呼ばれるこのポイントは全国的にも有名\n2021年オリンピック会場にも認定されている",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
        CameraPosition(target: LatLng(35.679888, 139.703203), zoom: 5),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          chiba1Marker,
          chiba2Marker,
          chiba3Marker,
          chiba4Marker,
          chiba5Marker,
          chiba6Marker,
          chiba8Marker,
          chiba9Marker,
          chiba10Marker,
          chiba11Marker,
          chiba12Marker,
          chiba13Marker,
          chiba14Marker,
          chiba15Marker,
          chiba16Marker,
          chiba17Marker,
          chiba18Marker,
          chiba19Marker,
          chiba20Marker,
          chiba21Marker,
          chiba22Marker,
          chiba23Marker,
          chiba24Marker,
          chiba25Marker,
          chiba26Marker,
          chiba27Marker,
          chiba28Marker,
          chiba29Marker,
          chiba30Marker,
          chiba31Marker,
          chiba32Marker,
          chiba33Marker,
          chiba34Marker,
          chiba35Marker,
          chiba36Marker,
          chiba37Marker,
          chiba38Marker,
          chiba39Marker,
          chiba40Marker,
          chiba41Marker,
          chiba42Marker,
          chiba43Marker,
          chiba44Marker,
          chiba45Marker,
          chiba46Marker,
          chiba47Marker,
          chiba48Marker,
          chiba49Marker,
          chiba50Marker,
          chiba51Marker,
          chiba52Marker,
          chiba53Marker,
          chiba54Marker,
          chiba55Marker,
          chiba56Marker,
          chiba57Marker,
          chiba58Marker,
          chiba59Marker,
          chiba60Marker,
          chiba61Marker,
          chiba62Marker,
          chiba63Marker,
          chiba64Marker,
          chiba65Marker,
          chiba66Marker,
          chiba67Marker,
          chiba68Marker,
          chiba69Marker,
          chiba70Marker,
          chiba71Marker,
          chiba72Marker,
          chiba73Marker,
          chiba74Marker,
          chiba75Marker,
          chiba76Marker,
        //  神奈川エリア
          kanagawa1Marker,
          kanagawa2Marker,
          kanagawa3Marker,
          kanagawa4Marker,
          kanagawa5Marker,
          kanagawa6Marker,
          kanagawa7Marker,
          kanagawa8Marker,
          kanagawa9Marker,
          kanagawa10Marker,
          kanagawa11Marker,
          kanagawa12Marker,
          kanagawa13Marker,
          kanagawa14Marker,
          kanagawa15Marker,
          kanagawa16Marker,
          kanagawa17Marker,
          kanagawa18Marker,
          kanagawa19Marker,
          kanagawa20Marker,
          kanagawa21Marker,
          kanagawa22Marker,
          kanagawa23Marker,
          kanagawa24Marker,
          kanagawa25Marker,
          kanagawa26Marker,
          kanagawa27Marker,
          kanagawa28Marker,
          kanagawa29Marker,
          kanagawa30Marker,
          kanagawa31Marker,
          kanagawa32Marker,
          kanagawa33Marker,
          kanagawa34Marker,
          kanagawa35Marker,
          kanagawa36Marker,
          kanagawa37Marker,
          kanagawa38Marker,
          kanagawa39Marker,
          kanagawa40Marker,
          kanagawa41Marker,
          kanagawa42Marker,
          kanagawa43Marker,
          kanagawa44Marker,
          kanagawa45Marker,
          kanagawa46Marker,
          kanagawa47Marker,
          kanagawa48Marker,
          kanagawa49Marker,
        //  茨城
          ibaraki1Marker,
          ibaraki2Marker,
          ibaraki3Marker,
          ibaraki4Marker,
          ibaraki5Marker,
          ibaraki6Marker,
          ibaraki7Marker,
          ibaraki8Marker,
          ibaraki9Marker,
          ibaraki10Marker,
          ibaraki11Marker,
          ibaraki12Marker,
          ibaraki13Marker,
          ibaraki14Marker,
          ibaraki15Marker,
          ibaraki16Marker,
          ibaraki17Marker,
          ibaraki18Marker,
          ibaraki19Marker,
          ibaraki20Marker,
          ibaraki21Marker,
          ibaraki22Marker,
          ibaraki23Marker,
          ibaraki24Marker,
          ibaraki25Marker,
          ibaraki26Marker,
          ibaraki27Marker,
          ibaraki28Marker,
          ibaraki29Marker,
          ibaraki30Marker,
          ibaraki31Marker,
          ibaraki32Marker,
          ibaraki33Marker,
          ibaraki34Marker,

        },
      ),
    );
  }

}
//千葉北エリア 79
Marker chiba5Marker = Marker(
  markerId: MarkerId('片貝新堤'),
  position: LatLng(35.531354, 140.458156),
  infoWindow: InfoWindow(title: '片貝新堤'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba6Marker = Marker(
  markerId: MarkerId('片貝漁港'),
  position: LatLng(35.534457, 140.462551),
  infoWindow: InfoWindow(title: '片貝漁港'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba7Marker = Marker(
  markerId: MarkerId('志田下(オリンピック会場)'),
  position: LatLng(35.336133, 140.396002),
  infoWindow: InfoWindow(title: '志田下(オリンピック会場)'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba1Marker = Marker(
  markerId: MarkerId('一宮'),
  position: LatLng(35.372330, 140.391619),
  infoWindow: InfoWindow(title: '一宮'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba2Marker = Marker(
  markerId: MarkerId('岩和田'),
  position: LatLng(35.181070, 140.363735),
  infoWindow: InfoWindow(title: '岩和田'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba3Marker = Marker(
  markerId: MarkerId('マルキ'),
  position: LatLng(35.120418, 140.131858),
  infoWindow: InfoWindow(title: 'マルキ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba4Marker = Marker(
  markerId: MarkerId('君ケ浜'),
  position: LatLng(35.714696, 140.865733),
  infoWindow: InfoWindow(title: '君ケ浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba8Marker = Marker(
  markerId: MarkerId('銚子マリーナ'),
  position: LatLng(35.70736, 140.8398),
  infoWindow: InfoWindow(title: '銚子マリーナ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba9Marker = Marker(
  markerId: MarkerId('崖下'),
  position: LatLng(35.71299, 140.81482),
  infoWindow: InfoWindow(title: '崖下'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba10Marker = Marker(
  markerId: MarkerId('飯岡漁港'),
  position: LatLng(35.69215, 140.73768),
  infoWindow: InfoWindow(title: '飯岡漁港'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba11Marker = Marker(
  markerId: MarkerId('みなと公園'),
  position: LatLng(35.69373, 140.72683),
  infoWindow: InfoWindow(title: 'みなと公園'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba12Marker = Marker(
  markerId: MarkerId('飯岡メイン'),
  position: LatLng(35.70082, 140.71595),
  infoWindow: InfoWindow(title: '飯岡メイン'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba13Marker = Marker(
  markerId: MarkerId('飯岡'),
  position: LatLng(35.70131, 140.71041),
  infoWindow: InfoWindow(title: '飯岡'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba14Marker = Marker(
  markerId: MarkerId('飯岡河口'),
  position: LatLng(35.70026,140.69383),
  infoWindow: InfoWindow(title: '飯岡河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker chiba15Marker = Marker(
  markerId: MarkerId('椎名内'),
  position: LatLng(35.69303, 140.66641),
  infoWindow: InfoWindow(title: '椎名内'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba16Marker = Marker(
  markerId: MarkerId('かんぽ前'),
  position: LatLng(35.68691, 140.65233),
  infoWindow: InfoWindow(title: 'かんぽ前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba17Marker = Marker(
  markerId: MarkerId('旭'),
  position: LatLng(35.68252, 140.64206),
  infoWindow: InfoWindow(title: '旭'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba18Marker = Marker(
  markerId: MarkerId('吉崎浜'),
  position: LatLng(35.6691, 140.61879),
  infoWindow: InfoWindow(title: '吉崎浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba19Marker = Marker(
  markerId: MarkerId('野手浜'),
  position: LatLng(35.65594, 140.59818),
  infoWindow: InfoWindow(title: '野手浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba20Marker = Marker(
  markerId: MarkerId('今泉・新堀川'),
  position: LatLng(35.64521, 140.58266),
  infoWindow: InfoWindow(title: '今泉・新堀川'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba21Marker = Marker(
  markerId: MarkerId('堀川浜'),
  position: LatLng(35.63471, 140.56926),
  infoWindow: InfoWindow(title: '堀川浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba22Marker = Marker(
  markerId: MarkerId('本須賀'),
  position: LatLng(35.55001, 1140.4707),
  infoWindow: InfoWindow(title: '本須賀'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba23Marker = Marker(
  markerId: MarkerId('作田'),
  position: LatLng(35.54486, 140.46733),
  infoWindow: InfoWindow(title: '作田'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba24Marker = Marker(
  markerId: MarkerId('豊海'),
  position: LatLng(35.51154, 140.43776),
  infoWindow: InfoWindow(title: '豊海'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba25Marker = Marker(
  markerId: MarkerId('白子'),
  position: LatLng(35.44678, 140.40511),
  infoWindow: InfoWindow(title: '白子'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba26Marker = Marker(
  markerId: MarkerId('中里'),
  position: LatLng(35.43133, 140.40021),
  infoWindow: InfoWindow(title: '中里'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba27Marker = Marker(
  markerId: MarkerId('サンライズ'),
  position: LatLng(35.35455, 140.39147),
  infoWindow: InfoWindow(title: 'サンライズ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker chiba28Marker = Marker(
  markerId: MarkerId('東浪見'),
  position: LatLng(35.34892, 140.39219),
  infoWindow: InfoWindow(title: '東浪見'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba29Marker = Marker(
  markerId: MarkerId('夷隅河口'),
  position: LatLng(35.29584, 140.4091),
  infoWindow: InfoWindow(title: '夷隅河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba30Marker = Marker(
  markerId: MarkerId('夷隅'),
  position: LatLng(35.29293, 140.40706),
  infoWindow: InfoWindow(title: '夷隅'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba31Marker = Marker(
  markerId: MarkerId('大原'),
  position: LatLng(35.26047, 140.3992),
  infoWindow: InfoWindow(title: '大原'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba32Marker = Marker(
  markerId: MarkerId('大原河口'),
  position: LatLng(35.25816, 140.40083),
  infoWindow: InfoWindow(title: '大原河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba33Marker = Marker(
  markerId: MarkerId('木戸浜'),
  position: LatLng(35.61422, 140.54062),
  infoWindow: InfoWindow(title: '木戸浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba34Marker = Marker(
  markerId: MarkerId('南浜'),
  position: LatLng(35.58397, 140.50293),
  infoWindow: InfoWindow(title: '南浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba35Marker = Marker(
  markerId: MarkerId('岩船'),
  position: LatLng(35.19992, 140.39032),
  infoWindow: InfoWindow(title: '岩船'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba36Marker = Marker(
  markerId: MarkerId('御宿メイン'),
  position: LatLng(35.18257, 140.35614),
  infoWindow: InfoWindow(title: '御宿メイン'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba37Marker = Marker(
  markerId: MarkerId('御宿漁港'),
  position: LatLng(35.18036, 140.34906),
  infoWindow: InfoWindow(title: '御宿漁港'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba38Marker = Marker(
  markerId: MarkerId('サンドラ下'),
  position: LatLng(35.17265, 140.34414),
  infoWindow: InfoWindow(title: 'サンドラ下'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba39Marker = Marker(
  markerId: MarkerId('部原'),
  position: LatLng(35.1681, 140.33717),
  infoWindow: InfoWindow(title: '部原'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba40Marker = Marker(
  markerId: MarkerId('豊浜'),
  position: LatLng(35.16493, 140.33343),
  infoWindow: InfoWindow(title: '豊浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker chiba41Marker = Marker(
  markerId: MarkerId('新官'),
  position: LatLng(35.15719, 140.332),
  infoWindow: InfoWindow(title: '新官'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba42Marker = Marker(
  markerId: MarkerId('勝浦'),
  position: LatLng(35.15017, 140.30727),
  infoWindow: InfoWindow(title: '勝浦'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba43Marker = Marker(
  markerId: MarkerId('松部'),
  position: LatLng(35.14237, 140.29067),
  infoWindow: InfoWindow(title: '松部'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba44Marker = Marker(
  markerId: MarkerId('鵜原'),
  position: LatLng(35.13551, 140.2766),
  infoWindow: InfoWindow(title: '鵜原'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba45Marker = Marker(
  markerId: MarkerId('城崎海岸'),
  position: LatLng(35.12292, 140.16888),
  infoWindow: InfoWindow(title: '城崎海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba46Marker = Marker(
  markerId: MarkerId('興津'),
  position: LatLng(35.13501, 140.24938),
  infoWindow: InfoWindow(title: '興津'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba47Marker = Marker(
  markerId: MarkerId('グランドホテル前'),
  position: LatLng(35.11072, 140.11356),
  infoWindow: InfoWindow(title: 'グランドホテル前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba48Marker = Marker(
  markerId: MarkerId('東条海岸'),
  position: LatLng(35.11893, 140.12737),
  infoWindow: InfoWindow(title: '東条海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba49Marker = Marker(
  markerId: MarkerId('待崎川河口'),
  position: LatLng(35.10657, 140.10849),
  infoWindow: InfoWindow(title: '待崎川河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba50Marker = Marker(
  markerId: MarkerId('前原'),
  position: LatLng(35.1009, 140.10499),
  infoWindow: InfoWindow(title: '前原'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba51Marker = Marker(
  markerId: MarkerId('京王マンション前'),
  position: LatLng(35.0585, 140.05498),
  infoWindow: InfoWindow(title: '京王マンション前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba52Marker = Marker(
  markerId: MarkerId('和田'),
  position: LatLng(35.04414, 140.02496),
  infoWindow: InfoWindow(title: '和田'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba53Marker = Marker(
  markerId: MarkerId('和田白渚'),
  position: LatLng(35.03008, 140.0005),
  infoWindow: InfoWindow(title: '和田白渚'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba54Marker = Marker(
  markerId: MarkerId('大原駐車場'),
  position: LatLng(35.02523, 139.99485),
  infoWindow: InfoWindow(title: '大原駐車場'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba55Marker = Marker(
  markerId: MarkerId('花籠'),
  position: LatLng(35.02221, 139.9918),
  infoWindow: InfoWindow(title: '花籠'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba56Marker = Marker(
  markerId: MarkerId('丸山川河口'),
  position: LatLng(35.00945, 139.97977),
  infoWindow: InfoWindow(title: '丸山川河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba57Marker = Marker(
  markerId: MarkerId('千歳'),
  position: LatLng(34.99643, 139.97298),
  infoWindow: InfoWindow(title: '千歳'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba58Marker = Marker(
  markerId: MarkerId('瀬戸浜'),
  position: LatLng(34.97752, 139.96749),
  infoWindow: InfoWindow(title: '瀬戸浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba59Marker = Marker(
  markerId: MarkerId('千倉'),
  position: LatLng(34.9649, 139.96027),
  infoWindow: InfoWindow(title: '千倉'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba60Marker = Marker(
  markerId: MarkerId('江見'),
  position: LatLng(35.0593, 140.05907),
  infoWindow: InfoWindow(title: '江見'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba61Marker = Marker(
  markerId: MarkerId('ローズマリー'),
  position: LatLng(35.00633, 139.97752),
  infoWindow: InfoWindow(title: 'ローズマリー'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba62Marker = Marker(
  markerId: MarkerId('根本'),
  position: LatLng(34.90469, 139.83738),
  infoWindow: InfoWindow(title: '根本'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba63Marker = Marker(
  markerId: MarkerId('布良'),
  position: LatLng(34.91304, 139.82483),
  infoWindow: InfoWindow(title: '布良'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba64Marker = Marker(
  markerId: MarkerId('巴・相浜'),
  position: LatLng(34.92634, 139.8271),
  infoWindow: InfoWindow(title: '巴・相浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba65Marker = Marker(
  markerId: MarkerId('ファミリーパーク'),
  position: LatLng(34.94378, 139.81099),
  infoWindow: InfoWindow(title: 'ファミリーパーク'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba66Marker = Marker(
  markerId: MarkerId('アロハガーデンたてやま'),
  position: LatLng(34.93855, 139.81894),
  infoWindow: InfoWindow(title: 'アロハガーデンたてやま'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba67Marker = Marker(
  markerId: MarkerId('いこいの村'),
  position: LatLng(34.9344, 139.82338),
  infoWindow: InfoWindow(title: 'いこいの村'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba68Marker = Marker(
  markerId: MarkerId('アクシオン前'),
  position: LatLng(34.95208, 139.79125),
  infoWindow: InfoWindow(title: 'アクシオン前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba69Marker = Marker(
  markerId: MarkerId('シークレット'),
  position: LatLng(34.95413, 139.78488),
  infoWindow: InfoWindow(title: 'シークレット'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba70Marker = Marker(
  markerId: MarkerId('岩井海岸'),
  position: LatLng(35.08788, 139.84285),
  infoWindow: InfoWindow(title: '岩井海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba71Marker = Marker(
  markerId: MarkerId('保田・元名'),
  position: LatLng(35.14119, 139.83488),
  infoWindow: InfoWindow(title: '保田・元名'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba72Marker = Marker(
  markerId: MarkerId('富津海水浴場'),
  position: LatLng(35.30613, 139.81356),
  infoWindow: InfoWindow(title: '富津海水浴場'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba73Marker = Marker(
  markerId: MarkerId('一松'),
  position: LatLng(35.41313, 140.3948),
  infoWindow: InfoWindow(title: '一松'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba74Marker = Marker(
  markerId: MarkerId('神社下'),
  position: LatLng(35.27543, 140.40092),
  infoWindow: InfoWindow(title: '神社下'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba75Marker = Marker(
  markerId: MarkerId('長谷川荘前'),
  position: LatLng(35.27128, 140.39982),
  infoWindow: InfoWindow(title: '長谷川荘前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker chiba76Marker = Marker(
  markerId: MarkerId('ドン・ロドリゴ'),
  position: LatLng(35.18344, 140.37788),
  infoWindow: InfoWindow(title: 'ドン・ロドリゴ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
//神奈川エリア　49
Marker kanagawa1Marker = Marker(
  markerId: MarkerId('三浦海岸'),
  position: LatLng(35.18649, 139.65703),
  infoWindow: InfoWindow(title: '三浦海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa2Marker = Marker(
  markerId: MarkerId('吉浜'),
  position: LatLng(35.14973, 139.1208),
  infoWindow: InfoWindow(title: '吉浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa3Marker = Marker(
  markerId: MarkerId('鎌高前'),
  position: LatLng(35.30672, 139.50055),
  infoWindow: InfoWindow(title: '鎌高前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa4Marker = Marker(
  markerId: MarkerId('湘南港'),
  position: LatLng(35.30119, 139.48644),
  infoWindow: InfoWindow(title: '湘南港'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa5Marker = Marker(
  markerId: MarkerId('腰越漁港'),
  position: LatLng(35.30715, 139.49221),
  infoWindow: InfoWindow(title: '腰越漁港'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa6Marker = Marker(
  markerId: MarkerId('鵠沼銅像前'),
  position: LatLng(35.31464, 139.47079),
  infoWindow: InfoWindow(title: '鵠沼銅像前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa7Marker = Marker(
  markerId: MarkerId('翔洋中前'),
  position: LatLng(35.31725, 139.45888),
  infoWindow: InfoWindow(title: '翔洋中前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa8Marker = Marker(
  markerId: MarkerId('引地川'),
  position: LatLng(35.31558, 139.46728),
  infoWindow: InfoWindow(title: '引地川'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa9Marker = Marker(
  markerId: MarkerId('スケパー前'),
  position: LatLng(35.31581, 139.46565),
  infoWindow: InfoWindow(title: 'スケパー前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa10Marker = Marker(
  markerId: MarkerId('逗子海岸'),
  position: LatLng(35.29186, 139.57264),
  infoWindow: InfoWindow(title: '逗子海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa11Marker = Marker(
  markerId: MarkerId('材木座'),
  position: LatLng(35.30555, 139.55007),
  infoWindow: InfoWindow(title: '材木座'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa12Marker = Marker(
  markerId: MarkerId('由比ガ浜'),
  position: LatLng(35.30929, 139.54224),
  infoWindow: InfoWindow(title: '由比ガ浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa13Marker = Marker(
  markerId: MarkerId('稲村ガ崎'),
  position: LatLng(35.30279, 139.52372),
  infoWindow: InfoWindow(title: '稲村ガ崎'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa14Marker = Marker(
  markerId: MarkerId('立石'),
  position: LatLng(35.24105, 139.597),
  infoWindow: InfoWindow(title: '立石'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa15Marker = Marker(
  markerId: MarkerId('秋谷海岸'),
  position: LatLng(35.23873, 139.60011),
  infoWindow: InfoWindow(title: '秋谷海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa16Marker = Marker(
  markerId: MarkerId('一色海岸'),
  position: LatLng(35.26358, 139.57671),
  infoWindow: InfoWindow(title: '一色海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa17Marker = Marker(
  markerId: MarkerId('長者ヶ崎'),
  position: LatLng(35.25415, 139.58017),
  infoWindow: InfoWindow(title: '長者ヶ崎'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa18Marker = Marker(
  markerId: MarkerId('大崎'),
  position: LatLng(35.2933, 139.55941),
  infoWindow: InfoWindow(title: '大崎'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa19Marker = Marker(
  markerId: MarkerId('カブネ'),
  position: LatLng(35.29714, 139.55252),
  infoWindow: InfoWindow(title: 'カブネ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa20Marker = Marker(
  markerId: MarkerId('玉石'),
  position: LatLng(35.30288, 139.55226),
  infoWindow: InfoWindow(title: '玉石'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa21Marker = Marker(
  markerId: MarkerId('への字'),
  position: LatLng(35.30444, 139.51351),
  infoWindow: InfoWindow(title: 'への字'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa22Marker = Marker(
  markerId: MarkerId('峰ヶ原'),
  position: LatLng(35.30592, 139.50535),
  infoWindow: InfoWindow(title: '峰ヶ原'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa23Marker = Marker(
  markerId: MarkerId('一本松'),
  position: LatLng(35.3058, 139.49444),
  infoWindow: InfoWindow(title: '一本松'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa24Marker = Marker(
  markerId: MarkerId('恵風園前'),
  position: LatLng(35.30672, 139.4976),
  infoWindow: InfoWindow(title: '恵風園前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa25Marker = Marker(
  markerId: MarkerId('大六'),
  position: LatLng(35.29958, 139.47452),
  infoWindow: InfoWindow(title: '大六'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa26Marker = Marker(
  markerId: MarkerId('水族館前'),
  position: LatLng(35.30898, 139.47965),
  infoWindow: InfoWindow(title: '水族館前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa27Marker = Marker(
  markerId: MarkerId('マクドナルド前'),
  position: LatLng(35.31441, 139.47168),
  infoWindow: InfoWindow(title: 'マクドナルド前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa28Marker = Marker(
  markerId: MarkerId('松波地下道前'),
  position: LatLng(35.31681, 139.4619),
  infoWindow: InfoWindow(title: '松波地下道前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa29Marker = Marker(
  markerId: MarkerId('船前'),
  position: LatLng(35.31791, 139.45455),
  infoWindow: InfoWindow(title: '船前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa30Marker = Marker(
  markerId: MarkerId('辻堂正面'),
  position: LatLng(35.31813, 139.45319),
  infoWindow: InfoWindow(title: '辻堂正面'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa31Marker = Marker(
  markerId: MarkerId('第２駐車場前'),
  position: LatLng(35.3193, 139.44407),
  infoWindow: InfoWindow(title: '第２駐車場前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa32Marker = Marker(
  markerId: MarkerId('汐見台'),
  position: LatLng(35.31971, 139.43516),
  infoWindow: InfoWindow(title: '汐見台'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa33Marker = Marker(
  markerId: MarkerId('チサン'),
  position: LatLng(35.31939, 139.43234),
  infoWindow: InfoWindow(title: 'チサン'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa34Marker = Marker(
  markerId: MarkerId('パーク'),
  position: LatLng(35.31683, 139.4156),
  infoWindow: InfoWindow(title: 'パーク'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa35Marker = Marker(
  markerId: MarkerId('菱沼海岸'),
  position: LatLng(35.31815, 139.41991),
  infoWindow: InfoWindow(title: '菱沼海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa36Marker = Marker(
  markerId: MarkerId('Tバー'),
  position: LatLng(35.31538, 139.41429),
  infoWindow: InfoWindow(title: 'Tバー'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa37Marker = Marker(
  markerId: MarkerId('白樺'),
  position: LatLng(35.31814, 139.40228),
  infoWindow: InfoWindow(title: '白樺'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa38Marker = Marker(
  markerId: MarkerId('茅ヶ崎漁港'),
  position: LatLng(35.31665, 139.39859),
  infoWindow: InfoWindow(title: '茅ヶ崎漁港'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa39Marker = Marker(
  markerId: MarkerId('西浜'),
  position: LatLng(35.31615, 139.39563),
  infoWindow: InfoWindow(title: '西浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa40Marker = Marker(
  markerId: MarkerId('柳島'),
  position: LatLng(35.31641, 139.38497),
  infoWindow: InfoWindow(title: '柳島'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa41Marker = Marker(
  markerId: MarkerId('馬入'),
  position: LatLng(35.31647, 139.37462),
  infoWindow: InfoWindow(title: '馬入'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa42Marker = Marker(
  markerId: MarkerId('相模川河口'),
  position: LatLng(35.31476, 139.36498),
  infoWindow: InfoWindow(title: '相模川河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa43Marker = Marker(
  markerId: MarkerId('虹ケ浜'),
  position: LatLng(35.31421, 139.34103),
  infoWindow: InfoWindow(title: '虹ケ浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa44Marker = Marker(
  markerId: MarkerId('唐ヶ原'),
  position: LatLng(35.31267, 139.33186),
  infoWindow: InfoWindow(title: '唐ヶ原'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa45Marker = Marker(
  markerId: MarkerId('花水川河口'),
  position: LatLng(35.31323, 139.33501),
  infoWindow: InfoWindow(title: '花水川河口'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa46Marker = Marker(
  markerId: MarkerId('高浜台'),
  position: LatLng(35.31521, 139.35977),
  infoWindow: InfoWindow(title: '高浜台'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa47Marker = Marker(
  markerId: MarkerId('磯高前'),
  position: LatLng(35.31106, 139.32486),
  infoWindow: InfoWindow(title: '磯高前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa48Marker = Marker(
  markerId: MarkerId('大磯'),
  position: LatLng(35.30944, 139.31971),
  infoWindow: InfoWindow(title: '大磯'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker kanagawa49Marker = Marker(
  markerId: MarkerId('大磯北浜海岸'),
  position: LatLng(35.31069, 139.32243),
  infoWindow: InfoWindow(title: '大磯北浜海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
//
//茨城エリア
Marker ibaraki1Marker = Marker(
  markerId: MarkerId('二つ島'),
  position: LatLng(36.80572, 140.76243),
  infoWindow: InfoWindow(title: '二つ島'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki2Marker = Marker(
  markerId: MarkerId('高萩'),
  position: LatLng(36.71312, 140.72461),
  infoWindow: InfoWindow(title: '高萩'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki3Marker = Marker(
  markerId: MarkerId('いぶき浜'),
  position: LatLng(36.69507, 140.71708),
  infoWindow: InfoWindow(title: 'いぶき浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki4Marker = Marker(
  markerId: MarkerId('伊師浜'),
  position: LatLng(36.66562, 140.71486),
  infoWindow: InfoWindow(title: '伊師浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki5Marker = Marker(
  markerId: MarkerId('川尻'),
  position: LatLng(36.65203, 140.69989),
  infoWindow: InfoWindow(title: '川尻'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki6Marker = Marker(
  markerId: MarkerId('会瀬'),
  position: LatLng(36.57999, 140.66123),
  infoWindow: InfoWindow(title: '会瀬'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki7Marker = Marker(
  markerId: MarkerId('河原子'),
  position: LatLng(36.54304, 140.6454),
  infoWindow: InfoWindow(title: '河原子'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki8Marker = Marker(
  markerId: MarkerId('水木'),
  position: LatLng(36.51863, 140.63394),
  infoWindow: InfoWindow(title: '水木'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki9Marker = Marker(
  markerId: MarkerId('日立灯台'),
  position: LatLng(36.40308, 140.61144),
  infoWindow: InfoWindow(title: '日立灯台'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki10Marker = Marker(
  markerId: MarkerId('阿字ケ浦'),
  position: LatLng(36.39156, 140.61449),
  infoWindow: InfoWindow(title: '阿字ケ浦'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki11Marker = Marker(
  markerId: MarkerId('大洗'),
  position: LatLng(36.32868, 140.59374),
  infoWindow: InfoWindow(title: '大洗'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki12Marker = Marker(
  markerId: MarkerId('サンビーチ'),
  position: LatLng(36.30258, 140.56764),
  infoWindow: InfoWindow(title: 'サンビーチ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki13Marker = Marker(
  markerId: MarkerId('大貫'),
  position: LatLng(36.29728, 140.56419),
  infoWindow: InfoWindow(title: '大貫'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki14Marker = Marker(
  markerId: MarkerId('玉田'),
  position: LatLng(36.22557, 140.56251),
  infoWindow: InfoWindow(title: '玉田'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki15Marker = Marker(
  markerId: MarkerId('冷水'),
  position: LatLng(36.20903, 140.56566),
  infoWindow: InfoWindow(title: '冷水'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki16Marker = Marker(
  markerId: MarkerId('大竹海岸'),
  position: LatLng(36.16188, 140.57844),
  infoWindow: InfoWindow(title: '大竹海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki17Marker = Marker(
  markerId: MarkerId('岡堀米'),
  position: LatLng(36.15465, 140.58072),
  infoWindow: InfoWindow(title: '岡堀米'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki18Marker = Marker(
  markerId: MarkerId('上沢'),
  position: LatLng(36.10463, 140.6004),
  infoWindow: InfoWindow(title: '上沢'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki19Marker = Marker(
  markerId: MarkerId('汲上'),
  position: LatLng(36.13005, 140.59033),
  infoWindow: InfoWindow(title: '汲上'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki20Marker = Marker(
  markerId: MarkerId('京知釜'),
  position: LatLng(36.09604, 140.60484),
  infoWindow: InfoWindow(title: '京知釜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki21Marker = Marker(
  markerId: MarkerId('角折'),
  position: LatLng(36.03839, 140.63335),
  infoWindow: InfoWindow(title: '角折'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki22Marker = Marker(
  markerId: MarkerId('女神'),
  position: LatLng(36.03368, 140.63581),
  infoWindow: InfoWindow(title: '女神'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki23Marker = Marker(
  markerId: MarkerId('一本松'),
  position: LatLng(35.3058, 139.49444),
  infoWindow: InfoWindow(title: '一本松'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki24Marker = Marker(
  markerId: MarkerId('トップサンテ下'),
  position: LatLng(36.08691, 140.60862),
  infoWindow: InfoWindow(title: 'トップサンテ下'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki25Marker = Marker(
  markerId: MarkerId('明石'),
  position: LatLng(35.99837, 140.6562),
  infoWindow: InfoWindow(title: '明石'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki26Marker = Marker(
  markerId: MarkerId('水族館前'),
  position: LatLng(35.30898, 139.47965),
  infoWindow: InfoWindow(title: '水族館前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki27Marker = Marker(
  markerId: MarkerId('下津'),
  position: LatLng(35.98193, 140.6648),
  infoWindow: InfoWindow(title: '下津'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki28Marker = Marker(
  markerId: MarkerId('平井'),
  position: LatLng(35.97216, 140.671),
  infoWindow: InfoWindow(title: '平井'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki29Marker = Marker(
  markerId: MarkerId('日川浜'),
  position: LatLng(35.8718, 140.73986),
  infoWindow: InfoWindow(title: '日川浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki30Marker = Marker(
  markerId: MarkerId('風車前'),
  position: LatLng(35.8417, 140.76046),
  infoWindow: InfoWindow(title: '風車前'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki31Marker = Marker(
  markerId: MarkerId('シーサイドパーク'),
  position: LatLng(35.78898, 140.80075),
  infoWindow: InfoWindow(title: 'シーサイドパーク'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki32Marker = Marker(
  markerId: MarkerId('舎利浜'),
  position: LatLng(35.77168, 140.81508),
  infoWindow: InfoWindow(title: '舎利浜'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki33Marker = Marker(
  markerId: MarkerId('波崎海岸'),
  position: LatLng(35.75602, 140.82873),
  infoWindow: InfoWindow(title: '波崎海岸'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker ibaraki34Marker = Marker(
  markerId: MarkerId('波崎'),
  position: LatLng(35.75246, 140.83348),
  infoWindow: InfoWindow(title: '波崎'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);