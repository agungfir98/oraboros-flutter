import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/main.dart';

class GetBudgetDTO {
  final String userId;

  GetBudgetDTO({required this.userId});
}

Future<List<BudgetDTO>> getUserBudget(GetBudgetDTO budgetDTO) async {
  List<Map<String, dynamic>> budgetList = await supabase
      .from('budgets')
      .select()
      .eq(
        'user_id',
        budgetDTO.userId,
      )
      .then((value) => value);

  return BudgetDTO.fromJsonList(budgetList);
}
