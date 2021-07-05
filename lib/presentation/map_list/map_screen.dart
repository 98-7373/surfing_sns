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
//神奈川エリア　
//
