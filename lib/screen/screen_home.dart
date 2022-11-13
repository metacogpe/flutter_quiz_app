import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;  // 반응형 위한 사이즈 가져오기
    double width = screenSize.width;
    double height = screenSize.height;
    
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),  // AppBar에서 페이지 이동시 뒤로가기 버튼 지우기 효과
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'images/quiz.jpg', 
                  width: width * 0.8,
                ),
              ),
              Padding(padding: EdgeInsets.all(width * 0.024),
              ),
              Text(
                'Flutter Quiz App',
                style: TextStyle(
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Info About Quiz\n 퀴즈 풀기를 눌러 주세요.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
    );
  }
}
