import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pastry/src/chat/detail/bloc/chat_bloc.dart';
import 'package:pastry/src/store/detail/cubit/store_detail_cubit.dart';
import 'package:repositories/repositories.dart';
import '../model/baker.dart';
import '../../../chat/detail/view/message_screen.dart';

class StoreDetailPage extends StatelessWidget {
  final String? storeId;
  final String? sellerId;
  const StoreDetailPage({
    Key? key,
    required this.storeId,
    this.sellerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double appBarHeight = AppBar().preferredSize.height;
    // final double storeHeaderHeight =
    248.0; // Adjust this to the actual height of the Store header
    // final double remainingHeight = screenHeight -
    // storeHeaderHeight -
    16.0; // subtract any other widget heights

    return BlocProvider<StoreDetailCubit>(
      create: (context) => StoreDetailCubit(
          storeDetailsRepository: StoreDetailsRepository(
            sellerId: sellerId,
            storeId: storeId,
          ),
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocBuilder<StoreDetailCubit, StoreDetailState>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(state.store?.storeName ?? "Loading..."),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.store?.storeName ?? "Loading...",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "@${(state.store?.storeName ?? 'Loading...')}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),

                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ChatBloc(),
                                  child: const ChatScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text("Direct Messages"),
                        ),
                        // const SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: const FaIcon(FontAwesomeIcons.tiktok),
                        //       tooltip: "Social Media Profile 1",
                        //     ),
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: const FaIcon(FontAwesomeIcons.instagram),
                        //       tooltip: "Social Media Profile 23",
                        //     ),
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: const FaIcon(FontAwesomeIcons.pinterest),
                        //       tooltip: "Social Media Profile 3",
                        //     ),
                        //   ],
                        // ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20.0),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "All Products",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //TODO : Store's detail Bloc
                        // Container(
                        //   child: ProductGridView(products: s),
                        // ),
                      ],
                    );
                  }, childCount: 1),
                ),
              ],
            )),
      ),
    );
  }
}
