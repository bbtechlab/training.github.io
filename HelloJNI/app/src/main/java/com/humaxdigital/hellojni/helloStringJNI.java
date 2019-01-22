package com.humaxdigital.hellojni;

public class helloStringJNI {
    static {
        System.loadLibrary("nativelib");
    }

    public native String getStringJNI();

}
