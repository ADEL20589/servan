import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const ServanApp());

class ServanApp extends StatefulWidget {
  const ServanApp({super.key});
  @override State<ServanApp> createState() => _ServanAppState();
}

class _ServanAppState extends State<ServanApp> {
  bool loggedIn = false;
  String user = '';
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SERVAN CRM',
    theme: ThemeData(useMaterial3: true, fontFamily: 'sans', colorSchemeSeed: const Color(0xff176b68), scaffoldBackgroundColor: const Color(0xfff6f8f9)),
    home: loggedIn ? ServanShell(user: user) : LoginPage(onLogin: (u) => setState(() {user=u; loggedIn=true;})),
  );
}

class LoginPage extends StatefulWidget { final void Function(String) onLogin; const LoginPage({super.key, required this.onLogin});
  @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final u=TextEditingController(text:'admin'), p=TextEditingController(text:'1234'); String? err;
  @override Widget build(BuildContext c)=>Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding:const EdgeInsets.all(24),child: ConstrainedBox(constraints:const BoxConstraints(maxWidth:440),child: Card(elevation:2,child:Padding(padding:const EdgeInsets.all(28),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    const Icon(Icons.shield_outlined,size:64,color:Color(0xff176b68)), const SizedBox(height:16),
    const Text('servan',textAlign:TextAlign.center,style:TextStyle(fontSize:34,fontWeight:FontWeight.w800)),
    const Text('راهکار هوشمند',textAlign:TextAlign.center,style:TextStyle(fontSize:16)), const SizedBox(height:22),
    const Text('مدیریت حرفه‌ای، سریع و هوشمند؛ با دقت و اطمینان',textAlign:TextAlign.center,style:TextStyle(fontSize:15)), const SizedBox(height:24),
    TextField(controller:u,decoration:const InputDecoration(labelText:'نام کاربری',prefixIcon:Icon(Icons.person_outline),border:OutlineInputBorder())), const SizedBox(height:12),
    TextField(controller:p,obscureText:true,decoration:const InputDecoration(labelText:'رمز عبور',prefixIcon:Icon(Icons.lock_outline),border:OutlineInputBorder())),
    if(err!=null) Padding(padding:const EdgeInsets.only(top:10),child:Text(err!,style:const TextStyle(color:Colors.red))), const SizedBox(height:18),
    FilledButton.icon(onPressed:(){if(u.text.trim().isEmpty||p.text.isEmpty){setState(()=>err='نام کاربری و رمز عبور الزامی است');return;} if(u.text!='admin'||p.text!='1234'){setState(()=>err='اطلاعات ورود صحیح نیست');return;} widget.onLogin(u.text.trim());},icon:const Icon(Icons.login),label:const Padding(padding:EdgeInsets.all(12),child:Text('ورود'))),
    const SizedBox(height:10), const Text('حالت آفلاین: داده‌های اصلی CRM بدون اینترنت قابل استفاده‌اند.',textAlign:TextAlign.center,style:TextStyle(color:Colors.grey))
  ])))))));
}

class ServanShell extends StatefulWidget { final String user; const ServanShell({super.key,required this.user}); @override State<ServanShell> createState()=>_ServanShellState(); }
class _ServanShellState extends State<ServanShell> {
  int index=0;
  final pages=<Widget>[
    const DashboardPage(), PeoplePage(), LeadsPage(), CasesPage(), FinancePage(), DocumentsPage(), ContractsPage(), CommunicationsPage(), ReportsPage(), SettingsPage()
  ];
  final labels=['داشبورد','اشخاص و نقش‌ها','سرنخ‌ها','پرونده‌ها','مالی','مدارک','قراردادها','ارتباطات و بازاریابی','گزارش‌ها','تنظیمات'];
  final icons=[Icons.dashboard_outlined,Icons.people_outline,Icons.track_changes,Icons.folder_outlined,Icons.account_balance_wallet_outlined,Icons.description_outlined,Icons.article_outlined,Icons.campaign_outlined,Icons.bar_chart_outlined,Icons.settings_outlined];
  @override Widget build(BuildContext c)=>Directionality(textDirection:TextDirection.rtl,child:Scaffold(
    appBar:AppBar(title:Text(labels[index]),actions:[IconButton(onPressed:()=>showSearch(context:context,delegate:GlobalSearchDelegate()),icon:const Icon(Icons.search)),Padding(padding:const EdgeInsets.symmetric(horizontal:12),child:Center(child:Text(widget.user)))],),
    drawer:Drawer(child:SafeArea(child:Column(children:[const SizedBox(height:18),const Text('servan',style:TextStyle(fontSize:30,fontWeight:FontWeight.bold)),const Text('راهکار هوشمند'),const Divider(height:30),Expanded(child:ListView.builder(itemCount:labels.length,itemBuilder:(c,i)=>ListTile(selected:i==index,leading:Icon(icons[i]),title:Text(labels[i]),onTap:(){setState(()=>index=i);Navigator.pop(c);})),)])),),
    body:pages[index],
    bottomNavigationBar:NavigationBar(selectedIndex:index<5?index:0,onDestinationSelected:(i){if(i<5)setState(()=>index=i);},destinations:[for(int i=0;i<5;i++)NavigationDestination(icon:Icon(icons[i]),label:labels[i])]),
  ));
}

class DashboardPage extends StatelessWidget { const DashboardPage({super.key}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[
  const Text('نمای کلی CRM',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),const SizedBox(height:6),const Text('مشتری با پرونده یکی نیست؛ هر شخص می‌تواند چند پرونده داشته باشد.'),const SizedBox(height:18),
  Wrap(spacing:10,runSpacing:10,children:[stat('مشتری فعال','128',Icons.people),stat('پرونده فعال','164',Icons.folder),stat('سرنخ فعال','37',Icons.track_changes),stat('سرنخ تبدیل‌شده','91',Icons.how_to_reg),stat('اقدام امروز','12',Icons.task_alt),stat('مدارک ناقص','9',Icons.warning_amber)]),const SizedBox(height:20),
  section('اقدامات مهم امروز',[row('پیگیری سرنخ','3 مورد عقب‌افتاده',Icons.call),row('پرونده ناقص','5 پرونده نیازمند مدرک',Icons.folder_open),row('قرارداد در انتظار','2 قرارداد',Icons.article)]),
]); }
Widget stat(String a,String b,IconData i)=>SizedBox(width:155,child:Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(i,size:28),const SizedBox(height:12),Text(a),Text(b,style:const TextStyle(fontSize:25,fontWeight:FontWeight.bold))]))));
Widget section(String t,List<Widget> rows)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold)),...rows])));
Widget row(String a,String b,IconData i)=>ListTile(contentPadding:EdgeInsets.zero,leading:Icon(i),title:Text(a),subtitle:Text(b));
}

class PeoplePage extends StatelessWidget { PeoplePage({super.key}); final data=const [('علی رضایی','مشتری، بازاریاب'),('مریم احمدی','مشتری، معرف'),('رضا کریمی','ضامن'),('سارا محمدی','همکار')]; @override Widget build(BuildContext c)=>CrudList(title:'اشخاص و نقش‌ها',add:'شخص جدید',items:data.map((e)=>'${e.$1} — ${e.$2}').toList(),detail:'CRM360 شخص'); }
class LeadsPage extends StatelessWidget { const LeadsPage({super.key}); @override Widget build(BuildContext c)=>CrudList(title:'سرنخ‌ها',add:'سرنخ جدید',items:const ['علی رضایی — فعال — 2 طرح — 3 حساب','مریم احمدی — تبدیل‌شده — 1 طرح — 2 حساب','شرکت نمونه — فعال — 4 طرح — 5 حساب'],detail:'CRM360 سرنخ'); }
class CasesPage extends StatelessWidget { const CasesPage({super.key}); @override Widget build(BuildContext c)=>CrudList(title:'پرونده‌ها',add:'پرونده جدید',items:const ['1405-00031 — علی رضایی — مدارک ناقص','1405-00032 — علی رضایی — در اعتبارسنجی','1405-00033 — مریم احمدی — قرارداد'],detail:'CRM360 پرونده'); }
class CrudList extends StatelessWidget { final String title,add,detail; final List<String> items; const CrudList({super.key,required this.title,required this.add,required this.items,required this.detail}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[Row(children:[Expanded(child:Text(title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold))),FilledButton.icon(onPressed:()=>showDialog(context:c,builder:(_)=>SimpleForm(title:add)),icon:const Icon(Icons.add),label:Text(add))]),const SizedBox(height:14),TextField(decoration:InputDecoration(prefixIcon:const Icon(Icons.search),hintText:'جستجو در $title',border:OutlineInputBorder(borderRadius:BorderRadius.circular(14)))),const SizedBox(height:10),...items.map((x)=>Card(child:ListTile(title:Text(x),subtitle:Text(detail),leading:const Icon(Icons.person_outline),trailing:const Icon(Icons.chevron_left),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>Case360Page(title:x))))))]); }

class Case360Page extends StatelessWidget { final String title; const Case360Page({super.key,required this.title}); @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('CRM360')),body:DefaultTabController(length:8,child:Column(children:[Padding(padding:const EdgeInsets.all(12),child:Text(title,style:const TextStyle(fontWeight:FontWeight.bold))),const TabBar(isScrollable:true,tabs:[Tab(text:'خلاصه'),Tab(text:'طرح‌ها و حساب‌ها'),Tab(text:'معرف و بازاریاب'),Tab(text:'ضامن و تضمین'),Tab(text:'مدارک'),Tab(text:'قرارداد'),Tab(text:'مالی'),Tab(text:'Timeline')]),Expanded(child:TabBarView(children:[info('خلاصه پرونده',['مرحله فعلی: مدارک ناقص','مشتری: متصل به شخص','پرونده مستقل از شمارش مشتری']),info('طرح‌ها و حساب‌ها',['طرح اول: تسهیلات نمونه','حساب 1: بانک نمونه','حساب 2: بانک نمونه']),info('معرف و بازاریاب',['معرف: مریم احمدی','سهم: 5٪','وضعیت پرداخت: در انتظار']),info('ضامن و تضمین',['ضامن: رضا کریمی','نوع تضمین: چک','مبلغ: ۳٬۰۰۰٬۰۰۰٬۰۰۰ ریال']),DocumentsTab(),info('قرارداد',['قرارداد شماره: 1405-00031','قابل ویرایش و تولید PDF']),FinanceTab(),TimelineTab()]))]))); }
Widget info(String t,List<String> x)=>ListView(padding:const EdgeInsets.all(16),children:[Text(t,style:const TextStyle(fontSize:19,fontWeight:FontWeight.bold)),...x.map((e)=>Card(child:ListTile(title:Text(e))))]);
class DocumentsTab extends StatefulWidget { const DocumentsTab({super.key}); @override State<DocumentsTab> createState()=>_DocumentsTabState(); }
class _DocumentsTabState extends State<DocumentsTab>{final items=['کارت ملی','شناسنامه','مدرک درآمد','قرارداد','مدرک ضامن']; final done=<bool>[false,true,false,false,true]; @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[const Text('چک‌لیست مدارک',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),...List.generate(items.length,(i)=>CheckboxListTile(value:done[i],onChanged:(v)=>setState(()=>done[i]=v??false),title:Text(items[i]),subtitle:Text(done[i]?'تکمیل شده':'ناقص / نیازمند فایل'))),OutlinedButton.icon(onPressed:(){setState(()=>items.add('مدرک جدید'));done.add(false);},icon:const Icon(Icons.add),label:const Text('افزودن آیتم چک‌لیست'))]);}
class FinanceTab extends StatelessWidget { const FinanceTab({super.key}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[const Text('مالی پرونده',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),ListTile(title:const Text('فاکتور پرونده'),subtitle:const Text('۳٬۰۰۰٬۰۰۰٬۰۰۰ ریال'),trailing:Chip(label:Text('قفل‌شده'))),ListTile(title:const Text('هزینه ضامن'),subtitle:const Text('۵۰٬۰۰۰٬۰۰۰ ریال')),ListTile(title:const Text('سود'),subtitle:const Text('محاسبه‌شده برای مدیریت'))]);}
class TimelineTab extends StatelessWidget { const TimelineTab({super.key}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[for(final e in ['ثبت پرونده','دریافت کارت ملی','ثبت طرح تسهیلات','ارسال برای اعتبارسنجی'])Card(child:ListTile(leading:const Icon(Icons.timeline),title:Text(e),subtitle:Text('${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now())} — کاربر admin')))]);}

class FinancePage extends StatelessWidget { const FinancePage({super.key}); @override Widget build(BuildContext c)=>CrudList(title:'مالی و حساب‌ها',add:'ثبت مالی',items:const ['فاکتور 1405-00031 — ۳٬۰۰۰٬۰۰۰٬۰۰۰ ریال — قفل‌شده','انتقال 0021 — بانک نمونه — ۵۰۰٬۰۰۰٬۰۰۰ ریال','سود روزانه مدیریت — ۱۸۰٬۰۰۰٬۰۰۰ ریال'],detail:'ثبت مالی و Audit'); }
class DocumentsPage extends StatelessWidget { const DocumentsPage({super.key}); @override Widget build(BuildContext c)=>CrudList(title:'مدارک و فایل‌ها',add:'ثبت مدرک',items:const ['1405-00031 / کارت ملی — تکمیل','1405-00031 / درآمد — ناقص','1405-00032 / قرارداد — تکمیل'],detail:'فایل، وضعیت، دریافت‌کننده، تاریخ'); }
class ContractsPage extends StatelessWidget { const ContractsPage({super.key}); @override Widget build(BuildContext c)=>CrudList(title:'قراردادها و فرم‌ها',add:'قرارداد جدید',items:const ['قرارداد 1405-00031 — قابل ویرایش','قرارداد 1405-00032 — PDF آماده','قالب قرارداد تسهیلات — نسخه 3'],detail:'قالب، متغیرها، نسخه و PDF'); }
class CommunicationsPage extends StatelessWidget { const CommunicationsPage({super.key}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[const Text('مرکز ارتباطات و بازاریابی',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),const SizedBox(height:12),...['SMS','VoIP','Email','WhatsApp','Telegram Bot API','Bale','Eitaa','Webhook / API'].map((x)=>Card(child:ListTile(leading:const Icon(Icons.send_outlined),title:Text(x),subtitle:const Text('اتصال مرکزی — تست / فعال‌سازی / حذف'),trailing:Switch(value:false,onChanged:(_){ }))))]); }
class ReportsPage extends StatelessWidget { const ReportsPage({super.key}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[const Text('گزارش‌ها',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),...['گزارش روزانه پرونده‌ها','گردش مالی روزانه','سود روزانه کاربران','عملکرد فروش و پیگیری','گزارش مدارک ناقص','گزارش قراردادها','گزارش معرف/بازاریاب/ضامن'].map((x)=>Card(child:ListTile(title:Text(x),trailing:const Icon(Icons.chevron_left))))]); }
class SettingsPage extends StatelessWidget { const SettingsPage({super.key}); @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[const Text('تنظیمات',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),...['کاربران و دسترسی‌ها','دسته‌بندی‌ها','چک‌لیست‌های پرونده','قالب فرم و قرارداد','مرکز پشتیبان‌گیری','امنیت و Audit Log','لایسنس و شناسه مشتری','اعلان‌ها','تنظیمات ارتباطات'].map((x)=>Card(child:ListTile(title:Text(x),subtitle:const Text('قابل مدیریت بر اساس سطح دسترسی'),trailing:const Icon(Icons.chevron_left))))]); }
class SimpleForm extends StatelessWidget { final String title; const SimpleForm({super.key,required this.title}); @override Widget build(BuildContext c)=>AlertDialog(title:Text(title),content:const SizedBox(width:420,child:Column(mainAxisSize:MainAxisSize.min,children:[TextField(decoration:InputDecoration(labelText:'نام / عنوان')),SizedBox(height:10),TextField(decoration:InputDecoration(labelText:'توضیحات')),SizedBox(height:10),TextField(decoration:InputDecoration(labelText:'مبلغ / درصد'))])),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('انصراف')),FilledButton(onPressed:()=>Navigator.pop(c),child:const Text('ذخیره'))]); }
class GlobalSearchDelegate extends SearchDelegate<String>{final all=['علی رضایی','پرونده 1405-00031','قرارداد 1405-00032','حساب بانک نمونه','رضا کریمی ضامن','مریم احمدی معرف','پیام تلگرام','پیگیری امروز']; @override List<Widget>? buildActions(BuildContext c)=>[IconButton(onPressed:()=>query='',icon:const Icon(Icons.clear))]; @override Widget? buildLeading(BuildContext c)=>IconButton(onPressed:()=>close(c,''),icon:const Icon(Icons.arrow_back)); @override Widget buildResults(BuildContext c)=>ListView(children:[for(final x in all.where((x)=>x.contains(query)))ListTile(title:Text(x),leading:const Icon(Icons.search))]); @override Widget buildSuggestions(BuildContext c)=>buildResults(c);}
