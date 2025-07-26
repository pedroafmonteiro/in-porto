import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:in_porto/view/search/search_view.dart';

class ActionCenter extends StatefulWidget {
  const ActionCenter({super.key});

  @override
  State<ActionCenter> createState() => _ActionCenterState();
}

class _ActionCenterState extends State<ActionCenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 600),
        closedElevation: 5,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        closedColor: const Color(0xFFFFFAFA),
        openColor: const Color(0xFFFFFAFA),
        closedBuilder: (context, action) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFAFA),
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    // Handle favorite button press
                  },
                ),
                InkWell(
                  onTap: action,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xFFE0E0E0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_rounded,
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    // Handle settings button press
                  },
                ),
              ],
            ),
          );
        },
        openBuilder: (context, action) {
          return const SearchView();
        },
      ),
    );
  }
}
