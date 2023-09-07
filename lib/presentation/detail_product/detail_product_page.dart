import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/checkout/checkout_bloc.dart';

import '../../data/models/responses/list_product_response_model.dart';
import '../../presentation/cart/cart_page.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEE4D2D),
        title: Text(
          widget.product.attributes!.name!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 150,
            child: Image.network(widget.product.attributes!.image!),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.product.attributes!.name!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text('Rp ${formatAngka(widget.product.attributes!.price!)}'),
          const SizedBox(
            height: 8,
          ),
          Text(widget.product.attributes!.description!),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffEE4D2D)),
            onPressed: () {
              context.read<CheckoutBloc>().add(AddToCartEvent(
                    product: widget.product,
                  ));
            },
            child: BlocListener<CheckoutBloc, CheckoutState>(
              listener: (context, state) {
                if (state is CheckoutLoaded) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CartPage();
                  }));
                }
              },
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Text(
                    'Beli',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- fungsi tambahan ---
  String formatAngka(int? number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
