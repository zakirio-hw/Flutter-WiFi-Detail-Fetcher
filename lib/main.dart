import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wi-Fi API Flutter',
      home: WifiDetailDialog(),
    );
  }
}

class WifiDetailDialog extends StatelessWidget {
  Future<void> _getWifiInfo(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      String wifiName = await WifiInfo().getWifiName() ?? 'Unknown SSID';
      String wifiIP = await WifiInfo().getWifiIP() ?? 'Unknown IP Address';
      String wifiBSSID = await WifiInfo().getWifiBSSID() ?? 'Unknown BSSID';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Wi-Fi Details'),
            content: Text('SSID: $wifiName\n'
                'IP Address: $wifiIP\n'
                'BSSID: $wifiBSSID'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Denied'),
            content: Text('Location permission is required to get Wi-Fi information.'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zakirio\'s Wi-Fi Detail Fetcher'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _getWifiInfo(context),
          child: Text('Show Wi-Fi Details'),
        ),
      ),
    );
  }
}
