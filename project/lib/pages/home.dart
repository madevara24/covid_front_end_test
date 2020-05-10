import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid_front_end/services/covid_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> listOfCountries = ['World'];
  String confirmed = 'null';
  String active = 'null';
  String recovered = 'null';
  String deaths = 'null';

  String dropDownValue = 'World';

  @override
  void initState() {
    super.initState();
    
    if(confirmed == 'null' || active == 'null' || recovered == 'null' || deaths == 'null' || listOfCountries.length == 1){
      print('initstate');
      init();
    }
  }

  @override
  Widget build(BuildContext context) {

    print('build');

    return Scaffold(
      backgroundColor: Color(0xfff3f6f9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton.icon(
                onPressed: (){}, 
                icon: Icon(Icons.home), 
                label: Text('Overview')
              ),
              FlatButton.icon(
                onPressed: (){}, 
                icon: Icon(Icons.airline_seat_flat), 
                label: Text('Symtomps')
              ),
              FlatButton.icon(
                onPressed: (){}, 
                icon: Icon(Icons.dvr), 
                label: Text('News')
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Covid-19 Data Overview",    
                        style: TextStyle(
                          fontFamily: "Roboto",fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color:Color(0xff9d59f0),  
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      child: DropdownButton<String>(
                        value: dropDownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            onDropDownChange(newValue);
                            this.dropDownValue = newValue;
                          });
                        },
                        items: listOfCountries
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HomeTopStatisticCard(topText: 'Confirmed', bottomText: this.confirmed, bottomTextColor: Color(0xfff059ac),),
                    HomeTopStatisticCard(topText: 'Active', bottomText: this.active, bottomTextColor: Color(0xfff09d59),),
                    HomeTopStatisticCard(topText: 'Recovered', bottomText: this.recovered, bottomTextColor: Color(0xff89da29),),
                    HomeTopStatisticCard(topText: 'Deaths', bottomText: this.deaths, bottomTextColor: Color(0xff1b4676),)
                  ],
                ),
              ],
            ),
          )
        )
      ),
    );
  }

  void init() async{
    CovidData instance = CovidData(selectedCountry: 'World');
    await instance.getCovidData();
    this.confirmed = instance.confirmed;
    this.active = instance.active;
    this.recovered = instance.recovered;
    this.deaths = instance.deaths;
    this.listOfCountries = instance.listOfCountries;
    print('getcoviddata');
    setState(() {
      print('Finished Init');
    });
  }

  void onDropDownChange(String value) async{
    print('Select: ' + value);
    CovidData instance = CovidData(selectedCountry: value);
    await instance.getCovidData();
    this.confirmed = instance.confirmed;
    this.active = instance.active;
    this.recovered = instance.recovered;
    this.deaths = instance.deaths;
    this.listOfCountries = instance.listOfCountries;
    setState(() {
      print('Finished onDropdownChange');
    });
  }
}

class HomeMainChart extends StatefulWidget {
  const HomeMainChart({
    Key key,
  }) : super(key: key);

  @override
  _HomeMainChartState createState() => _HomeMainChartState();
}

class _HomeMainChartState extends State<HomeMainChart> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
          colors: const [
            Color(0xff2c274c),
            Color(0xff46426c),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Unfold Shop 2018',
                style: TextStyle(
                  color: Color(0xff827daa),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Monthly Sales',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: LineChart(
                    isShowingMainData ? sampleData1() : sampleData2(),
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}

class HomeTopStatisticCard extends StatefulWidget {
  const HomeTopStatisticCard({
    Key key, this.topText, this.bottomText, this.bottomTextColor
  }) : super(key: key);

  final String topText;
  final String bottomText;
  final Color bottomTextColor;

  @override
  _HomeTopStatisticCardState createState() => _HomeTopStatisticCardState();
}

class _HomeTopStatisticCardState extends State<HomeTopStatisticCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.topText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto-Medium",
                fontSize: 20,
                color:Color(0xff1b4676),  
              ),
            ),
            Text(
              widget.bottomText,    
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",fontWeight: FontWeight.w700,
                fontSize: 48,
                color: widget.bottomTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}