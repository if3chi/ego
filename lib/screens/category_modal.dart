import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/util/ui_helpers.dart';
import 'package:ego/models/category.dart';
import 'package:ego/widgets/ego_text.dart';

class CategoryModal extends StatefulWidget {
  const CategoryModal({Key? key, required this.setCategory}) : super(key: key);

  final Function setCategory;

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  List<Category> categories = Category.categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [kSwatch0.withOpacity(0.9), kSwatch6]),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: EgoText.subheading(
              "What is this Transaction for?",
              color: Colors.white,
            ),
          ),
          Container(color: Colors.white, height: 1, width: double.infinity),
          vSpaceTiny,
          SizedBox(
            height: screenHeightPercent(context, percentage: 0.8),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              children: [
                ...categories.map((category) => Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: kSwatch3,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          widget.setCategory(category);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.cover,
                              width: 46,
                            ),
                            vSpaceTiny,
                            EgoText.caption(
                              category.name.toUpperCase(),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
