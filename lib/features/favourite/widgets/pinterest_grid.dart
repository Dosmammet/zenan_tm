import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zenan/features/favourite/widgets/const_colors.dart';
import 'package:zenan/features/favourite/widgets/fashion_cat_widget.dart';

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final rnd = Random();
  late List<int> extents;
  int crossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    extents = List<int>.generate(100, (int index) => rnd.nextInt(5) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FashionCategoriesWidget(),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: MasonryGridView.count(
                    //physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemBuilder: (context, index) {
                      final height = extents[index] * 100;
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: height.toDouble(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Turkmenistan-Ashgabat.jpg/532px-Turkmenistan-Ashgabat.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: extents.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
