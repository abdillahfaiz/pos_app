import 'package:flutter/material.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/core/components/app_button.dart';
import 'package:pos_app/app/core/string_const/assets_const.dart';
import 'package:pos_app/data/models/ticket_model.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String paymentMethod = '';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(AssetsConst.backBtn),
        ),
        title: Text('Penjualan', style: TextStyle(color: AppColor.mainColor)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary'),
                  Text(
                    'Rp total_amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              AppButton(
                label: 'Process',
                onPressed: paymentMethod.isEmpty ? null : () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: arguments['product'].length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final data = arguments['product'][index] as TicketModel;
                  return ItemCardOrder(
                    title: data.title,
                    subtitle: data.subtitle,
                    price: data.price,
                    count: data.count,
                    totalPrice: data.totalPrice,
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Total Amount'),
                trailing: Text('Rp ${arguments['totalAmount']}'),
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  _PaymentButton(
                    title: 'QRIS',
                    onPressed: () {
                      setState(() {
                        paymentMethod = 'QRIS';
                      });
                    },
                    isSelected: paymentMethod == 'QRIS',
                    icon: AssetsConst.qris,
                  ),
                  _PaymentButton(
                    title: 'Cash',
                    onPressed: () {
                      setState(() {
                        paymentMethod = 'Cash';
                      });
                    },
                    isSelected: paymentMethod == 'Cash',
                    icon: AssetsConst.cash,
                  ),
                  _PaymentButton(
                    title: 'Transfer',
                    onPressed: () {
                      setState(() {
                        paymentMethod = 'Transfer';
                      });
                    },
                    isSelected: paymentMethod == 'Transfer',
                    icon: AssetsConst.transfer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentButton extends StatelessWidget {
  const _PaymentButton({
    required this.title,
    required this.onPressed,
    required this.isSelected,
    required this.icon,
  });

  final String title;
  final void Function()? onPressed;
  final bool isSelected;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColor.mainColor : Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? AppColor.mainColor : Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            color: isSelected ? Colors.white : AppColor.mainColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColor.mainColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCardOrder extends StatefulWidget {
  const ItemCardOrder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.count,
    required this.totalPrice,
  });

  final String title;
  final String subtitle;
  final int price;
  final int count;
  final int totalPrice;

  @override
  State<ItemCardOrder> createState() => _ItemCardOrderState();
}

class _ItemCardOrderState extends State<ItemCardOrder> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 15)),
            Text(
              widget.subtitle,
              style: TextStyle(fontSize: 11, color: AppColor.subtitleGrey),
            ),
            const SizedBox(height: 13.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp ${widget.price} x ${widget.count}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
