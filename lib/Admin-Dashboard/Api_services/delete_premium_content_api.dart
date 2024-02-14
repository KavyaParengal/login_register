import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Routes/route_names.dart';
import '../../Utilities/constants.dart';

class DeletePaidContent {
  static Future<void> deletePaidContent(BuildContext context, String paidContentId) async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var data = {
        "id": paidContentId,
      };
      print(data);
      final urls = APIConstants.url + APIConstants.delete_paid_content;
      print(urls);
      String token = (localStorage.getString('token') ?? '' );
      String newToken = 'token $token';
      print(token);
      var response = await http.post(Uri.parse(urls), headers: {'Authorization': newToken}, body: data);
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Delete successfully !'),
            ));
        Navigator.pushNamed(context, RouteName.admin_view_premium_content);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while deleting item: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}