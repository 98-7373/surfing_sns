import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/presentation/surf_list/surf_model.dart';
import 'package:surfing_sns/presentation/widget/surf_card.dart';

class SurfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SurfModel>(
      create: (BuildContext context) => SurfModel(),
      child: Consumer<SurfModel>(
          builder: (BuildContext context, SurfModel model, Widget child) {
            return Scaffold(
              appBar: AppBar(
              ),
              body: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ExpansionTileCard(
                      leading: CircleAvatar(child: Text('')),
                      title: Text('北海道'),
                      subtitle: Text('9ポイント'),
                      children: <Widget>[
                        Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Card(
                              child: Expanded(
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Text('佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                    InkWell(
                                      child: Text(' 佐原'),
                                      onTap: () {

                                      },
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_downward),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text('Open'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {

                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text('Close'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.swap_vert),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text('Toggle'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ExpansionTileCard(
                      leading: CircleAvatar(child: Text('B')),
                      title: Text('Tap me!'),
                      subtitle: Text('I expand, too!'),
                      children: <Widget>[
                        Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

Use me any time you think your app could benefit from being just a bit more Material.

These buttons control the card above!""",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_downward),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text('Open'),
                                ],
                              ),
                            ),
                            TextButton(

                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text('Close'),
                                ],
                              ),
                            ),
                            TextButton(

                              onPressed: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.swap_vert),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text('Toggle'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

      ),
    );
  }
}
