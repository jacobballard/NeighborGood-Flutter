import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../create_store/cubit/create_store_cubit.dart';
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
              onPressed: () => imageUploaderCubit.pickAndUploadImage(),
              child: const Text('Upload Images'),
            ),
          ),
          BlocBuilder<ImageUploaderCubit, ImageUploaderState>(
            builder: (context, state) {
              if (state.uploadStatus == ImageUploaderStatus.uploading) {
                return const CircularProgressIndicator();
              }
              if (state.uploadStatus == ImageUploaderStatus.failure) {
                return Text(state.errorMessage ?? 'Error');
              }
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: state.status == FormzStatus.invalid
                        ? Colors.red
                        : Colors.transparent,
                  ),
                ),
                child: NonScrollableGridView(
                  crossAxisCount: 3,
                  children: List.generate(state.imageUrls.length, (index) {
                    return DragTarget<int>(
                      builder: (context, candidateData, rejectedData) {
                        return Draggable<int>(
                          data: index,
                          feedback: Material(
                            child: Image.network(
                              state.imageUrls[index],
                              width: 50,
                              height: 50,
                            ),
                          ),
                          childWhenDragging: Container(),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                state.imageUrls[index],
                                fit: BoxFit.cover,
                                // width: itemWidth,
                                // height: itemHeight,
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    context
                                        .read<ImageUploaderCubit>()
                                        .deleteImage(state.imageUrls[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      onWillAccept: (data) => data != index,
                      onAccept: (data) {
                        context
                            .read<ImageUploaderCubit>()
                            .reorderImages(data, index);
                      },
                    );

                    // return DragTarget<int>(
                    //   builder: (context, candidateData, rejectedData) {
                    //     return LongPressDraggable<int>(
                    //       data: index,
                    //       feedback: Material(
                    //         child: Image.network(state.imageUrls[index]),
                    //       ),
                    //       childWhenDragging: Container(),
                    //       child: Stack(
                    //         children: <Widget>[
                    //           Image.network(
                    //             state.imageUrls[index],
                    //             fit: BoxFit.cover,
                    //           ),
                    //           Positioned(
                    //             right: 0,
                    //             child: IconButton(
                    //               icon: Icon(Icons.close),
                    //               onPressed: () {
                    //                 context
                    //                     .read<ImageUploaderCubit>()
                    //                     .deleteImage(state.imageUrls[index]);
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   onWillAccept: (data) => data != index,
                    //   onAccept: (data) {
                    //     context
                    //         .read<ImageUploaderCubit>()
                    //         .reorderImages(data, index);
                    //   },
                    // );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//... Rest of your code

// class NonScrollableGridView extends StatelessWidget {
//   final List<Widget> children;
//   final int crossAxisCount;

//   const NonScrollableGridView(
//       {Key? key, required this.children, required this.crossAxisCount})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final childAspectRatio = MediaQuery.of(context).size.width /
//     //     (crossAxisCount *
//     //         200); // Adjust this based on your item's width/height ratio.

//     final childAspectRatio = 1.0;
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final itemHeight = width / crossAxisCount / childAspectRatio;
//         final height = children.length / crossAxisCount * itemHeight;

//         return SizedBox(
//           width: width,
//           height: height,
//           child: GridView.count(
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisCount: crossAxisCount,
//             childAspectRatio: childAspectRatio,
//             children: children,
//           ),
//         );
//       },
//     );
//   }
// }
class NonScrollableGridView extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double itemWidth = 125.0;
  final double itemHeight = 125.0;

  const NonScrollableGridView({
    Key? key,
    required this.children,
    required this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Calculate the number of rows needed based on the number of children
        final numRows = (children.length / crossAxisCount).ceil();
        final height = numRows * itemHeight;

        return SizedBox(
          width: width,
          height: height,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: children.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) => Container(
              width: itemWidth,
              height: itemHeight,
              child: children[index],
            ),
          ),
        );
      },
    );
  }
}
