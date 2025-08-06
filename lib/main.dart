// main.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:notification_app/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Fade animation for the logo
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Scale animation for the logo
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    // Start the animation
    _animationController.forward();

    // Navigate to main page 
    Timer(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      'assets/images/logobpbatam.png',
                      width: 80,
                      height: 80,
                      fit:
                          BoxFit
                              .cover, 
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40),

            // Loading 
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: LoadingDots(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// Loading dots widget 
class LoadingDots extends StatefulWidget {
  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with TickerProviderStateMixin {
  late AnimationController _dotsController;
  late Animation<int> _currentDotAnimation;

  @override
  void initState() {
    super.initState();

    _dotsController = AnimationController(
      duration: Duration(milliseconds: 1200), // Total durasi 
      vsync: this,
    )..repeat();

    _currentDotAnimation = IntTween(
      begin: 0,
      end: 3,
    ).animate(CurvedAnimation(parent: _dotsController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _currentDotAnimation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            bool isActive = index == _currentDotAnimation.value;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color:
                    isActive
                        ? Colors.orange[400] // Kuning untuk dot yang aktif
                        : Colors.blue[800], // Biru untuk dot yang tidak aktif
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
