import 'package:flutter/material.dart';
import 'package:mine_calculator/features/presentation/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mine Calculator"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Blending Nikel", style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 10),
          cardItemMenu(
            context: context,
            title: "Blending By Density And Volume",
            iconWidget: const Icon(Icons.fitbit_rounded),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          cardItemMenu(
            context: context,
            title: "Blending By Tonage",
            iconWidget: const Icon(Icons.fitbit_rounded),
            onTap: () => Navigator.pushNamed(context, Routes.byTonageScreen),
          ),
        ],
      ),
    );
  }

  Card cardItemMenu({
    required String title,
    required void Function()? onTap,
    required Widget iconWidget,
    required BuildContext context,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(child: iconWidget),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
