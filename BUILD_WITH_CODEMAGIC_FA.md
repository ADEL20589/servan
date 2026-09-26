# SERVAN Mobile R06.0.0 — Codemagic Ready

این بسته برای ساخت APK اندروید با Codemagic آماده شده است.

## ساخت APK

1. این پوشه را در یک GitHub repository قرار دهید.
2. Repository را به Codemagic متصل کنید.
3. Workflow با نام `SERVAN Android APK` را انتخاب کنید.
4. Build را اجرا کنید.
5. خروجی `app-release.apk` از بخش Artifacts قابل دانلود است.

### نکته
پوشه `android/` عمداً داخل سورس قرار نگرفته است؛ در مرحله Build با `flutter create --platforms=android` ساخته می‌شود. بنابراین برای این بسته نصب Android Studio روی کامپیوتر لازم نیست.

این نسخه برای گرفتن APK قابل نصب و تست آفلاین آماده شده است. امضای اختصاصی Release/Google Play در مرحله انتشار نهایی باید جداگانه تنظیم شود.

ورود آزمایشی: `admin / 1234`
