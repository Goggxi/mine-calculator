import 'package:flutter/material.dart';
import 'package:mine_calculator/features/data/db.dart';
import 'package:mine_calculator/features/domain/entities/slot.dart';
import 'package:mine_calculator/features/domain/entities/tonage.dart';
import 'package:mine_calculator/features/presentation/routes/app_routes.dart';

class ByTonageDetailScreen extends StatefulWidget {
  final Slot slot;
  const ByTonageDetailScreen({Key? key, required this.slot}) : super(key: key);

  @override
  State<ByTonageDetailScreen> createState() => _ByTonageDetailScreenState();
}

class _ByTonageDetailScreenState extends State<ByTonageDetailScreen> {
  late List<Tonage> tonage;
  bool isLoading = false;

  Future refreshTonage() async {
    setState(() => isLoading = true);
    tonage = await Db.instance.findAllTonage(widget.slot.id!);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshTonage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.slot.title),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tonage.isEmpty
              ? const Center(child: Text("Kosong"))
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return Text("ada " + tonage.length.toString());
                  },
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: tonage.length),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.byTonageAddOrEditScreen);
        },
        label: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(width: 4),
            Text("Tambah"),
          ],
        ),
      ),
    );
  }
}
