import 'package:ecofriendly_app/features/company/presentation/widgets/brand_with_reviews.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.location,
    required this.name,
    required this.brand,
    required this.priceOriginal,
    required this.priceDiscountApplied,
    required this.img,
    this.isFavorite = false,
    this.isPromocion = false,
    this.offPercentage = 0.0,
    this.onPressedFavorite,
  });
  final String name;
  final String brand;
  final double priceOriginal;
  final double priceDiscountApplied;
  final String img;
  final String location;
  final bool isFavorite;
  final bool isPromocion;
  final double offPercentage;
  final void Function()? onPressedFavorite;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleTheme = Theme.of(context).textTheme.titleMedium!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        );
    return GestureDetector(
      onTap: () => context.push(location),
      child: Container(
        width: size.width,
        height: 300,
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        decoration: ShapeDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: SizesApp.sizesCartScreen.wBorderSide - .7,
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius:
                BorderRadius.circular(SizesApp.sizesCartScreen.borderRadious),
          ),
          shadows: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              blurStyle: BlurStyle.normal,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image + reaction + chip
            _ImageProduct(
              img: img,
              isFavorite: isFavorite,
              promotion: isPromocion,
              percentage: offPercentage,
              onPressedFavorite: onPressedFavorite,
            ),
            // title
            Text(
              name,
              maxLines: 2,
              style: titleTheme,
            ),
            // brand + views
            BrandWithReViews(
              brand: brand.toUpperCase(),
              reViews: 4.5,
            ),
            PriceWithPriceDiscount(
              originalPrice: priceOriginal,
              percentageDiscount: offPercentage,
              isPromotion: isPromocion,
              priceDiscount: priceDiscountApplied,
            )
            // price
          ],
        ),
      ),
    );
  }
}

class _ImageProduct extends StatelessWidget {
  const _ImageProduct({
    required this.img,
    required this.isFavorite,
    bool? promotion,
    double? percentage,
    this.onPressedFavorite,
  })  : isPromocion = promotion ?? false,
        offPercentage = percentage ?? 0.0;
  final String img;
  final bool isFavorite;
  final bool isPromocion;
  final double offPercentage;
  final void Function()? onPressedFavorite;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titlePromotion = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Image.network(
            width: size.width,
            height: size.height * .15,
            img,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return SizedBox(
                  width: size.width * .4,
                  height: size.height * .15,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return child;
            },
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: onPressedFavorite,
            icon: Icon(
              !isFavorite ? Icons.eco_outlined : Icons.eco_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 35,
            ),
          ),
        ),
        isPromocion
            ? Positioned(
                left: 2,
                top: 6,
                child: Container(
                  width: 80,
                  height: 25,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${(offPercentage * 100).toInt()}% OFF',
                      style: titlePromotion,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class PriceWithPriceDiscount extends StatelessWidget {
  const PriceWithPriceDiscount({
    super.key,
    required this.originalPrice,
    required this.percentageDiscount,
    required this.priceDiscount,
    this.isPromotion,
  });
  final double originalPrice;
  final double percentageDiscount;
  final double priceDiscount;
  final bool? isPromotion;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textPriceOriginal = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: MyColors.mainColor,
          fontWeight: FontWeight.w500,
          letterSpacing: .8,
        );
    final textPriceDiscount = Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          decoration: TextDecoration.lineThrough,
          decorationColor: Colors.grey,
          height: 0.3,
          letterSpacing: 0.15,
        );
    return SizedBox(
        width: size.width,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'S/. ${percentageDiscount == 0 ? originalPrice : priceDiscount}',
              style: textPriceOriginal,
            ),
            if (percentageDiscount != 0)
              Text(
                'S/. $originalPrice',
                style: textPriceDiscount,
              ),
          ],
        ));
  }
}
