import 'package:flutter/material.dart';

class BrandWithReViews extends StatelessWidget {
  const BrandWithReViews({
    super.key,
    required this.brand,
    required this.reViews,
  });
  final String brand;
  final double reViews;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleBrand = Theme.of(context).textTheme.titleSmall!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
          color: Colors.grey[500],
          fontSize: 16,
        );
    final titleReView = Theme.of(context).textTheme.titleSmall!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );
    return SizedBox(
      width: size.width,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * .2,
            child: Text(
              brand,
              style: titleBrand,
            ),
          ),
          SizedBox(
            width: size.width * .13,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.amber,
                ),
                Text(
                  reViews.toString(),
                  style: titleReView,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
