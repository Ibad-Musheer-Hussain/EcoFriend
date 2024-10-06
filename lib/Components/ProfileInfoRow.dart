import 'package:flutter/material.dart';

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final ValueChanged<String> onValueChanged;
  final bool? isEditingEnabled;

  const ProfileInfoRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.value,
    required this.onValueChanged,
    required this.isEditingEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller =
        TextEditingController(text: value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _controller,
                  enabled: isEditingEnabled,
                  onChanged: onValueChanged,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    isDense: true,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
