import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/static/message_static.dart';
import '../../provider/theme.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   MyMessage.myMessageChatBot(
  //       context,
  //       "سلام من یک ربات هستم . اما هنوز فعال نشدم اما به زودی راه اندازی میشم",
  //       5);
  // }

  TextEditingController message_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: theme.iconItem),
          backgroundColor: Colors.transparent,
          leadingWidth: myWidth * 0.2,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: (() {
                Navigator.pop(context);
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(IconlyLight.arrow_left_2, color: theme.iconItem),
              ),
            )
          ],
          elevation: 0.0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      height: myHeight * 0.15,
                      width: myWidth,
                      decoration: BoxDecoration(
                          color: theme.items,
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: const EdgeInsetsDirectional.all(15.0),
                      child: Text(
                        "سلام من یک ربات هستم . اما هنوز فعال نشدم اما به زودی راه اندازی میشم",
                        style: TextStyle(color: theme.text),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: myHeight * 0.08,
                width: myWidth,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: message_controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        IconlyBold.send,
                        color: theme.iconItem,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          message_controller.clear();
                        });
                      },
                      child:
                          Icon(Icons.close, size: 17.0, color: theme.iconItem),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
