import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

const systems = [
  'ماکس فاز صفر', 'مالتی‌پلکس فرانسه', 'مالتی‌پلکس سازه پویش',
  'مالتی‌پلکس اکوماکس کروز', 'مالتی‌پلکس SMS', 'تک‌نود کروز',
  'تک‌نود سازه پویش', 'سیستم هوشمند CEC', 'مالتی‌پلکس سایپا',
];
const titles = ['معرفی', 'عیب‌یابی', 'نقشه‌ها', 'عیوب شایع', 'تعمیر نود'];
const icons = [Icons.info_outline, Icons.search, Icons.map_outlined,
  Icons.warning_amber, Icons.build_outlined];
const gold = Color(0xFFFFCD65);

void main() => runApp(MaterialApp(
  locale: const Locale('fa'), supportedLocales: const [Locale('fa')],
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  title: 'کارپلکس', debugShowCheckedModeBanner: false,
  theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: gold,
    brightness: Brightness.dark), scaffoldBackgroundColor: const Color(0xFF111318)),
  builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child!),
  home: const Home(),
));

class Home extends StatelessWidget {
  const Home({super.key});
  void openSystem(BuildContext context, String system) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => Details(system: system),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF6F7FA),
    appBar: AppBar(title: const Text('خانه'), centerTitle: true,
      backgroundColor: const Color(0xFFFFD32A), foregroundColor: const Color(0xFF292000)),
    drawer: Drawer(child: SafeArea(child: ListView(children: [
      const ListTile(leading: Icon(Icons.bolt, color: gold), title: Text('کارپلکس')),
      for (final system in systems) ListTile(title: Text(system), onTap: () {
        Navigator.of(context).pop();
        openSystem(context, system);
      }),
    ]))),
    body: CustomScrollView(slivers: [
      const SliverToBoxAdapter(child: AspectRatio(aspectRatio: 16 / 9,
        child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topRight, end: Alignment.bottomLeft,
          colors: [Color(0xFF071832), Color(0xFF075890), Color(0xFF081D39)],
        )), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Carplex', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic, color: Colors.white)),
          SizedBox(height: 8),
          Icon(Icons.directions_car, size: 76, color: Color(0xFF72D8FF)),
        ]))),
      )),
      SliverPadding(padding: const EdgeInsets.all(14), sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, mainAxisExtent: 142),
        itemCount: systems.length,
        itemBuilder: (context, i) => Card(color: Colors.white, surfaceTintColor: Colors.transparent,
          elevation: 2, margin: EdgeInsets.zero, clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(onTap: () => openSystem(context, systems[i]),
            child: Padding(padding: const EdgeInsets.all(8), child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [
                CircleAvatar(radius: 25, backgroundColor: const Color(0xFF103B67),
                  foregroundColor: const Color(0xFF82DCFF), child: Icon([
                    Icons.directions_car, Icons.electric_car, Icons.memory,
                    Icons.bolt, Icons.hub, Icons.speed, Icons.developer_board,
                    Icons.settings, Icons.directions_car_filled,
                  ][i])),
                const SizedBox(height: 8),
                Flexible(child: Text(systems[i], textAlign: TextAlign.center,
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF8A5C00), fontWeight: FontWeight.bold))),
              ],
            )),
          ),
        ),
      )),
    ]),
  );
}

class Details extends StatelessWidget {
  const Details({required this.system, super.key});
  final String system;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF6F7FA),
    appBar: AppBar(title: Text(system), centerTitle: true,
      backgroundColor: const Color(0xFFFFD32A), foregroundColor: const Color(0xFF292000)),
    body: SafeArea(child: ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: titles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => Card(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          minTileHeight: 72,
          leading: CircleAvatar(backgroundColor: const Color(0xFF103B67),
            foregroundColor: Colors.white, child: Icon(icons[i])),
          title: Text(titles[i], style: const TextStyle(
            color: Color(0xFF292000), fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.chevron_left, color: Color(0xFF8A5C00)),
          onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => SectionPage(system: system, title: titles[i]),
          )),
        ),
      ),
    )),
  );
}

class SectionPage extends StatelessWidget {
  const SectionPage({required this.system, required this.title, super.key});
  final String system;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: ListTile(title: Text(system),
        subtitle: const Text('محتوای این بخش هنوز اضافه نشده است.'))),
    ]),
  );
}
