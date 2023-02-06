import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                        'حساب کاربری',
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
            const Text(
              'بهادر فولادی',
              style: TextStyle(fontFamily: 'SB', fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              '09369421435',
              style: TextStyle(fontFamily: 'SM', fontSize: 10),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: const [
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColors.grey,
              ),
            ),
            const Text(
              'V-1.0.00',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColors.grey,
              ),
            ),
            const Text(
              'inatagram.com/bahador_22',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
