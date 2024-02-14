import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Routes/route_names.dart';
import '../../Utilities/constants.dart';

class EditPremiumPriceApi {
  static Future<void> editPremiumPrice(
      BuildContext context, String title ,String price, String description, int planId) async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    try {
      var data = {
        "title": title,
        "price": price,
        "description": description,
        "id": planId.toString()
      };
      print(data);
      final urls = APIConstants.url + APIConstants.edit_plan_item;
      print(urls);
      String token = (localStorage.getString('token') ?? '' );
      String newToken = 'token $token';
      print(token);
      var response = await http.patch(Uri.parse(urls), headers: {'Authorization': newToken}, body: data);
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(body['message']),
        //     ));
        Navigator.pushNamed(context, RouteName.admin_view_price_plan);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
      }
    } catch (e) {
      throw e.toString();
    }
  }
}