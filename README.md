# HYPTinyConsolePlugin
This is a conversion of Cosmo's [TinyConsole library](https://github.com/Cosmo/TinyConsole) into a [Hyperion](https://github.com/willowtreeapps/Hyperion-iOS) library

<p align="center" id="Tiny Console Gif">
    <img src="https://raw.githubusercontent.com/NashZhou/HYPTinyConsolePlugin/master/gif/tiny-console.gif"/>
</p>

### Implementation & Notes
* Add the TinyConsolePlugin.framework file in your iOS project manually by following Hyperion's manual tutorial
* While the first-party plugins require no code implementation, you must call to the TinyConsole via Objective C or Swift
* [TinyConsole doesn't support Storyboards](https://github.com/Cosmo/TinyConsole/issues/29)

### Accessing the TinyConsole API
**Objective C**

* Install the framework like any other Hyperion plugin
* Use `#import <TinyConsolePlugin/TinyConsole.h>` and call `[TinyConsole printText:]` to print to the console

**Swift**

* Install the framework like any other Hyperion plugin
* Create a bridging header file and import TinyConsole
* Call `TinyConsole.printText()` to print to the console

**C#**

* Create a Xamarin iOS binding of the TinyConsole plugin
* Install the framework as a Native Reference along with HyperionCore in your iOS app
* Call to your Xamarin binding to print to the console
