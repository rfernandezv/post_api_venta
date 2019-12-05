import 'SaleOrderDetail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sale {
  final int customerId;
  final List<SaleOrderDetail> details;
  
  Sale({this.customerId, this.details});
 
  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      customerId: json['customerId'],
      details: json['details']
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["customerId"] = customerId;
    map["details"] =   List<dynamic>.from(details.map( (x) => x.toMap() ));
   
    return map;
  }
}
 

 Future<String> createSale(String url, {Map body}) async {
  return http.post(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    }, body: json.encode(body) ).then((http.Response response) {
    final int statusCode = response.statusCode;
    print(response.body);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    //return Sale.fromJson(json.decode(response.body));
    return response.body;
  });
}
 
class MyApp extends StatelessWidget {
  final Future<Sale> sale;

  //SaleOrderDetail newDetail = new SaleOrderDetail(detailId: "", saleId: "", status: 1, price: 10, productId: 1, currency: "PEN", quantity: 5);
  List<SaleOrderDetail>  newDetails = new List<SaleOrderDetail>(); 
  
  // SaleOrderDetail(detailId: "", saleId: "", status: 1, price: 10, productId: 1, currency: "PEN", quantity: 5)
 
  MyApp({Key key, this.sale}) : super(key: key);
  //static final CREATE_POST_URL = 'http://10.0.2.2:8085/sales';
  static final CREATE_POST_URL = 'https://inkafarma-axon.cfapps.io/sales';
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Sale'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new RaisedButton(
                  onPressed: () async {
                    newDetails.add(new SaleOrderDetail(detailId: "", saleId: "", status: 1, price: 10, productId: 1, currency: "PEN", quantity: 1));
                    newDetails.add(new SaleOrderDetail(detailId: "", saleId: "", status: 1, price: 5, productId: 11, currency: "PEN", quantity: 5));
                    newDetails.add(new SaleOrderDetail(detailId: "", saleId: "", status: 1, price: 7, productId: 12, currency: "PEN", quantity: 4));

                    Sale newSale = new Sale(customerId: 2, details: newDetails);
                    Map newMap =newSale.toMap();
                    String saleId = await createSale(CREATE_POST_URL, body: newMap);
                    print(saleId);
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          )),
    );
  }
}
 
void main() => runApp(MyApp());