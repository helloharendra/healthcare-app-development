import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen(this.d, {super.key});
  final Doctor d;
  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  static final days = bookableDays();
  static const slots = ['09:30 AM', '10:00 AM', '10:30 AM', '11:30 AM', '04:00 PM', '04:30 PM', '05:30 PM', '06:00 PM'];
  static const booked = {'10:00 AM', '04:30 PM'};
  int day = 1;
  String? slot;
  bool video = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.d;
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor details'), actions: [IconButton(onPressed: () => Contact.show(context, appName, 'Favourite Doctors'), icon: const Icon(Icons.favorite_border))]),
      body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 120), children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(children: [
            Hero(tag: d.name, child: NetImage(d.photo, width: 96, height: 96, radius: 20)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Flexible(child: Text(d.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18))), const SizedBox(width: 4), const Icon(Icons.verified, color: brand, size: 18)]),
                Text(d.speciality, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Row(children: [const Icon(Icons.local_hospital_outlined, size: 16, color: mint), const SizedBox(width: 4), Flexible(child: Text(d.hospital, style: const TextStyle(fontSize: 13)))]),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        Row(children: [
          _stat(Icons.people_alt_rounded, '${(d.reviews * 3.2).round()}+', 'Patients'),
          _stat(Icons.workspace_premium_rounded, '${d.exp} yrs', 'Experience'),
          _stat(Icons.star_rounded, '${d.rating}', 'Rating'),
          _stat(Icons.chat_rounded, '${d.reviews}', 'Reviews'),
        ]),
        const SizedBox(height: 20),
        const Text('About', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
        const SizedBox(height: 6),
        Text(d.about, style: const TextStyle(color: Colors.black54, height: 1.5)),
        const SizedBox(height: 20),
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: false, icon: Icon(Icons.apartment_rounded), label: Text('In-clinic')),
            ButtonSegment(value: true, icon: Icon(Icons.videocam_rounded), label: Text('Video consult')),
          ],
          selected: {video},
          onSelectionChanged: (s) => setState(() => video = s.first),
        ),
        const SizedBox(height: 20),
        const Text('Select date', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
        const SizedBox(height: 10),
        SizedBox(
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final sel = i == day;
              return GestureDetector(
                onTap: () => setState(() => day = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  decoration: BoxDecoration(color: sel ? brand : Colors.white, borderRadius: BorderRadius.circular(18)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(days[i].$1, style: TextStyle(color: sel ? Colors.white70 : Colors.black45)),
                    Text(days[i].$2, style: TextStyle(color: sel ? Colors.white : Colors.black87, fontSize: 20, fontWeight: FontWeight.w800)),
                  ]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Text('Available slots', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: slots.map((s) {
            final taken = booked.contains(s);
            final sel = slot == s;
            return ChoiceChip(
              label: Text(s),
              selected: sel,
              onSelected: taken ? null : (_) => setState(() => slot = s),
              selectedColor: brand,
              labelStyle: TextStyle(color: sel ? Colors.white : taken ? Colors.black26 : Colors.black87, fontWeight: FontWeight.w600, decoration: taken ? TextDecoration.lineThrough : null),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ]),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          color: Colors.white,
          child: Row(children: [
            Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Consultation fee', style: TextStyle(color: Colors.black45, fontSize: 12)),
              Text('₹${video ? d.fee - 100 : d.fee}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
            ]),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                onPressed: slot == null ? null : () => _confirm(context),
                child: Text(slot == null ? 'Select a slot' : 'Book ${days[day].$1} ${days[day].$2}, $slot', style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _confirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 56),
        title: const Text('Appointment booked!'),
        content: Text('${widget.d.name}\n${days[day].$1} ${days[day].$2} ${days[day].$3} · $slot · ${video ? 'Video consult' : 'In-clinic'}', textAlign: TextAlign.center),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Contact.show(context, appName, 'Online Payments & Booking Confirmation');
            },
            child: const Text('Pay now'),
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData i, String v, String l) => Expanded(
        child: Column(children: [
          CircleAvatar(radius: 24, backgroundColor: brand.withValues(alpha: .1), child: Icon(i, color: brand)),
          const SizedBox(height: 6),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w800)),
          Text(l, style: const TextStyle(color: Colors.black45, fontSize: 12)),
        ]),
      );
}
