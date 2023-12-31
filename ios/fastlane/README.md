fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios version

```sh
[bundle exec] fastlane ios version
```

Update version

### ios submit_review

```sh
[bundle exec] fastlane ios submit_review
```

Submit review only

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Push a new beta build to TestFlight

### ios release

```sh
[bundle exec] fastlane ios release
```

Push a new release build to the App Store

### ios send_slack_test

```sh
[bundle exec] fastlane ios send_slack_test
```



### ios send_slack_appstore

```sh
[bundle exec] fastlane ios send_slack_appstore
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
