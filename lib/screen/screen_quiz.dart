// 퀴즈 화면 구현
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;

  QuizScreen({required this.quizs}); // 이전 화면에서 퀴즈 데이터 넘겨 받게 됨

  @override
  _QuizScreenState createState() => _QuizScreenState(); // 상태 선언
}

class _QuizScreenState extends State<QuizScreen> {
  // 3가지 상태 정의 : 퀴즈별 답안, 답안상태
  List<int> _answers = [-1, -1, -1]; // 퀴즈별 답안
  List<bool> _answerState = [false, false, false, false]; // 4개 보기의 눌린 상태
  int _currentIndex = 0; // 현재 보고 있는 퀴즈
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형 위한 사이즈 가져오기
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
            child: Swiper(
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(), // 남는 여백 모두 채우기
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          // 보기를 아래에 별도의 함수로 정의
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  child: _currentIndex == widget.quizs.length - 1
                      ? Text('결과보기',
                          style: TextStyle(color: Colors.white),
                  )
                      : Text('다음문제',
                          style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.deepPurple),
                  ),
                  onPressed: _answers[_currentIndex] == -1
                      ? null
                      : () {
                          if (_currentIndex == widget.quizs.length - 1) {}
                          else {
                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                          }
                        },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } // _buildQuizCard

// 보기 4개 리스트
  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          index: i,
          // 위젯 폴더의 별도 위젯으로 정의된 것 사용 : widget_candidate.dart
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            // 탭 시의 상태 관리
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                  //print(_answers[_currentIndex]); // 디버깅에 사용 : 탭으로 선택 여부 확인
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ), // CandWidget
      ); // _children.add
      _children.add(
        // children 에 패딩 추가
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    } // for
    return _children;
  } // _buildCandidates

} // QuizScreen
