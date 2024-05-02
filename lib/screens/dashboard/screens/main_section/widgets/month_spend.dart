import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oraboros/components/box_container.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:oraboros/services/order.service.dart';
import 'package:provider/provider.dart';

class ThisMonthSpend extends StatelessWidget {
  const ThisMonthSpend({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = context.read<ProfileProvider>().profile[ProfileProvider.id];
    return FutureBuilder(
      future: OrderService().getMonthlySpent(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const BoxContainer(child: Text('loading...'));
        }
        return BoxContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "This month spend",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              Text(
                "Rp. ${NumberFormat().format(snapshot.data)}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
