// tutorial02.c
// A pedagogical video player that will stream through every video frame as fast as it can.
//
// Code based on FFplay, Copyright (c) 2003 Fabrice Bellard, 
// and a tutorial by Martin Bohme (boehme@inb.uni-luebeckREMOVETHIS.de)
// Tested on Gentoo, CVS version 5/01/07 compiled with GCC 4.1.1
// Use
//
// gcc -o tutorial02 tutorial02.c -lavformat -lavcodec -lz -lm `sdl-config --cflags --libs`
// to build (assuming libavformat and libavcodec are correctly installed, 
// and assuming you have sdl-config. Please refer to SDL docs for your installation.)
//
// Run using
// tutorial02 myvideofile.mpg
//
// to play the video stream on your screen.

/*
gcc -o tutorial02 tutorial02.c -lavutil -lavformat -lavcodec -lswscale -lz -lavutil -lm `sdl-config --cflags --libs`
*/

#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"

#include "sdl/include/SDL/SDL.h"
#include "sdl/include/SDL/SDL_thread.h"

#ifdef __MINGW32__
#undef main /* Prevents SDL from overriding main() */
#endif

#include <stdio.h>

int main(int argc, char *argv[]) {
  AVFormatContext *pFormatCtx;
  int             i, videoStream;
  AVCodecContext  *pCodecCtx;
  AVCodec         *pCodec;
  AVFrame         *pFrame; 
  AVPacket        packet;
  int             frameFinished;
  float           aspect_ratio;
  struct SwsContext *img_convert_ctx;

  SDL_Overlay     *bmp;
  SDL_Surface     *screen;
  SDL_Rect        rect;
  SDL_Event       event;

  if(argc < 2) {
    fprintf(stderr, "Usage: test <file>\n");
    exit(1);
  }
  // Register all formats and codecs
  av_register_all();
  
  if(SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER)) {
    fprintf(stderr, "Could not initialize SDL - %s\n", SDL_GetError());
    exit(1);
  }

  // Open video file
  if(av_open_input_file(&pFormatCtx, argv[1], NULL, 0, NULL)!=0)
    return -1; // Couldn't open file
  
  // Retrieve stream information
  if(av_find_stream_info(pFormatCtx)<0)
    return -1; // Couldn't find stream information
  
  // Dump information about file onto standard error
  dump_format(pFormatCtx, 0, argv[1], 0);
  
  // Find the first video stream
  videoStream=-1;
  for(i=0; i<pFormatCtx->nb_streams; i++)
    if(pFormatCtx->streams[i]->codec->codec_type==AVMEDIA_TYPE_VIDEO) {
      videoStream=i;
      break;
    }
  if(videoStream==-1)
    return -1; // Didn't find a video stream
  
  // Get a pointer to the codec context for the video stream
  pCodecCtx=pFormatCtx->streams[videoStream]->codec;
  
  // Find the decoder for the video stream
  pCodec=avcodec_find_decoder(pCodecCtx->codec_id);
  if(pCodec==NULL) {
    fprintf(stderr, "Unsupported codec!\n");
    return -1; // Codec not found
  }
  
  // Open codec
  if(avcodec_open(pCodecCtx, pCodec)<0)
    return -1; // Could not open codec
  
  // Allocate video frame
  pFrame=avcodec_alloc_frame();

  // Make a screen to put our video
#ifndef __DARWIN__
        screen = SDL_SetVideoMode(pCodecCtx->width, pCodecCtx->height, 0, 0);
#else
        screen = SDL_SetVideoMode(pCodecCtx->width, pCodecCtx->height, 24, 0);
#endif
  if(!screen) {
    fprintf(stderr, "SDL: could not set video mode - exiting\n");
    exit(1);
  }
  
  // Allocate a place to put our YUV image on that screen
  bmp = SDL_CreateYUVOverlay(pCodecCtx->width,
				 pCodecCtx->height,
				 SDL_YV12_OVERLAY,
				 screen);


  // Read frames and save first five frames to disk
  i=0;
  while(av_read_frame(pFormatCtx, &packet)>=0) {
    // Is this a packet from the video stream?
    if(packet.stream_index==videoStream) {
      // Decode video frame
      avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, 
			   &packet);
      
      // Did we get a video frame?
      if(frameFinished) {
	SDL_LockYUVOverlay(bmp);

	AVPicture pict;
	pict.data[0] = bmp->pixels[0];
	pict.data[1] = bmp->pixels[2];
	pict.data[2] = bmp->pixels[1];

	pict.linesize[0] = bmp->pitches[0];
	pict.linesize[1] = bmp->pitches[2];
	pict.linesize[2] = bmp->pitches[1];

	// Convert the image into YUV format that SDL uses
/*
	img_convert(&pict, PIX_FMT_YUV420P,
                    (AVPicture *)pFrame, pCodecCtx->pix_fmt, 
		    pCodecCtx->width, pCodecCtx->height);
*/
	int dstFmt;
	dstFmt = PIX_FMT_YUV420P;

	img_convert_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height,
 pCodecCtx->pix_fmt, pCodecCtx->width, pCodecCtx->height,
 dstFmt, SWS_BICUBIC, NULL, NULL, NULL);

	sws_scale(img_convert_ctx, (const uint8_t* const*)pFrame->data, pFrame->linesize,
 0, pCodecCtx->height, pict.data, pict.linesize);

/*
	printf("*(pict.data[0]: %d\n", *(pict.data[0]));
	printf("*(pict.data[1]: %d\n", *(pict.data[1]));
	printf("*(pict.data[2]: %d\n", *(pict.data[2]));
	printf("*(pict.data[3]: %d\n", *(pict.data[3]));
	printf("linesize[0]: %d\n", pict.linesize[0]);
	printf("linesize[1]: %d\n", pict.linesize[1]);
	printf("linesize[2]: %d\n", pict.linesize[2]);
	printf("linesize[3]: %d\n", pict.linesize[3]);
	printf("width: %d\n", pCodecCtx->width);
	printf("height: %d\n", pCodecCtx->height);
*/
	++i;
	if(i>50)
	if(i<=51) {
	printf("frame 51\n");
		if( *(pict.data[0]) == 20) 
			printf("frame 51, line 0, x=1, 20\n");
	}

	SDL_UnlockYUVOverlay(bmp);
	
	rect.x = 0;
	rect.y = 0;
	rect.w = pCodecCtx->width;
	rect.h = pCodecCtx->height;
	SDL_DisplayYUVOverlay(bmp, &rect);
//SDL_Delay(1000);
//return 0;
      }
    }
    
    // Free the packet that was allocated by av_read_frame
    av_free_packet(&packet);
    SDL_PollEvent(&event);
    switch(event.type) {
    case SDL_QUIT:
      SDL_Quit();
      exit(0);
      break;
    default:
      break;
    }

  }
  
  // Free the YUV frame
  av_free(pFrame);
  
  // Close the codec
  avcodec_close(pCodecCtx);
  
  // Close the video file
  av_close_input_file(pFormatCtx);
  
  return 0;
}
