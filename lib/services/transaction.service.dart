import 'package:oraboros/DTO/order.dto.dart';
import 'package:oraboros/DTO/transaction.dto.dart';
import 'package:oraboros/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService {
  final String table = "transactions";

  Future newTransaction(
      String userId, List<TransactionDTO> transactionData) async {
    List<Map<String, dynamic>> data =
        transactionData.map((value) => value.toJson()).toList();

    try {
      PostgrestMap transaction = await supabase
          .from(table)
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

  Future<List<UserTransactions>> getUserTransaction(String userId) async {
    List<dynamic> data = await supabase
        .from(table)
        .select('*, orders(*,budgets(icon))')
        .eq('user_id', userId);

    return data.map(
      (item) {
        List<UserOrderDTO> orderList = [];

        for (var item in item[UserTransactions.ordersKey]) {
          if (item is Map<String, dynamic>) {
            UserOrderDTO order = UserOrderDTO.fromJson(item);
            orderList.add(order);
          } else {
            print("Unexpected data type in list: ${item.runtimeType}");
          }
        }

        return UserTransactions(
          id: item[UserTransactions.idKey],
          createdAt: item[UserTransactions.createdAtKey],
          orders: orderList,
          userId: item[UserTransactions.userIdKey],
        );
      },
    ).toList();
  }
}
