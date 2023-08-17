import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pastry/src/app/app.dart';
// import 'package:pastry/src/chat/detail/bloc/chat_bloc.dart';
import 'package:pastry/src/chat/detail/cubit/chat_cubit.dart';
import 'package:pastry/src/product/detail/view/product_detail.dart';
import 'package:pastry/src/product/list/view/product_grid_view.dart';
import 'package:pastry/src/store/detail/cubit/store_detail_cubit.dart';
import 'package:provider/provider.dart';
import 'package:repositories/repositories.dart';
import '../model/baker.dart';
import '../../../chat/detail/view/message_screen.dart';

class StoreDetailPage extends StatelessWidget {
  final String sellerId;
  const StoreDetailPage({
    Key? key,
    required this.sellerId,
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

    var storeDetailCubit = StoreDetailCubit(
        storeDetailsRepository: StoreDetailsRepository(
          sellerId: sellerId,
        ),
        authenticationRepository: context.read<AuthenticationRepository>());
    // ..getStoreDetails();

    // storeDetailCubit.getStoreDetails();

    print('here returning bloc privder $sellerId');
    return BlocProvider(
      create: (context) => storeDetailCubit,
      // child: BlocBuilder<StoreDetailCubit, StoreDetailState>(
      // builder: (context, state) {
      // print('building');
      // storeDetailCubit.getStoreDetails();
      // print(state.store?.storeName);

      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<StoreDetailCubit, StoreDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case StoreDetailStatus.success:
                  return Text(state.store!.storeName);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
        body: BlocBuilder<StoreDetailCubit, StoreDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case StoreDetailStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case StoreDetailStatus.success:
                return StoreDetailsBody(storeDetails: state.store!);
              case StoreDetailStatus.failure:
                return ProductDetailsErrorWidget(onRetry: () async {
                  context.read<StoreDetailCubit>().getStoreDetails();
                });
              case StoreDetailStatus.initial:
                return const Center(child: CircularProgressIndicator());
              default:
                return Container();
            }
          },
        ),
        // body: BlocBuilder<StoreDetailCubit, StoreDetailState>(
        //   builder: (context, state) => CustomScrollView(
        //     slivers: [
        //       SliverToBoxAdapter(
        //         child: Padding(
        //           padding: const EdgeInsets.all(16.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 state.store?.storeName ?? "Loading...",
        //                 style: const TextStyle(
        //                   fontSize: 24,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               const SizedBox(height: 8),
        //               Text(
        //                 "@${(state.store?.storeName ?? 'Loading...')}",
        //                 style: TextStyle(
        //                   fontSize: 16,
        //                   color: Colors.grey[600],
        //                 ),
        //               ),

        //               const SizedBox(height: 8),
        //               ElevatedButton(
        //                 onPressed: () {
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) => BlocProvider(
        //                         create: (context) => ChatBloc(),
        //                         child: const ChatScreen(),
        //                       ),
        //                     ),
        //                   );
        //                 },
        //                 child: const Text("Direct Messages"),
        //               ),
        //               // const SizedBox(height: 16),
        //               // Row(
        //               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               //   children: [
        //               //     IconButton(
        //               //       onPressed: () {},
        //               //       icon: const FaIcon(FontAwesomeIcons.tiktok),
        //               //       tooltip: "Social Media Profile 1",
        //               //     ),
        //               //     IconButton(
        //               //       onPressed: () {},
        //               //       icon: const FaIcon(FontAwesomeIcons.instagram),
        //               //       tooltip: "Social Media Profile 23",
        //               //     ),
        //               //     IconButton(
        //               //       onPressed: () {},
        //               //       icon: const FaIcon(FontAwesomeIcons.pinterest),
        //               //       tooltip: "Social Media Profile 3",
        //               //     ),
        //               //   ],
        //               // ),
        //               const Divider(),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const SliverToBoxAdapter(
        //         child: SizedBox(height: 20.0),
        //       ),

        //     ],
        //   ),
        // )),
        // },
      ),
    );
  }
}

class StoreDetailsBody extends StatelessWidget {
  final StoreDetail storeDetails;
  // final List<Product>? products;
  const StoreDetailsBody({
    Key? key,
    required this.storeDetails,
    // required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CarouselWidget(
            images: storeDetails.imageUrls,
            carouselRequiredMaxHeight:
                (MediaQuery.of(context).size.height * 0.30),
          ),
        ),
        SliverToBoxAdapter(
          child: StoreHeaderWidget(storeDetails: storeDetails),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "All Products",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                BlocBuilder<StoreDetailCubit, StoreDetailState>(
                  builder: (context, state) {
                    switch (state.productsStatus) {
                      case StoreProductDetailStatus.initial:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case StoreProductDetailStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case StoreProductDetailStatus.failure:
                        return const Center(
                            child: Text("Something went wrong!"));
                      case StoreProductDetailStatus.success:
                        return ProductGridView(products: state.products);
                      default:
                        return Container();
                    }
                  },
                )
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}

class StoreHeaderWidget extends StatelessWidget {
  final StoreDetail storeDetails;

  const StoreHeaderWidget({
    super.key,
    required this.storeDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            storeDetails.storeName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "@${(storeDetails.storeName)}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // TODO: Poor form this is not streamed
              (context.read<AppBloc>().state.user.accountType ==
                      AccountType.guest)
                  ? null
                  : Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        var chat = ChatCubit(dynamic);

                        return BlocProvider(
                          create: (context) => chat,
                          child: FutureBuilder(
                            future: chat.createRoom(storeDetails.storeId),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? ChatPage(room: snapshot.data!)
                                  : const SizedBox.shrink();
                            },
                          ),
                        );
                      }),
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
    );
  }
}
