import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pastry/src/seller/product/product_upload/bloc/product_upload_bloc.dart';

class ProductUploadScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  ProductUploadScreen({super.key});
  // Add other controllers for other fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Upload')),
      body: BlocConsumer<ProductUploadBloc, ProductUploadState>(
        listener: (context, state) {
          if (state is ProductUploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product uploaded successfully')),
            );
          } else if (state is ProductUploadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product upload failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductUploadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  // Add other form fields for other product details
                  // ...
                  ElevatedButton(
                    onPressed: () {
                      // final product = Product(
                      //   id: 'example-id',
                      //   title: titleController.text,
                      //   // Add other product details
                      //   // Add other product details
                      //   // ...
                      // );
                      // TODO : Flesh out Product instantiation
                      const product = null;

                      context.read<ProductUploadBloc>().add(
                            ProductUpload(
                              product: product,
                              imageSource: ImageSource.gallery,
                            ),
                          );
                    },
                    child: const Text('Upload from Gallery'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //   final product = Product(
                      //     id: 'example-id',
                      //     title: titleController.text,
                      //     // Add other product details
                      //     // ...
                      //   );
                      const product = null;

                      context.read<ProductUploadBloc>().add(
                            ProductUpload(
                              product: product,
                              imageSource: ImageSource.camera,
                            ),
                          );
                    },
                    child: const Text('Upload from Camera'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
