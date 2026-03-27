import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class SlideData {
  final String title;
  final String content;
  final IconData icon;
  final Color backgroundColor;

  SlideData({
    required this.title,
    required this.content,
    required this.icon,
    required this.backgroundColor,
  });
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: '歡迎使用 CouldAI',
      content: '我是一個強大的 Flutter 開發助手。\n\n雖然我不能直接匯出 PPTX 檔案，\n但我可以幫您用程式碼打造專屬的簡報應用程式！',
      icon: Icons.auto_awesome,
      backgroundColor: const Color(0xFFE3F2FD),
    ),
    SlideData(
      title: '我可以為您做什麼？',
      content: '1. 撰寫簡報大綱與內容\n2. 開發跨平台 App (iOS, Android, Web)\n3. 設計精美的 UI/UX 介面\n4. 串接 Supabase 資料庫',
      icon: Icons.build_circle_outlined,
      backgroundColor: const Color(0xFFF3E5F5),
    ),
    SlideData(
      title: '互動式體驗',
      content: '透過 Flutter 製作的簡報，\n您可以加入動畫、即時資料、甚至是互動按鈕，\n這是一般靜態簡報軟體做不到的！',
      icon: Icons.touch_app,
      backgroundColor: const Color(0xFFE8F5E9),
    ),
    SlideData(
      title: '告訴我您的需求',
      content: '您想要做什麼主題的簡報呢？\n請告訴我，我會立刻為您生成內容與畫面！',
      icon: Icons.chat_bubble_outline,
      backgroundColor: const Color(0xFFFFF3E0),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return _buildSlide(_slides[index]);
            },
          ),
          
          // Navigation Controls
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  IconButton.filledTonal(
                    onPressed: _currentPage == 0 ? null : _previousPage,
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 32,
                  ),
                  
                  // Page Indicators
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 12,
                        width: _currentPage == index ? 32 : 12,
                        decoration: BoxDecoration(
                          color: _currentPage == index 
                              ? Theme.of(context).colorScheme.primary 
                              : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  
                  // Next Button
                  IconButton.filled(
                    onPressed: _currentPage == _slides.length - 1 ? null : _nextPage,
                    icon: const Icon(Icons.arrow_forward),
                    iconSize: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(SlideData slide) {
    return Container(
      color: slide.backgroundColor,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            slide.icon,
            size: 120,
            color: Colors.black87,
          ),
          const SizedBox(height: 40),
          Text(
            slide.title,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            slide.content,
            style: const TextStyle(
              fontSize: 24,
              height: 1.5,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
