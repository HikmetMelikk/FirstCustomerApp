import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Customeradd> createCustomeradd(
  String customerName,
  String customerPhone,
  String customerAddress,
  String customerEmail,
  String orderName,
  String orderId,
) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.49:3000/api/customer/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'customerEmail': customerEmail,
      'orderName': orderName,
      'orderId': orderId
    }),
  );

  if (response.statusCode == 201) {
    return Customeradd.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Customeradd.');
  }
}

class Customeradd {
  String customerName;
  String customerPhone;
  String customerAddress;
  String customerEmail;
  String orderName;
  String orderId;

  Customeradd(
      {required this.customerName,
      required this.customerPhone,
      required this.customerAddress,
      required this.customerEmail,
      required this.orderName,
      required this.orderId});

  factory Customeradd.fromJson(Map<String, dynamic> json) {
    return Customeradd(
      customerName: json["customerName"],
      customerPhone: json["customerPhone"],
      customerAddress: json["customerAddress"],
      customerEmail: json["customerEmail"],
      orderName: json["orderName"],
      orderId: json["orderId"],
    );
  }
}

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<AddCustomerPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  Future<Customeradd>? _futureCustomeradd;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Add Customer Page')),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureCustomeradd == null)
              ? buildColumn()
              : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Hero(
          tag: 'addcustomer',
          child: Material(child: Text('Customer Add page')),
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Customer Name'),
        ),
        TextField(
          controller: _controller1,
          decoration: const InputDecoration(hintText: 'Enter Customer Phone'),
        ),
        TextField(
          controller: _controller2,
          decoration: const InputDecoration(hintText: 'Enter Customer Address'),
        ),
        TextField(
          controller: _controller3,
          decoration: const InputDecoration(hintText: 'Enter Customer E-mail'),
        ),
        TextField(
          controller: _controller4,
          decoration: const InputDecoration(hintText: 'Enter Order Name'),
        ),
        TextField(
          controller: _controller5,
          decoration: const InputDecoration(hintText: 'Enter Order Id'),
        ),
        Container(
          width: 200,
          height: 80,
          padding: const EdgeInsets.only(top: 40.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _futureCustomeradd = createCustomeradd(
                  _controller.text,
                  _controller1.text,
                  _controller2.text,
                  _controller3.text,
                  _controller4.text,
                  _controller5.text,
                );
              });
            },
            child: const Text(
              'Create Data',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  FutureBuilder<Customeradd> buildFutureBuilder() {
    return FutureBuilder<Customeradd>(
      future: _futureCustomeradd,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.customerName);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
