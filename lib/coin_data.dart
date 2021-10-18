import 'package:http/http.dart' as http;

const apikey = 'Write-Your-Own-API';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  int rate;
  String link =
      'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=76BDB961-93A8-488D-A99D-9AD582C427C4';
  Future fetchAlbum() async {
    final response = await http.get(Uri.parse('$link'));
    // print(response.body);
    return (response.body);
  }
}
