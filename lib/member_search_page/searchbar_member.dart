import 'package:flutter/material.dart';

class SearchBarClass extends StatelessWidget {
  const SearchBarClass({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          hintText: "Search Tennis Clubs",
          controller: controller,
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          trailing: [
            const Icon(Icons.search),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(
          5,
          (int index) {
            final String item = 'Club $index';
            return ListTile(
                title: Text(item),
                onTap: () {
                  controller.closeView(item);
                });
          },
        );
      },
    );
  }
}
