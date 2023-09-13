---
title: 'Flutter SharedPreferences'
tags: Flutter
disqus: hackmd
---

<style>
.red {
  color: red;
}
.blue {
    color: blue;
}
</style>

<font size="6">Flutter SharedPreferences</font>

**目錄：**

[TOC]

## 添加依賴

```shell=
flutter pub add shared_preferences
```

## 配置

在啟動Flutter web時，使用固定端口(port number)

- 在網絡服務器中運行
```shell=
flutter run -d headless-server --web-port=1234
```

- 在chrome運行
```shell=
flutter run -d chrome --web-port=1234
```

## 保存數據

要存儲數據，請使用SharedPreferences類的setter 方法。Setter方法可用於各種基本數據類型，例如setInt、setBool和setString。

Setter 方法做兩件事：首先，同步更新key-value 到內存中，然後保存到磁盤中。

```dart=
// obtain shared preferences
final prefs = await SharedPreferences.getInstance();

// set value
await prefs.setInt('counter', counter);
```

## 讀取數據

要讀取數據，請使用SharedPreferences類相應的getter 方法。對於每一個setter 方法都有對應的getter 方法。例如，你可以使用getInt、getBool和getString方法。

```dart=
final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
final counter = prefs.getInt('counter') ?? 0;
```

## 移除數據

使用remove()方法刪除數據。

```dart=
final prefs = await SharedPreferences.getInstance();

await prefs.remove('counter');
```

## 支持類型

雖然使用key-value 存儲非常簡單方便，但是它也有以下局限性：

只能用於基本數據類型：int、double、bool、string和stringList。

不適用於大量數據的存儲。

## 包裝

包裝成Singleton的方式，並且不需要await，使其方便使用

使用以下非常簡單的類來獲取SharedPreferences實例，而無需await
```dart=
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();
}
```

初始化instancemay inmain()函數，如下：

```dart=
void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPrefs instance.
  await SharedPrefs.init();

  runApp(MyApp());
}
```

重新定義方法

```dart=
// More abstraction
static const _kCounter = 'counter';

static Future<bool> setCounter(int value) =>
  _instance.setInt(_kCounter, value);

static int? getCounter() => _instance.getInt(_kCounter);

static removeCounter() => _instance.remove(_kCounter);
```

使用

```dart=
// 獲取
final counter = SharedPrefs.getCounter();

// 設定
SharedPrefs.setCounter(_counter);
```

## Demo

https://github.com/imacuser111/flutter_database_example

## 參考

https://flutter.cn/docs/cookbook/persistence/key-value

https://stackoverflow.com/a/67616533
