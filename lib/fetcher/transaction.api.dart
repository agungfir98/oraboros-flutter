import 'package:oraboros/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future newTransaction(String userId, List<Map<String, dynamic>> data) async {
  try {
    PostgrestMap transaction = await supabase
        .from('transactions')
        .insert({"user_id": userId})
        .select()
        .single();

    List<Map<String, dynamic>> orderList = data.map((order) {
      return {...order, 'transaction_id': transaction['id']};
    }).toList();
    supabase.from('orders').insert(orderList).then((value) {});
  } catch (e) {
    throw Exception('something wrong with the server');
  }
}
