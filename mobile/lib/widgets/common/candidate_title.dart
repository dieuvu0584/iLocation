import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// Shows a place name translated into the app's language, with its
/// native/local-language name alongside when OpenStreetMap has a distinct
/// one (e.g. "Seoul (서울특별시)") — see `LocationSearchCandidate.localName`.
/// Shared by the search results list and the history list.
class CandidateTitle extends StatelessWidget {
  final String name;
  final String? localName;

  const CandidateTitle({super.key, required this.name, this.localName});

  @override
  Widget build(BuildContext context) {
    if (localName == null) return Text(name);
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: name),
          TextSpan(text: ' ($localName)', style: const TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
