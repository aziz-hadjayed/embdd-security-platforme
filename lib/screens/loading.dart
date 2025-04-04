import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plat_forme/routes/app_routes.dart'; // Adaptez le chemin d'import
import 'dart:math';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _loadingPercentage = 0;
  late Timer _loadingTimer;

  int randomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  @override
  void initState() {
    super.initState();

    // Simuler une progression de chargement
    _loadingTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _loadingPercentage = randomInt(_loadingPercentage, 100);

        // Arrêter le timer quand on atteint 100%
        if (_loadingPercentage >= 100) {
          timer.cancel();
        }
      });
    });

    // Démarre le timer pour la redirection _____________________________________ 3 sec
    Future.delayed(const Duration(seconds: 3), () {
      _loadingTimer.cancel();
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _loadingTimer.cancel();
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
            // Animation de chargement
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A237E)),
              strokeWidth: 5,
            ),
            const SizedBox(height: 20),

            // Texte de chargement
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),

            // Pourcentage qui s'actualise
            Text(
              "$_loadingPercentage%",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
