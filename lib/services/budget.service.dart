import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetService {
  final String budgetTable = "budgets";
  final String userIdKey = "user_id";

  Future<List<UserBudgetDTO>> getUserBudget(String userId) async {
    List<Map<String, dynamic>> userBudget =
        await supabase.from(budgetTable).select().eq(userIdKey, userId);

    return userBudget.map((budget) => UserBudgetDTO.fromJson(budget)).toList();
  }

  Future newBudget(NewBudgetDTO data) async {
    return supabase
        .from(budgetTable)
        .insert(data.toJson())
        .select()
        .single()
        .then((value) => value);
  }

  SupabaseStreamBuilder streamUserBudget(String userId) {
    return supabase
        .from(budgetTable)
        .stream(primaryKey: ['id']).eq(userIdKey, userId);
  }
}
