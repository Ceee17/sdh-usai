import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/zone_data.dart';
import 'package:uas/widgets/grid.dart';

class ChooseZonePage extends StatefulWidget {
  const ChooseZonePage({super.key});

  @override
  State<ChooseZonePage> createState() => _ChooseZonePageState();
}

class _ChooseZonePageState extends State<ChooseZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Zone",
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: warningBox,
                child: Column(
                  children: [
                    Text("Warning!!!", style: warningText),
                    Text(
                      "Make sure you are in the right zone before ordering",
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ],
                ),
              ),
              h(20),
              Text(
                "Zone List",
                style: headerText(24),
              ),
              h(20),
              Expanded(
                child: buildZoneGrid(context, zoneData, ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
