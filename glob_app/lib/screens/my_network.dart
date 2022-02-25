import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glob_app/data/shared_prefs.dart';
import 'package:glob_app/models/network_settings.dart';
import 'package:glob_app/shared/menu_bar.dart';
import 'package:network_info_plus/network_info_plus.dart';

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
  List<NetworkInterface> networkInterfaces = <NetworkInterface>[];
  final info = NetworkInfo();
  NetworkSettings? networkSettings;

  @override
  void initState() {
    settings.init().then((value) async {
      List<NetworkInterface> networks = await NetworkInterface.list(includeLoopback: true);
      // ConnectivityResult connectivity = await Connectivity().checkConnectivity();

      String? wifiName = await info.getWifiName(); // FooNetwork
      String? wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
      String? wifiIP = await info.getWifiIP(); // 192.168.1.43
      String? wifiIPv6 = await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
      String? wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
      String? wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
      String? wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1

      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        fontType = settings.getFontType();
        networkInterfaces = networks;
        networkSettings = NetworkSettings(wifiName, wifiBSSID, wifiIP, wifiIPv6, wifiSubmask, wifiBroadcast, wifiGateway);
      });
    });
    super.initState();
  }

  String buildNetworkSettings(InternetAddress ipInfo, String name) {
    String text = '\n\nName: $name\nValue: ${ipInfo.address}'
        '\nHost: ${ipInfo.host}'
        // '\nConnection Name: ${connectivity.name}'
        '\nGateway: ${networkSettings?.wifiGateway ?? 'n/a'}'
        '\nWifi Name: ${networkSettings?.wifiName}'
        '\nWifi Broadcast: ${networkSettings?.wifiBroadcast}'
        '\nWifi Ipv4: ${networkSettings?.wifiIp}'
        '\nWifi Ipv6: ${networkSettings?.wifiIpv6}'
        '\nWifi BssId: ${networkSettings?.wifiBssId}'
        '\nWifi Submask: ${networkSettings?.wifiSubmask}'
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
          child: ListView(
            children: buildNetworkItems(),
          ),
        ));
  }

  List<Widget> buildNetworkItems() {
    String networkSettingsText = 'Network Settings: ';
    List<Widget> networkItems = <Widget>[];
    if(networkInterfaces.isEmpty) return [];

    for(NetworkInterface networkInterface in networkInterfaces) {
      String name = networkInterface.name;
      for(InternetAddress ipInfo in networkInterface.addresses) {
        Widget widget = ListTile(
          leading: Text(name),
          title: Text(buildNetworkSettings(ipInfo, name), style: TextStyle(fontSize: fontSize, fontFamily: fontType)),
          // title: Text(name),
          // leading: Text(buildNetworkSettings(ipInfo, name), style: TextStyle(fontSize: fontSize, fontFamily: fontType)),
        );
        networkItems.add(widget);
        // networkSettingsText += buildNetworkSettings(ipInfo, name);
      }
    }

    return networkItems;
  }
}