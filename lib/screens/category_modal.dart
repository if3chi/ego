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
                      margin: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () {
                          widget.setCategory(category);
                          Navigator.pop(context);
                        },
                        child: CategoryCard(
                            categoryName: category.name.toUpperCase()),
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

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.categoryName,
    this.categoryIcon = 'assets/images/logo.png',
  }) : super(key: key);

  final String categoryName;
  final String categoryIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          gradient: const LinearGradient(
              colors: [kSwatch0, kSwatch6],
              begin: Alignment.bottomCenter,
              end: Alignment.topLeft),
          boxShadow: [
            BoxShadow(
                color: kSwatch0.withOpacity(0.5),
                blurRadius: 0.5,
                spreadRadius: 1,
                offset: const Offset(1, 1)),
            BoxShadow(
                color: kMediumGreyColor.withOpacity(0.6),
                blurRadius: 0.5,
                spreadRadius: 1,
                offset: const Offset(-1, -1)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(categoryIcon, fit: BoxFit.cover, width: 46),
          vSpaceNormal,
          EgoText.caption(categoryName, color: Colors.white),
        ],
      ),
    );
  }
}
