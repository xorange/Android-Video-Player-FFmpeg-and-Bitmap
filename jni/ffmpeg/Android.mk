LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := ffmpeg
 
include $(LOCAL_PATH)/config.mak
 
LOCAL_CFLAGS := -DHAVE_AV_CONFIG_H -std=c99 -mfloat-abi=softfp -mfpu=neon -marm -march=armv7-a -mtune=cortex-a8
CFLAGS += -mfpu=neon

TARGET_ARCH_ABI :=armeabi-v7a

SWSCALE_C_FILES = options.c \
	rgb2rgb.c \
	swscale.c \
	swscale.h \
	utils.c \
	yuv2rgb.c \
	swscale_unscaled.c \
	swscale_internal.h

SWSCALE_C_FILES-$(ARCH_BFIN)          +=  bfin/internal_bfin.c     \
                               bfin/swscale_bfin.c      \
                               bfin/yuv2rgb_bfin.c
SWSCALE_C_FILES-$(CONFIG_MLIB)        +=  mlib/yuv2rgb_mlib.c
SWSCALE_C_FILES-$(HAVE_ALTIVEC)       +=  ppc/swscale_altivec.c    \
                               ppc/yuv2rgb_altivec.c    \
                               ppc/yuv2yuv_altivec.c
SWSCALE_C_FILES-$(HAVE_MMX)           +=  x86/rgb2rgb.c            \
                               x86/swscale_mmx.c        \
                               x86/yuv2rgb_mmx.c
SWSCALE_C_FILES-$(HAVE_VIS)           +=  sparc/yuv2rgb_vis.c
SWSCALE_C_FILES-$(HAVE_YASM)          +=  x86/scale.c

SWSCALE_C_FILES += $(SWSCALE_C_FILES-yes)
SWSCALE_SRC_FILES = $(addprefix libswscale/, $(sort $(SWSCALE_C_FILES)))
 
AVUTIL_C_FILES = adler32.c                                                        \
       aes.c                                                            \
       audioconvert.c                                                   \
       avstring.c                                                       \
       base64.c                                                         \
       cpu.c                                                            \
       crc.c                                                            \
       des.c                                                            \
       error.c                                                          \
       eval.c                                                           \
       fifo.c                                                           \
       file.c                                                           \
       imgutils.c                                                       \
       intfloat_readwrite.c                                             \
       inverse.c                                                        \
       lfg.c                                                            \
       lls.c                                                            \
       log.c                                                            \
       lzo.c                                                            \
       mathematics.c                                                    \
       md5.c                                                            \
       mem.c                                                            \
       dict.c                                                           \
       opt.c                                                            \
       parseutils.c                                                     \
       pixdesc.c                                                        \
       random_seed.c                                                    \
       rational.c                                                       \
       rc4.c                                                            \
       samplefmt.c                                                      \
       sha.c                                                            \
       tree.c                                                           \
       utils.c                                                          \
	arm/cpu.c \

AVUTIL_SRC_FILES = $(addprefix libavutil/, $(sort $(AVUTIL_C_FILES)))
 
AVCODEC_C_FILES = allcodecs.c                                                      \
       audioconvert.c                                                   \
       avpacket.c                                                       \
       bitstream.c                                                      \
       bitstream_filter.c                                               \
       dsputil.c                                                        \
       faanidct.c                                                       \
       fmtconvert.c                                                     \
       imgconvert.c                                                     \
       jrevdct.c                                                        \
       options.c                                                        \
       parser.c                                                         \
       raw.c                                                            \
       rawdec.c                                                         \
       resample.c                                                       \
       resample2.c                                                      \
       simple_idct.c                                                    \
       utils.c                                                          \

# parts needed for many different codecs
AVCODEC_C_FILES-$(CONFIG_AANDCT)                  += aandcttab.c
AVCODEC_C_FILES-$(CONFIG_AC3DSP)                  += ac3dsp.c
AVCODEC_C_FILES-$(CONFIG_CRYSTALHD)               += crystalhd.c
AVCODEC_C_FILES-$(CONFIG_ENCODERS)                += faandct.c jfdctfst.c jfdctint.c
AVCODEC_C_FILES-$(CONFIG_DCT)                     += dct.c dct32_fixed.c dct32_float.c
AVCODEC_C_FILES-$(CONFIG_DWT)                     += dwt.c
AVCODEC_C_FILES-$(CONFIG_DXVA2)                   += dxva2.c
FFT-AVCODEC_C_FILES-$(CONFIG_HARDCODED_TABLES)    += cos_tables.c cos_fixed_tables.c
AVCODEC_C_FILES-$(CONFIG_FFT)                     += avfft.c fft_fixed.c fft_float.c \
                                          $(FFT-AVCODEC_C_FILES-yes)
AVCODEC_C_FILES-$(CONFIG_GOLOMB)                  += golomb.c
AVCODEC_C_FILES-$(CONFIG_H264DSP)                 += h264dsp.c h264idct.c
AVCODEC_C_FILES-$(CONFIG_H264PRED)                += h264pred.c
AVCODEC_C_FILES-$(CONFIG_HUFFMAN)                 += huffman.c
AVCODEC_C_FILES-$(CONFIG_LPC)                     += lpc.c
AVCODEC_C_FILES-$(CONFIG_LSP)                     += lsp.c
AVCODEC_C_FILES-$(CONFIG_MDCT)                    += mdct_fixed.c mdct_float.c
AVCODEC_C_FILES-$(CONFIG_MPEGAUDIODSP)            += mpegaudiodsp.c                \
                                          mpegaudiodsp_fixed.c          \
                                          mpegaudiodsp_float.c
RDFT-AVCODEC_C_FILES-$(CONFIG_HARDCODED_TABLES)   += sin_tables.c
AVCODEC_C_FILES-$(CONFIG_RDFT)                    += rdft.c $(RDFT-AVCODEC_C_FILES-yes)
AVCODEC_C_FILES-$(CONFIG_SINEWIN)                 += sinewin.c
AVCODEC_C_FILES-$(CONFIG_VAAPI)                   += vaapi.c
AVCODEC_C_FILES-$(CONFIG_VDA)                     += vda.c
AVCODEC_C_FILES-$(CONFIG_VDPAU)                   += vdpau.c

# decoders/encoders/hardware accelerators
AVCODEC_C_FILES-$(CONFIG_A64MULTI_ENCODER)        += a64multienc.c elbg.c
AVCODEC_C_FILES-$(CONFIG_A64MULTI5_ENCODER)       += a64multienc.c elbg.c
AVCODEC_C_FILES-$(CONFIG_AAC_DECODER)             += aacdec.c aactab.c aacsbr.c aacps.c \
                                          aacadtsdec.c mpeg4audio.c kbdwin.c
AVCODEC_C_FILES-$(CONFIG_AAC_ENCODER)             += aacenc.c aaccoder.c    \
                                          aacpsy.c aactab.c      \
                                          psymodel.c iirfilter.c \
                                          mpeg4audio.c kbdwin.c
AVCODEC_C_FILES-$(CONFIG_AASC_DECODER)            += aasc.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_AC3_DECODER)             += ac3dec.c ac3dec_data.c ac3.c kbdwin.c
AVCODEC_C_FILES-$(CONFIG_AC3_ENCODER)             += ac3enc_float.c ac3enc.c ac3tab.c \
                                          ac3.c kbdwin.c
AVCODEC_C_FILES-$(CONFIG_AC3_FIXED_ENCODER)       += ac3enc_fixed.c ac3enc.c ac3tab.c ac3.c
AVCODEC_C_FILES-$(CONFIG_ALAC_DECODER)            += alac.c
AVCODEC_C_FILES-$(CONFIG_ALAC_ENCODER)            += alacenc.c
AVCODEC_C_FILES-$(CONFIG_ALS_DECODER)             += alsdec.c bgmc.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_AMRNB_DECODER)           += amrnbdec.c celp_filters.c   \
                                          celp_math.c acelp_filters.c \
                                          acelp_vectors.c             \
                                          acelp_pitch_delay.c
AVCODEC_C_FILES-$(CONFIG_AMRWB_DECODER)           += amrwbdec.c celp_filters.c   \
                                          celp_math.c acelp_filters.c \
                                          acelp_vectors.c             \
                                          acelp_pitch_delay.c lsp.c
AVCODEC_C_FILES-$(CONFIG_AMV_DECODER)             += sp5xdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_ANM_DECODER)             += anm.c
AVCODEC_C_FILES-$(CONFIG_ANSI_DECODER)            += ansi.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_APE_DECODER)             += apedec.c
AVCODEC_C_FILES-$(CONFIG_ASS_DECODER)             += assdec.c ass.c ass_split.c
AVCODEC_C_FILES-$(CONFIG_ASS_ENCODER)             += assenc.c ass.c
AVCODEC_C_FILES-$(CONFIG_ASV1_DECODER)            += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ASV1_ENCODER)            += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ASV2_DECODER)            += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ASV2_ENCODER)            += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ATRAC1_DECODER)          += atrac1.c atrac.c
AVCODEC_C_FILES-$(CONFIG_ATRAC3_DECODER)          += atrac3.c atrac.c
AVCODEC_C_FILES-$(CONFIG_AURA_DECODER)            += cyuv.c
AVCODEC_C_FILES-$(CONFIG_AURA2_DECODER)           += aura.c
AVCODEC_C_FILES-$(CONFIG_AVS_DECODER)             += avs.c
AVCODEC_C_FILES-$(CONFIG_BETHSOFTVID_DECODER)     += bethsoftvideo.c
AVCODEC_C_FILES-$(CONFIG_BFI_DECODER)             += bfi.c
AVCODEC_C_FILES-$(CONFIG_BINK_DECODER)            += bink.c binkdsp.c
AVCODEC_C_FILES-$(CONFIG_BINKAUDIO_DCT_DECODER)   += binkaudio.c wma.c
AVCODEC_C_FILES-$(CONFIG_BINKAUDIO_RDFT_DECODER)  += binkaudio.c wma.c
AVCODEC_C_FILES-$(CONFIG_BINTEXT_DECODER)         += bintext.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_BMP_DECODER)             += bmp.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_BMP_ENCODER)             += bmpenc.c
AVCODEC_C_FILES-$(CONFIG_BMV_VIDEO_DECODER)       += bmv.c
AVCODEC_C_FILES-$(CONFIG_BMV_AUDIO_DECODER)       += bmv.c
AVCODEC_C_FILES-$(CONFIG_C93_DECODER)             += c93.c
AVCODEC_C_FILES-$(CONFIG_CAVS_DECODER)            += cavs.c cavsdec.c cavsdsp.c \
                                          mpeg12data.c mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_CDGRAPHICS_DECODER)      += cdgraphics.c
AVCODEC_C_FILES-$(CONFIG_CINEPAK_DECODER)         += cinepak.c
AVCODEC_C_FILES-$(CONFIG_CLJR_DECODER)            += cljr.c
AVCODEC_C_FILES-$(CONFIG_CLJR_ENCODER)            += cljr.c
AVCODEC_C_FILES-$(CONFIG_COOK_DECODER)            += cook.c
AVCODEC_C_FILES-$(CONFIG_CSCD_DECODER)            += cscd.c
AVCODEC_C_FILES-$(CONFIG_CYUV_DECODER)            += cyuv.c
AVCODEC_C_FILES-$(CONFIG_DCA_DECODER)             += dca.c synth_filter.c dcadsp.c
AVCODEC_C_FILES-$(CONFIG_DCA_ENCODER)             += dcaenc.c
AVCODEC_C_FILES-$(CONFIG_DIRAC_DECODER)           += diracdec.c dirac.c diracdsp.c \
                                          dirac_arith.c mpeg12data.c dwt.c
AVCODEC_C_FILES-$(CONFIG_DFA_DECODER)             += dfa.c
AVCODEC_C_FILES-$(CONFIG_DNXHD_DECODER)           += dnxhddec.c dnxhddata.c
AVCODEC_C_FILES-$(CONFIG_DNXHD_ENCODER)           += dnxhdenc.c dnxhddata.c       \
                                          mpegvideo_enc.c motion_est.c \
                                          ratecontrol.c mpeg12data.c   \
                                          mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_DPX_DECODER)             += dpx.c
AVCODEC_C_FILES-$(CONFIG_DPX_ENCODER)             += dpxenc.c
AVCODEC_C_FILES-$(CONFIG_DSICINAUDIO_DECODER)     += dsicinav.c
AVCODEC_C_FILES-$(CONFIG_DSICINVIDEO_DECODER)     += dsicinav.c
AVCODEC_C_FILES-$(CONFIG_DVBSUB_DECODER)          += dvbsubdec.c
AVCODEC_C_FILES-$(CONFIG_DVBSUB_ENCODER)          += dvbsub.c
AVCODEC_C_FILES-$(CONFIG_DVDSUB_DECODER)          += dvdsubdec.c
AVCODEC_C_FILES-$(CONFIG_DVDSUB_ENCODER)          += dvdsubenc.c
AVCODEC_C_FILES-$(CONFIG_DVVIDEO_DECODER)         += dv.c dvdata.c
AVCODEC_C_FILES-$(CONFIG_DVVIDEO_ENCODER)         += dv.c dvdata.c
AVCODEC_C_FILES-$(CONFIG_DXA_DECODER)             += dxa.c
AVCODEC_C_FILES-$(CONFIG_EAC3_DECODER)            += eac3dec.c eac3_data.c
AVCODEC_C_FILES-$(CONFIG_EAC3_ENCODER)            += eac3enc.c ac3enc.c ac3enc_float.c \
                                          ac3tab.c ac3.c kbdwin.c eac3_data.c
AVCODEC_C_FILES-$(CONFIG_EACMV_DECODER)           += eacmv.c
AVCODEC_C_FILES-$(CONFIG_EAMAD_DECODER)           += eamad.c eaidct.c mpeg12.c \
                                          mpeg12data.c mpegvideo.c  \
                                          error_resilience.c
AVCODEC_C_FILES-$(CONFIG_EATGQ_DECODER)           += eatgq.c eaidct.c
AVCODEC_C_FILES-$(CONFIG_EATGV_DECODER)           += eatgv.c
AVCODEC_C_FILES-$(CONFIG_EATQI_DECODER)           += eatqi.c eaidct.c mpeg12.c \
                                          mpeg12data.c mpegvideo.c  \
                                          error_resilience.c
AVCODEC_C_FILES-$(CONFIG_EIGHTBPS_DECODER)        += 8bps.c
AVCODEC_C_FILES-$(CONFIG_EIGHTSVX_EXP_DECODER)    += 8svx.c
AVCODEC_C_FILES-$(CONFIG_EIGHTSVX_FIB_DECODER)    += 8svx.c
AVCODEC_C_FILES-$(CONFIG_EIGHTSVX_RAW_DECODER)    += 8svx.c
AVCODEC_C_FILES-$(CONFIG_ESCAPE124_DECODER)       += escape124.c
AVCODEC_C_FILES-$(CONFIG_FFV1_DECODER)            += ffv1.c rangecoder.c
AVCODEC_C_FILES-$(CONFIG_FFV1_ENCODER)            += ffv1.c rangecoder.c
AVCODEC_C_FILES-$(CONFIG_FFVHUFF_DECODER)         += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_FFVHUFF_ENCODER)         += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_FLAC_DECODER)            += flacdec.c flacdata.c flac.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_FLAC_ENCODER)            += flacenc.c flacdata.c flac.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_FLASHSV_DECODER)         += flashsv.c
AVCODEC_C_FILES-$(CONFIG_FLASHSV_ENCODER)         += flashsvenc.c
AVCODEC_C_FILES-$(CONFIG_FLASHSV2_ENCODER)        += flashsv2enc.c
AVCODEC_C_FILES-$(CONFIG_FLASHSV2_DECODER)        += flashsv.c
AVCODEC_C_FILES-$(CONFIG_FLIC_DECODER)            += flicvideo.c
AVCODEC_C_FILES-$(CONFIG_FOURXM_DECODER)          += 4xm.c
AVCODEC_C_FILES-$(CONFIG_FRAPS_DECODER)           += fraps.c
AVCODEC_C_FILES-$(CONFIG_FRWU_DECODER)            += frwu.c
AVCODEC_C_FILES-$(CONFIG_G723_1_DECODER)          += g723_1.c acelp_vectors.c \
                                          celp_filters.c celp_math.c
AVCODEC_C_FILES-$(CONFIG_G723_1_ENCODER)          += g723_1.c
AVCODEC_C_FILES-$(CONFIG_G729_DECODER)            += g729dec.c lsp.c celp_math.c acelp_filters.c acelp_pitch_delay.c acelp_vectors.c g729postfilter.c
AVCODEC_C_FILES-$(CONFIG_GIF_DECODER)             += gifdec.c lzw.c
AVCODEC_C_FILES-$(CONFIG_GIF_ENCODER)             += gif.c lzwenc.c
AVCODEC_C_FILES-$(CONFIG_GSM_DECODER)             += gsmdec.c gsmdec_data.c msgsmdec.c
AVCODEC_C_FILES-$(CONFIG_GSM_MS_DECODER)          += gsmdec.c gsmdec_data.c msgsmdec.c
AVCODEC_C_FILES-$(CONFIG_H261_DECODER)            += h261dec.c h261.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H261_ENCODER)            += h261enc.c h261.c             \
                                          mpegvideo_enc.c motion_est.c \
                                          ratecontrol.c mpeg12data.c   \
                                          mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_H263_DECODER)            += h263dec.c h263.c ituh263dec.c        \
                                          mpeg4video.c mpeg4videodec.c flvdec.c\
                                          intelh263dec.c mpegvideo.c           \
                                          error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H263_VAAPI_HWACCEL)      += vaapi_mpeg4.c
AVCODEC_C_FILES-$(CONFIG_H263_ENCODER)            += mpegvideo_enc.c mpeg4video.c      \
                                          mpeg4videoenc.c motion_est.c      \
                                          ratecontrol.c h263.c ituh263enc.c \
                                          flvenc.c mpeg12data.c             \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H264_DECODER)            += h264.c                               \
                                          h264_loopfilter.c h264_direct.c      \
                                          cabac.c h264_sei.c h264_ps.c         \
                                          h264_refs.c h264_cavlc.c h264_cabac.c\
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H264_DXVA2_HWACCEL)      += dxva2_h264.c
AVCODEC_C_FILES-$(CONFIG_H264_VAAPI_HWACCEL)      += vaapi_h264.c
AVCODEC_C_FILES-$(CONFIG_H264_VDA_HWACCEL)        += vda_h264.c
AVCODEC_C_FILES-$(CONFIG_HUFFYUV_DECODER)         += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_HUFFYUV_ENCODER)         += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_IDCIN_DECODER)           += idcinvideo.c
AVCODEC_C_FILES-$(CONFIG_IDF_DECODER)             += bintext.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_IFF_BYTERUN1_DECODER)    += iff.c
AVCODEC_C_FILES-$(CONFIG_IFF_ILBM_DECODER)        += iff.c
AVCODEC_C_FILES-$(CONFIG_IMC_DECODER)             += imc.c
AVCODEC_C_FILES-$(CONFIG_INDEO2_DECODER)          += indeo2.c
AVCODEC_C_FILES-$(CONFIG_INDEO3_DECODER)          += indeo3.c
AVCODEC_C_FILES-$(CONFIG_INDEO5_DECODER)          += indeo5.c ivi_common.c ivi_dsp.c
AVCODEC_C_FILES-$(CONFIG_INTERPLAY_DPCM_DECODER)  += dpcm.c
AVCODEC_C_FILES-$(CONFIG_INTERPLAY_VIDEO_DECODER) += interplayvideo.c
AVCODEC_C_FILES-$(CONFIG_JPEG2000_DECODER)        += j2kdec.c mqcdec.c mqc.c j2k.c j2k_dwt.c
AVCODEC_C_FILES-$(CONFIG_JPEG2000_ENCODER)        += j2kenc.c mqcenc.c mqc.c j2k.c j2k_dwt.c
AVCODEC_C_FILES-$(CONFIG_JPEGLS_DECODER)          += jpeglsdec.c jpegls.c \
                                          mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_JPEGLS_ENCODER)          += jpeglsenc.c jpegls.c
AVCODEC_C_FILES-$(CONFIG_JV_DECODER)              += jvdec.c
AVCODEC_C_FILES-$(CONFIG_KGV1_DECODER)            += kgv1dec.c
AVCODEC_C_FILES-$(CONFIG_KMVC_DECODER)            += kmvc.c
AVCODEC_C_FILES-$(CONFIG_LAGARITH_DECODER)        += lagarith.c lagarithrac.c
AVCODEC_C_FILES-$(CONFIG_LJPEG_ENCODER)           += ljpegenc.c mjpegenc.c mjpeg.c \
                                          mpegvideo_enc.c motion_est.c  \
                                          ratecontrol.c mpeg12data.c    \
                                          mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_LOCO_DECODER)            += loco.c
AVCODEC_C_FILES-$(CONFIG_MACE3_DECODER)           += mace.c
AVCODEC_C_FILES-$(CONFIG_MACE6_DECODER)           += mace.c
AVCODEC_C_FILES-$(CONFIG_MDEC_DECODER)            += mdec.c mpeg12.c mpeg12data.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MIMIC_DECODER)           += mimic.c
AVCODEC_C_FILES-$(CONFIG_MJPEG_DECODER)           += mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_MJPEG_ENCODER)           += mjpegenc.c mjpeg.c           \
                                          mpegvideo_enc.c motion_est.c \
                                          ratecontrol.c mpeg12data.c   \
                                          mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_MJPEGB_DECODER)          += mjpegbdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_MLP_DECODER)             += mlpdec.c mlpdsp.c
AVCODEC_C_FILES-$(CONFIG_MMVIDEO_DECODER)         += mmvideo.c
AVCODEC_C_FILES-$(CONFIG_MOTIONPIXELS_DECODER)    += motionpixels.c
AVCODEC_C_FILES-$(CONFIG_MP1_DECODER)             += mpegaudiodec.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP1FLOAT_DECODER)        += mpegaudiodec_float.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP2_DECODER)             += mpegaudiodec.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP2_ENCODER)             += mpegaudioenc.c mpegaudio.c \
                                          mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP2FLOAT_DECODER)        += mpegaudiodec_float.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP3ADU_DECODER)          += mpegaudiodec.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP3ADUFLOAT_DECODER)     += mpegaudiodec_float.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP3ON4_DECODER)          += mpegaudiodec.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c         \
                                          mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_MP3ON4FLOAT_DECODER)     += mpegaudiodec_float.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c         \
                                          mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_MP3_DECODER)             += mpegaudiodec.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP3FLOAT_DECODER)        += mpegaudiodec_float.c mpegaudiodecheader.c \
                                          mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPC7_DECODER)            += mpc7.c mpc.c mpegaudiodec.c      \
                                          mpegaudiodecheader.c mpegaudio.c \
                                          mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPC8_DECODER)            += mpc8.c mpc.c mpegaudiodec.c      \
                                          mpegaudiodecheader.c mpegaudio.c \
                                          mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPEGVIDEO_DECODER)       += mpeg12.c mpeg12data.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG_XVMC_DECODER)       += mpegvideo_xvmc.c
AVCODEC_C_FILES-$(CONFIG_MPEG1VIDEO_DECODER)      += mpeg12.c mpeg12data.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG1VIDEO_ENCODER)      += mpeg12enc.c mpegvideo_enc.c \
                                          timecode.c                  \
                                          motion_est.c ratecontrol.c  \
                                          mpeg12.c mpeg12data.c       \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG2_DXVA2_HWACCEL)     += dxva2_mpeg2.c
AVCODEC_C_FILES-$(CONFIG_MPEG2_VAAPI_HWACCEL)     += vaapi_mpeg2.c
AVCODEC_C_FILES-$(CONFIG_MPEG2VIDEO_DECODER)      += mpeg12.c mpeg12data.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG2VIDEO_ENCODER)      += mpeg12enc.c mpegvideo_enc.c \
                                          timecode.c                  \
                                          motion_est.c ratecontrol.c  \
                                          mpeg12.c mpeg12data.c       \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG4_VAAPI_HWACCEL)     += vaapi_mpeg4.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V1_DECODER)       += msmpeg4.c msmpeg4data.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V2_DECODER)       += msmpeg4.c msmpeg4data.c h263dec.c \
                                          h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V2_ENCODER)       += msmpeg4.c msmpeg4data.c h263dec.c \
                                          h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V3_DECODER)       += msmpeg4.c msmpeg4data.c h263dec.c \
                                          h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V3_ENCODER)       += msmpeg4.c msmpeg4data.c h263dec.c \
                                          h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSRLE_DECODER)           += msrle.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_MSVIDEO1_DECODER)        += msvideo1.c
AVCODEC_C_FILES-$(CONFIG_MSVIDEO1_ENCODER)        += msvideo1enc.c elbg.c
AVCODEC_C_FILES-$(CONFIG_MSZH_DECODER)            += lcldec.c
AVCODEC_C_FILES-$(CONFIG_MXPEG_DECODER)           += mxpegdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_NELLYMOSER_DECODER)      += nellymoserdec.c nellymoser.c
AVCODEC_C_FILES-$(CONFIG_NELLYMOSER_ENCODER)      += nellymoserenc.c nellymoser.c
AVCODEC_C_FILES-$(CONFIG_NUV_DECODER)             += nuv.c rtjpeg.c
AVCODEC_C_FILES-$(CONFIG_PAM_DECODER)             += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PAM_ENCODER)             += pamenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PBM_DECODER)             += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PBM_ENCODER)             += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PCX_DECODER)             += pcx.c
AVCODEC_C_FILES-$(CONFIG_PCX_ENCODER)             += pcxenc.c
AVCODEC_C_FILES-$(CONFIG_PGM_DECODER)             += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGM_ENCODER)             += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGMYUV_DECODER)          += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGMYUV_ENCODER)          += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGSSUB_DECODER)          += pgssubdec.c
AVCODEC_C_FILES-$(CONFIG_PICTOR_DECODER)          += pictordec.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_PNG_DECODER)             += png.c pngdec.c
AVCODEC_C_FILES-$(CONFIG_PNG_ENCODER)             += png.c pngenc.c
AVCODEC_C_FILES-$(CONFIG_PPM_DECODER)             += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PPM_ENCODER)             += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PRORES_DECODER)          += proresdec2.c
AVCODEC_C_FILES-$(CONFIG_PRORES_LGPL_DECODER)     += proresdec_lgpl.c proresdsp.c
AVCODEC_C_FILES-$(CONFIG_PRORES_ENCODER)          += proresenc.c
AVCODEC_C_FILES-$(CONFIG_PTX_DECODER)             += ptx.c
AVCODEC_C_FILES-$(CONFIG_QCELP_DECODER)           += qcelpdec.c celp_math.c         \
                                          celp_filters.c acelp_vectors.c \
                                          acelp_filters.c
AVCODEC_C_FILES-$(CONFIG_QDM2_DECODER)            += qdm2.c mpegaudiodec.c            \
                                          mpegaudiodecheader.c mpegaudio.c \
                                          mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_QDRAW_DECODER)           += qdrw.c
AVCODEC_C_FILES-$(CONFIG_QPEG_DECODER)            += qpeg.c
AVCODEC_C_FILES-$(CONFIG_QTRLE_DECODER)           += qtrle.c
AVCODEC_C_FILES-$(CONFIG_QTRLE_ENCODER)           += qtrleenc.c
AVCODEC_C_FILES-$(CONFIG_R10K_DECODER)            += r210dec.c
AVCODEC_C_FILES-$(CONFIG_R210_DECODER)            += r210dec.c
AVCODEC_C_FILES-$(CONFIG_RA_144_DECODER)          += ra144dec.c ra144.c celp_filters.c
AVCODEC_C_FILES-$(CONFIG_RA_144_ENCODER)          += ra144enc.c ra144.c celp_filters.c
AVCODEC_C_FILES-$(CONFIG_RA_288_DECODER)          += ra288.c celp_math.c celp_filters.c
AVCODEC_C_FILES-$(CONFIG_RAWVIDEO_DECODER)        += rawdec.c
AVCODEC_C_FILES-$(CONFIG_RAWVIDEO_ENCODER)        += rawenc.c
AVCODEC_C_FILES-$(CONFIG_RL2_DECODER)             += rl2.c
AVCODEC_C_FILES-$(CONFIG_ROQ_DECODER)             += roqvideodec.c roqvideo.c
AVCODEC_C_FILES-$(CONFIG_ROQ_ENCODER)             += roqvideoenc.c roqvideo.c elbg.c
AVCODEC_C_FILES-$(CONFIG_ROQ_DPCM_DECODER)        += dpcm.c
AVCODEC_C_FILES-$(CONFIG_ROQ_DPCM_ENCODER)        += roqaudioenc.c
AVCODEC_C_FILES-$(CONFIG_RPZA_DECODER)            += rpza.c
AVCODEC_C_FILES-$(CONFIG_RV10_DECODER)            += rv10.c
AVCODEC_C_FILES-$(CONFIG_RV10_ENCODER)            += rv10enc.c
AVCODEC_C_FILES-$(CONFIG_RV20_DECODER)            += rv10.c
AVCODEC_C_FILES-$(CONFIG_RV20_ENCODER)            += rv20enc.c
AVCODEC_C_FILES-$(CONFIG_RV30_DECODER)            += rv30.c rv34.c rv30dsp.c rv34dsp.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_RV40_DECODER)            += rv40.c rv34.c rv34dsp.c rv40dsp.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_S302M_DECODER)           += s302m.c
AVCODEC_C_FILES-$(CONFIG_SGI_DECODER)             += sgidec.c
AVCODEC_C_FILES-$(CONFIG_SGI_ENCODER)             += sgienc.c rle.c
AVCODEC_C_FILES-$(CONFIG_SHORTEN_DECODER)         += shorten.c
AVCODEC_C_FILES-$(CONFIG_SIPR_DECODER)            += sipr.c acelp_pitch_delay.c \
                                          celp_math.c acelp_vectors.c \
                                          acelp_filters.c celp_filters.c \
                                          sipr16k.c
AVCODEC_C_FILES-$(CONFIG_SMACKAUD_DECODER)        += smacker.c
AVCODEC_C_FILES-$(CONFIG_SMACKER_DECODER)         += smacker.c
AVCODEC_C_FILES-$(CONFIG_SMC_DECODER)             += smc.c
AVCODEC_C_FILES-$(CONFIG_SNOW_DECODER)            += snowdec.c snow.c rangecoder.c
AVCODEC_C_FILES-$(CONFIG_SNOW_ENCODER)            += snowenc.c snow.c rangecoder.c    \
                                          motion_est.c ratecontrol.c       \
                                          h263.c mpegvideo.c               \
                                          error_resilience.c ituh263enc.c  \
                                          mpegvideo_enc.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_SOL_DPCM_DECODER)        += dpcm.c
AVCODEC_C_FILES-$(CONFIG_SONIC_DECODER)           += sonic.c
AVCODEC_C_FILES-$(CONFIG_SONIC_ENCODER)           += sonic.c
AVCODEC_C_FILES-$(CONFIG_SONIC_LS_ENCODER)        += sonic.c
AVCODEC_C_FILES-$(CONFIG_SP5X_DECODER)            += sp5xdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_SRT_DECODER)             += srtdec.c ass.c
AVCODEC_C_FILES-$(CONFIG_SRT_ENCODER)             += srtenc.c ass_split.c
AVCODEC_C_FILES-$(CONFIG_SUNRAST_DECODER)         += sunrast.c
AVCODEC_C_FILES-$(CONFIG_SVQ1_DECODER)            += svq1dec.c svq1.c h263.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_SVQ1_ENCODER)            += svq1enc.c svq1.c    \
                                          motion_est.c h263.c \
                                          mpegvideo.c error_resilience.c \
                                          ituh263enc.c mpegvideo_enc.c   \
                                          ratecontrol.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_SVQ3_DECODER)            += h264.c svq3.c                       \
                                          h264_loopfilter.c h264_direct.c     \
                                          h264_sei.c h264_ps.c h264_refs.c    \
                                          h264_cavlc.c h264_cabac.c cabac.c   \
                                          mpegvideo.c error_resilience.c      \
                                          svq1dec.c svq1.c h263.c
AVCODEC_C_FILES-$(CONFIG_TARGA_DECODER)           += targa.c
AVCODEC_C_FILES-$(CONFIG_TARGA_ENCODER)           += targaenc.c rle.c
AVCODEC_C_FILES-$(CONFIG_THEORA_DECODER)          += xiph.c
AVCODEC_C_FILES-$(CONFIG_THP_DECODER)             += mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_TIERTEXSEQVIDEO_DECODER) += tiertexseqv.c
AVCODEC_C_FILES-$(CONFIG_TIFF_DECODER)            += tiff.c lzw.c faxcompr.c
AVCODEC_C_FILES-$(CONFIG_TIFF_ENCODER)            += tiffenc.c rle.c lzwenc.c
AVCODEC_C_FILES-$(CONFIG_TMV_DECODER)             += tmv.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_TRUEMOTION1_DECODER)     += truemotion1.c
AVCODEC_C_FILES-$(CONFIG_TRUEMOTION2_DECODER)     += truemotion2.c
AVCODEC_C_FILES-$(CONFIG_TRUESPEECH_DECODER)      += truespeech.c
AVCODEC_C_FILES-$(CONFIG_TSCC_DECODER)            += tscc.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_TTA_DECODER)             += tta.c
AVCODEC_C_FILES-$(CONFIG_TWINVQ_DECODER)          += twinvq.c celp_math.c
AVCODEC_C_FILES-$(CONFIG_TXD_DECODER)             += txd.c s3tc.c
AVCODEC_C_FILES-$(CONFIG_ULTI_DECODER)            += ulti.c
AVCODEC_C_FILES-$(CONFIG_UTVIDEO_DECODER)         += utvideo.c
AVCODEC_C_FILES-$(CONFIG_V210_DECODER)            += v210dec.c
AVCODEC_C_FILES-$(CONFIG_V210_ENCODER)            += v210enc.c
AVCODEC_C_FILES-$(CONFIG_V210X_DECODER)           += v210x.c
AVCODEC_C_FILES-$(CONFIG_VB_DECODER)              += vb.c
AVCODEC_C_FILES-$(CONFIG_VBLE_DECODER)            += vble.c
AVCODEC_C_FILES-$(CONFIG_VC1_DECODER)             += vc1dec.c vc1.c vc1data.c vc1dsp.c \
                                          msmpeg4.c msmpeg4data.c           \
                                          intrax8.c intrax8dsp.c
AVCODEC_C_FILES-$(CONFIG_VC1_DXVA2_HWACCEL)       += dxva2_vc1.c
AVCODEC_C_FILES-$(CONFIG_VC1_VAAPI_HWACCEL)       += vaapi_vc1.c
AVCODEC_C_FILES-$(CONFIG_VCR1_DECODER)            += vcr1.c
AVCODEC_C_FILES-$(CONFIG_VCR1_ENCODER)            += vcr1.c
AVCODEC_C_FILES-$(CONFIG_VMDAUDIO_DECODER)        += vmdav.c
AVCODEC_C_FILES-$(CONFIG_VMDVIDEO_DECODER)        += vmdav.c
AVCODEC_C_FILES-$(CONFIG_VMNC_DECODER)            += vmnc.c
AVCODEC_C_FILES-$(CONFIG_VORBIS_DECODER)          += vorbisdec.c vorbis.c \
                                          vorbis_data.c xiph.c
AVCODEC_C_FILES-$(CONFIG_VORBIS_ENCODER)          += vorbisenc.c vorbis.c \
                                          vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_VP3_DECODER)             += vp3.c vp3dsp.c
AVCODEC_C_FILES-$(CONFIG_VP5_DECODER)             += vp5.c vp56.c vp56data.c vp56dsp.c \
                                          vp3dsp.c vp56rac.c
AVCODEC_C_FILES-$(CONFIG_VP6_DECODER)             += vp6.c vp56.c vp56data.c vp56dsp.c \
                                          vp3dsp.c vp6dsp.c vp56rac.c
AVCODEC_C_FILES-$(CONFIG_VP8_DECODER)             += vp8.c vp8dsp.c vp56rac.c
AVCODEC_C_FILES-$(CONFIG_VQA_DECODER)             += vqavideo.c
AVCODEC_C_FILES-$(CONFIG_WAVPACK_DECODER)         += wavpack.c
AVCODEC_C_FILES-$(CONFIG_WMALOSSLESS_DECODER)     += wmalosslessdec.c wma.c
AVCODEC_C_FILES-$(CONFIG_WMAPRO_DECODER)          += wmaprodec.c wma.c
AVCODEC_C_FILES-$(CONFIG_WMAV1_DECODER)           += wmadec.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAV1_ENCODER)           += wmaenc.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAV2_DECODER)           += wmadec.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAV2_ENCODER)           += wmaenc.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAVOICE_DECODER)        += wmavoice.c \
                                          celp_math.c celp_filters.c \
                                          acelp_vectors.c acelp_filters.c
AVCODEC_C_FILES-$(CONFIG_WMV1_DECODER)            += msmpeg4.c msmpeg4data.c
AVCODEC_C_FILES-$(CONFIG_WMV2_DECODER)            += wmv2dec.c wmv2.c        \
                                          msmpeg4.c msmpeg4data.c \
                                          intrax8.c intrax8dsp.c
AVCODEC_C_FILES-$(CONFIG_WMV2_ENCODER)            += wmv2enc.c wmv2.c \
                                          msmpeg4.c msmpeg4data.c \
                                          mpeg4videodec.c ituh263dec.c h263dec.c
AVCODEC_C_FILES-$(CONFIG_WNV1_DECODER)            += wnv1.c
AVCODEC_C_FILES-$(CONFIG_WS_SND1_DECODER)         += ws-snd1.c
AVCODEC_C_FILES-$(CONFIG_XAN_DPCM_DECODER)        += dpcm.c
AVCODEC_C_FILES-$(CONFIG_XAN_WC3_DECODER)         += xan.c
AVCODEC_C_FILES-$(CONFIG_XAN_WC4_DECODER)         += xxan.c
AVCODEC_C_FILES-$(CONFIG_XBIN_DECODER)            += bintext.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_XL_DECODER)              += xl.c
AVCODEC_C_FILES-$(CONFIG_XSUB_DECODER)            += xsubdec.c
AVCODEC_C_FILES-$(CONFIG_XSUB_ENCODER)            += xsubenc.c
AVCODEC_C_FILES-$(CONFIG_YOP_DECODER)             += yop.c
AVCODEC_C_FILES-$(CONFIG_ZLIB_DECODER)            += lcldec.c
AVCODEC_C_FILES-$(CONFIG_ZLIB_ENCODER)            += lclenc.c
AVCODEC_C_FILES-$(CONFIG_ZMBV_DECODER)            += zmbv.c
AVCODEC_C_FILES-$(CONFIG_ZMBV_ENCODER)            += zmbvenc.c

# (AD)PCM decoders/encoders
AVCODEC_C_FILES-$(CONFIG_PCM_ALAW_DECODER)           += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_ALAW_ENCODER)           += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_BLURAY_DECODER)         += pcm-mpeg.c
AVCODEC_C_FILES-$(CONFIG_PCM_DVD_DECODER)            += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_DVD_ENCODER)            += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_LXF_DECODER)            += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_MULAW_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_MULAW_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S8_DECODER)             += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S8_ENCODER)             += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S8_PLANAR_DECODER)      += 8svx.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16LE_PLANAR_DECODER)   += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24DAUD_DECODER)        += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24DAUD_ENCODER)        += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U8_DECODER)             += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U8_ENCODER)             += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32BE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32BE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32LE_DECODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32LE_ENCODER)          += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_ZORK_DECODER)           += pcm.c

AVCODEC_C_FILES-$(CONFIG_ADPCM_4XM_DECODER)          += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_ADX_DECODER)          += adxdec.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_ADX_ENCODER)          += adxenc.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_CT_DECODER)           += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_DECODER)           += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_MAXIS_XA_DECODER)  += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_R1_DECODER)        += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_R2_DECODER)        += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_R3_DECODER)        += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_XAS_DECODER)       += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_G722_DECODER)         += g722.c g722dec.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_G722_ENCODER)         += g722.c g722enc.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_G726_DECODER)         += g726.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_G726_ENCODER)         += g726.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_AMV_DECODER)      += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_DK3_DECODER)      += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_DK4_DECODER)      += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_EA_EACS_DECODER)  += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_EA_SEAD_DECODER)  += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_ISS_DECODER)      += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_QT_DECODER)       += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_QT_ENCODER)       += adpcmenc.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_SMJPEG_DECODER)   += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_WAV_DECODER)      += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_WAV_ENCODER)      += adpcmenc.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_WS_DECODER)       += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_MS_DECODER)           += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_MS_ENCODER)           += adpcmenc.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SBPRO_2_DECODER)      += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SBPRO_3_DECODER)      += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SBPRO_4_DECODER)      += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SWF_DECODER)          += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SWF_ENCODER)          += adpcmenc.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_THP_DECODER)          += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_XA_DECODER)           += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_YAMAHA_DECODER)       += adpcm.c adpcm_data.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_YAMAHA_ENCODER)       += adpcmenc.c adpcm_data.c

# libavformat dependencies
AVCODEC_C_FILES-$(CONFIG_ADTS_MUXER)              += mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_CAF_DEMUXER)             += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_DV_DEMUXER)              += dvdata.c
AVCODEC_C_FILES-$(CONFIG_DV_MUXER)                += dvdata.c timecode.c
AVCODEC_C_FILES-$(CONFIG_FLAC_DEMUXER)            += flacdec.c flacdata.c flac.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_FLAC_MUXER)              += flacdec.c flacdata.c flac.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_FLV_DEMUXER)             += mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_GXF_DEMUXER)             += mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_IFF_DEMUXER)             += iff.c
AVCODEC_C_FILES-$(CONFIG_LATM_MUXER)              += mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_MATROSKA_AUDIO_MUXER)    += xiph.c mpeg4audio.c vorbis_data.c \
                                          flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_MATROSKA_DEMUXER)        += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MATROSKA_MUXER)          += xiph.c mpeg4audio.c \
                                          flacdec.c flacdata.c flac.c \
                                          mpegaudiodata.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_MP3_MUXER)               += mpegaudiodata.c mpegaudiodecheader.c
AVCODEC_C_FILES-$(CONFIG_MOV_DEMUXER)             += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MOV_MUXER)               += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPEGTS_MUXER)            += mpegvideo.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_MPEGTS_DEMUXER)          += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MXF_MUXER)               += timecode.c
AVCODEC_C_FILES-$(CONFIG_NUT_MUXER)               += mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_OGG_DEMUXER)             += flacdec.c flacdata.c flac.c \
                                          dirac.c mpeg12data.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_OGG_MUXER)               += xiph.c flacdec.c flacdata.c flac.c \
                                          vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_RTP_MUXER)               += mpeg4audio.c mpegvideo.c xiph.c
AVCODEC_C_FILES-$(CONFIG_SPDIF_DEMUXER)           += aacadtsdec.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_WEBM_MUXER)              += xiph.c mpeg4audio.c \
                                          flacdec.c flacdata.c flac.c \
                                          mpegaudiodata.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_WTV_DEMUXER)             += mpeg4audio.c mpegaudiodata.c

# external codec libraries
AVCODEC_C_FILES-$(CONFIG_LIBAACPLUS_ENCODER)         += libaacplus.c
AVCODEC_C_FILES-$(CONFIG_LIBCELT_DECODER)            += libcelt_dec.c
AVCODEC_C_FILES-$(CONFIG_LIBDIRAC_DECODER)           += libdiracdec.c
AVCODEC_C_FILES-$(CONFIG_LIBDIRAC_ENCODER)           += libdiracenc.c libdirac_libschro.c
AVCODEC_C_FILES-$(CONFIG_LIBFAAC_ENCODER)            += libfaac.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_DECODER)             += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_ENCODER)             += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_MS_DECODER)          += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_MS_ENCODER)          += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBMP3LAME_ENCODER)         += libmp3lame.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENCORE_AMRNB_DECODER)  += libopencore-amr.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENCORE_AMRNB_ENCODER)  += libopencore-amr.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENCORE_AMRWB_DECODER)  += libopencore-amr.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENJPEG_DECODER)        += libopenjpegdec.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENJPEG_ENCODER)        += libopenjpegenc.c
AVCODEC_C_FILES-$(CONFIG_LIBSCHROEDINGER_DECODER)    += libschroedingerdec.c \
                                             libschroedinger.c    \
                                             libdirac_libschro.c
AVCODEC_C_FILES-$(CONFIG_LIBSCHROEDINGER_ENCODER)    += libschroedingerenc.c \
                                             libschroedinger.c    \
                                             libdirac_libschro.c
AVCODEC_C_FILES-$(CONFIG_LIBSPEEX_DECODER)           += libspeexdec.c
AVCODEC_C_FILES-$(CONFIG_LIBSPEEX_ENCODER)           += libspeexenc.c
AVCODEC_C_FILES-$(CONFIG_LIBSTAGEFRIGHT_H264_DECODER)+= libstagefright.c
AVCODEC_C_FILES-$(CONFIG_LIBTHEORA_ENCODER)          += libtheoraenc.c
AVCODEC_C_FILES-$(CONFIG_LIBUTVIDEO_DECODER)         += libutvideo.c
AVCODEC_C_FILES-$(CONFIG_LIBVO_AACENC_ENCODER)       += libvo-aacenc.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_LIBVO_AMRWBENC_ENCODER)     += libvo-amrwbenc.c
AVCODEC_C_FILES-$(CONFIG_LIBVORBIS_ENCODER)          += libvorbis.c vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_LIBVPX_DECODER)             += libvpxdec.c
AVCODEC_C_FILES-$(CONFIG_LIBVPX_ENCODER)             += libvpxenc.c
AVCODEC_C_FILES-$(CONFIG_LIBX264_ENCODER)            += libx264.c
AVCODEC_C_FILES-$(CONFIG_LIBXAVS_ENCODER)            += libxavs.c
AVCODEC_C_FILES-$(CONFIG_LIBXVID)                    += libxvidff.c libxvid_rc.c

# parsers
AVCODEC_C_FILES-$(CONFIG_AAC_PARSER)              += aac_parser.c aac_ac3_parser.c \
                                          aacadtsdec.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_AC3_PARSER)              += ac3_parser.c ac3tab.c \
                                          aac_ac3_parser.c
AVCODEC_C_FILES-$(CONFIG_CAVSVIDEO_PARSER)        += cavs_parser.c
AVCODEC_C_FILES-$(CONFIG_DCA_PARSER)              += dca_parser.c
AVCODEC_C_FILES-$(CONFIG_DIRAC_PARSER)            += dirac_parser.c
AVCODEC_C_FILES-$(CONFIG_DNXHD_PARSER)            += dnxhd_parser.c
AVCODEC_C_FILES-$(CONFIG_DVBSUB_PARSER)           += dvbsub_parser.c
AVCODEC_C_FILES-$(CONFIG_DVDSUB_PARSER)           += dvdsub_parser.c
AVCODEC_C_FILES-$(CONFIG_FLAC_PARSER)             += flac_parser.c flacdata.c flac.c \
                                          vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_H261_PARSER)             += h261_parser.c
AVCODEC_C_FILES-$(CONFIG_H263_PARSER)             += h263_parser.c
AVCODEC_C_FILES-$(CONFIG_H264_PARSER)             += h264_parser.c h264.c            \
                                          cabac.c                         \
                                          h264_refs.c h264_sei.c h264_direct.c \
                                          h264_loopfilter.c h264_cabac.c \
                                          h264_cavlc.c h264_ps.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_AAC_LATM_PARSER)         += latm_parser.c
AVCODEC_C_FILES-$(CONFIG_MJPEG_PARSER)            += mjpeg_parser.c
AVCODEC_C_FILES-$(CONFIG_MLP_PARSER)              += mlp_parser.c mlp.c
AVCODEC_C_FILES-$(CONFIG_MPEG4VIDEO_PARSER)       += mpeg4video_parser.c h263.c \
                                          mpegvideo.c error_resilience.c \
                                          mpeg4videodec.c mpeg4video.c \
                                          ituh263dec.c h263dec.c
AVCODEC_C_FILES-$(CONFIG_MPEGAUDIO_PARSER)        += mpegaudio_parser.c \
                                          mpegaudiodecheader.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPEGVIDEO_PARSER)        += mpegvideo_parser.c    \
                                          mpeg12.c mpeg12data.c \
                                          mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_PNM_PARSER)              += pnm_parser.c pnm.c
AVCODEC_C_FILES-$(CONFIG_RV30_PARSER)             += rv34_parser.c
AVCODEC_C_FILES-$(CONFIG_RV40_PARSER)             += rv34_parser.c
AVCODEC_C_FILES-$(CONFIG_VC1_PARSER)              += vc1_parser.c vc1.c vc1data.c \
                                          msmpeg4.c msmpeg4data.c mpeg4video.c \
                                          h263.c mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_VP3_PARSER)              += vp3_parser.c
AVCODEC_C_FILES-$(CONFIG_VP8_PARSER)              += vp8_parser.c

# bitstream filters
AVCODEC_C_FILES-$(CONFIG_AAC_ADTSTOASC_BSF)          += aac_adtstoasc_bsf.c aacadtsdec.c \
                                             mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_CHOMP_BSF)                  += chomp_bsf.c
AVCODEC_C_FILES-$(CONFIG_DUMP_EXTRADATA_BSF)         += dump_extradata_bsf.c
AVCODEC_C_FILES-$(CONFIG_H264_MP4TOANNEXB_BSF)       += h264_mp4toannexb_bsf.c
AVCODEC_C_FILES-$(CONFIG_IMX_DUMP_HEADER_BSF)        += imx_dump_header_bsf.c
AVCODEC_C_FILES-$(CONFIG_MJPEG2JPEG_BSF)             += mjpeg2jpeg_bsf.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_MJPEGA_DUMP_HEADER_BSF)     += mjpega_dump_header_bsf.c
AVCODEC_C_FILES-$(CONFIG_MOV2TEXTSUB_BSF)            += movsub_bsf.c
AVCODEC_C_FILES-$(CONFIG_MP3_HEADER_COMPRESS_BSF)    += mp3_header_compress_bsf.c
AVCODEC_C_FILES-$(CONFIG_MP3_HEADER_DECOMPRESS_BSF)  += mp3_header_decompress_bsf.c \
                                             mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_NOISE_BSF)                  += noise_bsf.c
AVCODEC_C_FILES-$(CONFIG_REMOVE_EXTRADATA_BSF)       += remove_extradata_bsf.c
AVCODEC_C_FILES-$(CONFIG_TEXT2MOVSUB_BSF)            += movsub_bsf.c

# thread libraries
AVCODEC_C_FILES-$(HAVE_PTHREADS)                  += pthread.c
AVCODEC_C_FILES-$(HAVE_W32THREADS)                += pthread.c
AVCODEC_C_FILES-$(HAVE_OS2THREADS)                += pthread.c

AVCODEC_C_FILES-$(CONFIG_MLIB)                    += mlib/dsputil_mlib.c           \
 
AVCODEC_C_FILES += $(AVCODEC_C_FILES-yes)
 
AVCODEC_SRC_FILES = $(addprefix libavcodec/, $(sort $(AVCODEC_C_FILES)))
 
AVCODEC_ARM_C_FILES-$(CONFIG_DCA_DECODER) += arm/dcadsp_init_arm.c \
 
AVCODEC_ARM_C_FILES-$(CONFIG_VP5_DECODER) += arm/vp56dsp_init_arm.c
AVCODEC_ARM_C_FILES-$(CONFIG_VP6_DECODER) += arm/vp56dsp_init_arm.c
 
AVCODEC_ARM_C_FILES-$(CONFIG_H264DSP) += arm/h264dsp_init_arm.c \
arm/h264pred_init_arm.c \
 
AVCODEC_ARM_C_FILES += arm/dsputil_init_arm.c \
arm/dsputil_arm.S \
arm/fft_init_arm.c \
arm/jrevdct_arm.S \
arm/mpegvideo_arm.c \
arm/simple_idct_arm.S \
 
AVCODEC_ARM_C_FILES-$(HAVE_ARMV5TE) += arm/dsputil_init_armv5te.c \
arm/mpegvideo_armv5te.c \
arm/mpegvideo_armv5te_s.S \
arm/simple_idct_armv5te.S \
 
AVCODEC_ARM_C_FILES-$(HAVE_ARMV6) += arm/dsputil_init_armv6.c \
arm/dsputil_armv6.S \
arm/simple_idct_armv6.S \
 
AVCODEC_ARM_C_FILES-$(HAVE_ARMVFP) += arm/dsputil_vfp.S \
arm/dsputil_init_vfp.c \
 
AVCODEC_ARM_C_FILES-$(HAVE_IWMMXT) += arm/dsputil_iwmmxt.c \
arm/mpegvideo_iwmmxt.c \

NEON-FILES-$(CONFIG_FFT)                += arm/fft_neon.S               \
                                          arm/fft_fixed_neon.S          \
NEON-FILES-$(CONFIG_MDCT)               += arm/mdct_neon.S              \
                                          arm/mdct_fixed_neon.S         \
NEON-FILES-$(CONFIG_RDFT)               += arm/rdft_neon.S              \
NEON-FILES-$(CONFIG_H264DSP)            += arm/h264dsp_neon.S           \
                                          arm/h264idct_neon.S           \
NEON-FILES-$(CONFIG_H264PRED)           += arm/h264pred_neon.S          \
NEON-FILES-$(CONFIG_AC3DSP)             += arm/ac3dsp_neon.S
NEON-FILES-$(CONFIG_DCA_DECODER)        += arm/dcadsp_neon.S            \
                                          arm/synth_filter_neon.S       \
NEON-FILES-$(CONFIG_VP3_DECODER)        += arm/vp3dsp_neon.S
NEON-FILES-$(CONFIG_VP5_DECODER)        += arm/vp56dsp_neon.S           \
                                          arm/vp3dsp_neon.S             \
NEON-FILES-$(CONFIG_VP6_DECODER)        += arm/vp56dsp_neon.S           \
                                          arm/vp3dsp_neon.S             \
NEON-FILES-$(CONFIG_VP8_DECODER)        += arm/vp8dsp_neon.S

AVCODEC_ARM_C_FILES-$(HAVE_NEON)        += arm/dsputil_init_neon.S      \
                                          arm/dsputil_neon.S            \
                                          arm/fmtconvert_neon.S         \
                                          arm/int_neon.S                \
                                          arm/mpegvideo_neon.S          \
                                          arm/simple_idct_neon.S        \
                                          $(NEON-FILES-yes)
 
AVCODEC_ARM_C_FILES += $(AVCODEC_ARM_C_FILES-yes)

#manualy add
AVCODEC_ARM_C_FILES += arm/ac3dsp_init_arm.c
AVCODEC_ARM_C_FILES += arm/fft_fixed_init_arm.c
AVCODEC_ARM_C_FILES += arm/fmtconvert_init_arm.c
AVCODEC_ARM_C_FILES += arm/mpegaudiodsp_init_arm.c
AVCODEC_ARM_C_FILES += arm/vp8dsp_init_arm.c
AVCODEC_ARM_C_FILES += arm/ac3dsp_arm.S
 
AVCODEC_ARM_SRC_FILES = $(addprefix libavcodec/, $(sort $(AVCODEC_ARM_C_FILES)))
 
AVFORMAT_C_FILES = allformats.c         \
       cutils.c             \
       id3v1.c              \
       id3v2.c              \
       metadata.c           \
       options.c            \
       os_support.c         \
       sdp.c                \
       seek.c               \
       utils.c              \
 
# muxers/demuxers
AVFORMAT_C_FILES-$(CONFIG_A64_MUXER)                 += a64.c
AVFORMAT_C_FILES-$(CONFIG_AAC_DEMUXER)               += aacdec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_AC3_DEMUXER)               += ac3dec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_AC3_MUXER)                 += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_ACT_DEMUXER)               += act.c
AVFORMAT_C_FILES-$(CONFIG_ADF_DEMUXER)               += bintext.c sauce.c
AVFORMAT_C_FILES-$(CONFIG_ADTS_MUXER)                += adtsenc.c
AVFORMAT_C_FILES-$(CONFIG_AEA_DEMUXER)               += aea.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_AIFF_DEMUXER)              += aiffdec.c riff.c pcm.c isom.c
AVFORMAT_C_FILES-$(CONFIG_AIFF_MUXER)                += aiffenc.c riff.c isom.c
AVFORMAT_C_FILES-$(CONFIG_AMR_DEMUXER)               += amr.c
AVFORMAT_C_FILES-$(CONFIG_AMR_MUXER)                 += amr.c
AVFORMAT_C_FILES-$(CONFIG_ANM_DEMUXER)               += anm.c
AVFORMAT_C_FILES-$(CONFIG_APC_DEMUXER)               += apc.c
AVFORMAT_C_FILES-$(CONFIG_APE_DEMUXER)               += ape.c apetag.c
AVFORMAT_C_FILES-$(CONFIG_APPLEHTTP_DEMUXER)         += applehttp.c
AVFORMAT_C_FILES-$(CONFIG_ASF_DEMUXER)               += asfdec.c asf.c asfcrypt.c \
                                            riff.c avlanguage.c
AVFORMAT_C_FILES-$(CONFIG_ASF_MUXER)                 += asfenc.c asf.c riff.c
AVFORMAT_C_FILES-$(CONFIG_ASS_DEMUXER)               += assdec.c
AVFORMAT_C_FILES-$(CONFIG_ASS_MUXER)                 += assenc.c
AVFORMAT_C_FILES-$(CONFIG_AU_DEMUXER)                += au.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_AU_MUXER)                  += au.c
AVFORMAT_C_FILES-$(CONFIG_AVI_DEMUXER)               += avidec.c riff.c avi.c
AVFORMAT_C_FILES-$(CONFIG_AVI_MUXER)                 += avienc.c riff.c avi.c
AVFORMAT_C_FILES-$(CONFIG_AVISYNTH)                  += avisynth.c
AVFORMAT_C_FILES-$(CONFIG_AVM2_MUXER)                += swfenc.c
AVFORMAT_C_FILES-$(CONFIG_AVS_DEMUXER)               += avs.c vocdec.c voc.c
AVFORMAT_C_FILES-$(CONFIG_BETHSOFTVID_DEMUXER)       += bethsoftvid.c
AVFORMAT_C_FILES-$(CONFIG_BFI_DEMUXER)               += bfi.c
AVFORMAT_C_FILES-$(CONFIG_BINK_DEMUXER)              += bink.c
AVFORMAT_C_FILES-$(CONFIG_BINTEXT_DEMUXER)           += bintext.c sauce.c
AVFORMAT_C_FILES-$(CONFIG_BIT_DEMUXER)               += bit.c
AVFORMAT_C_FILES-$(CONFIG_BIT_MUXER)                 += bit.c
AVFORMAT_C_FILES-$(CONFIG_BMV_DEMUXER)               += bmv.c
AVFORMAT_C_FILES-$(CONFIG_C93_DEMUXER)               += c93.c vocdec.c voc.c
AVFORMAT_C_FILES-$(CONFIG_CAF_DEMUXER)               += cafdec.c caf.c mov.c riff.c isom.c
AVFORMAT_C_FILES-$(CONFIG_CAF_MUXER)                 += cafenc.c caf.c riff.c isom.c
AVFORMAT_C_FILES-$(CONFIG_CAVSVIDEO_DEMUXER)         += cavsvideodec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_CAVSVIDEO_MUXER)           += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_CDG_DEMUXER)               += cdg.c
AVFORMAT_C_FILES-$(CONFIG_CRC_MUXER)                 += crcenc.c
AVFORMAT_C_FILES-$(CONFIG_DAUD_DEMUXER)              += daud.c
AVFORMAT_C_FILES-$(CONFIG_DAUD_MUXER)                += daud.c
AVFORMAT_C_FILES-$(CONFIG_DFA_DEMUXER)               += dfa.c
AVFORMAT_C_FILES-$(CONFIG_DIRAC_DEMUXER)             += diracdec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_DIRAC_MUXER)               += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_DNXHD_DEMUXER)             += dnxhddec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_DNXHD_MUXER)               += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_DSICIN_DEMUXER)            += dsicin.c
AVFORMAT_C_FILES-$(CONFIG_DTS_DEMUXER)               += dtsdec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_DTS_MUXER)                 += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_DV_DEMUXER)                += dv.c
AVFORMAT_C_FILES-$(CONFIG_DV_MUXER)                  += dvenc.c
AVFORMAT_C_FILES-$(CONFIG_DXA_DEMUXER)               += dxa.c riff.c
AVFORMAT_C_FILES-$(CONFIG_EA_CDATA_DEMUXER)          += eacdata.c
AVFORMAT_C_FILES-$(CONFIG_EA_DEMUXER)                += electronicarts.c
AVFORMAT_C_FILES-$(CONFIG_EAC3_DEMUXER)              += ac3dec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_EAC3_MUXER)                += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_FFM_DEMUXER)               += ffmdec.c
AVFORMAT_C_FILES-$(CONFIG_FFM_MUXER)                 += ffmenc.c
AVFORMAT_C_FILES-$(CONFIG_FFMETADATA_DEMUXER)        += ffmetadec.c
AVFORMAT_C_FILES-$(CONFIG_FFMETADATA_MUXER)          += ffmetaenc.c
AVFORMAT_C_FILES-$(CONFIG_FILMSTRIP_DEMUXER)         += filmstripdec.c
AVFORMAT_C_FILES-$(CONFIG_FILMSTRIP_MUXER)           += filmstripenc.c
AVFORMAT_C_FILES-$(CONFIG_FLAC_DEMUXER)              += flacdec.c rawdec.c \
                                            oggparsevorbis.c \
                                            vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_FLAC_MUXER)                += flacenc.c flacenc_header.c \
                                            vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_FLIC_DEMUXER)              += flic.c
AVFORMAT_C_FILES-$(CONFIG_FLV_DEMUXER)               += flvdec.c
AVFORMAT_C_FILES-$(CONFIG_FLV_MUXER)                 += flvenc.c avc.c
AVFORMAT_C_FILES-$(CONFIG_FOURXM_DEMUXER)            += 4xm.c
AVFORMAT_C_FILES-$(CONFIG_FRAMECRC_MUXER)            += framecrcenc.c
AVFORMAT_C_FILES-$(CONFIG_FRAMEMD5_MUXER)            += md5enc.c
AVFORMAT_C_FILES-$(CONFIG_GIF_MUXER)                 += gif.c
AVFORMAT_C_FILES-$(CONFIG_GSM_DEMUXER)               += gsmdec.c
AVFORMAT_C_FILES-$(CONFIG_GXF_DEMUXER)               += gxf.c
AVFORMAT_C_FILES-$(CONFIG_GXF_MUXER)                 += gxfenc.c audiointerleave.c
AVFORMAT_C_FILES-$(CONFIG_G722_DEMUXER)              += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_G722_MUXER)                += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_G723_1_DEMUXER)            += g723_1.c
AVFORMAT_C_FILES-$(CONFIG_G723_1_MUXER)              += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_G729_DEMUXER)              += g729dec.c
AVFORMAT_C_FILES-$(CONFIG_H261_DEMUXER)              += h261dec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_H261_MUXER)                += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_H263_DEMUXER)              += h263dec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_H263_MUXER)                += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_H264_DEMUXER)              += h264dec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_H264_MUXER)                += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_IDCIN_DEMUXER)             += idcin.c
AVFORMAT_C_FILES-$(CONFIG_IDF_DEMUXER)               += bintext.c
AVFORMAT_C_FILES-$(CONFIG_IFF_DEMUXER)               += iff.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2_DEMUXER)            += img2.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2_MUXER)              += img2.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2PIPE_DEMUXER)        += img2.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2PIPE_MUXER)          += img2.c
AVFORMAT_C_FILES-$(CONFIG_INGENIENT_DEMUXER)         += ingenientdec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_IPMOVIE_DEMUXER)           += ipmovie.c
AVFORMAT_C_FILES-$(CONFIG_ISS_DEMUXER)               += iss.c
AVFORMAT_C_FILES-$(CONFIG_IV8_DEMUXER)               += iv8.c
AVFORMAT_C_FILES-$(CONFIG_IVF_DEMUXER)               += ivfdec.c riff.c
AVFORMAT_C_FILES-$(CONFIG_IVF_MUXER)                 += ivfenc.c
AVFORMAT_C_FILES-$(CONFIG_JV_DEMUXER)                += jvdec.c
AVFORMAT_C_FILES-$(CONFIG_LATM_DEMUXER)              += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_LATM_MUXER)                += latmenc.c
AVFORMAT_C_FILES-$(CONFIG_LMLM4_DEMUXER)             += lmlm4.c
AVFORMAT_C_FILES-$(CONFIG_LOAS_DEMUXER)              += loasdec.c
AVFORMAT_C_FILES-$(CONFIG_LXF_DEMUXER)               += lxfdec.c
AVFORMAT_C_FILES-$(CONFIG_M4V_DEMUXER)               += m4vdec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_M4V_MUXER)                 += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MATROSKA_DEMUXER)          += matroskadec.c matroska.c \
                                            riff.c isom.c rmdec.c rm.c
AVFORMAT_C_FILES-$(CONFIG_MATROSKA_MUXER)            += matroskaenc.c matroska.c \
                                            riff.c isom.c avc.c \
                                            flacenc_header.c avlanguage.c
AVFORMAT_C_FILES-$(CONFIG_MD5_MUXER)                 += md5enc.c
AVFORMAT_C_FILES-$(CONFIG_MICRODVD_DEMUXER)          += microdvddec.c
AVFORMAT_C_FILES-$(CONFIG_MICRODVD_MUXER)            += microdvdenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MJPEG_DEMUXER)             += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_MJPEG_MUXER)               += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MLP_DEMUXER)               += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_MLP_MUXER)                 += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MM_DEMUXER)                += mm.c
AVFORMAT_C_FILES-$(CONFIG_MMF_DEMUXER)               += mmf.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_MMF_MUXER)                 += mmf.c riff.c
AVFORMAT_C_FILES-$(CONFIG_MOV_DEMUXER)               += mov.c riff.c isom.c
AVFORMAT_C_FILES-$(CONFIG_MOV_MUXER)                 += movenc.c riff.c isom.c avc.c \
                                            movenchint.c rtpenc_chain.c
AVFORMAT_C_FILES-$(CONFIG_MP2_MUXER)                 += mp3enc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MP3_DEMUXER)               += mp3dec.c
AVFORMAT_C_FILES-$(CONFIG_MP3_MUXER)                 += mp3enc.c rawenc.c id3v2enc.c
AVFORMAT_C_FILES-$(CONFIG_MPC_DEMUXER)               += mpc.c apetag.c
AVFORMAT_C_FILES-$(CONFIG_MPC8_DEMUXER)              += mpc8.c
AVFORMAT_C_FILES-$(CONFIG_MPEG1SYSTEM_MUXER)         += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG1VCD_MUXER)            += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2DVD_MUXER)            += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2VOB_MUXER)            += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2SVCD_MUXER)           += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG1VIDEO_MUXER)          += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2VIDEO_MUXER)          += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEGPS_DEMUXER)            += mpeg.c
AVFORMAT_C_FILES-$(CONFIG_MPEGTS_DEMUXER)            += mpegts.c isom.c
AVFORMAT_C_FILES-$(CONFIG_MPEGTS_MUXER)              += mpegtsenc.c adtsenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEGVIDEO_DEMUXER)         += mpegvideodec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_MPJPEG_MUXER)              += mpjpeg.c
AVFORMAT_C_FILES-$(CONFIG_MSNWC_TCP_DEMUXER)         += msnwc_tcp.c
AVFORMAT_C_FILES-$(CONFIG_MTV_DEMUXER)               += mtv.c
AVFORMAT_C_FILES-$(CONFIG_MVI_DEMUXER)               += mvi.c
AVFORMAT_C_FILES-$(CONFIG_MXF_DEMUXER)               += mxfdec.c mxf.c
AVFORMAT_C_FILES-$(CONFIG_MXF_MUXER)                 += mxfenc.c mxf.c audiointerleave.c
AVFORMAT_C_FILES-$(CONFIG_MXG_DEMUXER)               += mxg.c
AVFORMAT_C_FILES-$(CONFIG_NC_DEMUXER)                += ncdec.c
AVFORMAT_C_FILES-$(CONFIG_NSV_DEMUXER)               += nsvdec.c
AVFORMAT_C_FILES-$(CONFIG_NULL_MUXER)                += nullenc.c
AVFORMAT_C_FILES-$(CONFIG_NUT_DEMUXER)               += nutdec.c nut.c riff.c
AVFORMAT_C_FILES-$(CONFIG_NUT_MUXER)                 += nutenc.c nut.c riff.c
AVFORMAT_C_FILES-$(CONFIG_NUV_DEMUXER)               += nuv.c riff.c
AVFORMAT_C_FILES-$(CONFIG_OGG_DEMUXER)               += oggdec.c         \
                                            oggparsecelt.c   \
                                            oggparsedirac.c  \
                                            oggparseflac.c   \
                                            oggparseogm.c    \
                                            oggparseskeleton.c \
                                            oggparsespeex.c  \
                                            oggparsetheora.c \
                                            oggparsevorbis.c \
                                            riff.c \
                                            vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_OGG_MUXER)                 += oggenc.c \
                                            vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_OMA_DEMUXER)               += oma.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_PCM_ALAW_DEMUXER)          += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_ALAW_MUXER)            += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_MULAW_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_MULAW_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S8_DEMUXER)            += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S8_MUXER)              += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32BE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32BE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32LE_DEMUXER)         += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32LE_MUXER)           += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U8_DEMUXER)            += pcmdec.c pcm.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U8_MUXER)              += pcmenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_PMP_DEMUXER)               += pmpdec.c
AVFORMAT_C_FILES-$(CONFIG_PVA_DEMUXER)               += pva.c
AVFORMAT_C_FILES-$(CONFIG_QCP_DEMUXER)               += qcp.c
AVFORMAT_C_FILES-$(CONFIG_R3D_DEMUXER)               += r3d.c
AVFORMAT_C_FILES-$(CONFIG_RAWVIDEO_DEMUXER)          += rawvideodec.c rawdec.c
AVFORMAT_C_FILES-$(CONFIG_RAWVIDEO_MUXER)            += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_RL2_DEMUXER)               += rl2.c
AVFORMAT_C_FILES-$(CONFIG_RM_DEMUXER)                += rmdec.c rm.c
AVFORMAT_C_FILES-$(CONFIG_RM_MUXER)                  += rmenc.c rm.c
AVFORMAT_C_FILES-$(CONFIG_ROQ_DEMUXER)               += idroqdec.c
AVFORMAT_C_FILES-$(CONFIG_ROQ_MUXER)                 += idroqenc.c rawenc.c
AVFORMAT_C_FILES-$(CONFIG_RSO_DEMUXER)               += rsodec.c rso.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_RSO_MUXER)                 += rsoenc.c rso.c
AVFORMAT_C_FILES-$(CONFIG_RPL_DEMUXER)               += rpl.c
AVFORMAT_C_FILES-$(CONFIG_RTP_MUXER)                 += rtp.c         \
                                            rtpenc_aac.c     \
                                            rtpenc_latm.c    \
                                            rtpenc_amr.c     \
                                            rtpenc_h263.c    \
                                            rtpenc_mpv.c     \
                                            rtpenc.c      \
                                            rtpenc_h264.c \
                                            rtpenc_vp8.c  \
                                            rtpenc_xiph.c \
                                            avc.c
AVFORMAT_C_FILES-$(CONFIG_RTPDEC)                    += rdt.c         \
                                            rtp.c         \
                                            rtpdec.c      \
                                            rtpdec_amr.c  \
                                            rtpdec_asf.c  \
                                            rtpdec_g726.c \
                                            rtpdec_h263.c \
                                            rtpdec_h264.c \
                                            rtpdec_latm.c \
                                            rtpdec_mpeg4.c \
                                            rtpdec_qcelp.c \
                                            rtpdec_qdm2.c \
                                            rtpdec_qt.c   \
                                            rtpdec_svq3.c \
                                            rtpdec_vp8.c  \
                                            rtpdec_xiph.c
AVFORMAT_C_FILES-$(CONFIG_RTSP_DEMUXER)              += rtsp.c rtspdec.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_RTSP_MUXER)                += rtsp.c rtspenc.c httpauth.c \
                                            rtpenc_chain.c
AVFORMAT_C_FILES-$(CONFIG_SAP_DEMUXER)               += sapdec.c
AVFORMAT_C_FILES-$(CONFIG_SAP_MUXER)                 += sapenc.c rtpenc_chain.c
AVFORMAT_C_FILES-$(CONFIG_SDP_DEMUXER)               += rtsp.c
AVFORMAT_C_FILES-$(CONFIG_SEGAFILM_DEMUXER)          += segafilm.c
AVFORMAT_C_FILES-$(CONFIG_SEGMENT_MUXER)          	 += segment.c
AVFORMAT_C_FILES-$(CONFIG_SHORTEN_DEMUXER)           += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_SIFF_DEMUXER)              += siff.c
AVFORMAT_C_FILES-$(CONFIG_SMACKER_DEMUXER)           += smacker.c
AVFORMAT_C_FILES-$(CONFIG_SOL_DEMUXER)               += sol.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_SOX_DEMUXER)               += soxdec.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_SOX_MUXER)                 += soxenc.c
AVFORMAT_C_FILES-$(CONFIG_SPDIF_DEMUXER)             += spdif.c spdifdec.c
AVFORMAT_C_FILES-$(CONFIG_SPDIF_MUXER)               += spdif.c spdifenc.c
AVFORMAT_C_FILES-$(CONFIG_SRT_DEMUXER)               += srtdec.c
AVFORMAT_C_FILES-$(CONFIG_SRT_MUXER)                 += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_STR_DEMUXER)               += psxstr.c
AVFORMAT_C_FILES-$(CONFIG_SWF_DEMUXER)               += swfdec.c
AVFORMAT_C_FILES-$(CONFIG_SWF_MUXER)                 += swfenc.c
AVFORMAT_C_FILES-$(CONFIG_THP_DEMUXER)               += thp.c
AVFORMAT_C_FILES-$(CONFIG_TIERTEXSEQ_DEMUXER)        += tiertexseq.c
AVFORMAT_C_FILES-$(CONFIG_MKVTIMESTAMP_V2_MUXER)     += mkvtimestamp_v2.c
AVFORMAT_C_FILES-$(CONFIG_TMV_DEMUXER)               += tmv.c
AVFORMAT_C_FILES-$(CONFIG_TRUEHD_DEMUXER)            += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_TRUEHD_MUXER)              += rawenc.c
AVFORMAT_C_FILES-$(CONFIG_TTA_DEMUXER)               += tta.c
AVFORMAT_C_FILES-$(CONFIG_TTY_DEMUXER)               += tty.c sauce.c
AVFORMAT_C_FILES-$(CONFIG_TXD_DEMUXER)               += txd.c
AVFORMAT_C_FILES-$(CONFIG_VC1_DEMUXER)               += rawdec.c
AVFORMAT_C_FILES-$(CONFIG_VC1T_DEMUXER)              += vc1test.c
AVFORMAT_C_FILES-$(CONFIG_VC1T_MUXER)                += vc1testenc.c
AVFORMAT_C_FILES-$(CONFIG_VMD_DEMUXER)               += sierravmd.c
AVFORMAT_C_FILES-$(CONFIG_VOC_DEMUXER)               += vocdec.c voc.c
AVFORMAT_C_FILES-$(CONFIG_VOC_MUXER)                 += vocenc.c voc.c
AVFORMAT_C_FILES-$(CONFIG_VQF_DEMUXER)               += vqf.c
AVFORMAT_C_FILES-$(CONFIG_W64_DEMUXER)               += wav.c riff.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_WAV_DEMUXER)               += wav.c riff.c pcm.c
AVFORMAT_C_FILES-$(CONFIG_WAV_MUXER)                 += wav.c riff.c
AVFORMAT_C_FILES-$(CONFIG_WC3_DEMUXER)               += wc3movie.c
AVFORMAT_C_FILES-$(CONFIG_WEBM_MUXER)                += matroskaenc.c matroska.c \
                                            riff.c isom.c avc.c \
                                            flacenc_header.c avlanguage.c
AVFORMAT_C_FILES-$(CONFIG_WSAUD_DEMUXER)             += westwood.c
AVFORMAT_C_FILES-$(CONFIG_WSVQA_DEMUXER)             += westwood.c
AVFORMAT_C_FILES-$(CONFIG_WTV_DEMUXER)               += wtvdec.c wtv.c asfdec.c asf.c asfcrypt.c \
                                            avlanguage.c mpegts.c isom.c riff.c
AVFORMAT_C_FILES-$(CONFIG_WTV_MUXER)                 += wtvenc.c wtv.c asf.c asfenc.c riff.c
AVFORMAT_C_FILES-$(CONFIG_WV_DEMUXER)                += wv.c apetag.c
AVFORMAT_C_FILES-$(CONFIG_XA_DEMUXER)                += xa.c
AVFORMAT_C_FILES-$(CONFIG_XBIN_DEMUXER)              += bintext.c sauce.c
AVFORMAT_C_FILES-$(CONFIG_XMV_DEMUXER)               += xmv.c
AVFORMAT_C_FILES-$(CONFIG_XWMA_DEMUXER)              += xwma.c riff.c
AVFORMAT_C_FILES-$(CONFIG_YOP_DEMUXER)               += yop.c
AVFORMAT_C_FILES-$(CONFIG_YUV4MPEGPIPE_MUXER)        += yuv4mpeg.c
AVFORMAT_C_FILES-$(CONFIG_YUV4MPEGPIPE_DEMUXER)      += yuv4mpeg.c

# external libraries
AVFORMAT_C_FILES-$(CONFIG_LIBMODPLUG_DEMUXER)        += libmodplug.c
AVFORMAT_C_FILES-$(CONFIG_LIBNUT_DEMUXER)            += libnut.c riff.c
AVFORMAT_C_FILES-$(CONFIG_LIBNUT_MUXER)              += libnut.c riff.c

# protocols I/O
AVFORMAT_C_FILES+= avio.c aviobuf.c

AVFORMAT_C_FILES-$(CONFIG_APPLEHTTP_PROTOCOL)        += applehttpproto.c
AVFORMAT_C_FILES-$(CONFIG_CACHE_PROTOCOL)            += cache.c
AVFORMAT_C_FILES-$(CONFIG_CONCAT_PROTOCOL)           += concat.c
AVFORMAT_C_FILES-$(CONFIG_CRYPTO_PROTOCOL)           += crypto.c
AVFORMAT_C_FILES-$(CONFIG_FILE_PROTOCOL)             += file.c
AVFORMAT_C_FILES-$(CONFIG_GOPHER_PROTOCOL)           += gopher.c
AVFORMAT_C_FILES-$(CONFIG_HTTP_PROTOCOL)             += http.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_HTTPPROXY_PROTOCOL)        += http.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_HTTPS_PROTOCOL)            += http.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_MMSH_PROTOCOL)             += mmsh.c mms.c asf.c
AVFORMAT_C_FILES-$(CONFIG_MMST_PROTOCOL)             += mmst.c mms.c asf.c
AVFORMAT_C_FILES-$(CONFIG_MD5_PROTOCOL)              += md5proto.c
AVFORMAT_C_FILES-$(CONFIG_PIPE_PROTOCOL)             += file.c

# external or internal rtmp
RTMP-AVFORMAT_C_FILES-$(CONFIG_LIBRTMP)               = librtmp.c
RTMP-AVFORMAT_C_FILES-$(!CONFIG_LIBRTMP)              = rtmpproto.c rtmppkt.c
AVFORMAT_C_FILES-$(CONFIG_RTMP_PROTOCOL)             += $(RTMP-AVFORMAT_C_FILES-yes)

AVFORMAT_C_FILES-$(CONFIG_RTP_PROTOCOL)              += rtpproto.c
AVFORMAT_C_FILES-$(CONFIG_TCP_PROTOCOL)              += tcp.c
AVFORMAT_C_FILES-$(CONFIG_TLS_PROTOCOL)              += tls.c
AVFORMAT_C_FILES-$(CONFIG_UDP_PROTOCOL)              += udp.c

AVFORMAT_C_FILES += $(AVFORMAT_C_FILES-yes)
 
AVFORMAT_SRC_FILES = $(addprefix libavformat/, $(sort $(AVFORMAT_C_FILES)))

tempSrc := \
$(SWSCALE_SRC_FILES) \
$(AVUTIL_SRC_FILES) \
$(AVCODEC_SRC_FILES) \
$(AVCODEC_ARM_SRC_FILES) \
$(AVFORMAT_SRC_FILES)

LOCAL_SRC_FILES := $(tempSrc)

LOCAL_ARM_MODE := arm

include $(BUILT_SHARED_LIBRARY)

