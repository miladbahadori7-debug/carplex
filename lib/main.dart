import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

const systems = [
  'مالتی‌پلکس فرانسه', 'ماکس فاز صفر', 'مالتی‌پلکس سازه پویش',
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
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Row(children: [Icon(Icons.bolt, color: gold),
      SizedBox(width: 8), Text('کارپلکس')]), backgroundColor: const Color(0xFF191C23)),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Text('سیستم‌های مالتی‌پلکس خودرو', style: Theme.of(context).textTheme.titleLarge),
      const Padding(padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('برای دیدن بخش‌ها، یک سیستم انتخاب کن.')),
      for (final system in systems) Card(child: ListTile(
        leading: const Icon(Icons.memory, color: gold),
        title: Text(system), subtitle: const Text('مشاهدهٔ بخش‌های سیستم'),
        trailing: const Icon(Icons.chevron_left),
        onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (_) => Details(system: system))),
      )),
    ]),
  );
}

class Details extends StatelessWidget {
  const Details({required this.system, super.key});
  final String system;
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: titles.length,
    child: Scaffold(
      appBar: AppBar(title: Text(system), bottom: TabBar(
        isScrollable: true, tabAlignment: TabAlignment.start,
        tabs: [for (var i = 0; i < titles.length; i++) Tab(icon: Icon(icons[i]), text: titles[i])],
      )),
      body: TabBarView(children: [for (var i = 0; i < titles.length; i++)
        ListView(padding: const EdgeInsets.all(16), children: [Card(child: ListTile(
          leading: Icon(icons[i], color: gold), title: Text(titles[i]),
          subtitle: const Text('محتوای این بخش در نسخهٔ بعدی اضافه می‌شود.'),
        ))]),
      ]),
    ),
  );
}
