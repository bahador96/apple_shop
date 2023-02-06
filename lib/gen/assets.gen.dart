/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/active_fav_product.png
  AssetGenImage get activeFavProduct =>
      const AssetGenImage('assets/images/active_fav_product.png');

  /// File path: assets/images/icon_apple_blue.png
  AssetGenImage get iconAppleBlue =>
      const AssetGenImage('assets/images/icon_apple_blue.png');

  /// File path: assets/images/icon_application.png
  AssetGenImage get iconApplication =>
      const AssetGenImage('assets/images/icon_application.png');

  /// File path: assets/images/icon_back.png
  AssetGenImage get iconBack =>
      const AssetGenImage('assets/images/icon_back.png');

  /// File path: assets/images/icon_basket.png
  AssetGenImage get iconBasket =>
      const AssetGenImage('assets/images/icon_basket.png');

  /// File path: assets/images/icon_basket_active.png
  AssetGenImage get iconBasketActive =>
      const AssetGenImage('assets/images/icon_basket_active.png');

  /// File path: assets/images/icon_category.png
  AssetGenImage get iconCategory =>
      const AssetGenImage('assets/images/icon_category.png');

  /// File path: assets/images/icon_category_active.png
  AssetGenImage get iconCategoryActive =>
      const AssetGenImage('assets/images/icon_category_active.png');

  /// File path: assets/images/icon_favorite_deactive.png
  AssetGenImage get iconFavoriteDeactive =>
      const AssetGenImage('assets/images/icon_favorite_deactive.png');

  /// File path: assets/images/icon_home.png
  AssetGenImage get iconHome =>
      const AssetGenImage('assets/images/icon_home.png');

  /// File path: assets/images/icon_home_active.png
  AssetGenImage get iconHomeActive =>
      const AssetGenImage('assets/images/icon_home_active.png');

  /// File path: assets/images/icon_left_categroy.png
  AssetGenImage get iconLeftCategroy =>
      const AssetGenImage('assets/images/icon_left_categroy.png');

  /// File path: assets/images/icon_options.png
  AssetGenImage get iconOptions =>
      const AssetGenImage('assets/images/icon_options.png');

  /// File path: assets/images/icon_profile.png
  AssetGenImage get iconProfile =>
      const AssetGenImage('assets/images/icon_profile.png');

  /// File path: assets/images/icon_profile_active.png
  AssetGenImage get iconProfileActive =>
      const AssetGenImage('assets/images/icon_profile_active.png');

  /// File path: assets/images/icon_right_arrow_cricle.png
  AssetGenImage get iconRightArrowCricle =>
      const AssetGenImage('assets/images/icon_right_arrow_cricle.png');

  /// File path: assets/images/icon_search.png
  AssetGenImage get iconSearch =>
      const AssetGenImage('assets/images/icon_search.png');

  /// File path: assets/images/icon_star.png
  AssetGenImage get iconStar =>
      const AssetGenImage('assets/images/icon_star.png');

  /// File path: assets/images/iphone.png
  AssetGenImage get iphone => const AssetGenImage('assets/images/iphone.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        activeFavProduct,
        iconAppleBlue,
        iconApplication,
        iconBack,
        iconBasket,
        iconBasketActive,
        iconCategory,
        iconCategoryActive,
        iconFavoriteDeactive,
        iconHome,
        iconHomeActive,
        iconLeftCategroy,
        iconOptions,
        iconProfile,
        iconProfileActive,
        iconRightArrowCricle,
        iconSearch,
        iconStar,
        iphone
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
