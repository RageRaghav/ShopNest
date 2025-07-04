import 'package:shopnest/features/account/services/account_services.dart';
import 'package:shopnest/features/account/widgets/account_buttons.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {})
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: 'Logout', onTap: () => AccountServices().logout(context)),
            AccountButton(text: 'Your Wishlist', onTap: () {})
          ],
        )
      ],
    );
  }
}
