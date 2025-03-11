import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Order Detail')),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: arguments['product'].length,
            itemBuilder: (context, index) {
              final data = arguments['product'][index] as TicketModel;
              return ListTile(
                title: Text(data.title),
                subtitle: Text(data.subtitle),
                trailing: Text('Rp ${data.price}'),
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
              ),
              _PaymentButton(
                title: 'Cash',
                onPressed: () {
                  setState(() {
                    paymentMethod = 'Cash';
                  });
                },
                isSelected: paymentMethod == 'Cash',
              ),
              _PaymentButton(
                title: 'Transfer',
                onPressed: () {
                  setState(() {
                    paymentMethod = 'Transfer';
                  });
                },
                isSelected: paymentMethod == 'Transfer',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentButton extends StatelessWidget {
  const _PaymentButton({
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final String title;
  final void Function()? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(title),
    );
  }
}
