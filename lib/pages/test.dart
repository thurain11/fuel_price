import 'package:market_price/widgets/err_state_widget/no_internet_widget.dart';

import '../global.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Center(child: NoInternetWidget()),
    );
  }
}
