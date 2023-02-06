import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: 160,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Expanded(child: Container()),
              Image.asset('assets/images/iphone.png'),
              Positioned(
                top: 0,
                right: 10,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/images/active_fav_product.png'),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 6,
                    ),
                    child: Text(
                      '%4',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Text(
                  product.name,
                  maxLines: 1,
                  style: const TextStyle(fontFamily: 'sm', fontSize: 14),
                ),
              ),
              Container(
                height: 53,
                decoration: const BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.blue,
                      blurRadius: 25,
                      spreadRadius: -12,
                      offset: Offset(0.0, 15),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'تومان',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '49,800,000',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 13,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black,
                            ),
                          ),
                          Text(
                            '48,800,000',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'SM',
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 24,
                        child: Image.asset(
                            'assets/images/icon_right_arrow_cricle.png'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}