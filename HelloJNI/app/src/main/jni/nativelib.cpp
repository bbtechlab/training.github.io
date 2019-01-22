//
// Created by vqdo on 1/22/2019.
//
#include "com_humaxdigital_hellojni_helloStringJNI.h"

JNIEXPORT jstring JNICALL Java_com_humaxdigital_hellojni_helloStringJNI_getStringJNI (JNIEnv *env, jobject obj) {
    return (*env).NewStringUTF("hello JNI - Bamboo");
}

