import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class PhotoDialog extends StatefulWidget {
  final String url;
  const PhotoDialog({super.key, required this.url});

  @override
  State<PhotoDialog> createState() => _PhotoDialogState();
}

class _PhotoDialogState extends State<PhotoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        child: rfCommonCachedNetworkImage(widget.url, fit: BoxFit.cover),
      ),
    );
  }
}
