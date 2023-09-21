import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'orders_list_cubit.dart';

class SellersOrdersList extends StatelessWidget {
  const SellersOrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SellersOrdersListCubit>(
      create: (context) => SellersOrdersListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Manage Orders"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox.shrink(),
          ]),
        ),
      ),
    );
  }
}

class ListViewSellersOrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellersOrdersListCubit, SellersOrdersListState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => ListView.builder(
        itemBuilder: (context, index) => ListItemSellersOrdersList(),
      ),
    );
  }
}

class ListItemSellersOrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
