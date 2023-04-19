import 'package:apple_shop/bloc/basket/basket_bloc.dart';

import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/util/extentions/string_extention.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BasketItem>('CardBox');

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(child: BlocBuilder<BasketBloc, BasketSate>(
        builder: (context, state) {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 44,
                        left: 44,
                        bottom: 32,
                      ),
                      child: Container(
                        height: 46,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Image.asset('assets/images/icon_apple_blue.png'),
                            const Expanded(
                              child: Text(
                                'سبد خرید',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16,
                                  color: CustomColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is BasketDataFetchedState) ...{
                    state.basketItemList.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (basketItemList) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: basketItemList.length,
                            (context, index) {
                              return CardItem(basketItemList[index]);
                            },
                          ),
                        );
                      },
                    ),
                  },
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 100),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
                child: SizedBox(
                  height: 53,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily: 'sm',
                        fontSize: 18,
                      ),
                      backgroundColor: CustomColors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('ادامه ی فرایند'),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}

class CardItem extends StatelessWidget {
  final BasketItem basketItem;
  const CardItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(44, 0, 44, 20),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'آیفون 13 پرومکس',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "sb",
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          'گارانتی فیلان 18 ماهه',
                          style: TextStyle(
                            fontFamily: "sm",
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
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
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                fontFamily: "sm",
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              '29500000',
                              style: TextStyle(
                                fontFamily: "sm",
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: CustomColors.red,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, bottom: 2, right: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 10),
                                    const Text(
                                      "حذف",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontFamily: "sm",
                                        fontSize: 12,
                                        color: CustomColors.red,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Image.asset("assets/images/icon_trash.png")
                                  ],
                                ),
                              ),
                            ),
                            OptionCheap(
                              'آبی',
                              color: '4287f5',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 75,
                      height: 104,
                      child: CachedImage(
                        imageUrl: basketItem.thumbnail,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColors.grey.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('تومان'),
                SizedBox(width: 5),
                Text(
                  '59.000.000',
                  style: TextStyle(
                    fontFamily: "sb",
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String? color;
  String title;
  OptionCheap(
    this.title, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CustomColors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              )
            },
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontFamily: "sm",
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
