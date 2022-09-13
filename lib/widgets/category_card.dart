import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.image, required this.title, required this.press,}) : super(key: key);

  final String image;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(13.0)
      ),
      child: InkWell(
        onTap: press,
        child: Column(
          children: [
            Image.asset(image),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
