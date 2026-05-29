import 'package:app_flutter/src/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoubleCardWidget extends StatefulWidget {
  final double padding;
  final void Function(int productId) onTap;

  const DoubleCardWidget({
    super.key,
    required this.padding,
    required this.onTap,
  });

  @override
  State<DoubleCardWidget> createState() => _DoubleCardWidgetState();
}

class _DoubleCardWidgetState extends State<DoubleCardWidget> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Wrap(
      spacing: widget.padding,
      runSpacing: widget.padding,
      children: List.generate(productProvider.products.length, (index) {
        return SizedBox(
          width: 180,
          child: Card(
            color: const Color.fromARGB(255, 243, 243, 243),
            elevation: 5,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: widget.padding,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        productProvider.products[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 21.5,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () => widget.onTap(
                        productProvider.products[index].productId,
                      ),
                      icon: const Icon(Icons.delete),
                      iconSize: 18,
                    ),
                  ],
                ),
                Text(
                  'R\$ ${productProvider.products[index].unitValue.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  productProvider.products[index].unitType,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Cat: ${productProvider.products[index].category}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Badge(
                    backgroundColor: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    label: Text(
                      'Badge',
                      style: TextStyle(fontSize: 11, letterSpacing: 1.25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
