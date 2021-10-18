import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

CoinData coindata = new CoinData();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState() {
    super.initState();
    getData();
  }

  String currency;
  String rateBTC = '?';
  String rateETH = '?';
  String rateLTC = '?';
  String selectedItem = 'USD';
  String returncountry() {
    return selectedItem;
  }

  Future getData() async {
    String url1 =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$country?apikey=$apikey';
    String url2 =
        'https://rest.coinapi.io/v1/exchangerate/ETH/$country?apikey=$apikey';
    String url3 =
        'https://rest.coinapi.io/v1/exchangerate/NZD/$country?apikey=$apikey';
    http.Response response1 = await get(Uri.parse(url1));
    http.Response response2 = await get(Uri.parse(url2));
    http.Response response3 = await get(Uri.parse(url3));
    String data1 = response1.body;
    String data2 = response2.body;
    String data3 = response3.body;
    double r1 = jsonDecode(data1)['rate'];
    double r2 = jsonDecode(data2)['rate'];
    double r3 = jsonDecode(data3)['rate'];
    rateBTC = r1.toStringAsFixed(2);
    rateETH = r2.toStringAsFixed(2);
    rateLTC = r3.toStringAsFixed(2);
  }

  Widget chooseDevice() {
    if (Platform.isIOS) {
      return ios101();
    } else if (Platform.isAndroid) {
      return android101();
    }
  }

  DropdownButton<String> android101() {
    List<DropdownMenuItem<String>> items101 = [];

    for (int i = 0; i < currenciesList.length; i++) {
      currency = currenciesList[i];
      var newitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      items101.add(newitem);
    }

    return DropdownButton<String>(
      dropdownColor: Colors.blue,
      value: selectedItem,
      items: items101,
      onChanged: (value) {
        setState(() {
          selectedItem = value;
          country = selectedItem;
          getData();
        });
      },
    );
  }

  CupertinoPicker ios101() {
    List<Widget> getioslist = [];
    for (int i = 0; i < currenciesList.length; i++) {
      currency = currenciesList[i];
      var newitem = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      getioslist.add(newitem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      children: getioslist,
      onSelectedItemChanged: (value) {
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rateBTC $country',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $rateETH $country',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $rateLTC $country',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: chooseDevice()),
        ],
      ),
    );
  }
}

_PriceScreenState obj = new _PriceScreenState();
String country = obj.selectedItem;
