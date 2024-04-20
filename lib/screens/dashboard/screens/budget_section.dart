import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraboros/DTO/budget.dto.dart';
import 'package:oraboros/fetcher/budget.api.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:provider/provider.dart';

class BudgetSection extends StatefulWidget {
  const BudgetSection({super.key});

  @override
  State<BudgetSection> createState() => _BudgetSectionState();
}

class _BudgetSectionState extends State<BudgetSection> {
  List<Map<String, dynamic>> _budgetList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    String userId = context.read<ProfileProvider>().profile['id'];
    try {
      List<Map<String, dynamic>> data =
          await BudgetService().getUserBudget(userId);
      setState(() {
        _budgetList = data;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'budgets',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: _budgetList.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: ListTile(
                    style: ListTileStyle.list,
                    visualDensity: VisualDensity.comfortable,
                    leading: Text(
                      _budgetList[index][BudgetMapKey.icon],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    title: Text(
                      _budgetList[index][BudgetMapKey.name],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Text(
                        "Rp. ${NumberFormat.decimalPattern().format(_budgetList[index][BudgetMapKey.amount])}"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
