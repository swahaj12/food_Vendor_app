import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_vendor_app/services/order_services.dart';
import 'package:intl/intl.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({Key? key, required this.document}) : super(key: key);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    Color? statusColor(DocumentSnapshot document) {
      if (document['orderStatus'] == 'Accepted') {
        return Colors.blueGrey[400];
      }
      if (document['orderStatus'] == 'Rejected') {
        return Colors.red;
      }
      if (document['orderStatus'] == 'Picked Up') {
        return Colors.pink[900];
      }
      if (document['orderStatus'] == 'On The Way') {
        return Colors.purple[900];
      }
      if (document['orderStatus'] == 'Delivered') {
        return Colors.green;
      }
      return Colors.orange;
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 0,
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              child: Icon(CupertinoIcons.square_list,
                  size: 18, color: statusColor(document)),
            ),
            title: Text(
              document['orderStatus'],
              style: TextStyle(
                fontSize: 12,
                color: statusColor(document),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'On ${DateFormat.yMMMd().format(DateTime.parse(document['timestamp']))}',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Payment Type :  ${document['cod'] == true ? 'Cash on delivery' : 'Paid Online'}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Amount : \Rs ${document['total'].toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          //TODO: Customer name , contact number
          ExpansionTile(
            title: Text(
              'Order details',
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
            subtitle: Text(
              'View order details',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                          document['products'][index]['productImage']),
                    ),
                    title: Text(
                      document['products'][index]['productName'],
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      '${document['products'][index]['qty']} x \Rs ${document['products'][index]['price'].toStringAsFixed(0)} = \Rs ${document['products'][index]['total'].toStringAsFixed(0)}',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  );
                },
                itemCount: document['products'].length,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Seller : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              document['seller']['shopName'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (int.parse(document['discount']) > 0)
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Discount : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${document['discount']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Discount Code: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${document['discountCode']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Delivery Fees: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '\Rs ${document['deliveryFee'].toString()}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 3,
            color: Colors.grey,
          ),
          Divider(
            height: 3,
            color: Colors.grey,
          ),
          statusContainer(document, context),
          Divider(
            height: 3,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget statusContainer(DocumentSnapshot document, context) {
    if (document['orderStatus'] == 'Accepted') {
      return Container(
        color: Colors.grey[300],
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 8, 40, 8),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            child: Text(
              'Assign Delivery Boy',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print('Assign delivery boy');
            },
          ),
        ),
      );
    }
    return Container(
      color: Colors.grey[300],
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog('Accept Order', 'Accepted', document.id, context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AbsorbPointer(
                absorbing: document['orderStatus'] == 'Rejected' ? true : false,
                child: TextButton(
                  style: document['orderStatus'] == 'Rejected'
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white))
                      : ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                  child: Text(
                    'Reject',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                        'Reject Order', 'Rejected', document.id, context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showDialog(title, status, documentId, context) {
    OrderServices _orderServices = OrderServices();
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text('Are you sure ?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  EasyLoading.show(status: 'Updating Status');
                  status == 'Accepted'
                      ? _orderServices
                          .updateOrderStatus(documentId, status)
                          .then((value) {
                          EasyLoading.showSuccess('Updated successfully');
                        })
                      : _orderServices
                          .updateOrderStatus(documentId, status)
                          .then((value) {
                          EasyLoading.showSuccess('Updated successfully');
                        });
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
