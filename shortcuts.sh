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

bounds() {
  current_value=$(adb shell getprop debug.layout true | tr -d '\r')
  if [[ "$current_value" == "false" ]]; then     	
    adb shell setprop debug.layout true
    update_properties
  else
    adb shell setprop debug.layout false
    update_properties
  fi
}

# Add to ~/.bash_profile or ~/.zshrc
kill_process() {
 adb shell am kill $package
}

# Sometimes regular kill_process does not work ¯\_(ツ)_/¯
kill_process_2() {
  adb shell "ps | grep ${package} | awk '{print $2}'" | xargs adb shell "run-as    ${package} kill"
}


screenshot() {
  adb exec-out screencap -p > ~/Desktop/screenshot.png
}

update_properties() {
 # https://github.com/aosp-mirror/platform_packages_apps_settings/blob/f8ad32823c5709348a5fb9618166b07394e88d99/src/com/android/settings/development/DevelopmentSettings.java#L2857
 adb shell service call activity 1599295570
}
