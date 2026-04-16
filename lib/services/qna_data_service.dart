import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';
import 'package:intl/intl.dart';

List<String> questionList = [
  '지금부터 30일간 상대방에게 연락해서는 안 됩니다. 상대방의 소식을 알려고 해서도 안 됩니다.',
  '오늘은 잔뜩 슬퍼해도 괜찮아요. 가슴속에 있는 응어리를 풀어주세요.',
  '상대방에게도 생각할 시간이 필요해요. 서로에게 여유를 주세요',
  '연락하고 싶은 마음 알겠지만, 참으세요. 섣부른 연락과 재회는 절대 건강한 결과를 부를 수 없어요.  하고 싶은 말이 있다면 감정억제기를 사용해보세요.',
  '왜 힘든일은 한꺼번에 찾아올까요? 지금 이 상황이 너무 견디기 힘들고 슬픔에서 벗어날 수 없을 것 같은 그 기분 충분히 다 쏟아내세요.',
  '이별은 돌이킬 수 없어요. 이걸 인정하지 않으면 당신이 무엇을 원하든 그 결과로 이어지기 힘들어요. 힘들지만 받아들이려고 노력해요.',
  '혹시 재회 관련 컨텐츠를 찾아보고 계신가요? 그렇다면, 차라리 이별 극복법을 검색해보면 어떨까요? 알잖아요. 도움되지 않는다는걸요.',
  '지인들에게서 x의 소식을 알려고 하지마세요. 어떠한 수단과 방법이든 x의 근황을 알 수 없도록 해요.',
  '지금 나의 몸 상태는 어떤가요? 아픈 곳은 없나요? 적절한 체지방과 근육량을 유지하고 있나요? 내 몸을 진단해보는 시간을 가져보아요. 몸의 건강도 마음의 건강만큼이나 중요하답니다.',
  ' 명상 해본 적 있으세요? 머릿 속에 생각이 많다면, 가끔은 비워주는 것도 필요해요. 오늘은 5분이라도 시간내서 명상을 해보면 어떨까요?',
  '해야 하는 일이 있나요? 여태껏 미뤄두는 일이 있지 않나요? 오늘부터 시작해보도록 해요. 무리하지 말고 조금씩 시작해보아요.',
  ' 맛있는 음식을 먹으면 도파민이 방출되어 기분이 좋아진다고 해요. 맛집을 찾아가며 기분전환 해보아요!',
  '이 시기가 다 지나가고 나면  어떤 사람이 되어있었으면 좋겠나요? 분명 당신은 더 성장하게 될거에요.',
  '당신은 어떤 사람과 함께하면 행복을 느낄 수 있다고 생각하나요? 지인이든 연인이든 한번 생각해볼까요?',
  ' 벌써 2주가 지났어요! 연락금지 규칙을 아주 잘 지키고 있어요! 지금처럼 2주만 더 버텨봐요. 이후가 함께할게요.',
  ' 나는 어떤 사람인가요? 나의 장점은 무엇인가요?  내가 좋아하는 음식, 색깔, 동물 등등…. 나를 탐구해보는 시간을 가져보아요.',
  ' 하고 싶은 일들의 목록을 적어볼까요? 나만의 버킷리스트를 만들게 되면 내가 무엇을 좋아하는지, 하고 싶은지, 나에 대해 더욱 잘 알게 될 거예요.',
  ' 숲으로 공원으로 산책하러 나가보는 건 어떨까요? 자연을 느끼며 힐링하는 시간을 가져보아요.',
  ' 이루고 싶은 일들이 있나요? 오늘은 그 목록을 적어볼까요? 커다란 꿈부터 소소한 꿈까지 모두 좋아요.',
  ' 이전의 사랑이 그리운 날인가요? 그렇다면 그 사람과 있었던 일 중 좋았던 일 5가지와 나빴던 일 5가지를 펜을 들고 손으로 적어보아요.',
  ' 친구들과 함께 즐거운 시간을 보내보는 건 어떨까요? 오래 연락이 끊긴 친구가 있다면 먼저 연락을 걸어보아요. 새로운 만남의 시작이 될 수도 있을 거예요.',
  ' 가장 좋아하는 옷을 입고 나가 볼까요? 가까운 곳도 좋고, 평소 가보고 싶던 카페도 좋아요. 한껏 꾸민 모습으로 나들이하다 보면 즐거울 거예요!',
  '혹시나 그 사람의 사진을 갤러리에서 지우지 못했다면, 자주 들어가지 마세요. 당분간은 숨겨놓고 우리 나중에 생각하기로 해요.',
  ' 지금의 당신은 어떤 사람인가요? 혹시나 놓치고 있던게 있을 수 있으니, 한번 커리어를 되돌아봐요.',
  ' 앞으로 어떤 인생을 살고 싶나요? 대략적인 그림말고, 구체적으로 한번 계획을 짜보면 어떨까요?',
  ' 그 사람의 소식이 궁금한가요? 하지만 아직은 안 됩니다. 자신을 더 돌볼 시간이 필요한 시기에요.',
  ' 지금 당신의 주변엔 어떤 사람들로 가득 차 있나요? 그 들에게 충분히 애정을 표현했나요? 당신을 이야기를 들어준 이들에게 고마움을 표현해보면 어떨까요?',
  ' 그동안 당신이 당신에게 가장 많이 해준말이 무엇인가요? 가장 고생했을 당신에게 좀 더 애정어린 말을 해주는건 어때요?',
  ' 내일이면 한달이 다 채워져요. 어떤 감정을 느끼고 있나요? 당신의 마음속에 작은 힘이 생겼다면 정말 행복할 것 같아요.',
  ' 한달동안 수고 많으셨어요. 이때까지 작성했던 문답과 감정변화를 한번 되돌아보면 어떨까요? 당신이 어떤 선택을 하든 당신을 응원할게요.'
];

class QnaData {
  QnaData({
    required this.dateID,
    required this.question,
    required this.answer,
    required this.regDateTime,
  });

  int dateID;
  String question;
  String answer;
  DateTime regDateTime;

  Map toJson() {
    return {
      'dateID': dateID,
      'question': question,
      'answer': answer,
      'regDateTime': regDateTime,
    };
  }

  factory QnaData.fromJson(json) {
    return QnaData(
      dateID: json['dateID'],
      question: json['question'],
      answer: json['answer'],
      regDateTime: DateTime.parse(json['regDateTime']),
    );
  }
}

class QnaDataService extends ChangeNotifier {
  List<QnaData> qnaDataList = [];

  QnaDataService() {
    loadQnaDataList();
  }

//qnaDataList 불러오기
  loadQnaDataList() {
    String? jsonString = prefs.getString('qnaDataList');

    if (jsonString == null) {
      createQnaDataList();
      return;
    }
    List qnaDataJsonList = jsonDecode(jsonString);
    qnaDataList =
        qnaDataJsonList.map((json) => QnaData.fromJson(json)).toList();
  }

//qnaDataList 로컬 저장
  saveQnaDataList() {
    List qnaDataJsonList =
        qnaDataList.map((qnaData) => qnaData.toJson()).toList();

    String jsonString = jsonEncode(qnaDataJsonList, toEncodable: myEncode);

    prefs.setString('qnaDataList', jsonString);
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  createQnaDataList() {
    DateTime newDate = DateTime.now();
    //시간 0으로 초기화
    DateTime today = newDate.subtract(Duration(
        hours: newDate.hour,
        minutes: newDate.minute,
        seconds: newDate.second,
        milliseconds: newDate.millisecond,
        microseconds: newDate.microsecond));
    for (int i = 0; i < questionList.length; i++) {
      DateTime dd = DateTime(today.year, today.month, today.day + i);
      String sdfString = DateFormat('yyyyMMdd').format(dd).toString();
      int id = int.parse(sdfString);

      QnaData qnaData = QnaData(
        dateID: id,
        question: questionList[i],
        answer: '',
        regDateTime: DateTime.now(),
      );
      qnaDataList.add(qnaData);
    }

    saveQnaDataList();
  }

  updateAnswer(int index, String ans) {
    QnaData qnaData = qnaDataList[index];
    qnaData.answer = ans;
    qnaData.regDateTime = DateTime.now();
    notifyListeners();
    saveQnaDataList();
  }
}
