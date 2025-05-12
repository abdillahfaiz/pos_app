import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/core/components/app_button.dart';
import 'package:pos_app/app/core/string_const/assets_const.dart';
import 'package:pos_app/app/core/utility/currency_formatter.dart';
import 'package:pos_app/app/cubit/product_cubit/product_cubit.dart';
import 'package:pos_app/app/cubit/product_cubit/product_state.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getAllProduct(),
      child: _Content(),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
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
  void dispose() {
    ticketEditController.dispose();
    priceEditController.dispose();
    ticketNameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listenWhen:
          (previous, current) => current.deleteSucces != previous.deleteSucces,
      listener: (context, state) async {
        if (state.deleteSucces.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.deleteSucces.message ?? '')),
          );
          await context.read<ProductCubit>().getAllProduct();
          context.read<ProductCubit>().resetDeleteState();
        }
      },
      child: Scaffold(
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
                var result = await showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ProductCubit(),
                      child: _CreateProductDialog(),
                    );
                  },
                );

                if (result == true) {
                  context.read<ProductCubit>().getAllProduct();
                }
              },
              icon: Icon(Icons.add_box_outlined, color: AppColor.mainColor),
            ),
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: LoadingAnimationWidget.halfTriangleDot(
                  color: AppColor.mainColor,
                  size: 32,
                ),
              );
            }

            if (state.error != '') {
              return Center(child: Text(state.error));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: () => context.read<ProductCubit>().getAllProduct(),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.productData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.productData[index].name ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(state.productData[index].description ?? ''),
                            Text(
                              CurrencyFormatter.formatIDR(
                                state.productData[index].price ?? 0,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await context
                                    .read<ProductCubit>()
                                    .deleteProduct(
                                      state.productData[index].id ?? 0,
                                    );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                ticketEditController.text =
                                    dataTicket[index]['ticket_name'];
                                priceEditController.text =
                                    dataTicket[index]['price'];

                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        ticketEditController
                                                            .text;

                                                    dataTicket[index]['price'] =
                                                        priceEditController
                                                            .text;

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
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CreateProductDialog extends StatelessWidget {
  _CreateProductDialog();

  final ticketNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama Tiket'),
              TextFormField(
                controller: ticketNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nama Tiket',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Tiket tidak boleh kosogn';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Text('Deskripsi'),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Harga Tiket',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosogn';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Text('Harga'),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Harga Tiket',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosogn';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 24.0),
              Text('Stock'),
              TextFormField(
                controller: stockController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Stock Tiket',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stock tidak tidak boleh kosogn';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      return state.isLoading
                          ? CircularProgressIndicator()
                          : AppButton(
                            label: 'Simpan',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await context
                                    .read<ProductCubit>()
                                    .createProduct(
                                      name: ticketNameController.text,
                                      description: descriptionController.text,
                                      price: int.parse(priceController.text),
                                      stock: int.parse(stockController.text),
                                    );
                                Navigator.pop(context, true);
                              }
                            },
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
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
  }
}
