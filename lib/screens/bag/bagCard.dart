// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BagCard extends StatelessWidget {
  final String name;
  final String price;
  final String desc;
  final String img;
  const BagCard({
    super.key,
    required this.name,
    required this.price,
    required this.desc,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      img,
                      height: 200,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        // Icon(Icons.cancel_outlined)
                      ],
                    ),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 130),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 5,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 255, 0, 0),
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.shopping_bag,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
