import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class LocationController extends GetxController {
  RxString concatenatedString ="".obs;
  RxBool servicestatus = false.obs;
  RxBool haspermission = false.obs;
  late LocationPermission permission;
  late Position position;
  RxString long = "".obs, lat = "".obs;
  var address = 'No location set'.obs;
  var address2 = 'No location set'.obs;
  var postalCode = 'No location set'.obs;
  var address1 = 'No location set'.obs;
  var locality = 'No location set'.obs;
  var country = 'Getting Country..'.obs;
  late StreamSubscription<Position> positionStream;

  checkGps(context) async {
    servicestatus.value = await Geolocator.isLocationServiceEnabled();
    if (servicestatus.value) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied) {
          haspermission.value = true;
        }
      } else {
        haspermission.value = true;
      }

      if (haspermission.value) {
        getLocation();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Location",
            ),
            content: const Text(
              "Please enable the location to place",
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                  servicestatus.value =
                  await Geolocator.isLocationServiceEnabled();
                  if (servicestatus.value) {
                    permission = await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                      } else if (permission ==
                          LocationPermission.deniedForever) {
                      } else {
                        haspermission.value = true;
                      }
                    } else {
                      haspermission.value = true;
                    }

                    if (haspermission.value) {
                      getLocation();
                    }
                  }
                },
              ),
            ],
          ));
    }
  }

  Future getLocation() async {
    log("Getting user location.........");
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    long.value = position.longitude.toString();
    lat.value = position.latitude.toString();
    print("Address$position");

    await placemarkFromCoordinates(double.parse(lat.value), double.parse(long.value)).then((value) async {
      locality.value = value.last.street!;
      address.value = value.first.name!;
      address1.value = value.first.street!;
      address2.value = value.first.administrativeArea!;
      postalCode.value = value.first.postalCode!;
      country.value = '${value.first.subLocality}';
      concatenatedString.value = "${address.value} ${country.value} ${postalCode.value}  ${locality.value} ${address2.value}";
      log("COMPLETE USER ADDRESS : $concatenatedString");
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     checkGps(Get.context);
  }
}