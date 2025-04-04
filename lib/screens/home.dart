import 'package:flutter/material.dart';
import 'package:plat_forme/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _statusController;
  late Animation<double> _scaleAnimation;
  bool _systemArmed = false;
  List<String> connectedDevices = [
    'Caméra 1',
    'Capteur Porte',
    'Alarme Principale',
  ];

  @override
  void initState() {
    super.initState();
    _statusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _statusController, curve: Curves.easeInOut),
    );
  }

  void _toggleSecurity() {
    setState(() {
      _systemArmed = !_systemArmed;
      if (_systemArmed) {
        _statusController.forward();
      } else {
        _statusController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSystemStatusCard(),
            const SizedBox(height: 20),
            _buildConnectedDevicesSection(),
            const SizedBox(height: 20),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Plateforme de Sécurité',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
        ),
      ],
    );
  }

  Widget _buildSystemStatusCard() {
    return AnimatedBuilder(
      animation: _statusController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'STATUT DU SYSTÈME',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Icon(
                      _systemArmed ? Icons.security : Icons.security_outlined,
                      color:
                          _systemArmed ? Colors.greenAccent : Colors.redAccent,
                      size: 48,
                      key: ValueKey<bool>(_systemArmed),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    icon: AnimatedRotation(
                      turns: _systemArmed ? 0.5 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(_systemArmed ? 'DÉSACTIVER' : 'ACTIVER'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _systemArmed ? Colors.red : Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _toggleSecurity,
                    label: Text("aziz"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConnectedDevicesSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'APPAREILS CONNECTÉS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: connectedDevices.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return AnimatedListItem(
                  index: index,
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.sensors_outlined),
                    ),
                    title: Text(
                      connectedDevices[index],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildAnimatedActionButton(
          Icons.emergency_outlined,
          'Urgence',
          Colors.red,
        ),
        _buildAnimatedActionButton(
          Icons.history_toggle_off_outlined,
          'Historique',
          Colors.blue,
        ),
        _buildAnimatedActionButton(
          Icons.notifications_active_outlined,
          'Alertes',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildAnimatedActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class AnimatedListItem extends StatelessWidget {
  final int index;
  final Widget child;

  const AnimatedListItem({super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: AnimationController(
            vsync: Navigator.of(context),
            duration: Duration(milliseconds: 300 + (index * 100)),
          )..forward(),
          curve: Curves.easeOutQuint,
        ),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: AnimationController(
              vsync: Navigator.of(context),
              duration: Duration(milliseconds: 500 + (index * 100)),
            )..forward(),
            curve: Curves.easeIn,
          ),
        ),
        child: child,
      ),
    );
  }
}
