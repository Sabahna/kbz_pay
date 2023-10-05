# HowTo & Ref of writing flutter plugin

## Android

**How to add/import Android Archive .aar file format in your flutter plugin.**

### Ref

1. [Ref1](https://stackoverflow.com/a/70074787/19999522)
2. [Ref2](https://stackoverflow.com/a/63665094/19999522)
3. [Ref3](https://developer.android.com/build/dependencies#groovy)

### Unresolved Reference xxx Error

When you `open for Editing in Android Studio`, Android Studio will download required libraries
including gradle. After that, everything will be fine and you can import flutter packages.
Sometimes, Android Studio will show error `Unresolved reference xxx`, xxx means your flutter
packages. **In this case, you should delete gradle caches, do
again `open for Editing in Android Studio` and it will download itself. Now, everything is normal.**
🎯

## iOS

In `ios/xxx.podspec`, you need configurations to integrate with Vendor Framework,

**Let's assume you are using only one vendor framework and your folder structure is like that -**

<pre>
.
└── plugin/
    ├── example/
    │   └── ...
    └── ios/
        └── xxxxxx.xcframework
</pre>

`xxxxxx` means your vendor framework name.
In this situation, you can integrate your podspec below that

```podspec
  s.preserve_paths = 'xxxxxx.xcframework/**/*'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework xxxxxx','ENABLE_BITCODE' => 'NO' }
  s.vendored_frameworks = 'xxxxxx.xcframework'
```

**Or if you are using many vendor frameworks and so you can integrate folder structure like -**

<pre>
.
└── plugin/
    ├── example/
    │   └── ...
    └── ios/
        └── Frameworks/
            ├── xxxxxx.xcframework
            └── yyyyyy.xcframework
</pre>

```podspec
   s.preserve_paths = 'Frameworks/**/**/*'
   s.vendored_frameworks = 'Frameworks/**'
```

### Ref

1. [Ref1](https://stackoverflow.com/a/70210039/19999522)
2. [Ref2](https://github.com/flutter/flutter/issues/51601)

`If you know Swift, you can also convert Objective-C code to Swift by using` [converter](https://okaxaki.github.io/objc2swift/demo.html)

**`If your Vendor Framework is writing with Objective-C and your plugin of language is Swift, some methods and names are overrided and renamed because of Swift Compiler.`You should learn about `Swift Style Guide`**

[Ref-SwiftCompiler](https://stackoverflow.com/a/40164599/19999522)

**How To Open Flutter Plugin in Xcode**

```shell
# Root of your plugin directory
cd example

flutter build ios --no-codesign # flutter build ios

# And, open example of Xcode project
cd ios && open Runner.xcworkspace
```

In Xcode,
<pre>
.
├── Runner
└── Pods/
    ├── Podfile
    └── Development Pods/
        └── your_plugin_name/
            └── ../
                └── ../
                    └── example/
                        └── ios/
                            └── .symlinks/
                                └── plugins/
                                    └── your_plugin_name/
                                        └── ios/
                                            └── Classes/
                                                └── YourPlugin.swift
</pre>

Now, you are ready to code plugin.


<hr>

<hr>

Best reference of flutter plugin using SDK
is -> [Spotify SDK for Flutter](https://github.com/brim-borium/spotify_sdk) . There, you can learn
how to write flutter plugin in Android and iOS.


<hr>

<hr>

# How To Use this Plugin

To use the plugin, please read [README.md](README.md) and config as the described.

