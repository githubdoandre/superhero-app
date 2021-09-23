import 'package:flutter/material.dart';
import 'package:super_hero/models/hero.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HeroDetailScreen extends StatelessWidget {
  final HeroModel hero;

  HeroDetailScreen({
    this.hero,
  });

  @override
  Widget build(BuildContext context) {
    final List<Powerstats> chartData = [
      Powerstats('strength', int.parse(hero.powerstats.strength)),
      Powerstats('speed', int.parse(hero.powerstats.speed)),
      Powerstats('power', int.parse(hero.powerstats.power)),
      Powerstats('combat', int.parse(hero.powerstats.combat)),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  child: Image.network(
                    hero.image,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.40,
                child: Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hero.name,
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 12.0,
                          ),
                          Text(
                            hero.biography.placeOfBirth != '-'
                                ? hero.biography.placeOfBirth
                                : 'Unavailable',
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${hero.appearance.gender} / ${hero.appearance.race} / ${hero.appearance.height} / ${hero.appearance.weight}",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: Container(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries<Powerstats, String>>[
                              // Renders column chart
                              ColumnSeries<Powerstats, String>(
                                  dataSource: chartData,
                                  xValueMapper: (Powerstats sales, _) =>
                                      sales.type,
                                  yValueMapper: (Powerstats sales, _) =>
                                      sales.value)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Powerstats {
  Powerstats(this.type, this.value);
  final String type;
  final int value;
}
