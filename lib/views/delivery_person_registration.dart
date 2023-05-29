import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as fb;
import 'package:universal_html/html.dart' as html;
import '../controller/registration_controller.dart';
import 'dart:async';

class DeliveryPersonRegistrationForm extends StatefulWidget {
  DeliveryPersonRegistrationForm({super.key});

  @override
  State<DeliveryPersonRegistrationForm> createState() =>
      _DeliveryPersonRegistrationFormState();
}

class _DeliveryPersonRegistrationFormState
    extends State<DeliveryPersonRegistrationForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _panController = TextEditingController();

  final TextEditingController _aadharController = TextEditingController();

  final TextEditingController _photoController = TextEditingController();

  final TextEditingController _drivingLicenseController =
      TextEditingController();

  final TextEditingController _vehicleRegistrationController =
      TextEditingController();

  final TextEditingController _emergencyContactNumberController =
      TextEditingController();

  final TextEditingController _vehicleTypeController = TextEditingController();

  final TextEditingController _vehicleLicenseNumberController =
      TextEditingController();

  String _selectedCategory = "Approved";

  String photoImageUrl = "";

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    var deliveryCategoryList = [
      "Approved",
      "Pending",
      "Rejected",
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                ),
                controller: _nameController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter your phone number",
                ),
                controller: _phoneNumberController,
              ),
              TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your address",
                ),
                controller: _addressController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "PAN",
                  hintText: "Enter your PAN number",
                ),
                controller: _panController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Aadhar",
                  hintText: "Enter your Aadhar number",
                ),
                controller: _aadharController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Driving License",
                  hintText: "Enter your driving license number",
                ),
                controller: _drivingLicenseController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Vehicle Registration",
                  hintText: "Enter your vehicle registration number",
                ),
                controller: _vehicleRegistrationController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Emergency Contact Number",
                  hintText: "Enter your emergency number",
                ),
                controller: _emergencyContactNumberController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Vehicle Type",
                  hintText: "Enter your vehicle type",
                ),
                controller: _vehicleTypeController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Vehicle License Number",
                  hintText: "Enter your vehicle license number",
                ),
                controller: _vehicleLicenseNumberController,
              ),
              SizedBox(
                height: 20.0,
              ),
              if (photoImageUrl != "")
                Image.network(
                  photoImageUrl,
                  height: 100.0,
                  width: 100.0,
                )
              else
                const Placeholder(
                  fallbackHeight: 100.0,
                  fallbackWidth: 100.0,
                ),
              // Image.network(
              //   "https://firebasestorage.googleapis.com/v0/b/famto-project.appspot.com/o/delivery-person-docs%2Fistockphoto-825383494-612x612.jpg?alt=media&token=fc5d465f-1e4a-4c1e-9620-7addfff04a65",
              //   height: 100.0,
              //   width: 100.0,
              // ),
              ElevatedButton(
                  onPressed: () async {
                    String url = "";
                    XFile? image = await selectPicture(ImageSource.gallery);
                    String? path = image?.path;
                    String? name = image?.name;
                    if (image != null && path != null && name != null) {
                      Uint8List imageData = await XFile(path).readAsBytes();
                      FirebaseStorage storage = FirebaseStorage.instance;
                      Reference ref =
                          storage.ref().child("images/$name-${DateTime.now()}");
                      UploadTask uploadTask = ref.putData(imageData);
                      uploadTask.then((res) async {
                        url = await res.ref.getDownloadURL();

                        setState(() {
                          photoImageUrl = url;
                          print("URL: $photoImageUrl");
                        });
                      });
                    }

                    // var picked = await FilePicker.platform.pickFiles();

                    // if (picked != null) {
                    //   print(picked.files.first.name);
                    //   uploadPic(io.File(picked.files.first.name));
                    // }
                  },
                  child: Text("Upload Photo")),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedCategory,
                items: deliveryCategoryList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value.toString();
                  });
                },
                hint: const Text("Select Delivery Category"),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    _registrationController.createDeliveryPersonRegistration(
                      phoneNumber: _phoneNumberController.text,
                      name: _nameController.text,
                      address: _addressController.text,
                      pan: _panController.text,
                      photo: photoImageUrl,
                      aadhaar: _aadharController.text,
                      drivingLicense: _drivingLicenseController.text,
                      status: _selectedCategory,
                      vehicleRegistration: _vehicleRegistrationController.text,
                      emergencyContact: _emergencyContactNumberController.text,
                      availability: true,
                    );
                  },
                  child: const Text("Register Delivery Person")),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<XFile?> selectPicture(ImageSource source) async {
    XFile? image;
    image = await ImagePicker().pickImage(
      source: source,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    return image;
  }

  // uploadImage() async {
  //   String url = "";

  //   // final ImagePicker picker = ImagePicker();
  //   // var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (pickedFile != null) {
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     Reference ref =
  //         storage.ref().child("images/" + DateTime.now().toString());
  //     UploadTask uploadTask = ref.putFile(io.File(pickedFile.path));
  //     uploadTask.then((res) {
  //       url = res.ref.getDownloadURL() as String;
  //     });
  //   }
  //   print(url);
  //   return url;
  // }

  // uploadFile(io.File image1) async {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   String url = "";
  //   Reference ref = storage.ref().child("images/${DateTime.now()}");
  //   UploadTask uploadTask = ref.putFile(image1);
  //   uploadTask.whenComplete(() {
  //     url = ref.getDownloadURL() as String;
  //     print(url);
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  //   return url;
  // }
}
