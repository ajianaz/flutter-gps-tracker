import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class SyncfusionMapsScreen extends StatefulWidget {
  final String title;

  SyncfusionMapsScreen({
    this.title = "Syncfusion Maps",
    Key? key,
  }) : super(key: key);

  @override
  State<SyncfusionMapsScreen> createState() => _SyncfusionMapsScreenState();
}

class _SyncfusionMapsScreenState extends State<SyncfusionMapsScreen> {
  late List<Model> data;
  late MapShapeSource _mapSource;

  late ThemeData themeData;
  late bool isDesktop;

  @override
  void initState() {
    data = <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          '       New\nSouth Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Colors.red.withOpacity(0.85),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];

    _mapSource = MapShapeSource.asset(
      'assets/json/australia.json',
      shapeDataField: 'STATE_NAME',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].state,
      dataLabelMapper: (int index) => data[index].stateCode,
      shapeColorValueMapper: (int index) => data[index].color,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    isDesktop = themeData.platform == TargetPlatform.macOS ||
        themeData.platform == TargetPlatform.windows ||
        themeData.platform == TargetPlatform.linux;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Container(
        height: 520,
        child: Center(
          child: SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: _mapSource,
                legend: MapLegend(MapElement.shape),
                showDataLabels: true,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text(data[index].stateCode,
                        style: themeData.textTheme.caption!
                            .copyWith(color: themeData.colorScheme.surface)),
                  );
                },
                tooltipSettings: MapTooltipSettings(
                    color: Colors.grey[700], //background color
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Colors.white,
                strokeWidth: 0.5,
                dataLabelSettings: MapDataLabelSettings(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: themeData.textTheme.caption!.fontSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Model {
  Model(this.state, this.color, this.stateCode);

  String state;
  Color color;
  String stateCode;
}
