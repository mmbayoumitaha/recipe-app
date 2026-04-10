import 'package:flutter/material.dart';

class TagsEditor extends StatefulWidget {
  final List<String> tags;
  final Function(String) onAdd;
  final Function(String) onRemove;

  const TagsEditor({
    super.key,
    required this.tags,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<TagsEditor> createState() => _TagsEditorState();
}

class _TagsEditorState extends State<TagsEditor> {
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty) {
      widget.onAdd(tag);
      _tagController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _tagController,
                decoration: InputDecoration(
                  hintText: 'e.g. Easy, Vegan',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: scheme.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _handleAdd,
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.primary,
                foregroundColor: scheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (widget.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: widget.tags.map((tag) {
              return Chip(
                label: Text(tag),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => widget.onRemove(tag),
                backgroundColor: scheme.primary.withAlpha(20),
                side: BorderSide(
                  color: scheme.primary.withAlpha(56),
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
