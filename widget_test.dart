import 'package:flutter_test/flutter_test.dart';
import 'package:servan_mobile/main.dart';
void main(){
 testWidgets('login page is rendered', (tester) async { await tester.pumpWidget(const ServanApp()); expect(find.text('servan'), findsOneWidget); expect(find.text('مدیریت حرفه‌ای، سریع و هوشمند؛ با دقت و اطمینان'), findsOneWidget); });
 testWidgets('dashboard opens after valid login', (tester) async { await tester.pumpWidget(const ServanApp()); await tester.tap(find.text('ورود')); await tester.pumpAndSettle(); expect(find.text('نمای کلی CRM'), findsOneWidget); expect(find.text('مشتری فعال'), findsOneWidget); });
}
