// tutorial01.c
// Code based on a tutorial by Martin Bohme (boehme@inb.uni-luebeckREMOVETHIS.de)
// Tested on Gentoo, CVS version 5/01/07 compiled with GCC 4.1.1
#include <string.h>
#include <jni.h>
#include <pthread.h>

#include <android/log.h>
#define INFO(msg) __android_log_write(ANDROID_LOG_INFO,"helloworld.c",msg);

jstring
Java_sysu_ss_xu_PlayerActivity_stringFromJNI( JNIEnv* env,
                                                  jobject thiz )
{  
 return (*env)->NewStringUTF(env, "Hello from JNI !");
}
