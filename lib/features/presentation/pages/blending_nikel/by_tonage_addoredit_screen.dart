import 'package:flutter/material.dart';

class ByTonageAddOrEditScreen extends StatefulWidget {
  const ByTonageAddOrEditScreen({Key? key}) : super(key: key);

  @override
  State<ByTonageAddOrEditScreen> createState() =>
      _ByTonageAddOrEditScreenState();
}

class _ByTonageAddOrEditScreenState extends State<ByTonageAddOrEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Data"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    label: Text("Hari & Tanggal"),
                    hintText: "Pilih Tanggal",
                    suffixIcon: Icon(Icons.event_rounded)),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Tidak Boleh Kosong";
                  }
                  return null;
                },
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(3000),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Dum"),
                  hintText: "Dum",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Grade"),
                  hintText: "Grade",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Tonage"),
                  hintText: "Tonage",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: const [
            Icon(Icons.save_rounded),
            SizedBox(width: 4),
            Text("Simpan"),
          ],
        ),
      ),
    );
  }
}
