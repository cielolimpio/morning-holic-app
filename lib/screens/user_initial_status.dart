import 'package:flutter/material.dart';
import 'package:morning_holic_app/components/app_bar.dart';
import 'package:morning_holic_app/components/elevated_button.dart';
import 'package:morning_holic_app/constants/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://morningholic.creatorlink.net/%ED%99%88');

class UserInitialStatusScreen extends StatefulWidget {
  const UserInitialStatusScreen({super.key});

  @override
  State<UserInitialStatusScreen> createState() =>
      _UserInitialStatusScreenState();
}

class _UserInitialStatusScreenState extends State<UserInitialStatusScreen> {
  WebViewController? _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
      ))
      ..loadRequest(homeUrl)
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox.fromSize(size: const Size(0, 60)),
                Expanded(
                  child: Stack(children: [
                    WebViewWidget(
                      controller: _webViewController!,
                    ),
                  ]),
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
            if (isLoading)
              const Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.3,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
