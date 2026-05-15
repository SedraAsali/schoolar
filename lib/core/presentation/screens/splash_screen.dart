
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scholar/core/presentation/screens/logIn.dart';
import '../../constant.dart';
import 'onbording_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.4,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

// دخول قوي (Zoom + Bounce)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.2, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.15, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
    ]).animate(_controller);

// Fade in
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

// Rotation خفيف جدًا (حركة حيوية)
    _rotateAnimation = Tween<double>(
      begin: -0.08,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

// Floating up & down
    _floatAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

// Glow pulse
    _glowAnimation = Tween<double>(
      begin: 10,
      end: 40,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Timer(const Duration(seconds: 10), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  LogIn(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Pulse Background
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Container(
                                  width: 220 * _pulseAnimation.value,
                                  height: 220 * _pulseAnimation.value,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: gold.withOpacity(0.02),
                                  ),
                                );
                              },
                            ),

                            // Glow effect الأصلي + اللوقو
                            Container(
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: gold.withOpacity(0.35),
                                    blurRadius: _glowAnimation.value,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  heightFactor: 0.3,
                                  child: Image.asset(
                                    'assets/images/log.png',
                                    height: 600,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 35),
                        Text(
                          'Scholar',
                          style: TextStyle(
                            color: gold,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),



                        const SizedBox(height: 45),

// Loading pulse
                        SizedBox(
                          width: 35,
                          height: 35,
                          child: CircularProgressIndicator(
                            color: gold,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}