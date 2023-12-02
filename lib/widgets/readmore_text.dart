import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ReadMoreText({
    Key? key,
    required this.text,
    this.trimLength = 100,
  }) : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = false;

  void _toggleReadMore() {
    setState(() {
      _readMore = !_readMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTrimmed = widget.text.length > widget.trimLength && !_readMore;
    final String mainText = isTrimmed
        ? widget.text.substring(0, widget.trimLength)
        : widget.text;
    final String readMoreText = isTrimmed ? '... Read more' : '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: _toggleReadMore,
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: const TextStyle(color: Colors.black), // Default text style
            children: [
              TextSpan(
                text: mainText,
              ),
              TextSpan(
                text: readMoreText,
                style: const TextStyle(color: Colors.blue), // Style for "Read more"
              ),
            ],
          ),
        ),
      ),
    );
  }
}
