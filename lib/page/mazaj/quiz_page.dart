import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/user_static.dart';
import 'package:sara_plant/model/new/quiz_model.dart';
import 'package:sara_plant/page/mazaj/answer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/helper.dart';
import '../../provider/theme.dart';
import '../start_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    get_all_quiz();
  }

  int _currentPage = 0;
  PageController _controller = PageController();
  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    generate_bool();
    answer_id_send.add(select_answer);
  }

  bool set_mazaj_bool = false;
  void set_mazaj(bool mazaj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("mazaj", set_mazaj_bool);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: is_loading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        onPageChanged: _onChanged,
                        itemCount: quiz_data.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                                height: myHeight * 0.2,
                                padding: const EdgeInsets.all(30.0),
                                child:
                                    Center(child: Text(quiz_data[index].quiz))),
                            Expanded(
                                child: ListView.builder(
                              itemCount: answer_data[_currentPage].length,
                              itemBuilder: (context, i) {
                                print(answer_bool);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ListTile(
                                    tileColor: answer_bool[i]
                                        ? Colors.greenAccent.withOpacity(0.5)
                                        : Colors.grey.withOpacity(0.1),
                                    onTap: () {
                                      setState(() {
                                        generate_bool();
                                        answer_bool[i] = true;
                                        select_answer =
                                            answer_data[_currentPage][i].id;
                                      });
                                      _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 800),
                                          curve: Curves.easeInOutQuint);
                                    },
                                    title: Text(
                                        answer_data[_currentPage][i].title),
                                    trailing: Icon(
                                      answer_bool[i]
                                          ? IconlyBold.tick_square
                                          : IconlyLight.close_square,
                                      color: answer_bool[i]
                                          ? Colors.green
                                          : Colors.redAccent.withOpacity(0.4),
                                    ),
                                  ),
                                );
                              },
                            )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            children: List<Widget>.generate(quiz_data.length,
                                (int index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 4.0,
                            width: (index == _currentPage) ? 45.0 : 4.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 30.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: (index == _currentPage)
                                    ? theme.animatedContainerToturial
                                    : theme.animatedContainerToturial
                                        .withOpacity(0.5)),
                          );
                        })),
                        Expanded(
                            child: Container(
                          height: myHeight * 0.07,
                          child: (_currentPage == (quiz_data.length - 1))
                              ? go_to_app()
                              : page_next(),
                        ))
                      ],
                    )
                  ],
                ),
              )
            : const My_loading(),
      ),
    );
  }

  List<bool> answer_bool = [];
  void generate_bool() {
    answer_bool = List<bool>.generate(
        answer_data[_currentPage].length, (counter) => false);
  }

  int? select_answer;
  var answer_id_send = [];

  var quiz_data_backup = [];
  var quiz_data = [];
  var answer_data_final = [];
  var answer_data = [];
  List quiz_data_list = [];
  bool is_loading = false;
  Future<QuizModel?> get_all_quiz() async {
    String url = Helper.url + 'mazaj/get_question';
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      var x = res.body;
      var get_data = quizModelFromJson(x);
      setState(() {
        quiz_data = get_data;
        quiz_data_backup = get_data;
        quiz_data_list = get_data;
        is_loading = true;
      });
      for (var i = 0; i < quiz_data.length; i++) {
        setState(() {
          answer_data.add(quiz_data[i].answer);
        });
      }
      generate_bool();
    } else {}
  }

  void message_create_mazaj() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('مزاج شما با موفقیت تعیین شد')));
  }

  void message_error_mazaj() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('متاسفانه خطایی رخ داده لطفا دوباره امتحان کنید')));
  }

  var answer_data_get;
  String? mazaj_select;
  void answer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String url = Helper.url + "mazaj/get_answer";
    print(answer_id_send);
    var body = json.encode({
      "answer": answer_id_send,
      "user": UserStaticFile.user_id,
    });
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> result = json.decode(res.body);
      setState(() {
        answer_data_get = result;
      });
      print(result);
      message_create_mazaj();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AnswerPage(data: answer_data_get)));
    } else {
      message_error_mazaj();
    }
  }

  Widget page_next() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            _controller.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutQuint);
          },
          child: Container(
            height: myHeight * 0.05,
            width: myWidth * 0.2,
            decoration: BoxDecoration(
                color: theme.nextBackButton,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Text("بعدی",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme.text))),
          ),
        ),
      ],
    );
  }

  Widget go_to_app() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            answer_id_send.add(select_answer);
            answer();
          },
          child: Container(
            height: myHeight * 0.05,
            width: myWidth * 0.3,
            decoration: BoxDecoration(
                color: theme.nextBackButton,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Text("تعیین مزاج",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme.text))),
          ),
        ),
      ],
    );
  }
}
