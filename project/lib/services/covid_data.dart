import 'dart:convert';
import 'package:http/http.dart';

class CovidData {

  final String url = 'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/0/query?where=1%3D1&outFields=Province_State,Country_Region,Confirmed,Recovered,Deaths,Active&returnGeometry=false&outSR=4326&f=json';

  List<String> listOfCountries = [];
  String confirmed;
  String active;
  String recovered;
  String deaths;

  String selectedCountry;

  CovidData({ this.selectedCountry });

  Future<void> getCovidData() async {

    try {
      // get url
      Response response = await get(url);
      Map map = jsonDecode(response.body);
      List list = map['features'];

      // count each data
      this.confirmed = countData(list, 'Confirmed', this.selectedCountry);
      this.active = countData(list, 'Active', this.selectedCountry);
      this.recovered = countData(list, 'Recovered', this.selectedCountry);
      this.deaths = countData(list, 'Deaths', this.selectedCountry);
      this.listOfCountries = getListOfCountries(list);

    } catch (e) {
      print('Caught error: $e');
      this.confirmed = '0';
      this.active = '0';
      this.recovered = '0';
      this.deaths = '0';
      this.listOfCountries = ['World'];
    }
  }

  String countData(List list, String categories, String country){

    int count = 0;

    list.forEach((element){
      if(country == 'World' || element['attributes']['Country_Region'] == country){
        count += element['attributes'][categories];
      }
    });

    return count.toString();
  }

  List<String> getListOfCountries(List list){

    List<String> listOfCountries = ['World'];

    list.forEach((element){
      listOfCountries.add(element['attributes']['Country_Region']);
    });
    listOfCountries = listOfCountries.toSet().toList();
    
    return listOfCountries;
  }
  
}