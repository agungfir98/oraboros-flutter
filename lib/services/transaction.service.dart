import 'package:oraboros/DTO/transaction.dto.dart';
import 'package:oraboros/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService {
  Future newTransaction(
      String userId, List<TransactionDTO> transactionData) async {
    List<Map<String, dynamic>> data =
        transactionData.map((value) => value.toJson()).toList();

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
}
