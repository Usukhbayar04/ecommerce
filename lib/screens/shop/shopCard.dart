// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../models/products.dart';
import '../detail/detail_page.dart';

class ShopCard extends StatelessWidget {
  final ProductModel data;
  const ShopCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String shortenText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return '${text.substring(0, maxLength)}...';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(data: data)),
        );
      },
      child: Container(
        width: 350,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 200,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data.image!),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shortenText(data.title!, 10),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    shortenText(data.description!, 20),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      if (data.rating != null) ...[
                        Row(
                          children: [
                            // Display star icons based on the rating rate
                            for (int i = 0; i < 5; i++)
                              if (i < data.rating!.rate!.floor())
                                const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 255, 230, 0),
                                  size: 18,
                                )
                              else if (i < data.rating!.rate!)
                                const Icon(
                                  Icons.star_half,
                                  color: Color.fromARGB(255, 255, 230, 0),
                                  size: 18,
                                )
                              else
                                const Icon(
                                  Icons.star_border,
                                  color: Color.fromARGB(255, 255, 230, 0),
                                  size: 18,
                                ),
                            const SizedBox(width: 5),
                            Text(
                              '${data.rating!.rate} (5)',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$${data.price!.toString()}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(
                        Icons.favorite_border,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
