import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mine_calculator/features/data/db.dart';
import 'package:mine_calculator/features/domain/entities/slot.dart';
import 'package:mine_calculator/features/presentation/routes/app_routes.dart';

class ByTonageScreen extends StatefulWidget {
  const ByTonageScreen({Key? key}) : super(key: key);

  @override
  State<ByTonageScreen> createState() => _ByTonageScreenState();
}

class _ByTonageScreenState extends State<ByTonageScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();

  late AnimationController _hide;
  late ScrollController _scrollController;
  late List<Slot> slots;
  bool isLoading = false;
  // bool isEdit = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hide.forward();
    _scrollController.addListener(
      () {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          _hide.forward();
        } else {
          _hide.reverse();
        }
      },
    );
    refreshSlots();
  }

  Future refreshSlots() async {
    setState(() => isLoading = true);
    slots = await Db.instance.findAllSlot("tonage");
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    // Db.instance.close();
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blending By Tonage"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : slots.isEmpty
              ? const Center(child: Text("Kosong"))
              : ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return _cardItem(
                      id: slots[index].id!,
                      title: slots[index].title,
                      date: slots[index].createdAt,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.byTonageDetailScreen,
                          arguments: {
                            "key-slot": Slot(
                              id: slots[index].id,
                              type: slots[index].type,
                              title: slots[index].title,
                              createdAt: slots[index].createdAt,
                            )
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox();
                  },
                  itemCount: slots.length,
                ),
      floatingActionButton: ScaleTransition(
        scale: _hide,
        alignment: Alignment.bottomRight,
        child: FloatingActionButton.extended(
          onPressed: () {
            showBottomSheetAddorEdit(false, null);
          },
          label: Row(
            children: const [
              Icon(Icons.add),
              SizedBox(width: 4),
              Text("Tambah Slot"),
            ],
          ),
        ),
      ),
    );
  }

  Card _cardItem({
    required int id,
    required String title,
    required DateTime date,
    required void Function()? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                showBottomSheetAddorEdit(
                  true,
                  Slot(id: id, type: "tonage", title: title, createdAt: date),
                );
                _titleTextController.text = title;
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.mode_edit_rounded,
              label: 'Edit',
            ),
            SlidableAction(
              flex: 1,
              onPressed: (_) {
                _deleteSlot(id: id, title: title);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_forever_rounded,
              label: 'Hapus',
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Divider(),
                Row(
                  children: [
                    const Icon(Icons.event_rounded),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        DateFormat("EEEE, dd/MM/yyyy - HH:ss", "id")
                            .format(date.toLocal()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showBottomSheetAddorEdit(bool isEdit, Slot? slot) {
    _titleTextController.clear();
    return showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Nama Slot",
                style: Theme.of(context).textTheme.headline6,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  controller: _titleTextController,
                  decoration: const InputDecoration(
                    hintText: "Masukkan nama slot",
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Tidak Boleh Kosong";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    isEdit ? await updateNote(slot!) : await _addSlot();
                    refreshSlots();
                  },
                  child: isEdit ? const Text("Ubah") : const Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _addSlot() async {
    if (_formKey.currentState!.validate()) {
      final slot = Slot(
          type: "tonage",
          title: _titleTextController.text,
          createdAt: DateTime.now());
      await Db.instance.createSlot(slot);
      Navigator.pop(context);
    }
  }

  Future updateNote(Slot sl) async {
    if (_formKey.currentState!.validate()) {
      final slot = Slot(
        id: sl.id,
        type: sl.type,
        title: _titleTextController.text,
        createdAt: sl.createdAt,
      );
      await Db.instance.updateSlots(slot);
      Navigator.pop(context);
    }
  }

  void _deleteSlot({
    required int id,
    required String title,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Hapus Slot"),
          content: Text.rich(
            TextSpan(
              text: "Yakin ingin menghapus ",
              children: [
                TextSpan(
                  text: title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const TextSpan(text: " ?"),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(_);
              },
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                color: Colors.blue,
                width: 0.6,
              )),
              child: const Text("tidak"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Db.instance.deleteSlots(id);
                Navigator.pop(_);
                refreshSlots();
              },
              child: const Text("yoi"),
            ),
          ],
        );
      },
    );
  }
}
