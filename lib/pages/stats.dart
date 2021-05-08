import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Stats extends StatefulWidget {
  final String name, image;
  const Stats({Key key, this.name, this.image}) : super(key: key);
  @override
  _StatsState createState() => _StatsState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('Sad', 35, HexColor('#E2A3FC')),
      ClicksPerYear('Happy', 25, HexColor('#E2A3FC')),
      ClicksPerYear('Angry', 15, HexColor('#E2A3FC')),
      ClicksPerYear('Neutral', 30, HexColor('#E2A3FC')),
    ];

    var weeklyData = [
      ClicksPerYear('Sad', 8, HexColor('#FF9AB7')),
      ClicksPerYear('Happy', 6, HexColor('#FF9AB7')),
      ClicksPerYear('Angry', 4, HexColor('#FF9AB7')),
      ClicksPerYear('Neutral', 7, HexColor('#FF9AB7')),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var weeklySeries = [
      charts.Series(
        data: weeklyData,
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Weekly',
      )
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30)),
    );

    var weeklyChart = charts.BarChart(
      weeklySeries,
      animate: true,
      defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30)),
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    var weeklychartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: weeklyChart,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#E5D6FF'),
        elevation: 0,
        title: Text(
          'Your mood stats',
          style: TextStyle(fontFamily: 'Gotham', color: Colors.black),
        ),
      ),
      backgroundColor: HexColor('#E5D6FF'),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/stats.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              HexColor('#E5D6FF').withOpacity(0.7), BlendMode.dstATop),
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: HexColor('#E5D6FF'),
                      backgroundImage: NetworkImage(widget.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "${widget.name}",
                        style: TextStyle(fontFamily: 'Gotham', fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Weekly Statistics",
                  style: TextStyle(fontFamily: 'Gotham', fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor('#C73DFF'),
                    ),
                    child: chartWidget),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Monthly Statistics",
                  style: TextStyle(fontFamily: 'Gotham', fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor('##FF5083'),
                    ),
                    child: weeklychartWidget),
              )
            ],
          ),
        ),
      ),
    );
  }
}
