import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    late InAppWebViewController webViewController;
    final GlobalKey globalKey = GlobalKey();
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (_) {
              return showDialogExit(context);
            });
        return false;
      },
      child: Scaffold(
        body: InAppWebView(
          key: globalKey,
          initialUrlRequest: URLRequest(
            url: Uri.parse(
                'http://ebook.windypermadi.com/Unity/projectsw/kelompoksatu'),
          ),
          initialOptions: options,
          onWebViewCreated: (InAppWebViewController controller) {
            webViewController = controller;
          },
        ),
      ),
    );
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
          disableDefaultErrorPage: true, useHybridComposition: true),
      ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
          allowsAirPlayForMediaPlayback: true));
}

AlertDialog showDialogExit(BuildContext context) {
  return AlertDialog(
    title:const Text('Keluar'),
    content:const Text('Yakin Mau Keluar Nih ?'),
    actions: [
      TextButton(
          onPressed: () => Navigator.pop(context), child: const Text('Tidak')),
           TextButton(
          onPressed: () {
             if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
          }, child: const Text('Keluar',style: TextStyle(color: Colors.grey),))
    ],
  );
}
