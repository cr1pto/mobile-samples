import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glob_app/data/shared_prefs.dart';
import 'package:glob_app/shared/menu_bar.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class MyNetworkScreen extends StatefulWidget {
  const MyNetworkScreen({Key? key}) : super(key: key);

  @override
  _MyNetworkScreenState createState() => _MyNetworkScreenState();
}

class _MyNetworkScreenState extends State<MyNetworkScreen> {
  SPSettings settings = SPSettings();
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  String fontType = 'courier';

  String networkSettingsText = '';

  @override
  void initState() {
    settings.init().then((value) async {
      List<NetworkInterface> networkInterfaces = await NetworkInterface.list(includeLoopback: true);
      // ConnectivityResult connectivity = await Connectivity().checkConnectivity();

      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        fontType = settings.getFontType();
        networkSettingsText += 'Network Settings: ';
        for(NetworkInterface networkInterface in networkInterfaces) {
          String name = networkInterface.name;
          for(InternetAddress ipInfo in networkInterface.addresses) {
            networkSettingsText += buildNetworkSettings(ipInfo, name);
          }
        }
      });
    });
    super.initState();
  }

  String buildNetworkSettings(InternetAddress ipInfo, String name) {
    String text = '\n\nName: $name\nValue: ${ipInfo.address}'
        '\nHost: ${ipInfo.host}'
        // '\nConnection Name: ${connectivity.name}'
        '\nType: ${ipInfo.type.name}';

    text += ipInfo.type.name.contains('IPv4') ?  '\nRaw Address:${ipInfo.rawAddress.toString().replaceAll(', ', '.')}': '\nRaw Address:${ipInfo.rawAddress.toString().replaceAll(', ', ':')}';

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Network'),
          backgroundColor: Color(settingColor),
        ),

        drawer: const MenuDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(networkSettingsText,
            style: TextStyle(fontSize: fontSize, fontFamily: fontType)),
        ));
  }
}