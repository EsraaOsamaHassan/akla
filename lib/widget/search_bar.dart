
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
  });

  final void Function(String value) onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,

      leading: const Icon(Icons.search),

      trailing: [
        if (_controller.text.isNotEmpty)
          IconButton(
            onPressed: _clearSearch,
            icon: const Icon(Icons.close),
            tooltip: 'Clear',
          ),
      ],

      hintText: 'Search',

      backgroundColor: const WidgetStatePropertyAll(
        Colors.white,
      ),

      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),

      onChanged: widget.onChanged,
    );
  }
}