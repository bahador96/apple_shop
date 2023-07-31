import 'package:apple_shop/util/extentions/string_extention.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPayymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinPalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  String? _authority;
  String? _status;
  UrlHandler urlHandler;
  ZarinPalPaymentHandler(this.urlHandler);

  @override
  Future<void> initPayymentRequest() async {
    _paymentRequest.setIsSandBox(false);
    _paymentRequest.setAmount(450000);
    _paymentRequest.setDescription('This is for test application apple shop');
    _paymentRequest.setMerchantID('543c2ee8-1b88-4f46-82d6-ffa00b77c6ae');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    linkStream.listen((deepLink) {
      if (deepLink!.toLowerCase().contains('authority')) {
        _authority = deepLink.extractValueFromQuery('Authority');
        _status = deepLink.extractValueFromQuery('Status');

        verifyPaymentRequest();
      }
    });
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(_status!, _authority!, _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        print(refID);
      } else {
        print('Error');
      }
    });
  }
}

class PayPalPaynmentHandler extends PaymentHandler {
  @override
  Future<void> initPayymentRequest() async {}

  @override
  Future<void> sendPaymentRequest() async {}

  @override
  Future<void> verifyPaymentRequest() async {}
}
