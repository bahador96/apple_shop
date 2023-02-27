import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/category_icon_item_chip.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitilzeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (state is HomeLoadingState) ...{
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  } else ...{
                    const _GetSearchBox(),
                    if (state is HomeRequestSuccessState) ...[
                      state.bannerList.fold(
                        (exceptionmessage) {
                          return SliverToBoxAdapter(
                            child: Text(exceptionmessage),
                          );
                        },
                        (listBanners) {
                          return _GetBanners(listBanners);
                        },
                      ),
                    ],
                    const _GetCategoryListTitle(),
                    if (state is HomeRequestSuccessState) ...[
                      state.categoryList.fold((exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      }, (categoryList) {
                        return _GetCatgoryList(categoryList);
                      })
                    ],

                    // title best seller
                    const _GetBesSellerTitle(),

                    // پر فورش ترین ها
                    if (state is HomeRequestSuccessState) ...[
                      state.bestSellerProductList.fold((exceptionMessage) {
                        return SliverToBoxAdapter(
                            child: Text(exceptionMessage));
                      }, (productList) {
                        return _GetBestSellerProducts(productList);
                      })
                    ],

                    // title most viwed
                    const _GetMostViwedTitle(),

                    // پر بازدید ترین ها
                    if (state is HomeRequestSuccessState) ...[
                      state.hotestProductList.fold((exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      }, (productList) {
                        return _GetMostViewedProduct(productList);
                      })
                    ],
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetMostViewedProduct extends StatelessWidget {
  final List<Product> productList;
  const _GetMostViewedProduct(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: productList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ProductItem(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetMostViwedTitle extends StatelessWidget {
  const _GetMostViwedTitle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, top: 32),
        child: Row(
          children: [
            const Text(
              'پربازدید  ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColors.grey,
              ),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                color: CustomColors.blue,
                fontFamily: 'SB',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetBestSellerProducts extends StatelessWidget {
  final List<Product> productList;
  const _GetBestSellerProducts(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: productList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetBesSellerTitle extends StatelessWidget {
  const _GetBesSellerTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColors.grey,
              ),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                color: CustomColors.blue,
                fontFamily: 'SB',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _GetCatgoryList extends StatelessWidget {
  final List<Category> listCategories;
  const _GetCatgoryList(
    this.listCategories, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: listCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CategoryItemChip(listCategories[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetCategoryListTitle extends StatelessWidget {
  const _GetCategoryListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 20,
          top: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'دسته بندی',
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 18,
                color: CustomColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetBanners extends StatelessWidget {
  final List<BannerCampain> bannerCampain;
  const _GetBanners(
    this.bannerCampain, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(
        bannerCampain,
      ),
    );
  }
}

class _GetSearchBox extends StatelessWidget {
  const _GetSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
              Image.asset('assets/images/icon_search.png'),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'جستجوی محصولات',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                    color: CustomColors.grey,
                  ),
                ),
              ),
              Image.asset('assets/images/icon_apple_blue.png'),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
