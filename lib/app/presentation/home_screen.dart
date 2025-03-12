// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/core/components/app_button.dart';
import 'package:pos_app/app/presentation/order_detail_screen.dart';
import 'package:pos_app/data/models/ticket_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TicketModel> ticketDummy = [
    TicketModel(
      title: 'Tiket Masuk Dewasa',
      subtitle: 'Nusantara',
      price: 50000,
    ),
    TicketModel(title: 'Tiket Masuk Anak', subtitle: 'Nusantara', price: 30000),
    TicketModel(
      title: 'Tiket Masuk Dewasa',
      subtitle: 'Mancanegara',
      price: 150000,
    ),
    TicketModel(
      title: 'Tiket Masuk Anak',
      subtitle: 'Mancanegara',
      price: 130000,
    ),
    TicketModel(
      title: 'Tiket Masuk Keluarga',
      subtitle: 'Nusantara 4 orang',
      price: 175000,
    ),
  ];

  int totalAmount = 20000;



  void updateTotalPrice() {
    setState(() {
      totalAmount = ticketDummy.fold(
        0,
        (sum, ticket) => sum + (ticket.price * ticket.count),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Penjualan', style: TextStyle(color: AppColor.mainColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: ticketDummy.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemBuilder: (context, index) {
                var data = ticketDummy[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == ticketDummy.length - 1 ? 100 : 0,
                  ),
                  child: ItemCardHome(
                    title: data.title,
                    subtitle: data.subtitle,
                    price: data.price,
                    count: data.count,
                    totalPrice: data.totalPrice,
                    onPressed: () {
                      updateTotalPrice();
                    },
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Summary'),
                          Text(
                            'Rp ${totalAmount.toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      AppButton(
                        label: 'Process',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/order-detail',
                            arguments: {
                              'product' : ticketDummy,
                              'totalAmount' : totalAmount,
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCardHome extends StatefulWidget {
  ItemCardHome({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.count,
    required this.totalPrice,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final int price;
  int count;
  int totalPrice;
  void Function()? onPressed;

  @override
  State<ItemCardHome> createState() => _ItemCardHomeState();
}

class _ItemCardHomeState extends State<ItemCardHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: TextStyle(fontSize: 15)),
                Text(
                  widget.subtitle,
                  style: TextStyle(fontSize: 11, color: AppColor.subtitleGrey),
                ),
                const SizedBox(height: 13.0),
                Text(
                  'Rp ${widget.price}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        if (widget.count == 0) {
                          return;
                        } else {
                          setState(() {
                            widget.count--;
                            widget.totalPrice = widget.price * widget.count;
                            widget.onPressed;
                          });
                        }
                      },
                      icon: Icon(Icons.remove, color: AppColor.mainColor),
                    ),
                    Text(
                      widget.count.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {
                        setState(() {
                          widget.count++;
                          widget.totalPrice = widget.price * widget.count;
                          widget.onPressed;
                        });
                      },
                      icon: Icon(Icons.add, color: AppColor.mainColor),
                    ),
                  ],
                ),
                Text(
                  'Rp ${widget.totalPrice}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
