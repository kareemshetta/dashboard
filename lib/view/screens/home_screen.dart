import 'package:dashboard/model/item_model.dart';
import 'package:dashboard/view_model/item_cubit/item_cubit.dart';
import 'package:dashboard/view_model/item_cubit/item_state.dart';

import 'package:dashboard/view/screens/edit_product_screen.dart';
import 'package:dashboard/view/views/new_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: BlocConsumer<ItemCubit, ItemState>(
          listener: (context, state) {},
          builder: (context, state) {
            final itemCubit = ItemCubit.get(context);
            final items = ItemCubit.get(context).items;

            return Column(
              children: [
                NewItem(
                  size: size,
                  productNameController: productNameController,
                  buttonTitle: 'Add Item',
                  productPriceController: productPriceController,
                  onPressed: () {
                    itemCubit.addItem(productNameController.text,
                        double.parse(productPriceController.text));
                    productPriceController.clear();
                    productNameController.clear();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                (state is ItemGetAllItemsLoadingState && items.isEmpty)
                    ? Center(
                        child: Text('no item to show'),
                      )
                    : Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            itemBuilder: (context, index) {
                              return ListItem(
                                  item: items[index], itemCubit: itemCubit);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 2,
                              );
                            },
                            itemCount: itemCubit.items.length))
              ],
            );
          },
        ),
      ),
    );
  }
}

// i put this listItem here cause this is the only place that will be used

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.item,
    required this.itemCubit,
  }) : super(key: key);

  final Item item;

  final ItemCubit itemCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Text(
              item.id.toString(),
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'LE ${item.price.toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: item);
            },
            icon: Icon(Icons.edit, color: Colors.green),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {
              itemCubit.deleteItem(item.id);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
    );
  }
}
