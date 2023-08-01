# Just copy-paste this file content to ~/.bash_profile or ~/.zshrc
profiling() {
  current_value=$(adb shell getprop debug.hwui.profile | tr -d '\r')
  #https://android.googlesource.com/platform/frameworks/base/+/7bd8eaf/libs/hwui/Properties.h
  if [[ "$current_value" == "false" ]]; then     	
    adb shell setprop debug.hwui.profile visual_bars
    update_properties
  else
    adb shell setprop debug.hwui.profile false
    update_properties
  fi
}

update_properties() {
 # https://github.com/aosp-mirror/platform_packages_apps_settings/blob/f8ad32823c5709348a5fb9618166b07394e88d99/src/com/android/settings/development/DevelopmentSettings.java#L2857
 adb shell service call activity 1599295570
}

screenshot() {
 adb exec-out screencap -p > screenshot.png
 mv -f screenshot.png ~/Desktop/screenshot.png
}
