import 'package:dio/dio.dart';

class MoneyRepository{
  Future<List<dynamic>> getMoneyList(String money) async {
    final response = await Dio()
    .get('https://api.currencyapi.com/v3/latest?apikey=cur_live_GYlzdyFyz7yWBNbyKvixIZzEoZPeoxJ5mrTtzZXJ&currencies=UAH%2CKRW%2CTHB%2CUSD%2CRUB%2CNOK%2CTRY&base_currency=$money');
    final data = response.data as Map<String,dynamic>;
    final dataList = data['data'].entries.map((e) => e.value as Map<String,dynamic>).toList();
    return dataList;
  }
}
