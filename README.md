# Backtrace-Crashpad
 Binary packages for Crashpad for crash reporting, with support for special extensions including file attachments.

 ## Crashpad

 [Crashpad](https://crashpad.chromium.org/) is a crash-reporting system.

 ### Documentation
  * [Crashpad interface documentation](https://crashpad.chromium.org/doxygen/)

 ### Source Code

 Crashpad’s source code is hosted in a Git repository at
 https://chromium.googlesource.com/crashpad/crashpad.

 ### Other Links

  * Bugs can be reported at the [Crashpad issue
    tracker](https://crashpad.chromium.org/bug/).
  * The [Crashpad bots](https://ci.chromium.org/p/crashpad/g/main/console)
    perform automated builds and tests.
  * [crashpad-dev](https://groups.google.com/a/chromium.org/group/crashpad-dev)
    is the Crashpad developers’ mailing list.

## Installation

- [CocoaPods](https://cocoapods.org/): For Backtrace-Crashpad, use the following entry in your Podfile:
```
pod 'Backtrace-Crashpad'
```
Then run `pod install`.

## Xcode setup

[App Sandbox Entitlements](https://developer.apple.com/documentation/security/app_sandbox_entitlements) needs to be disabled.

## Sample usage

```objc++
#include <iostream>
#include <base/files/file_path.h>
#include <client/crash_report_database.h>
#include <client/settings.h>
#include <client/crashpad_client.h>

void startCrashpad() {

  std::map<std::string, std::string> annotations;
  annotations["format"] = "minidump";
  annotations["token"] = "<BACKTRACE_TOKEN>";
  std::vector<std::string> arguments;
  CrashpadClient client;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docsPath = [paths objectAtIndex:0];
  std::unique_ptr<CrashReportDatabase> database = CrashReportDatabase::Initialize(base::FilePath{[[docsPath stringByAppendingString:@"/crashpad_db"] cStringUsingEncoding: NSUTF8StringEncoding]});
  database->GetSettings()->SetUploadsEnabled(true);
  NSString *crashpadHandlerPath = [[NSBundle mainBundle] pathForResource: @"crashpad_handler" ofType: @""];
  arguments.push_back("--no-rate-limit");
  client.StartHandler(base::FilePath{[crashpadHandlerPath cStringUsingEncoding: NSUTF8StringEncoding]},
                      base::FilePath{[[docsPath stringByAppendingString:@"/crashpad_db"] cStringUsingEncoding: NSUTF8StringEncoding]},
                      base::FilePath{[[docsPath stringByAppendingString:@"/crashpad_db"] cStringUsingEncoding: NSUTF8StringEncoding]},
                      "https://team.sp.backtrace.io:6098/post",
                      annotations,
                      arguments,
                      true,
                      true);

  // Crash the app
  DoTheImpossible();
}
```
