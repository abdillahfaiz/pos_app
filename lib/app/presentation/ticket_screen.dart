import 'package:flutter/material.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/core/components/app_button.dart';
import 'package:pos_app/app/core/string_const/assets_const.dart';
import 'package:pos_app/app/core/utility/currency_formatter.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  //COntroller untuk edit form
  final ticketEditController = TextEditingController();
  final priceEditController = TextEditingController();

  //Controller untuk create form
  final ticketNameController = TextEditingController();
  final priceController = TextEditingController();
  String kategoriValue = '';
  String kriteriaValue = '';

  List<Map<String, dynamic>> dataTicket = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(AssetsConst.backBtn),
        ),
        centerTitle: true,
        title: Text(
          'Kelola Tiket',
          style: TextStyle(color: AppColor.mainColor),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Nama Tiket'),
                          TextField(
                            controller: ticketNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nama Tiket',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Text('Harga'),
                          TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Harga Tiket',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Text('Kategori'),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Kategori',
                            ),
                            // value: ,
                            items: [
                              DropdownMenuItem(
                                value: 'Mancanegara',
                                child: Text('Mancanegara'),
                              ),
                              DropdownMenuItem(
                                value: 'Nusantara',
                                child: Text('Nusantara'),
                              ),
                            ],
                            onChanged: (value) {
                              kategoriValue = value ?? '';
                              print(kategoriValue);
                            },
                          ),
                          const SizedBox(height: 24.0),
                          Text('Kriteria'),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Kriteria',
                            ),
                            // value: ,
                            items: [
                              DropdownMenuItem(
                                value: 'Perorangan',
                                child: Text('Perorangan'),
                              ),
                              DropdownMenuItem(
                                value: 'Rombongan',
                                child: Text('Rombongan'),
                              ),
                            ],
                            onChanged: (value) {
                              kriteriaValue = value ?? '';
                            },
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppButton(
                                label: 'Batalkan',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                buttonColor: Colors.red,
                              ),
                              AppButton(
                                label: 'Simpan',
                                onPressed: () {
                                  dataTicket.add({
                                    'ticket_name': ticketNameController.text,
                                    'price': priceController.text,
                                    'category': kategoriValue,
                                    'criteria': kriteriaValue,
                                  });
                                  ticketNameController.clear();
                                  priceController.clear();
                                  kriteriaValue = '';
                                  kategoriValue = '';
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // children: [
                    //   Text('Nama Tiket'),
                    //   TextField(
                    //     controller: ticketNameController,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       hintText: 'Nama Tiket',
                    //     ),
                    //   ),
                    //   const SizedBox(height: 24.0),
                    //   Text('Harga'),
                    //   TextField(
                    //     controller: ticketNameController,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       hintText: 'Harga Tiket',
                    //     ),
                    //   ),
                    // ],
                  );
                },
              );
              print(dataTicket);
              print(kriteriaValue);
              setState(() {});
            },
            icon: Icon(Icons.add_box_outlined, color: AppColor.mainColor),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: dataTicket.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(dataTicket[index]['ticket_name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(dataTicket[index]['category']),
                  Text(
                    CurrencyFormatter.formatIDR(
                      int.parse(dataTicket[index]['price']),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dataTicket.removeAt(index);
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      ticketEditController.text =
                          dataTicket[index]['ticket_name'];
                      priceEditController.text = dataTicket[index]['price'];

                      await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Nama Tiket'),
                                  TextField(
                                    controller: ticketEditController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Nama Tiket',
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  Text('Harga'),
                                  TextField(
                                    controller: priceEditController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Harga Tiket',
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppButton(
                                        label: 'Batalkan',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        buttonColor: Colors.red,
                                      ),
                                      AppButton(
                                        label: 'Simpan',
                                        onPressed: () {
                                          // Cara 1---------
                                          dataTicket[index]['ticket_name'] =
                                              ticketEditController.text;

                                          dataTicket[index]['price'] =
                                              priceEditController.text;

                                          //Cara 2-----------
                                          // dataTicket[index] = {
                                          //   'ticket_name': ticketEditController.text,
                                          //   'price': priceEditController.text,
                                          //   'category': dataTicket[index]['category'],
                                          //   'criteria': dataTicket[index]['criteria'],
                                          // };

                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
