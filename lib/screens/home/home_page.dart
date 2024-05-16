import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/products.dart';
import 'productCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;

    Future<List<ProductModel>> getData() async {
      String result = await DefaultAssetBundle.of(context)
          .loadString("assets/data/products.json");
      return ProductModel.fromList(jsonDecode(result));
    }

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 270,
                      width: height,
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/img4.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment(-0.8, 0.8),
                        child: Text(
                          'Fashion killa',
                          style: TextStyle(
                            fontSize: 32,
                            color: Color.fromARGB(255, 8, 182, 124),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New style',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  'New summer style',
                                  style: TextStyle(
                                    color: Color.fromARGB(135, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            Text('View all'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 230,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: List.generate(
                                  min(snapshot.data!.length, 4),
                                  (index) =>
                                      ProductCard(data: snapshot.data![index]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New Collects',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 32,
                                  ),
                                ),
                                Text(
                                  'New summer style',
                                  style: TextStyle(
                                    color: Color.fromARGB(135, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            Text('View all'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: List.generate(
                                    min(snapshot.data!.length, 4),
                                    (index) => ProductCard(
                                        data: snapshot.data![index + 4]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching data'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}
