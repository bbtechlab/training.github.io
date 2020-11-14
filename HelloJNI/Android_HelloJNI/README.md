<span id="_Toc535936349" class="anchor"></span>*Developing Android NDK
Applications for Embedded Devices*

NDK application development can be divided into five steps shown in
following figure

![](media/image1.png){width="6.49375in" height="1.4097222222222223in"}

<span id="_Toc535936315" class="anchor"></span>**Figure 3‑1. NDK
Application Development Process**

<span id="_Toc535936350" class="anchor"></span>Developing Android NDK
Applications with Android Studio

***Required***

-   [*\[Install JDK
    8\]*](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

    -   jdk1.8.0\_201

-   [*\[Install Android
    Studio\]*](https://developer.android.com/studio/#downloads)

    -   Make sure that plugin NDK installed: Tools &gt; SDK Manager &gt;
        Android SDK

        -   Checked LLDB, CMake, NDK

![](media/image2.png){width="6.49375in" height="4.518055555555556in"}

<span id="_Toc535936316" class="anchor"></span>**Figure 3‑2. Install NDK
plugin **

Step 1: Creating a HelloJNI project

-   Open Android Studio IDE in your computer.

-   Create a new project and Edit the Application name to
    “**HelloJNI**”. (Optional) You can edit the company domain or select
    the suitable location for current project tutorial. Then click next
    button to proceed.

-   Select Minimum SDK (API 15:Android 4.0.3 (IceCreamSandwich). I
    choose the API 15 because many android devices currently are support
    more than API 15. Click Next button.

-   Choose “Empty Activity” and Click Next button

-   Lastly, press finish button.

\[*Note : You must download NDK package in the SDK Manager to
proceed.*\]

Step 2: Setup external tools

In your android studio menu go to File &gt; Settings. Expand the Tools
section you will see “External Tools” and Click it. After that create
two external tools which are javah and ndk-build.

![](media/image3.png){width="6.49375in" height="4.204861111111111in"}

<span id="_Toc535936317" class="anchor"></span>**Figure 3‑3. Setup
external tools: javah**

![](media/image4.png){width="6.50625in" height="4.590277777777778in"}

<span id="_Toc535936318" class="anchor"></span>**Figure 3‑4. Setup
external tools: ndk-build**

Step 3: Add a java class for Java Native Interface

Right click package name &gt; new &gt; Java class and name it as
“helloStringJNI“. This class will add static and load the library which
name is “nativelib”. The library name is followed by the so file, we
will compile .so file later. And the native method is to get the method
from the C and C++ source code.

![](media/image5.png){width="6.49375in" height="3.8194444444444446in"}

<span id="_Toc535936319" class="anchor"></span>**Figure 3‑5. Add a Java
class for JNI**

Edit helloStringJNI.java class

Go to the file and copy the following code in your class.

  ----------------------------------------------------------
  1.     01 package com**.**humaxdigital**.**hellojni**;**
         
         02
         
         03 public class helloStringJNI **{**
         
         04 static **{**
         
         05 System**.**loadLibrary**(**"nativelib"**);**
         
         06 **}**
         
         07
         
         08 public native String getStringJNI**();**
         
         09
         
         10 **}**
  ------ ---------------------------------------------------
  ----------------------------------------------------------

<span id="_Toc535936320" class="anchor"></span>**Code 3‑1. Add a Java
class for JNI**

Step 4: Edit build.gradle (Module:app)

Add ndk and sourceSets.main in the defaultConfig. NDK is to specific
what module name you use, for example our module name will be
“**nativelib**”. The moduleName will follow by the C or C++ files so we
will create later. In SourceSets.main section the jni.srcDirs = \[\]
mean disable auto and jniLibs.src are specify which jni library located.

![](media/image6.png){width="6.49375in" height="3.9881944444444444in"}

<span id="_Toc535936321" class="anchor"></span>**Figure 3‑7. Edit
build.gradle (module:app)**

Edit gradle-properties

You will occur an error if you do not add the following code:

android.useDeprecatedNdk=true

![](media/image7.png){width="6.49375in" height="3.5541666666666667in"}

<span id="_Toc535936322" class="anchor"></span>**Figure 3‑8. Edit
gradle-properties**

Step 5: Add JNI & Implement C/C++ for nativelib

From Android navigate to Project Files, after that right click main
folder &gt; New &gt; Folder &gt; JNI Folder. You will see a new JNI
folder was added in.

![](media/image8.png){width="3.529861111111111in" height="3.6625in"}

<span id="_Toc535936323" class="anchor"></span>**Figure 3‑9. Add a JNI
Folder**

Right click your folder name jni &gt; New &gt; New C/C++ Source File and
name it as “nativelib.cpp“. This name must be same as ModuleName in
build.gradle.

Generate header files for nativelib.cpp.

-   Go to your java folder and Right click helloJNI.java class &gt;
    NDK &gt;javah. It will automatically create a header file in your
    jni folder. For example, it will look like this.

  -----------------------------------------------------------------------------------------------------
  1.     01 /\* DO NOT EDIT THIS FILE - it is machine generated \*/
         
         02 \#include **&lt;**jni**.**h**&gt;**
         
         03 /\* Header for class com\_humaxdigital\_hellojni\_helloStringJNI \*/
         
         04
         
         05 \#ifndef \_Included\_com\_humaxdigital\_hellojni\_helloStringJNI
         
         06 \#define \_Included\_com\_humaxdigital\_hellojni\_helloStringJNI
         
         07 \#ifdef \_\_cplusplus
         
         08 extern "C" **{**
         
         09 \#endif
         
         10 /\*
         
         11 \* Class: com\_humaxdigital\_hellojni\_helloStringJNI
         
         12 \* Method: getStringJNI
         
         13 \* Signature: ()Ljava/lang/String;
         
         14 \*/
         
         15 JNIEXPORT jstring JNICALL Java\_com\_humaxdigital\_hellojni\_helloStringJNI\_getStringJNI
         
         16 **(**JNIEnv **\*,** jobject**);**
         
         17
         
         18 \#ifdef \_\_cplusplus
         
         19 **}**
         
         20 \#endif
         
         21 \#endif
         
         22
  ------ ----------------------------------------------------------------------------------------------
  -----------------------------------------------------------------------------------------------------

<span id="_Toc535936324" class="anchor"></span>**Code 3‑2. Header of
helloJNI.java class**

Now, edit nativelib.cpp files. Copy the method header from
Auto-generated header files and paste it into this file. After that, add
the parameter variable and return a value by using C++ code style. You
must include the header file.

  -------------------------------------------------------------------------------------------------------------------------------------------------------
  1.     01 //
         
         02 // Created by vqdo on 1/22/2019.
         
         03 //
         
         04 \#include "com\_humaxdigital\_hellojni\_helloStringJNI.h"
         
         05
         
         06 JNIEXPORT jstring JNICALL Java\_com\_humaxdigital\_hellojni\_helloStringJNI\_getStringJNI **(**JNIEnv **\***env**,** jobject obj**)** **{**
         
         07 **return** **(\***env**).**NewStringUTF**(**"hello JNI - Bamboo"**);**
         
         08 **}**
  ------ ------------------------------------------------------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------------------------------------------------------------

<span id="_Toc535936325" class="anchor"></span>**Code 3‑3.
nativelib.cpp**

Compile nativelib.so (shared library) file by creating Android.mk

Right click jni folder &gt; New &gt; File and name it to Android.mk. Add
the following code to your file.

[*\[Android.mk\]*](https://developer.android.com/ndk/guides/android_mk)

  -------------------------------------------------
  1.     1 LOCAL\_PATH **:=** \$(call my-dir)
         
         2 include \$(CLEAR\_VARS)
         
         3
         
         4 LOCAL\_MODULE **:=** nativelib
         
         5 LOCAL\_SRC\_FILES **:=** nativelib.cpp
         
         6 include \$(BUILD\_SHARED\_LIBRARY)
  ------ ------------------------------------------
  -------------------------------------------------

<span id="_Toc535936326" class="anchor"></span>**Code 3‑4. Android.mk
for compiling all C/C++ source of nativelib**

Right click jni folder &gt; New &gt; File and name it to Application.mk.
Add the following code to your file.

[*\[Application.mk\]*](https://developer.android.com/ndk/guides/application_mk)

  ----------------------------------------
  1.     1 APP\_MODULES **:=** nativelib
         
         2
         
         3 APP\_ABI **:=** all
  ------ ---------------------------------
  ----------------------------------------

<span id="_Toc535936327" class="anchor"></span>**Code 3‑5.
Appkication.mk for compiling nativelib module**

Right-click main folder &gt; NDK &gt; ndk-build. You will see new so
files will appear in your libs folder as the picture below. The folders
separate by different CPUs name.

![](media/image9.png){width="4.144444444444445in"
height="4.4215277777777775in"}

<span id="_Toc535936328" class="anchor"></span>**Figure 3‑14.
nativelib.so outputs separated by different CPUs name.**

Step 6: Access nativelib via main activity

Edit activity\_main.xml layout

  --------------------------------------------------------------------------------------------------------------------------------
  1.     **01** &lt;?xml version=**"1.0"** encoding=**"utf-8"**?&gt;
         
         **02** &lt;android.support.constraint.ConstraintLayout xmlns:android=**"*http://schemas.android.com/apk/res/android*"**
         
         03 xmlns:app=**"*http://schemas.android.com/apk/res-auto*"**
         
         04 xmlns:tools=**"*http://schemas.android.com/tools*"**
         
         05 android:layout\_width=**"match\_parent"**
         
         06 android:layout\_height=**"match\_parent"**
         
         07 tools:context=**".MainActivity"**&gt;
         
         **08 **
         
         **09** &lt;TextView
         
         10 android:layout\_width=**"wrap\_content"**
         
         11 android:layout\_height=**"wrap\_content"**
         
         12 android:id=**"@+id/textView"**
         
         13 android:text=**"Hello World!"**
         
         14 app:layout\_constraintBottom\_toBottomOf=**"parent"**
         
         15 app:layout\_constraintLeft\_toLeftOf=**"parent"**
         
         16 app:layout\_constraintRight\_toRightOf=**"parent"**
         
         17 app:layout\_constraintTop\_toTopOf=**"parent"** /&gt;
         
         **18 **
         
         **19** &lt;/android.support.constraint.ConstraintLayout&gt;
  ------ -------------------------------------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------

**Code 3‑6. activity\_main.xml layout**

Edit MainActivity.java class

  --------------------------------------------------------------------------------------------
  1.     01 package com**.**humaxdigital**.**hellojni**;**
         
         02
         
         03 **import** android**.**support**.**v7**.**app**.**AppCompatActivity**;**
         
         04 **import** android**.**os**.**Bundle**;**
         
         05 **import** android**.**widget**.**TextView**;**
         
         06
         
         07 public class MainActivity **extends** AppCompatActivity **{**
         
         08
         
         09 @Override
         
         10 protected void onCreate**(**Bundle savedInstanceState**)** **{**
         
         11 **super.**onCreate**(**savedInstanceState**);**
         
         12 setContentView**(**R**.**layout**.**activity\_main**);**
         
         13
         
         14 TextView textView**=(**TextView**)**findViewById**(**R**.**id**.**textView**);**
         
         15 helloStringJNI testStringJNI **=** **new** helloStringJNI**();**
         
         16 textView**.**setText**(**"" **+** testStringJNI**.**getStringJNI**());**
         
         17 **}**
         
         18 **}**
  ------ -------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------

**Code 3‑7. MainActivity.java class**

Now to try to run your project, you shall see the output like as below

![](media/image10.png){width="3.036111111111111in"
height="5.1930555555555555in"}

<span id="_Toc535936329" class="anchor"></span>**Figure 3‑15. Demo
application of nativelib**

<span id="_Toc535936351" class="anchor"></span>Developing Android NDK
Applications with Eclipse

***Required***

-   Install Eclipse IDE for Java Developers, Android Development
    Tools (ADT) Eclipse Plugin.

    -   [*\[Eclipse IDE 2018‑12\]*](https://www.eclipse.org/downloads/)

    -   [*\[Installing the Eclipse
        Plugin\]*](https://stuff.mit.edu/afs/sipb/project/android/docs/sdk/installing/installing-adt.html)

-   Install Android SDK

    -   [*\[Command line tools
        only\]*](https://developer.android.com/studio/#downloads)

-   [*\[Install NDK\]*](https://developer.android.com/ndk/downloads/)

  -----------------------------------------------------------------------------------------------------
  1.     bamboo@DESKTOP**-**9NDTRKT**:\~/work/**C**/**android**-**ndk**-**r10e\$ tree **-**L 1 **./**
         
         **./**
         
         ├── GNUmakefile
         
         ├── README**.**TXT
         
         ├── RELEASE**.**TXT
         
         ├── build
         
         ├── docs
         
         ├── find**-**win**-**host**.**cmd
         
         ├── ndk**-**build
         
         ├── ndk**-**build**.**cmd
         
         ├── ndk**-**depends**.**exe
         
         ├── ndk**-**gdb
         
         ├── ndk**-**gdb**-**py
         
         ├── ndk**-**gdb**-**py**.**cmd
         
         ├── ndk**-**gdb**.**py
         
         ├── ndk**-**stack**.**exe
         
         ├── ndk**-**which
         
         ├── platforms
         
         ├── prebuilt
         
         ├── remove**-**windows**-**symlink**.**sh
         
         ├── samples
         
         ├── sources
         
         ├── tests
         
         └── toolchains
         
         8 directories**,** 14 files
         
         bamboo@DESKTOP**-**9NDTRKT**:\~/work/**C**/**android**-**ndk**-**r10e\$
  ------ ----------------------------------------------------------------------------------------------
  -----------------------------------------------------------------------------------------------------

<span id="_Toc535936330" class="anchor"></span>**Figure 3‑16. Install
NDK to C:\\android-ndk-r10e**

-   [*\[Install JDK
    8\]*](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

    -   jdk1.8.0\_201
