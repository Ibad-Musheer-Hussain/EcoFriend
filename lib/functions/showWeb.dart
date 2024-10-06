import 'package:ecofriend/Components/WebViewModal.dart';
import 'package:flutter/material.dart';

void showWebViewModal(BuildContext context, String url) {
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(223, 255, 255, 255),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Learn View',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: WebViewModal(
                    url: url,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
