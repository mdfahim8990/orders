import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order/api_service/api_service.dart';
import 'package:order/model/order_model.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  bool loading = false;

  Future<void> getData() async {
    try {
      loading = true;
      if (mounted) setState(() {});
      var response = await ApiService().orders();
      if (response.success) {
        List<OrderModel> orderList = response.data['items']!
            .map<OrderModel>((e) => OrderModel.fromJson(e))
            .toList();
        if (orderList.isEmpty) {
          if (!mounted) return;
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text("Order Is Empty")),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );

          return;
        }

        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.message}"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      log("Error::OrderHistoryListPage::getData:: $e");
    } finally {
      loading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5, // Set the elevation to 8 (adjust as needed)
              child: ListTile(
                leading: Icon(Icons.add),
                trailing: Icon(Icons.arrow_forward),
                title: Text('Example Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
