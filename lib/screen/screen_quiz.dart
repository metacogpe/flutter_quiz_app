// 퀴즈 화면 구현
import 'package:flutter/material.dart';
import 'package:quiz_app/model/model_quiz.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;

  QuizScreen({required this.quizs}); // 이전 화면에서 퀴즈 데이터 넘겨 받게 됨

  @override
  _QuizScreenState createState() => _QuizScreenState(); // 상태 선언
}

class _QuizScreenState extends State<QuizScreen> {
  // 3가지 상태 정의 : 퀴즈별 답안, 답안상태
  List<int> _answers = [-1, -1, -1]; // 퀴즈별 답안
  List<bool> _answersState = [false, false, false, false]; // 4개 보기의 눌린 상태
  int _currentIndex = 0; // 현재 보고 있는 퀴즈
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size; // 반응형 위한 사이즈 가져오기
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
              ),
              width: width * 0.85,
              height: height * 0.5,
            ),
          ),
        ),
    );
  }

}



