#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"

#include <string.h>
#include <jni.h>
#include <pthread.h>

#include <android/log.h>
#define INFO(msg) __android_log_write(ANDROID_LOG_INFO,"pack.c",msg);

#define RE(msg) return (*env)->NewStringUTF(env, msg);

char debugMsg[100];
int test = 0;

AVFormatContext *pFormatCtx;
int             i, videoStream, frameCount = 0;
AVCodecContext  *pCodecCtx;
AVCodec         *pCodec;
AVFrame         *pFrame; 
AVPacket        packet;
int             frameFinished;
float           aspect_ratio;
struct SwsContext *img_convert_ctx;
int width, height, bit_rate;


/*****************************************************/
/* test */
/*****************************************************/

jstring
Java_sysu_ss_xu_FFmpeg_stringFromJNI( JNIEnv* env, jobject thiz )
{  
 return (*env)->NewStringUTF(env, "Helloworld from FFmpeg!");
}

void
Java_sysu_ss_xu_FFmpeg_nativeTest( JNIEnv* env, jobject thiz)
{
	++test;
	sprintf(debugMsg, "%d", test);
	INFO(debugMsg);
}

jintArray Java_sysu_ss_xu_FFmpeg_jniIntArray( JNIEnv* env, jobject thiz )
{
INFO("hi");
	int nativeIntArray[2];
	nativeIntArray[0] = 330;
	nativeIntArray[1] = 2;
	sprintf(debugMsg, "0 %d", nativeIntArray[0]);
	INFO(debugMsg);
	sprintf(debugMsg, "1 %d", nativeIntArray[1]);
	INFO(debugMsg);

	jintArray nativeReturn = (*env)->NewIntArray(env, 2);
	(*env)->SetIntArrayRegion(env, nativeReturn, 0, 2, nativeIntArray);
	return nativeReturn;
}

/*****************************************************/
/* / test */
/*****************************************************/

/*****************************************************/
/* FFmpeg API */
/*****************************************************/

void Java_sysu_ss_xu_FFmpeg_avRegisterAll( JNIEnv* env, jobject thiz )
{
	av_register_all();
}

/*
JNI_FALSE and JNI_TRUE are constants defined for the jboolean type:

#define JNI_FALSE  0
#define JNI_TRUE   1
*/

jboolean Java_sysu_ss_xu_FFmpeg_avOpenInputFile( JNIEnv* env, jobject thiz, jstring jfilePath )
{
	char* filePath = (char *)(*env)->GetStringUTFChars(env, jfilePath, NULL);
	if( av_open_input_file(&pFormatCtx, filePath, NULL, 0, NULL) != 0)
		return 0;
	else
		return 1;
}

jboolean Java_sysu_ss_xu_FFmpeg_avFindStreamInfo( JNIEnv* env, jobject thiz )
{
	if( av_find_stream_info(pFormatCtx) < 0)
		return 0;
	else
		return 1;
}

jboolean Java_sysu_ss_xu_FFmpeg_findVideoStream( JNIEnv* env, jobject thiz )
{
	videoStream=-1;
	for(i=0; i<pFormatCtx->nb_streams; i++)
		if(pFormatCtx->streams[i]->codec->codec_type==AVMEDIA_TYPE_VIDEO) {
		videoStream=i;
		break;
		}
	if( videoStream  == -1)
		return 0;
	else
		return 1;
}

jboolean Java_sysu_ss_xu_FFmpeg_avcodecFindDecoder( JNIEnv* env, jobject thiz )
{
	pCodecCtx=pFormatCtx->streams[videoStream]->codec;
  
	pCodec=avcodec_find_decoder(pCodecCtx->codec_id);
	if(pCodec==NULL) 
		return 0;
	else
		return 1;
}

jboolean Java_sysu_ss_xu_FFmpeg_avcodecOpen( JNIEnv* env, jobject thiz )
{
	if(avcodec_open(pCodecCtx, pCodec)<0)
		return 0;
	else
		return 1;
}

void Java_sysu_ss_xu_FFmpeg_avcodecAllocFrame( JNIEnv* env, jobject thiz )
{
	pFrame=avcodec_alloc_frame();
}

/*****************************************************/
/* / FFmpeg API */
/*****************************************************/

/*****************************************************/
/* functional call */
/*****************************************************/

jstring Java_sysu_ss_xu_FFmpeg_getCodecName( JNIEnv* env, jobject thiz )
{
	return (*env)->NewStringUTF(env, pCodec->name);
}

jint Java_sysu_ss_xu_FFmpeg_getWidth( JNIEnv* env, jobject thiz )
{
	width = pCodecCtx->width; 
	return pCodecCtx->width;
}

jint Java_sysu_ss_xu_FFmpeg_getHeight( JNIEnv* env, jobject thiz )
{
	height = pCodecCtx->height;
	return pCodecCtx->height;
}

jint Java_sysu_ss_xu_FFmpeg_getBitRate( JNIEnv* env, jobject thiz )
{
	bit_rate = pCodecCtx->bit_rate;
	return pCodecCtx->bit_rate;
}

/* for each decoded frame */
jbyteArray Java_sysu_ss_xu_FFmpeg_getNextDecodedFrame( JNIEnv* env, jobject thiz )
{
INFO("next decoded frame");

av_free_packet(&packet);

while(av_read_frame(pFormatCtx, &packet)>=0) {

	if(packet.stream_index==videoStream) {
	
		avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);

		if(frameFinished) {
INFO("got a frame");

		AVPicture pict;

		pict.linesize[0] = width;
		pict.linesize[1] = width / 2;
		pict.linesize[2] = width / 2;
/*
// tested ok.
		int pixelData1[ width * height ];
		int pixelData2[ width * height ];
		int pixelData3[ width * height ];
		pict.data[0] = pixelData1;
		pict.data[1] = pixelData2;
		pict.data[2] = pixelData3;
*/

		/* tested ok, too. Yay! */
		uint8_t pixelData[ width * height * 3 ];		
		pict.data[0] = &pixelData[ 0 ];
		pict.data[1] = &pixelData[ width * height ];
		pict.data[2] = &pixelData[ width * height * 2 ];
		
INFO("memory prepared");

		int dstFmt = PIX_FMT_YUV420P;

		img_convert_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height, pCodecCtx->pix_fmt, pCodecCtx->width, pCodecCtx->height, dstFmt, SWS_BICUBIC, NULL, NULL, NULL);

		sws_scale(img_convert_ctx, (const uint8_t* const*)pFrame->data, pFrame->linesize,
	 0, pCodecCtx->height, pict.data, pict.linesize);
INFO("frame format converted");
		sprintf(debugMsg, "*(pict.data[0]) %d", *(pict.data[0]));	
		INFO(debugMsg);
		sprintf(debugMsg, "*(pict.data[1]) %d", *(pict.data[1]));	
		INFO(debugMsg);
		sprintf(debugMsg, "*(pict.data[2]) %d", *(pict.data[2]));	
		INFO(debugMsg);
		sprintf(debugMsg, "sizeof %d %d", sizeof(pixelData[0]), sizeof(uint8_t));
		INFO(debugMsg);
		sprintf(debugMsg, "*pixelData %d", *pixelData);
		INFO(debugMsg);

++frameCount;
INFO("++frameCount and return");

		/* uint8_t == unsigned 8 bits == jboolean */
		jbyteArray nativePixels = (*env)->NewByteArray(env, width * height * 3);
INFO("where failed 1");
		(*env)->SetByteArrayRegion(env, nativePixels, 0, width * height * 3, pixelData);
INFO("where failed 2");

		return nativePixels;
		}

	}

	av_free_packet(&packet);
}
}

/*****************************************************/
/* / functional call */
/*****************************************************/


jstring
Java_sysu_ss_xu_FFmpeg_play( JNIEnv* env, jobject thiz, jstring jfilePath )
{

char* filePath = (char *)(*env)->GetStringUTFChars(env, jfilePath, NULL);
RE(filePath);

/*****************************************************/

  AVFormatContext *pFormatCtx;
  int             i, videoStream;
  AVCodecContext  *pCodecCtx;
  AVCodec         *pCodec;
  AVFrame         *pFrame; 
  AVPacket        packet;
  int             frameFinished;
  float           aspect_ratio;
  struct SwsContext *img_convert_ctx;

INFO(filePath);

/* FFmpeg */

  av_register_all();

  if(av_open_input_file(&pFormatCtx, filePath, NULL, 0, NULL)!=0)
	RE("failed av_open_input_file ");
  
  if(av_find_stream_info(pFormatCtx)<0)
    	RE("failed av_find_stream_info");

  videoStream=-1;
  for(i=0; i<pFormatCtx->nb_streams; i++)
    if(pFormatCtx->streams[i]->codec->codec_type==AVMEDIA_TYPE_VIDEO) {
      videoStream=i;
      break;
    }
  if(videoStream==-1)
    	RE("failed videostream == -1");
  
  pCodecCtx=pFormatCtx->streams[videoStream]->codec;
  
  pCodec=avcodec_find_decoder(pCodecCtx->codec_id);
  if(pCodec==NULL) {
    RE("Unsupported codec!");
  }
  
  if(avcodec_open(pCodecCtx, pCodec)<0)
    RE("failed codec_open");
  
  pFrame=avcodec_alloc_frame();

/* /FFmpeg */

INFO("codec name:");
INFO(pCodec->name);
INFO("Getting into stream decode:");

/* video stream */

  i=0;
  while(av_read_frame(pFormatCtx, &packet)>=0) {

    if(packet.stream_index==videoStream) {
      avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, 
			   &packet);
      if(frameFinished) {
++i;
INFO("frame finished");

	AVPicture pict;
/*
	img_convert_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height,
 pCodecCtx->pix_fmt, pCodecCtx->width, pCodecCtx->height,
 PIX_FMT_YUV420P, SWS_BICUBIC, NULL, NULL, NULL);

	sws_scale(img_convert_ctx, (const uint8_t* const*)pFrame->data, pFrame->linesize,
 0, pCodecCtx->height, pict.data, pict.linesize);
*/
      }

    }

    av_free_packet(&packet);
  }

/* /video stream */

  av_free(pFrame);
  
  avcodec_close(pCodecCtx);
  
  av_close_input_file(pFormatCtx);
  
  RE("end of main");
}
