import 'package:flutter/material.dart';
import 'package:glob_app/data/shared_prefs.dart';
import 'package:glob_app/models/network_settings.dart';
import 'package:glob_app/services/network.service.dart';
import 'package:glob_app/shared/menu_bar.dart';

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
  NetworkSettings? networkSettings;
  NetworkService networkService = NetworkService();

  @override
  void initState() {
    settings.init().then((value) async {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        fontType = settings.getFontType();
      });
    });
    super.initState();
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
    // if(networkInterfaces.isEmpty) return [];

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