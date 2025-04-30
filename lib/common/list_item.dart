import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final int? maxLines;
  final Widget? leading;

  const ListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.maxLines,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              leading ?? const Icon(Icons.text_snippet),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: maxLines,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: maxLines,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
