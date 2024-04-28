import 'package:oraboros/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetService {
  final String budgetTable = "budgets";
  final String userIdKey = "user_id";

  Future<List<Map<String, dynamic>>> getUserBudget(String userId) {
    return supabase
        .from(budgetTable)
        .select()
        .eq(userIdKey, userId)
        .then((value) => value);
  }

  Future newBudget(Map<String, dynamic> data) async {
    return supabase
        .from(budgetTable)
        .insert(data)
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
