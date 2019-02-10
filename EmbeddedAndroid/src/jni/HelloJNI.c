/*
 * *************************************************************************************
 *
 * Filename     : HelloJNI.c
 *
 * Description  : 
 *
 * Version      : 1.0
 * Created      : 01/28/19 00:15:18
 * Revision     : none
 * Compiler     : gcc
 *
 * Author       : Bamboo Do, bamboo@bbtechlab.com
 * Copyright (c) 2019, BBTECHLab - All rights reserved.
 *
 * *************************************************************************************
 */
/*******************************************************************/
/**************************** Header Files *************************/
/*******************************************************************/
/* Start Including Header Files */
#include <jni.h>        // JNI header provided by JDK
#include <stdio.h>      // C Standard IO Header
#include "HelloJNI.h"   // Generated
/* End Including Headers */

/*******************************************************************/
/****************************** define *****************************/
/*******************************************************************/
/* Start #define */
/* End #define */

/*******************************************************************/
/*********************** Type Defination ***************************/
/*******************************************************************/
/* Start typedef */
/* End typedef */


/*******************************************************************/
/*********************** Global Variables **************************/
/*******************************************************************/
/* Start global variable */
/* End global variable */


/*******************************************************************/
/*********************** Static Variables **************************/
/*******************************************************************/
/* Start static variable */
/* End static variable */


/*******************************************************************/
/******************** Global Functions ********************/
/*******************************************************************/
/* Start global functions */
/* End global functions */


/*******************************************************************/
/*********************** Static Functions **************************/
/*******************************************************************/
/* Start static functions */
/* End static functions */


/*******************************************************************/
/*********************** Function Description***********************/
/*******************************************************************/
#define ___STATIC_FUNCTION_________________

#define ___GLOBAL_FUNCTION_________________
// Implementation of the native method sayHello()
JNIEXPORT void JNICALL Java_HelloJNI_sayHello(JNIEnv *env, jobject thisObj) {
    printf("Hello World!\n");

    return;
}

JNIEXPORT jdouble JNICALL Java_HelloJNI_average(JNIEnv *env, jobject thisObj, jint n1, jint n2) {
	jdouble result;
	
	printf("In C, the numbers are %d and %d\n", n1, n2);
	
	result = ((jdouble)n1 + n2)/2.0;
	
	return result;
}

JNIEXPORT jstring JNICALL Java_HelloJNI_stringJNI(JNIEnv *env, jobject thisObj, jstring str){
	// Convert the JNI String (jstring) into C-string (char*)
	const char *charArray = (*env)->GetStringUTFChars(env, str, NULL);
	if (charArray == NULL) {
		return NULL;
	}
	
	// Displaying the received string
	printf("In C, the received string is: %s\n", charArray);
	(*env)->ReleaseStringUTFChars(env, str, charArray); // Release resourse
	
	// Prompt users to enter string
	char userString[128];
	printf("In C, Enter a string:");
	scanf("%s", userString);
	
	// Convert C-string (char*) into JNI String (jstring) and return
	return (*env)->NewStringUTF(env, userString);
}

JNIEXPORT jdoubleArray JNICALL Java_HelloJNI_sumAndAverage (JNIEnv *env, jobject thisObj, jintArray inJNIArray) {
	// Convert the incoming JNI jintarray to C's jint[]
	jint *intArray = (*env)->GetIntArrayElements(env, inJNIArray, NULL);
	if (intArray == NULL){
		return NULL;
	}
	jsize length = (*env)->GetArrayLength(env, inJNIArray);
	
	// Perforn its intended operations 
	jint sum = 0;
	int i;
	for (i = 0; i < length; i++) {
		sum += intArray[i];
	}
	jdouble average = (jdouble)sum / length;
	(*env)->ReleaseIntArrayElements(env, inJNIArray, intArray, 0); // Release resource
	
	jdouble outArray[] = {sum, average};
	
	// Conver the C's native jdouble[] to JNI jdoubleArray, and return
	jdoubleArray outJNIArray = (*env)->NewDoubleArray(env, 2); // Allocate
	if (NULL == outArray) {
		return NULL;
	}
	
	(*env)->SetDoubleArrayRegion(env, outJNIArray, 0, 2, outArray); // Copy
	
	return outJNIArray;
 }
 
JNIEXPORT void JNICALL Java_HelloJNI_modifyInstanceVariable(JNIEnv *env, jobject thisObj) {
	// Get a reference to this object's class
	jclass thisClass = (*env)->GetObjectClass(env, thisObj);
	
	// Get the Fileld ID of the instance variables "number"
	jfieldID fidNumber = (*env)->GetFieldID(env, thisClass, "number", "I");
	if (NULL == fidNumber)
		return;
	// Get the int given the FieldID
	jint number = (*env)->GetIntField(env, thisObj, fidNumber);
	printf("In C, the int is %d\n", number);
	
	// Change the value of variable
	number = 9999;
	(*env)->SetIntField(env, thisObj, fidNumber, number);
	
	// Get the FieldID of the instance variable "message"
	jfieldID fidMessage = (*env)->GetFieldID(env, thisClass, "message", "Ljava/lang/String;");
	if (NULL == fidMessage) 
		return;
	// Get the object given the Field ID
	jstring message = (*env)->GetObjectField(env, thisObj, fidMessage);
	// Create a C-string with the JNI String
	const char *cStr = (*env)->GetStringUTFChars(env, message, NULL);
	if (NULL == cStr) 
		return;
	printf("In C, the string is %s\n", cStr);
	(*env)->ReleaseStringUTFChars(env, message, cStr); // Release resource
	// Create a new C-string and assign to the JNI string
	message = (*env)->NewStringUTF(env, "Hello from C");
	if (NULL == message) 
		return;
	// modify the instance variables
	(*env)->SetObjectField(env, thisObj, fidMessage, message);
}

JNIEXPORT void JNICALL Java_HelloJNI_modifyStaticVariable(JNIEnv *env, jobject thisObj) {
}
/*********************** End of File ******************************/