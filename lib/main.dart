// CareConnect – Healthcare app UI demo by Naya Prayog Technologies (https://nayaprayog.com)
// Run: flutter pub get && flutter run   (Android, iOS or Chrome)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/contact.dart';
import 'screens/appointments.dart';
import 'screens/home.dart';

const appName = 'CareConnect';
const brand = Color(0xFF2563EB);
const mint = Color(0xFF14B8A6);

void main() => runApp(const CareConnectApp());

class CareConnectApp extends StatelessWidget {
  const CareConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand, tertiary: mint));
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(scaffoldBackgroundColor: const Color(0xFFF4F7FC), textTheme: GoogleFonts.dmSansTextTheme(base.textTheme)),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: i, children: const [HomeScreen(), AppointmentsScreen()]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Contact.show(context, appName, 'Video Consultation (Telemedicine)'),
        backgroundColor: mint,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.videocam_rounded),
        label: const Text('Consult now', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        backgroundColor: Colors.white,
        onDestinationSelected: (v) {
          if (v == 2) {
            Contact.show(context, appName, 'Health Records & Lab Reports');
            return;
          }
          setState(() => i = v);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded, color: brand), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month, color: brand), label: 'Appointments'),
          NavigationDestination(icon: Icon(Icons.folder_shared_outlined), label: 'Records'),
        ],
      ),
    );
  }
}
