import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopnest/constants/global_variables.dart';
import 'package:shopnest/constants/http_erros.dart';
import 'package:shopnest/constants/utils.dart';
import 'package:shopnest/features/auth/screens/auth_screen.dart';
import 'package:shopnest/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopnest/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    return orderList;
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
