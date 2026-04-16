import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ihuae/services/chat_data_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_ihuae/home/home_page.dart';
import 'package:flutter_ihuae/calendar/calendar_page.dart';
import 'package:flutter_ihuae/diary/diary_page.dart';
import 'package:flutter_ihuae/chat/chat_page.dart';
import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';
import 'package:flutter_ihuae/services/qna_data_service.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalendarDataService()),
        ChangeNotifierProvider(create: (context) => QnaDataService()),
        ChangeNotifierProvider(create: (context) => DiaryDataService()),
        ChangeNotifierProvider(create: (context) => ChatDataService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IhuAe',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ko', ''),
      ],
      theme: ThemeData(
        fontFamily: 'SpoqaHanSansNeo',
        primarySwatch: Colors.blue,
      ),
      home: BasePage(),
    );
  }
}

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  double _statusBarHeight = 0.0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CalendarPage(),
    DiaryPage(),
    ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
      return Consumer<QnaDataService>(
          builder: (context, qnaDataService, child) {
        return Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: (_selectedIndex !=
                          0) //(_selectedIndex == 2 || _selectedIndex == 3)
                      ? _statusBarHeight
                      : 0),
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: false, // 선택된 라벨 보이기/숨기기
            showUnselectedLabels: false, // 선택되지 않은 라벨 보이기/숨기기
            elevation: 0,
          
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/tab_on_ic_home.png')),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/tab_on_ic_calendar.png')),
                label: 'calendar',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/tab_on_ic_diary.png')),
                label: 'diary',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/tab_on_ic_chat.png')),
                label: 'chat',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF8291E6),
            unselectedItemColor: Color(0xFFD9D9D9),
            onTap: _onItemTapped,
          ),
        );
      });
    });
  }
}
