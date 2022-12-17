import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/splash_page.dart';
import '../components/loading_com.dart';
import '../components/no_internet.dart';
import '../provider/check_internet.dart';

class CheckNet extends StatefulWidget {
  const CheckNet({Key? key}) : super(key: key);

  @override
  State<CheckNet> createState() => _CheckNetState();
}

class _CheckNetState extends State<CheckNet> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: pageUI());
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (consumerContext, model, child) {
        if (model.isOnline != null) {
          return model.isOnline ? const Splash() : const NoInternet();
        }
        return const LoadingComponent();
      },
    );
  }
}
