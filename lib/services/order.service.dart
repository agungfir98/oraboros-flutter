import 'package:oraboros/DTO/order.dto.dart';
import 'package:oraboros/DTO/parameter.dto.dart';
import 'package:oraboros/main.dart';

class OrderService {
  String table = "orders";
  String column = "user_id";

  Future<List<UserOrderDTO>> getuserOrder(
      String userId, ParameterDTO? parameter) async {
    List<Map<String, dynamic>> data = await supabase
        .from(table)
        .select("*, budgets(icon)")
        .eq(column, userId)
        .limit(parameter?.limit ?? 5);

    return UserOrderDTO().fromListJson(data);
  }

  Future<int> getMonthlySpent(String userId) async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> data =
        await supabase.from(table).select('amount').eq(column, userId);
    List<UserOrderDTO> userOrder = UserOrderDTO().fromListJson(data);

    int sum = userOrder.fold(
        0, (previousValue, element) => previousValue + element.amount!);

    return sum;
  }
}
