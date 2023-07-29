import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://morningholic.creatorlink.net/%ED%99%88');

class UserInitialStatusScreen extends StatefulWidget {

  const UserInitialStatusScreen({super.key});

  @override
  State<UserInitialStatusScreen> createState() => _UserInitialStatusScreenState();
}

class _UserInitialStatusScreenState extends State<UserInitialStatusScreen> {
  WebViewController? _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(homeUrl)
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox.fromSize(size: const Size(0, 60)),
          Expanded(
            child: WebViewWidget(
              controller: _webViewController!,
            ),
          ),
          SizedBox.fromSize(size: const Size(0, 30)),
          CustomElevatedButton(
            text: '모닝홀릭 신청하러 가기',
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
          ),
          SizedBox.fromSize(size: const Size(0, 60)),
        ],
      ),
    );
  }
}
