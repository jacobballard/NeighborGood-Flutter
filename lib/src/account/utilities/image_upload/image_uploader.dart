import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_rapid/create_store/create_store_cubit.dart';

import 'image_uploader_cubit.dart';

class ImageUploadForm extends StatelessWidget {
  const ImageUploadForm({Key? key, required this.imageUploaderCubit})
      : super(key: key);

  final ImageUploaderCubit imageUploaderCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: imageUploaderCubit,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () => context
                  .read<CreateStoreCubit>()
                  .imageUploaderCubit
                  .pickAndUploadImage(),
              child: const Text('Upload Images'),
            ),
          ),
          BlocBuilder<ImageUploaderCubit, ImageUploaderState>(
            builder: (context, state) {
              if (state.status == ImageUploaderStatus.uploading) {
                return const CircularProgressIndicator();
              }
              if (state.status == ImageUploaderStatus.failure) {
                return const Text('Image upload failed.');
              }
              return NonScrollableGridView(
                crossAxisCount: 3,
                children: List.generate(state.imageUrls.length, (index) {
                  return Image.network(state.imageUrls[index]);
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NonScrollableGridView extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;

  const NonScrollableGridView(
      {Key? key, required this.children, required this.crossAxisCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final childAspectRatio = MediaQuery.of(context).size.width /
        (crossAxisCount *
            200); // Adjust this based on your item's width/height ratio.
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemHeight = width / crossAxisCount / childAspectRatio;
        final height = children.length / crossAxisCount * itemHeight;

        return SizedBox(
          width: width,
          height: height,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            children: children,
            childAspectRatio: childAspectRatio,
          ),
        );
      },
    );
  }
}
