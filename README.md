# StartProject iOS

This is an iOS App (iPhone) that communicates in UDP to the TI CC3200 LaunchPad running the startproject_cc3200_ti-rtos project

### Features

The following features have been implemented
* Control the CC3200 LaunchPad's Red or Orange LED by pressing ON or OFF within the App
* Press a button to open a browser which loads the CC3200 LaunchPad's internal webserver configuration
* Press a button to open this Github repository

### Technology Used

* It uses mDNS to automatically find the CC3200 and then use the appropraite IP address
* It uses Async Sockets library to send UDP packets
* It uses NSUserDefaults to store the IP address
* It has a gradient function to create a gradient background, this can be configured to different colors



