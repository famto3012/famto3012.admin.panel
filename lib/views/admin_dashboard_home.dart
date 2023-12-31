import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';

import '../controller/customer_controller.dart';
import '../controller/dashboard_controller.dart';
import '../controller/restaurant_management_controller.dart';
import 'delivery_person_dashboard.dart';
import 'widget/customer_widget_home.dart';
import 'restaurants_widget_home.dart';
import 'widget/customer_details_widget.dart';
import 'widget/product_catalogue_widget.dart';
import 'widget/restaurant_details_widget.dart';

class AdminDashBoardHome extends StatefulWidget {
  const AdminDashBoardHome({super.key});

  @override
  State<AdminDashBoardHome> createState() => _AdminDashBoardHomeState();
}

class _AdminDashBoardHomeState extends State<AdminDashBoardHome> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final CustomerController _customerController = Get.put(CustomerController());
  final RestaurantManagementController _restaurantManagementController = Get.put(RestaurantManagementController());

  String deliveryMethod = "Take Away";
  String deliveryOption = "On Demand";
  bool addCustomer = false;
  final scrollController3 =  ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
//
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Admin Dashboard'),
              IconButton(
                icon: Icon(Icons.delivery_dining),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryAgentDashboard(),
                      // DeliveryAgentDashboard(
                      //   itemFreePersonList: _registrationController.freeDeliveryPerson,
                      //   itemBusy: _registrationController.busyDeliveryPerson,
                      // ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: Obx(
          () => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 0.5,
                  ),
                ),
                // color: Colors.green,
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      selected: _dashboardController.pageSelected == 'Home'
                          ? true
                          : false,
                      selectedColor: Colors.blue,
                      onTap: () {
                        _dashboardController.setPage("Home");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.list),
                      title: Text('Orders'),
                      selected: _dashboardController.pageSelected ==
                                  'Orders Listing' ||
                              _dashboardController.pageSelected ==
                                  "Create Order"
                          ? true
                          : false,
                      selectedColor: Colors.blue,
                      onTap: () {
                        _dashboardController.setPage("Orders Listing");
                        addCustomer = false;

                        setState(() {});
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('Restaurants'),
                      selected:
                          _dashboardController.pageSelected == 'Restaurants'
                              ? true
                              : false,
                      selectedColor: Colors.blue,
                      onTap: () {
                        _restaurantManagementController.getRestaurantDetailsAll();
                        _dashboardController.setPage("restaurant listing");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag),
                      title: Text('Products'),
                      selected: _dashboardController.pageSelected == 'catalogue'
                          ? true
                          : false,
                      selectedColor: Colors.blue,
                      onTap: () {
                        _dashboardController.setPage("catalogue");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.people),
                      title: Text('Customers'),
                      selected: _dashboardController.pageSelected == 'Customers'
                          ? true
                          : false,
                      selectedColor: Colors.blue,
                      onTap: () {
                        _dashboardController.setPage("customer listing");
                        _customerController.getCustomerDataAll();
                      },
                    )
                  ],
                ),
                // child: Column(children: [
                // InkWell(
                //   onTap: () {},
                //   child: ListTile(
                //     leading: Icon(Icons.home),
                //     title: Text('Home'),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const Placeholder()),
                //     );
                //   },
                //   child: ListTile(
                //     leading: Icon(Icons.list),
                //     title: Text('Orders'),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const Placeholder()),
                //     );
                //   },
                //   child: ListTile(
                //     leading: Icon(Icons.restaurant),
                //     title: Text('Restaurants'),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const Placeholder()),
                //     );
                //   },
                //   child: ListTile(
                //     leading: Icon(Icons.shopping_bag),
                //     title: Text('Products'),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const Placeholder()),
                //     );
                //   },
                //   child: ListTile(
                //     leading: Icon(Icons.shopping_bag),
                //     title: Text('Customers'),
                //   ),
                // )
                // ]
                // ),
              ),
            ),
            _dashboardController.pageSelected == "Orders Listing"
                ? Flexible(
                    flex: 4,
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Order Status'),
                              _createOrderButton(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: scrollController3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: scrollController3,
                              child: DataTable(
                                  border: TableBorder.all(color: Colors.blue),
                                  headingRowColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.30);
                                  }),
                                  columns: [
                                    DataColumn(label: Text('Order ID')),
                                    DataColumn(label: Text('Order Status')),
                                    DataColumn(label: Text('Restaurant')),
                                    DataColumn(
                                      label: Text('Customer'),
                                    ),
                                    DataColumn(label: Text('Delivery Mode')),
                                    DataColumn(label: Text('Delivery Agent')),
                                    DataColumn(
                                      label: Text('Order Time'),
                                      onSort: (columnIndex, ascending) {},
                                    ),
                                    DataColumn(
                                        label: Text('Scheduled Delivery Time')),
                                    DataColumn(
                                      label: Text('Payment Mode'),
                                    ),
                                    DataColumn(label: Text('Address')),
                                    DataColumn(label: Text('Amount')),
                                    DataColumn(
                                      label: Text('Payment Status '),
                                    ),
                                    DataColumn(
                                      label: Text('Rating '),
                                    ),
                                    DataColumn(
                                      label: Text('Order Preparation Time'),
                                    ),
                                    DataColumn(
                                      label: Text('Device Type '),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text("12345")),
                                      DataCell(Text("Completed")),
                                      DataCell(Text("Restaurant")),
                                      DataCell(Text("Ruban")),
                                      DataCell(Text("Take Away")),
                                      DataCell(Text("Agent Name")),
                                      DataCell(Text("July 04 2023")),
                                      DataCell(Text("July 04 2023")),
                                      DataCell(Text("Cash")),
                                      DataCell(Text("address: abc, xyz")),
                                      DataCell(Text("Rs.110")),
                                      DataCell(Text("-")),
                                      DataCell(Text("-")),
                                      DataCell(Text("5 min")),
                                      DataCell(Text("Web")),
                                    ])
                                  ]),
                            ),
                          ),
                        )
                      ],
                    )))
                : _dashboardController.pageSelected == "Create Order"
                    ? Flexible(
                        flex: 4,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _dashboardController
                                            .setPage("Orders Listing");
                                        addCustomer = false;
                                      },
                                      icon: Icon(Icons.arrow_back_sharp),
                                    ),
                                    Text('Create Order'),
                                    Obx(() => Visibility(
                                      visible: _customerController.errorMessage.isNotEmpty,
                                        child: Row(
                                          children: [
                                            Text(_customerController.errorMessage),
                                            IconButton(onPressed: () {
                                              _customerController.setErrorMessage();
                                            }, icon: const Icon(Icons.close))
                                          ],
                                        )))
                                    // _createOrderButton(),
                                  ],
                                ),
                                _spacer(),
                                !addCustomer
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: Text('Select Customer')),
                                          SizedBox(
                                            width: 600,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Customer',
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          ElevatedButton(
                                              onPressed: () {
                                                addCustomer = true;
                                                setState(() {});
                                              },
                                              child: Text("Add")),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: Text('Add Customer')),
                                          _spacer(),
                                          Obx(() => SizedBox(
                                            width: 600,
                                            height: 300,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 400,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Name',
                                                    ),
                                                    controller: _customerController.nameController,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Email',
                                                    ),
                                                    controller: _customerController.emailController,

                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Password',
                                                    ),
                                                    controller: _customerController.passwordController,

                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Phone Number',
                                                    ),
                                                    controller: _customerController.phoneNumberController,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          _customerController.createCustomer();
                                                        },
                                                        child: Text(
                                                            "Add Customer")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          addCustomer = false;
                                                          setState(() {});
                                                        },
                                                        child: Text("Cancel")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),),
                                        ],
                                      ),
                                _spacer(),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 300,
                                        child: Text('Select Delivery Method')),
                                    SizedBox(
                                        width: 600,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: RadioListTile(
                                                  title: Text("Take Away"),
                                                  value: "Take Away",
                                                  groupValue: deliveryMethod,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deliveryMethod =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: RadioListTile(
                                                  title: Text("Home Delivery"),
                                                  value: "Home Delivery",
                                                  groupValue: deliveryMethod,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deliveryMethod =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: RadioListTile(
                                                  title: Text("Pick and Drop"),
                                                  value: "Pick and Drop",
                                                  groupValue: deliveryMethod,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deliveryMethod =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),

                                deliveryMethod == "Pick and Drop" ||
                                        deliveryMethod == "Home Delivery"
                                    ? _spacer()
                                    : SizedBox.shrink(),
                                deliveryMethod == "Pick and Drop"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: Text('Pickup Address')),
                                          SizedBox(
                                            width: 600,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Enter Address',
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                                deliveryMethod == "Pick and Drop"
                                    ? _spacer()
                                    : SizedBox.shrink(),

                                deliveryMethod == "Pick and Drop"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 300,
                                              child: Text('Pickup Details')),
                                          SizedBox(
                                            width: 600,
                                            height: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText: 'Name',
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText:
                                                              'Phone Number',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Email',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                                deliveryMethod == "Pick and Drop"
                                    ? _spacer()
                                    : SizedBox.shrink(),

                                deliveryMethod == "Pick and Drop" ||
                                        deliveryMethod == "Home Delivery"
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                      'Select Delivery Address')),
                                              SizedBox(
                                                width: 600,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        'No address added',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          _spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: 250,
                                                  height: 100,
                                                  child: Card(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: 100,
                                                              child:
                                                                  Text("Home"),
                                                            ),
                                                            SizedBox(
                                                              width: 100,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  IconButton(
                                                                    iconSize:
                                                                        15,
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(
                                                                        Icons
                                                                            .edit),
                                                                  ),
                                                                  IconButton(
                                                                    iconSize:
                                                                        15,
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(Icons
                                                                        .delete),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                "Address: abc, xyz",
                                                                maxLines: 3,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 100,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          _spacer(),
                                          InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Add Addresses",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ))
                                        ],
                                      )
                                    : SizedBox.shrink(),
                                deliveryMethod == "Pick and Drop" ||
                                        deliveryMethod == "Home Delivery"
                                    ? _spacer()
                                    : SizedBox.shrink(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 300,
                                        child: Text('Select Delivery Option')),
                                    SizedBox(
                                        width: 600,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: RadioListTile(
                                                  title: Text("On Demand"),
                                                  value: "On Demand",
                                                  groupValue: deliveryOption,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deliveryOption =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: RadioListTile(
                                                  title: Text("Scheduling"),
                                                  value: "Scheduling",
                                                  groupValue: deliveryOption,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      deliveryOption =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                _spacer(),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 300,
                                        child: Text('Select Restaurants')),
                                    SizedBox(
                                      width: 600,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Restaurants',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _spacer(),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     Text('Select Restaurants'),
                                //     TextField(
                                //       decoration: InputDecoration(
                                //         border: OutlineInputBorder(),
                                //         hintText: 'Restaurants',
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 300,
                                        child: Text('Search Product')),
                                    SizedBox(
                                      width: 600,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Products',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                _spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(width: 300),
                                    SizedBox(
                                      width: 350,
                                      height: 100,
                                      child: Card(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('Gobi Manchurian (Rs.40)'),
                                              InputQty(
                                                btnColor1: Colors.blue,
                                                btnColor2: Colors.blue,
                                                showMessageLimit: false,
                                                textFieldDecoration:
                                                    InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                boxDecoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.transparent,
                                                      width: 0.0),
                                                ),
                                                maxVal: double
                                                    .maxFinite, //max val to go
                                                initVal: 1,
                                                minVal: 1, //min starting val
                                                onQtyChanged: (val) {
                                                  print(val);

                                                  //on value changed we may set the value
                                                  //setstate could be called
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 20.0),
                                            child: Text('Rs.160'),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),

                                _spacer(),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     Text('Search Product'),
                                //     TextField(
                                //       decoration: InputDecoration(
                                //         border: OutlineInputBorder(),
                                //         hintText: 'Products',
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 300,
                                        child: Text('Any Suggestions?')),
                                    SizedBox(
                                      width: 600,
                                      child: TextField(
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Suggestions',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Invoices")),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(width: 300),
                                    SizedBox(
                                      width: 350,
                                      height: 150,
                                      child: Card(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _orderCostDetails(
                                            "Gobi Manchurian",
                                            "Rs.40",
                                          ),
                                          Divider(),
                                          _orderCostDetails(
                                            'Sub Total',
                                            "Rs.40",
                                          ),
                                          _orderCostDetails(
                                            'Sales Tax @5%',
                                            'Rs.2',
                                          ),
                                          _orderCostDetails(
                                            'GST @100%',
                                            'Rs.40',
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Create Order - Rs.84")),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     Text('Any Suggestions?'),
                                //     TextField(
                                //       decoration: InputDecoration(
                                //         border: OutlineInputBorder(),
                                //         hintText: 'Suggestions',
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : _dashboardController.pageSelected == "customer listing"
                        ? CustomerListing()
                        : _dashboardController.pageSelected ==
                                "restaurant listing"
                            ? RestaurantListing()
                            : _dashboardController.pageSelected == "catalogue"
                                ? ProductCatalogueScreen()
                                : _dashboardController.pageSelected ==
                                        "customer details"
                                    ? CustomerDetailsWidget()
                                    : _dashboardController.pageSelected ==
                                            "restaurant details"
                                        ? RestaurantDetailsWidget()
                                        : Flexible(
                                            flex: 4, child: SizedBox.shrink())
          ]),
        ));
  }

  Row _orderCostDetails(text1, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 120, child: Text(text1)),
        SizedBox(width: 120, child: Text(text2)),
      ],
    );
  }

  SizedBox _spacer() {
    return SizedBox(
      height: 20,
    );
  }

  ElevatedButton _createOrderButton() {
    return ElevatedButton(
      onPressed: () {
        _dashboardController.setPage("Create Order");
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      child: const Text("Create Order", style: TextStyle(color: Colors.black)),
    );
  }
}
