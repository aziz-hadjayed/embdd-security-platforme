



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AttackSelectionScreenState();
}

class _AttackSelectionScreenState extends State<AnalysisScreen> {
  List<Attack> attacks = [
    Attack('Buffer Overflow', 'Un programme écrit accidentellement plus de données qu'' un espace mémoire (buffer) ne peut en contenir, permettant à un attaquant d''écraser des zones critiques de la mémoire et d''exécuter du code malveillant'),
    Attack('XSS', 'Cross-Site Scripting'),
    Attack('DoS', 'Déni de service'),
    Attack('Phishing', 'Attaque par ingénierie sociale'),
    Attack('MITM', 'Man-in-the-Middle'),
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text(
          'Sélection d\'attaque',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        backgroundColor:  const Color(0xFF00FF88),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Text(
              'Choisissez votre type d\'attaque:',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF00FF88),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: attacks.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return AttackCard(
                    attack: attacks[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              
              onPressed: selectedIndex != null
                  ? () {
                      // Action à effectuer avec l'attaque sélectionnée
                      final selectedAttack = attacks[selectedIndex!];
                      print('Attaque sélectionnée: ${selectedAttack.name}');
                    }
                  : null,

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF88),
                padding: const EdgeInsets.symmetric(vertical: 16 )),

              child: Text(
                'Valider la sélection',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 49, 44, 44)
                ),
              ),

            ),

          ],
        ),
      ),
    );
  }
}


class Attack {
  final String name;
  final String description;

  Attack(this.name, this.description);
}

class AttackCard extends StatelessWidget {
  final Attack attack;
  final bool isSelected;
  final VoidCallback onTap;

  const AttackCard({
    super.key,
    required this.attack,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isSelected ? const Color.fromARGB(255, 65, 63, 67) : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attack.name,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? const Color(0xFF00FF88) : Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                attack.description,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
      
    );
    
  }
}