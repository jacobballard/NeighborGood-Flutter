import 'dart:async';
import 'dart:math';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/product/detail/cubit/product_detail_cubit.dart';
import 'package:pastry/src/product/detail/view/add_to_cart_button.dart';
import 'package:pastry/src/product/detail/view/product_detail_modifiers.dart';
import 'package:repositories/repositories.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final ProductDetails? details;
  const ProductDetailPage({
    Key? key,
    required this.product,
    this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewProductDetailsCubit = ViewProductDetailsCubit(
      productDetailsRepository: ProductDetailsRepository(
          productId: product.id, sellerId: product.seller_id),
      authenticationRepository: context.read<AuthenticationRepository>(),
    );

    // TODO: This is shanky I feel like my repo needs to handle instead
    if (details == null) viewProductDetailsCubit.getProductDetails;
    if (details != null) viewProductDetailsCubit.setProductDetails(details!);
    return BlocProvider(
      create: (context) => viewProductDetailsCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: BlocBuilder<ViewProductDetailsCubit, ViewProductDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case ViewProductDetailsStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ViewProductDetailsStatus.success:
                return ProductDetailsBody(
                    productDetails: state.productDetails!);
              case ViewProductDetailsStatus.failure:
                return ProductDetailsErrorWidget(onRetry: () async {
                  context.read<ViewProductDetailsCubit>().getProductDetails();
                });
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class ProductDetailsBody extends StatelessWidget {
  final ProductDetails productDetails;

  const ProductDetailsBody({Key? key, required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CarouselWidget(images: productDetails.image_urls),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ProductDescriptionHeaderWidget(productDetails: productDetails),
              ModifierList(modifiers: productDetails.modifiers),
              const AddToCartButton(),
              ProductDescriptionFooterWidget(productDetails: productDetails),
            ],
          ),
        ),
      ],
    );
  }
}

class DeliveryMethodIconsWidget extends StatelessWidget {
  final List<String> deliveryMethods;

  const DeliveryMethodIconsWidget({Key? key, required this.deliveryMethods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: deliveryMethods.map<Widget>((method) {
        switch (method) {
          // TODO : Refactor this war crime
          case 'DeliveryMethodType.local_pickup':
            return const Icon(Icons.local_mall); // Use hands for local pickup
          case 'DeliveryMethodType.delivery':
            return const Icon(Icons.local_shipping); // Use car for delivery
          case 'DeliveryMethodType.shipping':
            return const Icon(
                Icons.local_post_office); // Use parcel for shipping
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }
}

class CarouselWidget extends StatefulWidget {
  final List<String> images;

  const CarouselWidget({Key? key, required this.images}) : super(key: key);

  @override
  CarouselWidgetState createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  // int _current = 0;
  List<double> imageRatios = [];
  List<String> sortedImages = [];

  @override
  void initState() {
    super.initState();
    print("init");
    print(widget.images);
    // Calculate the aspect ratio of all images and sort them
    if (widget.images.isNotEmpty) {
      Future.wait(
        widget.images.map(
          (image) async {
            final Completer<ImageInfo> completer = Completer();
            final ImageStream stream =
                NetworkImage(image).resolve(const ImageConfiguration());
            final listener = ImageStreamListener((ImageInfo info, bool _) {
              if (!completer.isCompleted) {
                completer.complete(info);
              }
            });
            stream.addListener(listener);
            print("added listener");
            final info = await completer.future;
            print("completed");
            print(image);
            stream.removeListener(listener);

            var height = info.image.height.toDouble();
            var width = info.image.width.toDouble();
            print("return");
            return {'ratio': height / width, 'image': image};
          },
        ),
      ).then(
        (values) {
          values.sort((a, b) {
            var ratioA = a['ratio'] as double?;
            var ratioB = b['ratio'] as double?;
            if (ratioA != null && ratioB != null) {
              return ratioB.compareTo(ratioA);
            }
            return 0;
          });
          setState(() {
            imageRatios = values.map((e) => e['ratio']).toList().cast<double>();
            sortedImages =
                values.map((e) => e['image']).toList().cast<String>();
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var maxImageHeight = screenHeight * 0.75;
    var screenWidth = MediaQuery.of(context).size.width;
    double guidelineheight = 0;
    if (imageRatios.isNotEmpty) {
      guidelineheight = screenWidth * imageRatios[0];
    }
    var carouselHeight = min(maxImageHeight, guidelineheight);

    if (imageRatios.isEmpty) {
      // Display a loading indicator or something else while waiting for image ratios to load
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: CarouselSlider.builder(
        itemCount: sortedImages.length,
        itemBuilder: (context, index, realIdx) {
          return Container(
            color: Colors.black,
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.network(
                  sortedImages[index],
                  width: screenWidth,
                  fit: BoxFit.cover,
                  height: screenWidth * imageRatios[index],
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: carouselHeight,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            // setState(() {
            //   _current = index;
            // });
          },
        ),
      ),
    );
  }
}

class ProductDescriptionHeaderWidget extends StatelessWidget {
  final ProductDetails productDetails;

  const ProductDescriptionHeaderWidget(
      {super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ViewProductDetailsCubit, ViewProductDetailsState>(
        buildWhen: (previous, current) =>
            previous.displayPrice != current.displayPrice,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (state.displayPrice == null)
                      Text(
                        "\$${productDetails.price.toString()}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: theme.primaryColor, // Use the theme color
                        ),
                      ),
                    if (state.displayPrice != null)
                      Text(
                        "\$${state.displayPrice}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: theme.primaryColor, // Use the theme color
                        ),
                      ),
                    const SizedBox(
                      width: 8,
                    ),
                    DeliveryMethodIconsWidget(
                      deliveryMethods: productDetails.deliveryMethods
                              ?.map((e) => e.type.toString())
                              .toList() ??
                          [],
                    ),
                  ],
                ),
                Text(
                  productDetails.name,
                  style: TextStyle(
                    fontSize: 16, // Decreased the font size
                    color:
                        theme.textTheme.bodyLarge?.color, // Use the theme color
                  ),
                  maxLines: 3, // Allow the title to span multiple lines
                  overflow: TextOverflow
                      .ellipsis, // Add ellipsis if the title is too long
                ),
              ],
            ),
          );
        });
  }
}

class ProductDescriptionFooterWidget extends StatelessWidget {
  final ProductDetails productDetails;

  const ProductDescriptionFooterWidget({Key? key, required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("details");
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productDetails.description,
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.bodyMedium?.color, // Use the theme color
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const ProductDetailsErrorWidget({Key? key, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the theme here
    return ListView(
      children: [
        const SizedBox(height: 100),
        Center(
          child: Icon(
            Icons.error,
            color: theme.colorScheme.error, // Use the theme color
            size: 80,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Something went wrong!',
            style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.error), // Use the theme color
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ),
      ],
    );
  }
}
