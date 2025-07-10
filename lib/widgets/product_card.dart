import 'package:ecommerce_demo_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget  {
  final Product product;
  final VoidCallback onBuyPressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.onBuyPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              product.imageURL,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 40,),
              ),
            ),
            // child: Image.asset(product.imageURL, height: 100, width: double.infinity, fit: BoxFit.cover),
            // child: Image.asset('assets/iamges/mouse.jpg', height: 100, width: double.infinity, fit: BoxFit.cover),
            // print(product.imageURL);
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${product.priceRange} . ${product.moq} . ${product.rating}⭐'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onBuyPressed, 
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 77, 109, 165)),
                  child: const Text('Purchase Now'))
              ],
            ),)
        ],
      ),
    );
  }
}
