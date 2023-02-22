import 'package:bloc/bloc.dart';
import 'package:dashboard/model/db_helper.dart';
import 'package:dashboard/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemInitialState());
  static ItemCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<Item> _items = [];

  List<Item> get items => [..._items];

  int itemCount = 0;
  Future<void> addItem(String name, double price) async {
    // itemCount++;
    // _items.add(Item(name: name, id: itemCount, price: price));
    emit(ItemAddItemState());
    final id = await DBHelper.insert('items', {'name': name, 'price': price});
    if (id > 0) {
      emit(ItemAddItemState());
      await getAllData();
    } else {
      emit(ItemAddItemErrorState());
    }
  }

  Future<void> getAllData() async {
    emit(ItemGetAllItemsLoadingState());
    final allItems = await DBHelper.getData('items');
    _items = allItems.map((e) => Item.formJson(e)).toList();
    emit(ItemGetAllItemsState());
  }

  Future<void> deleteItem(int id) async {
    itemCount++;
    _items.removeWhere((element) => element.id == id);
    final noChanges = await DBHelper.deleteData(id);
    emit(ItemDeleteItemState());
    await getAllData();
  }

  Future<void> updateItem(Item item) async {
    // final index = _items.indexWhere((element) => element.id == item.id);
    // _items[0] = item;

    final noChanges = await DBHelper.updateData(item);
    if (noChanges > 0) {
      emit(ItemUpdateItemState());
      await getAllData();
    }
  }
}
