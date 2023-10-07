// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/comment/bloc/comment_bloc.dart';
import 'package:apple_shop/bloc/product/product__state.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/constants/colors.dart';

import 'package:apple_shop/data/model/peoduct_image.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/properties.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(ProductInitializeEvent(
            widget.product.id, widget.product.categoryId));
        return bloc;
      },
      child: DetailScreenContent(
        parentWidget: widget,
      ),
    );
  }
}

class DetailScreenContent extends StatelessWidget {
  const DetailScreenContent({
    super.key,
    required this.parentWidget,
  });

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductDetailLoadingState) {
              return const Center(child: LoadingAnimation());
            }
            return SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (state is ProductDetailResponseState) ...{
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 44, left: 44, bottom: 32, top: 10),
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
                              Expanded(
                                child: state.productCategory.fold(
                                  (l) {
                                    return const Text(
                                      'اطلاعات محصول',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'SB',
                                        fontSize: 16,
                                        color: CustomColors.blue,
                                      ),
                                    );
                                  },
                                  (productCategory) {
                                    return Text(
                                      productCategory.title ?? 'دسته بندی',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'SB',
                                        fontSize: 16,
                                        color: CustomColors.blue,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Image.asset(
                                'assets/images/icon_back.png',
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          parentWidget.product.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'SB',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productImages.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (productImageList) {
                        return GalleryWidget(
                            parentWidget.product.thumbnail, productImageList);
                      },
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productVariant.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (productVariantList) {
                        return VariantCotainerGenerator(productVariantList);
                      },
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productProperties.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(
                            l,
                          ),
                        );
                      },
                      (propertyList) {
                        return ProductProperties(propertyList);
                      },
                    )
                  },
                  if (state is ProductDetailResponseState) ...{
                    ProductDescription(parentWidget.product.description),
                  },
                  if (state is ProductDetailResponseState) ...{
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            useSafeArea: true,
                            showDragHandle: true,
                            builder: (context) {
                              return BlocProvider(
                                child: CommentBottomSheet(
                                  productId: parentWidget.product.id,
                                ),
                                create: (context) {
                                  final bloc = CommentBloc(locator.get());

                                  bloc.add(CommentInitilzeEvent(
                                      parentWidget.product.id));
                                  return bloc;
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 44,
                            right: 44,
                            top: 24,
                          ),
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: CustomColors.grey,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.asset(
                                  'assets/images/icon_left_categroy.png'),
                              const SizedBox(width: 10),
                              const Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SB',
                                  color: CustomColors.blue,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 26,
                                    height: 26,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+10',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'SB',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                ': نظرات کاربران',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SB',
                                  color: CustomColors.blue,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  },
                  if (state is ProductDetailResponseState) ...{
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 44, right: 44),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PricetagButton(),
                            AddToBasketButton(parentWidget.product),
                          ],
                        ),
                      ),
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet({
    super.key,
    required this.productId,
  });

  final String productId;
  // ScrollController controller;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading) {
          return const Center(
            child: LoadingAnimation(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                // controller: controller,
                slivers: [
                  if (state is CommentResponse) ...{
                    state.response.fold((l) {
                      return const SliverToBoxAdapter(
                        child: Text('خطایی در نمایش نظرات به وجود آمده'),
                      );
                    }, (commentList) {
                      if (commentList.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              "نظری برای این محصول ثبت نشده",
                            ),
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: commentList.length,
                          (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          (commentList[index].username.isEmpty)
                                              ? 'کاربر'
                                              : commentList[index].username,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          commentList[index].text,
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child:
                                        (commentList[index].avatar.isNotEmpty)
                                            ? CachedImage(
                                                imageUrl: commentList[index]
                                                    .userThumbnailUrl,
                                              )
                                            : Image.asset(
                                                'assets/images/avatar.png'),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    })
                  }
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 18,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              BorderSide(color: CustomColors.blue, width: 3),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Positioned(
                            child: Container(
                              height: 60,
                              decoration: const BoxDecoration(
                                color: CustomColors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (textController.text.isEmpty) {
                                      return;
                                      //show error
                                      //dialog
                                      //snackbar
                                      //toast
                                    }
                                    context.read<CommentBloc>().add(
                                        CommentPostEvent(
                                            productId, textController.text));

                                    textController.text = '';
                                  },
                                  child: const SizedBox(
                                    height: 53,
                                    child: Center(
                                      child: Text(
                                        'افزودن نظر به محصول',
                                        style: TextStyle(
                                          fontFamily: 'SB',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  final List<Property> productPropertyList;
  const ProductProperties(
    this.productPropertyList, {
    super.key,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisable = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisable = !_isVisable;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 44,
                right: 44,
                top: 24,
              ),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(width: 10),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SB',
                      color: CustomColors.blue,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    ': مشخصات فنی',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SB',
                      color: CustomColors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisable,
            child: Container(
              margin: EdgeInsets.only(
                left: 44,
                right: 44,
                top: (widget.productPropertyList.isNotEmpty) ? 24 : 5,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: (widget.productPropertyList.isNotEmpty)
                  ? ListView.builder(
                      itemCount: widget.productPropertyList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var property = widget.productPropertyList[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                '${property.value!} : ${property.title!}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 14,
                                  height: 1.8,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : const Text(
                      'مشخصات فنی برای این محصول یافت نشد',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'sm',
                        fontSize: 14,
                        height: 1.8,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String productDescription;
  const ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisable = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisable = !_isVisable;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 44,
                right: 44,
                top: 24,
              ),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(width: 10),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SB',
                      color: CustomColors.blue,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    ': توضیحات محصول',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SB',
                      color: CustomColors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisable,
            child: Container(
              margin: EdgeInsets.only(
                left: 44,
                right: 44,
                top: (widget.productDescription.isNotEmpty) ? 24 : 5,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Text(
                (widget.productDescription.isNotEmpty)
                    ? widget.productDescription
                    : '!محصول توضیحات ندارد',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'SM',
                  height: 1.8,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantCotainerGenerator extends StatelessWidget {
  final List<ProductVarint> productVariantList;
  const VariantCotainerGenerator(
    this.productVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        for (var productVariant in productVariantList) ...{
          if (productVariant.variantList.isNotEmpty) ...{
            VariantGeneratorChild(productVariant)
          }
        }
      ],
    ));
  }
}

class VariantGeneratorChild extends StatelessWidget {
  final ProductVarint productVariant;
  const VariantGeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44, top: 20, left: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: const TextStyle(fontSize: 12, fontFamily: 'SM'),
          ),
          const SizedBox(height: 10),
          if (productVariant.variantType.type == VariantTypeEnum.color) ...{
            ColorVariantList(productVariant.variantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.storage) ...{
            StroageVariantList(productVariant.variantList)
          },
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final List<ProductImage> productImageList;
  String? defaultProductThumbnail;

  int selectedItem = 0;

  GalleryWidget(
    this.defaultProductThumbnail,
    this.productImageList, {
    super.key,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icon_star.png',
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: CachedImage(
                            imageUrl: (widget.productImageList.isEmpty)
                                ? widget.defaultProductThumbnail
                                : widget.productImageList[widget.selectedItem]
                                    .imageUrl,
                          )),
                      const Spacer(),
                      Image.asset(
                        'assets/images/icon_favorite_deactive.png',
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 44, right: 44, top: 4),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productImageList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            padding: const EdgeInsets.all(4),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: CustomColors.red,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: CachedImage(
                              imageUrl: widget.productImageList[index].imageUrl,
                              radius: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  Product product;
  AddToBasketButton(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 57,
            width: 140,
            decoration: const BoxDecoration(
              color: CustomColors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {
                  context.read<ProductBloc>().add(ProductAddToBasket(product));

                  context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
                },
                child: const SizedBox(
                  height: 57,
                  width: 135,
                  child: Center(
                    child: Text(
                      'افزودن سبد خرید',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PricetagButton extends StatelessWidget {
  const PricetagButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: const BoxDecoration(
              color: CustomColors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              height: 53,
              width: 160,
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
                          fontFamily: 'SM', fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '49,800,000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 13,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                            // decorationColor: CustomColors.red,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  final List<Variant> variantList;
  const ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'FF${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(1),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: (_selectedIndex == index)
                      ? Border.all(
                          color: CustomColors.blueIndicator,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StroageVariantList extends StatefulWidget {
  final List<Variant> stroageVariants;
  const StroageVariantList(this.stroageVariants, {super.key});

  @override
  State<StroageVariantList> createState() => _StroageVariantListState();
}

class _StroageVariantListState extends State<StroageVariantList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.stroageVariants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: (_selectedIndex == index)
                      ? Border.all(
                          width: 2,
                          color: CustomColors.blueIndicator,
                        )
                      : Border.all(
                          width: 1,
                          color: CustomColors.grey,
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      widget.stroageVariants[index].value!,
                      style: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
