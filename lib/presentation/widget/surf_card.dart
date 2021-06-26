import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';


class SurfCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      //baseColor: Theme.of(context).cardTheme.color,
      baseColor: Theme.of(context).cardColor,
      initialPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      finalPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      borderRadius: BorderRadius.circular(20),
      initialElevation: 2.0,
      contentPadding: const EdgeInsets.only(right: 5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            ],
          ),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 20.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 20,
                ),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                        const Text('なし'),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 20,
                ),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.account_circle,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                        const Text('なし'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}