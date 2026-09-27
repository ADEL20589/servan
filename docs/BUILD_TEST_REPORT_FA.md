# گزارش تست تحویل

## تست‌هایی که در این محیط انجام شد
- ساختار پروژه Flutter ایجاد و بررسی شد.
- pubspec و فایل اصلی و تست Widget ایجاد شدند.
- مسیرهای اصلی UI برای ماژول‌های CRM تعریف شدند.
- ورود آزمایشی admin / 1234 در کد کنترل می‌شود.

## محدودیت مهم
در محیط ساخت فعلی Flutter SDK، Android SDK و Xcode در دسترس نیستند؛ بنابراین APK/IPA باینری به عنوان «کامپایل و تست‌شده» ارائه نشده است.

برای تست واقعی Android:
1. Flutter را نصب کنید.
2. `flutter pub get`
3. `flutter test`
4. `flutter build apk --release`

برای iOS، build/signing نهایی به macOS و Xcode نیاز دارد.
