import 'package:dashboard/view/views/custom_button.dart';
import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  const NewItem({
    Key? key,
    required this.size,
    required this.productNameController,
    required this.productPriceController,
    required this.onPressed,
    required this.buttonTitle,
  }) : super(key: key);

  final Size size;
  final TextEditingController productNameController;
  final TextEditingController productPriceController;
  final void Function()? onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
                border: UnderlineInputBorder(),
                label: Text('product name'),
                hintText: 'Enter Product name'),
            controller: productNameController,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
                border: UnderlineInputBorder(),
                label: Text('product price'),
                hintText: 'Enter Product product price'),
            controller: productPriceController,
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
              color: Colors.deepOrange,
              onPressed: onPressed,
              buttonTitle: buttonTitle,
              radius: 20.0)
        ],
      ),
    );
  }
}
