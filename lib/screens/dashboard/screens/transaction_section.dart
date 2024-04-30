import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraboros/DTO/order.dto.dart';
import 'package:oraboros/DTO/transaction.dto.dart';
import 'package:oraboros/components/separator.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:oraboros/services/transaction.service.dart';
import 'package:provider/provider.dart';

/// Example for EmojiPicker
class TransactionSection extends StatefulWidget {
  const TransactionSection({super.key});

  @override
  State<TransactionSection> createState() => _TransactionSection();
}

class _TransactionSection extends State<TransactionSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = context.read<ProfileProvider>().profile[ProfileProvider.id];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'transactions history',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: FutureBuilder<List<UserTransactions>>(
            future: TransactionService().getUserTransaction(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff122334),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('no data'),
                );
              }
              List<UserTransactions> data = snapshot.data!;
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<UserOrderDTO> order = data[index].orders;
                  int total = order.fold(
                      0, (value, element) => value + element.amount!);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xff122334),
                          offset: Offset(3, 5),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      leading: Text(
                        DateFormat('dd/MM')
                            .format(DateTime.parse(data[index].createdAt)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Separator();
                            },
                            shrinkWrap: true,
                            itemCount: data[index].orders.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${order[i].budgets?.icon}"),
                                        Expanded(
                                          child: Text(
                                            "${order[i].name}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Rp. ${NumberFormat.decimalPattern().format(order[i].amount)}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              );
                            },
                          ),
                          const Separator(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: Text('Total')),
                              Text(
                                'Rp. ${NumberFormat.decimalPattern().format(total)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
