import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraboros/DTO/order.dto.dart';
import 'package:oraboros/DTO/parameter.dto.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:oraboros/services/order.service.dart';
import 'package:provider/provider.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = context.read<ProfileProvider>().profile[ProfileProvider.id];
    return FutureBuilder(
      future: OrderService().getuserOrder(userId, ParameterDTO(limit: 5)),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('no Data'));
        }
        List<UserOrderDTO> data = snapshot.data!;
        return ListView.separated(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
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
                    dense: true,
                    leading: Text(
                      "${data[index].budgets?.icon}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    title: Text(
                      "${data[index].name}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    trailing: Text(
                      "Rp. ${NumberFormat().format(data[index].amount)}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ));
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: data.length);
      },
    );
  }
}
