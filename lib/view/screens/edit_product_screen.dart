import 'package:dashboard/model/item_model.dart';
import 'package:dashboard/view_model/item_cubit/item_cubit.dart';
import 'package:dashboard/view_model/item_cubit/item_state.dart';

import 'package:dashboard/view/views/new_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({Key? key}) : super(key: key);
  static const routeName = 'edit-screen';
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final oldItem = ModalRoute.of(context)!.settings.arguments as Item;
    productNameController.text = oldItem.name;
    productPriceController.text = oldItem.price.toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: BlocConsumer<ItemCubit, ItemState>(
        listener: (context, state) {
          if (state is ItemUpdateItemState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    'item updated successfully',
                  ),
                  backgroundColor: Colors.green),
            );
            productPriceController.clear();
            productNameController.clear();
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final itemCubit = ItemCubit.get(context);
          return Center(
              child: NewItem(
                  size: size,
                  productNameController: productNameController,
                  productPriceController: productPriceController,
                  onPressed: () async {
                    await itemCubit.updateItem(Item(
                        name: productNameController.text,
                        id: oldItem.id,
                        price: double.parse(productPriceController.text)));
                  },
                  buttonTitle: 'Update Item'));
        },
      ),
    );
  }
}
