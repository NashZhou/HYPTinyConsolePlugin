# HYPTinyConsolePlugin
Use Cosmo's [TinyConsole library](https://github.com/Cosmo/TinyConsole) along with all the other [Hyperion iOS](https://github.com/willowtreeapps/Hyperion-iOS) plugins!

<p align="center" id="Tiny Console Gif">
<img src="https://raw.githubusercontent.com/NashZhou/HYPTinyConsolePlugin/master/gif/tiny-console.gif"/>
</p>

### Implementation & Notes
* Add the TinyConsolePlugin.framework file in your iOS project manually by following Hyperion's manual tutorial
* While the first-party plugins require no code implementation, you must call to the TinyConsole via Objective C or Swift
* [TinyConsole doesn't support Storyboards](https://github.com/Cosmo/TinyConsole/issues/29)

### Accessing TinyConsole
#### Objective C

* Install the framework like any other Hyperion plugin
* Override the application launch window in `AppDelegate.m`
``` objc
_window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
_window.rootViewController = [UIViewController new];
[_window makeKeyAndVisible];
```
* Add the following header to your view controllers
``` objc
#import <TinyConsolePlugin/TinyConsole.h>
```
* Call `[TinyConsole printText:@""];` to print to the console

#### Swift

* Install the framework like any other Hyperion plugin
* Create a bridging header file and import TinyConsole using the Objective C import statement
* Override the application launch window in `AppDelegate.swift`
``` swift
window = UIWindow(frame: UIScreen.main.bounds)
window?.rootViewController = UIViewController()
window?.makeKeyAndVisible()
```
* Add the following header to your view controllers
``` swift
import TinyConsolePlugin.TinyConsole
```
* Call `TinyConsole.printText("")` to print to the console

#### C#

* Right click your project and add TinyConsolePlugin.framework as a native reference along with HyperionCore.framework
* Add the TinyConsolePlugin Nuget Package [here](https://www.nuget.org/packages/TinyConsolePlugin/1.0.0) or include the TinyConsolePlugin dll file as a reference to your project
* Override the application launch window in `AppDelegate.cs`
``` cs
Window = new UIWindow(UIScreen.MainScreen.Bounds);
Window.RootViewController = new UIViewController();
Window.MakeKeyAndVisible();
```
* Add the following namespace to your view controllers
``` cs
using TinyConsolePlugin;
```
* Call `TinyConsole.PrintText("");` to print to the console
* In order to make sure the plugin remains in Debug mode, add `Condition="'$(Configuration)'=='Debug'"` to the back of the framework and dll file references in your .csproj file

Ex.
```
<Reference Include="TinyConsolePlugin" Condition="'$(Configuration)'=='Debug'">
```
