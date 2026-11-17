import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});
  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool past = false;

  @override
  Widget build(BuildContext context) {
    final list = appointments.where((a) => a.past == past).toList();
    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(20, 12, 20, 100), children: [
        const Text('Appointments', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        SegmentedButton<bool>(
          segments: const [ButtonSegment(value: false, label: Text('Upcoming')), ButtonSegment(value: true, label: Text('Completed'))],
          selected: {past},
          onSelectionChanged: (s) => setState(() => past = s.first),
        ),
        const SizedBox(height: 16),
        ...list.map((a) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
              child: Column(children: [
                Row(children: [
                  NetImage(a.doctor.photo, width: 56, height: 56, radius: 14),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(a.doctor.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text(a.doctor.speciality, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: (a.mode == 'Video call' ? mint : brand).withValues(alpha: .1), borderRadius: BorderRadius.circular(20)),
                    child: Text(a.mode, style: TextStyle(color: a.mode == 'Video call' ? mint : brand, fontWeight: FontWeight.w700, fontSize: 12)),
                  ),
                ]),
                const Divider(height: 24),
                Row(children: [
                  const Icon(Icons.calendar_today_rounded, size: 16, color: Colors.black45),
                  const SizedBox(width: 6),
                  Text(a.date, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time_rounded, size: 16, color: Colors.black45),
                  const SizedBox(width: 6),
                  Text(a.time, style: const TextStyle(fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: OutlinedButton(onPressed: () => Contact.show(context, appName, past ? 'Prescriptions & Visit Summary' : 'Reschedule / Cancel'), child: Text(past ? 'Prescription' : 'Reschedule'))),
                  const SizedBox(width: 10),
                  Expanded(child: FilledButton(onPressed: () => Contact.show(context, appName, past ? 'Book Follow-up' : 'Join Video Consultation'), child: Text(past ? 'Book again' : (a.mode == 'Video call' ? 'Join call' : 'Get directions')))),
                ]),
              ]),
            )),
      ]),
    );
  }
}
