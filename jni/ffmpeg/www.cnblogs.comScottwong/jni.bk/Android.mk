LOCAL_PATH := $(call my-dir)/..
 
include $(CLEAR_VARS)
 
LOCAL_MODULE := ffmpeg
 
include $(LOCAL_PATH)/config.mak
 
LOCAL_CFLAGS := -DHAVE_AV_CONFIG_H -std=c99
 
AVUTIL_C_FILES = adler32.c \
aes.c \
avstring.c \
base64.c \
crc.c \
des.c \
error.c \
fifo.c \
intfloat_readwrite.c \
lfg.c \
lls.c \
log.c \
lzo.c \
mathematics.c \
md5.c \
mem.c \
pixdesc.c \
random_seed.c \
rational.c \
rc4.c \
sha.c \
tree.c \
utils.c \
 
AVUTIL_SRC_FILES = $(addprefix libavutil/, $(sort $(AVUTIL_C_FILES)))
 
AVCODEC_C_FILES = allcodecs.c \
audioconvert.c \
avpacket.c \
bitstream.c \
bitstream_filter.c \
dsputil.c \
eval.c \
faanidct.c \
imgconvert.c \
jrevdct.c \
opt.c \
options.c \
parser.c \
raw.c \
resample.c \
resample2.c \
simple_idct.c \
utils.c \
 
AVCODEC_C_FILES-$(CONFIG_AANDCT) += aandcttab.c
AVCODEC_C_FILES-$(CONFIG_ENCODERS) += faandct.c jfdctfst.c jfdctint.c
AVCODEC_C_FILES-$(CONFIG_DCT) += dct.c
AVCODEC_C_FILES-$(CONFIG_DWT) += dwt.c
AVCODEC_C_FILES-$(CONFIG_DXVA2) += dxva2.c
FFT-FILES-$(CONFIG_HARDCODED_TABLES) += cos_tables.c
AVCODEC_C_FILES-$(CONFIG_FFT) += avfft.c fft.c $(FFT-FILES-yes)
AVCODEC_C_FILES-$(CONFIG_GOLOMB) += golomb.c
AVCODEC_C_FILES-$(CONFIG_H264DSP) += h264dsp.c h264idct.c h264pred.c
AVCODEC_C_FILES-$(CONFIG_LPC) += lpc.c
AVCODEC_C_FILES-$(CONFIG_LSP) += lsp.c
AVCODEC_C_FILES-$(CONFIG_MDCT) += mdct.c
RDFT-FILES-$(CONFIG_HARDCODED_TABLES) += sin_tables.c
AVCODEC_C_FILES-$(CONFIG_RDFT) += rdft.c $(RDFT-FILES-yes)
AVCODEC_C_FILES-$(CONFIG_VAAPI) += vaapi.c
AVCODEC_C_FILES-$(CONFIG_VDPAU) += vdpau.c
 
AVCODEC_C_FILES-$(CONFIG_AAC_DECODER) += aacdec.c aactab.c aacsbr.c aacps.c
AVCODEC_C_FILES-$(CONFIG_AAC_ENCODER) += aacenc.c aaccoder.c \
aacpsy.c aactab.c \
psymodel.c iirfilter.c \
mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_AASC_DECODER) += aasc.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_AC3_DECODER) += ac3dec.c ac3dec_data.c ac3.c
AVCODEC_C_FILES-$(CONFIG_AC3_ENCODER) += ac3enc.c ac3tab.c ac3.c
AVCODEC_C_FILES-$(CONFIG_ALAC_DECODER) += alac.c
AVCODEC_C_FILES-$(CONFIG_ALAC_ENCODER) += alacenc.c
AVCODEC_C_FILES-$(CONFIG_ALS_DECODER) += alsdec.c bgmc.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_AMRNB_DECODER) += amrnbdec.c celp_filters.c \
celp_math.c acelp_filters.c \
acelp_vectors.c \
acelp_pitch_delay.c
AVCODEC_C_FILES-$(CONFIG_AMV_DECODER) += sp5xdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_ANM_DECODER) += anm.c
AVCODEC_C_FILES-$(CONFIG_APE_DECODER) += apedec.c
AVCODEC_C_FILES-$(CONFIG_ASV1_DECODER) += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ASV1_ENCODER) += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ASV2_DECODER) += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ASV2_ENCODER) += asv1.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_ATRAC1_DECODER) += atrac1.c atrac.c
AVCODEC_C_FILES-$(CONFIG_ATRAC3_DECODER) += atrac3.c atrac.c
AVCODEC_C_FILES-$(CONFIG_AURA_DECODER) += cyuv.c
AVCODEC_C_FILES-$(CONFIG_AURA2_DECODER) += aura.c
AVCODEC_C_FILES-$(CONFIG_AVS_DECODER) += avs.c
AVCODEC_C_FILES-$(CONFIG_BETHSOFTVID_DECODER) += bethsoftvideo.c
AVCODEC_C_FILES-$(CONFIG_BFI_DECODER) += bfi.c
AVCODEC_C_FILES-$(CONFIG_BINK_DECODER) += bink.c binkidct.c
AVCODEC_C_FILES-$(CONFIG_BINKAUDIO_DCT_DECODER) += binkaudio.c wma.c
AVCODEC_C_FILES-$(CONFIG_BINKAUDIO_RDFT_DECODER) += binkaudio.c wma.c
AVCODEC_C_FILES-$(CONFIG_BMP_DECODER) += bmp.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_BMP_ENCODER) += bmpenc.c
AVCODEC_C_FILES-$(CONFIG_C93_DECODER) += c93.c
AVCODEC_C_FILES-$(CONFIG_CAVS_DECODER) += cavs.c cavsdec.c cavsdsp.c \
mpeg12data.c mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_CDGRAPHICS_DECODER) += cdgraphics.c
AVCODEC_C_FILES-$(CONFIG_CINEPAK_DECODER) += cinepak.c
AVCODEC_C_FILES-$(CONFIG_CLJR_DECODER) += cljr.c
AVCODEC_C_FILES-$(CONFIG_CLJR_ENCODER) += cljr.c
AVCODEC_C_FILES-$(CONFIG_COOK_DECODER) += cook.c
AVCODEC_C_FILES-$(CONFIG_CSCD_DECODER) += cscd.c
AVCODEC_C_FILES-$(CONFIG_CYUV_DECODER) += cyuv.c
AVCODEC_C_FILES-$(CONFIG_DCA_DECODER) += dca.c synth_filter.c dcadsp.c
AVCODEC_C_FILES-$(CONFIG_DNXHD_DECODER) += dnxhddec.c dnxhddata.c
AVCODEC_C_FILES-$(CONFIG_DNXHD_ENCODER) += dnxhdenc.c dnxhddata.c \
mpegvideo_enc.c motion_est.c \
ratecontrol.c mpeg12data.c \
mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_DPX_DECODER) += dpx.c
AVCODEC_C_FILES-$(CONFIG_DSICINAUDIO_DECODER) += dsicinav.c
AVCODEC_C_FILES-$(CONFIG_DSICINVIDEO_DECODER) += dsicinav.c
AVCODEC_C_FILES-$(CONFIG_DVBSUB_DECODER) += dvbsubdec.c
AVCODEC_C_FILES-$(CONFIG_DVBSUB_ENCODER) += dvbsub.c
AVCODEC_C_FILES-$(CONFIG_DVDSUB_DECODER) += dvdsubdec.c
AVCODEC_C_FILES-$(CONFIG_DVDSUB_ENCODER) += dvdsubenc.c
AVCODEC_C_FILES-$(CONFIG_DVVIDEO_DECODER) += dv.c dvdata.c
AVCODEC_C_FILES-$(CONFIG_DVVIDEO_ENCODER) += dv.c dvdata.c
AVCODEC_C_FILES-$(CONFIG_DXA_DECODER) += dxa.c
AVCODEC_C_FILES-$(CONFIG_EAC3_DECODER) += eac3dec.c eac3dec_data.c
AVCODEC_C_FILES-$(CONFIG_EACMV_DECODER) += eacmv.c
AVCODEC_C_FILES-$(CONFIG_EAMAD_DECODER) += eamad.c eaidct.c mpeg12.c \
mpeg12data.c mpegvideo.c \
error_resilience.c
AVCODEC_C_FILES-$(CONFIG_EATGQ_DECODER) += eatgq.c eaidct.c
AVCODEC_C_FILES-$(CONFIG_EATGV_DECODER) += eatgv.c
AVCODEC_C_FILES-$(CONFIG_EATQI_DECODER) += eatqi.c eaidct.c mpeg12.c \
mpeg12data.c mpegvideo.c \
error_resilience.c
AVCODEC_C_FILES-$(CONFIG_EIGHTBPS_DECODER) += 8bps.c
AVCODEC_C_FILES-$(CONFIG_EIGHTSVX_EXP_DECODER) += 8svx.c
AVCODEC_C_FILES-$(CONFIG_EIGHTSVX_FIB_DECODER) += 8svx.c
AVCODEC_C_FILES-$(CONFIG_ESCAPE124_DECODER) += escape124.c
AVCODEC_C_FILES-$(CONFIG_FFV1_DECODER) += ffv1.c rangecoder.c
AVCODEC_C_FILES-$(CONFIG_FFV1_ENCODER) += ffv1.c rangecoder.c
AVCODEC_C_FILES-$(CONFIG_FFVHUFF_DECODER) += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_FFVHUFF_ENCODER) += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_FLAC_DECODER) += flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_FLAC_ENCODER) += flacenc.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_FLASHSV_DECODER) += flashsv.c
AVCODEC_C_FILES-$(CONFIG_FLASHSV_ENCODER) += flashsvenc.c
AVCODEC_C_FILES-$(CONFIG_FLIC_DECODER) += flicvideo.c
AVCODEC_C_FILES-$(CONFIG_FOURXM_DECODER) += 4xm.c
AVCODEC_C_FILES-$(CONFIG_FRAPS_DECODER) += fraps.c huffman.c
AVCODEC_C_FILES-$(CONFIG_FRWU_DECODER) += frwu.c
AVCODEC_C_FILES-$(CONFIG_GIF_DECODER) += gifdec.c lzw.c
AVCODEC_C_FILES-$(CONFIG_GIF_ENCODER) += gif.c lzwenc.c
AVCODEC_C_FILES-$(CONFIG_H261_DECODER) += h261dec.c h261.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H261_ENCODER) += h261enc.c h261.c \
mpegvideo_enc.c motion_est.c \
ratecontrol.c mpeg12data.c \
mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_H263_DECODER) += h263dec.c h263.c ituh263dec.c \
mpeg4video.c mpeg4videodec.c flvdec.c\
intelh263dec.c mpegvideo.c \
error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H263_VAAPI_HWACCEL) += vaapi_mpeg4.c
AVCODEC_C_FILES-$(CONFIG_H263_ENCODER) += mpegvideo_enc.c mpeg4video.c \
mpeg4videoenc.c motion_est.c \
ratecontrol.c h263.c ituh263enc.c \
flvenc.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H264_DECODER) += h264.c \
h264_loopfilter.c h264_direct.c \
cabac.c h264_sei.c h264_ps.c \
h264_refs.c h264_cavlc.c h264_cabac.c\
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_H264_DXVA2_HWACCEL) += dxva2_h264.c
AVCODEC_C_FILES-$(CONFIG_H264_ENCODER) += h264enc.c h264dspenc.c
AVCODEC_C_FILES-$(CONFIG_H264_VAAPI_HWACCEL) += vaapi_h264.c
AVCODEC_C_FILES-$(CONFIG_HUFFYUV_DECODER) += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_HUFFYUV_ENCODER) += huffyuv.c
AVCODEC_C_FILES-$(CONFIG_IDCIN_DECODER) += idcinvideo.c
AVCODEC_C_FILES-$(CONFIG_IFF_BYTERUN1_DECODER) += iff.c
AVCODEC_C_FILES-$(CONFIG_IFF_ILBM_DECODER) += iff.c
AVCODEC_C_FILES-$(CONFIG_IMC_DECODER) += imc.c
AVCODEC_C_FILES-$(CONFIG_INDEO2_DECODER) += indeo2.c
AVCODEC_C_FILES-$(CONFIG_INDEO3_DECODER) += indeo3.c
AVCODEC_C_FILES-$(CONFIG_INDEO5_DECODER) += indeo5.c ivi_common.c ivi_dsp.c
AVCODEC_C_FILES-$(CONFIG_INTERPLAY_DPCM_DECODER) += dpcm.c
AVCODEC_C_FILES-$(CONFIG_INTERPLAY_VIDEO_DECODER) += interplayvideo.c
AVCODEC_C_FILES-$(CONFIG_JPEGLS_DECODER) += jpeglsdec.c jpegls.c \
mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_JPEGLS_ENCODER) += jpeglsenc.c jpegls.c
AVCODEC_C_FILES-$(CONFIG_KGV1_DECODER) += kgv1dec.c
AVCODEC_C_FILES-$(CONFIG_KMVC_DECODER) += kmvc.c
AVCODEC_C_FILES-$(CONFIG_LJPEG_ENCODER) += ljpegenc.c mjpegenc.c mjpeg.c \
mpegvideo_enc.c motion_est.c \
ratecontrol.c mpeg12data.c \
mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_LOCO_DECODER) += loco.c
AVCODEC_C_FILES-$(CONFIG_MACE3_DECODER) += mace.c
AVCODEC_C_FILES-$(CONFIG_MACE6_DECODER) += mace.c
AVCODEC_C_FILES-$(CONFIG_MDEC_DECODER) += mdec.c mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MIMIC_DECODER) += mimic.c
AVCODEC_C_FILES-$(CONFIG_MJPEG_DECODER) += mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_MJPEG_ENCODER) += mjpegenc.c mjpeg.c \
mpegvideo_enc.c motion_est.c \
ratecontrol.c mpeg12data.c \
mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_MJPEGB_DECODER) += mjpegbdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_MLP_DECODER) += mlpdec.c mlpdsp.c
AVCODEC_C_FILES-$(CONFIG_MMVIDEO_DECODER) += mmvideo.c
AVCODEC_C_FILES-$(CONFIG_MOTIONPIXELS_DECODER) += motionpixels.c
AVCODEC_C_FILES-$(CONFIG_MP1_DECODER) += mpegaudiodec.c mpegaudiodecheader.c \
mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP2_DECODER) += mpegaudiodec.c mpegaudiodecheader.c \
mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP2_ENCODER) += mpegaudioenc.c mpegaudio.c \
mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP3ADU_DECODER) += mpegaudiodec.c mpegaudiodecheader.c \
mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MP3ON4_DECODER) += mpegaudiodec.c mpegaudiodecheader.c \
mpegaudio.c mpegaudiodata.c \
mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_MP3_DECODER) += mpegaudiodec.c mpegaudiodecheader.c \
mpegaudio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPC7_DECODER) += mpc7.c mpc.c mpegaudiodec.c \
mpegaudiodecheader.c mpegaudio.c \
mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPC8_DECODER) += mpc8.c mpc.c mpegaudiodec.c \
mpegaudiodecheader.c mpegaudio.c \
mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPEGVIDEO_DECODER) += mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG_XVMC_DECODER) += mpegvideo_xvmc.c
AVCODEC_C_FILES-$(CONFIG_MPEG1VIDEO_DECODER) += mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG1VIDEO_ENCODER) += mpeg12enc.c mpegvideo_enc.c \
motion_est.c ratecontrol.c \
mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG2_VAAPI_HWACCEL) += vaapi_mpeg2.c
AVCODEC_C_FILES-$(CONFIG_MPEG2VIDEO_DECODER) += mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG2VIDEO_ENCODER) += mpeg12enc.c mpegvideo_enc.c \
motion_est.c ratecontrol.c \
mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MPEG4_VAAPI_HWACCEL) += vaapi_mpeg4.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V1_DECODER) += msmpeg4.c msmpeg4data.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V1_ENCODER) += msmpeg4.c msmpeg4data.c h263dec.c \
h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V2_DECODER) += msmpeg4.c msmpeg4data.c h263dec.c \
h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V2_ENCODER) += msmpeg4.c msmpeg4data.c h263dec.c \
h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V3_DECODER) += msmpeg4.c msmpeg4data.c h263dec.c \
h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSMPEG4V3_ENCODER) += msmpeg4.c msmpeg4data.c h263dec.c \
h263.c ituh263dec.c mpeg4videodec.c
AVCODEC_C_FILES-$(CONFIG_MSRLE_DECODER) += msrle.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_MSVIDEO1_DECODER) += msvideo1.c
AVCODEC_C_FILES-$(CONFIG_MSZH_DECODER) += lcldec.c
AVCODEC_C_FILES-$(CONFIG_NELLYMOSER_DECODER) += nellymoserdec.c nellymoser.c
AVCODEC_C_FILES-$(CONFIG_NELLYMOSER_ENCODER) += nellymoserenc.c nellymoser.c
AVCODEC_C_FILES-$(CONFIG_NUV_DECODER) += nuv.c rtjpeg.c
AVCODEC_C_FILES-$(CONFIG_PAM_DECODER) += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PAM_ENCODER) += pamenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PBM_DECODER) += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PBM_ENCODER) += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PCX_DECODER) += pcx.c
AVCODEC_C_FILES-$(CONFIG_PCX_ENCODER) += pcxenc.c
AVCODEC_C_FILES-$(CONFIG_PGM_DECODER) += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGM_ENCODER) += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGMYUV_DECODER) += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGMYUV_ENCODER) += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PGSSUB_DECODER) += pgssubdec.c
AVCODEC_C_FILES-$(CONFIG_PNG_DECODER) += png.c pngdec.c
AVCODEC_C_FILES-$(CONFIG_PNG_ENCODER) += png.c pngenc.c
AVCODEC_C_FILES-$(CONFIG_PPM_DECODER) += pnmdec.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PPM_ENCODER) += pnmenc.c pnm.c
AVCODEC_C_FILES-$(CONFIG_PTX_DECODER) += ptx.c
AVCODEC_C_FILES-$(CONFIG_QCELP_DECODER) += qcelpdec.c celp_math.c \
celp_filters.c acelp_vectors.c \
acelp_filters.c
AVCODEC_C_FILES-$(CONFIG_QDM2_DECODER) += qdm2.c mpegaudiodec.c \
mpegaudiodecheader.c mpegaudio.c \
mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_QDRAW_DECODER) += qdrw.c
AVCODEC_C_FILES-$(CONFIG_QPEG_DECODER) += qpeg.c
AVCODEC_C_FILES-$(CONFIG_QTRLE_DECODER) += qtrle.c
AVCODEC_C_FILES-$(CONFIG_QTRLE_ENCODER) += qtrleenc.c
AVCODEC_C_FILES-$(CONFIG_R210_DECODER) += r210dec.c
AVCODEC_C_FILES-$(CONFIG_RA_144_DECODER) += ra144.c celp_filters.c
AVCODEC_C_FILES-$(CONFIG_RA_288_DECODER) += ra288.c celp_math.c celp_filters.c
AVCODEC_C_FILES-$(CONFIG_RAWVIDEO_DECODER) += rawdec.c
AVCODEC_C_FILES-$(CONFIG_RAWVIDEO_ENCODER) += rawenc.c
AVCODEC_C_FILES-$(CONFIG_RL2_DECODER) += rl2.c
AVCODEC_C_FILES-$(CONFIG_ROQ_DECODER) += roqvideodec.c roqvideo.c
AVCODEC_C_FILES-$(CONFIG_ROQ_ENCODER) += roqvideoenc.c roqvideo.c elbg.c
AVCODEC_C_FILES-$(CONFIG_ROQ_DPCM_DECODER) += dpcm.c
AVCODEC_C_FILES-$(CONFIG_ROQ_DPCM_ENCODER) += roqaudioenc.c
AVCODEC_C_FILES-$(CONFIG_RPZA_DECODER) += rpza.c
AVCODEC_C_FILES-$(CONFIG_RV10_DECODER) += rv10.c
AVCODEC_C_FILES-$(CONFIG_RV10_ENCODER) += rv10enc.c
AVCODEC_C_FILES-$(CONFIG_RV20_DECODER) += rv10.c
AVCODEC_C_FILES-$(CONFIG_RV20_ENCODER) += rv20enc.c
AVCODEC_C_FILES-$(CONFIG_RV30_DECODER) += rv30.c rv34.c rv30dsp.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_RV40_DECODER) += rv40.c rv34.c rv40dsp.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_SGI_DECODER) += sgidec.c
AVCODEC_C_FILES-$(CONFIG_SGI_ENCODER) += sgienc.c rle.c
AVCODEC_C_FILES-$(CONFIG_SHORTEN_DECODER) += shorten.c
AVCODEC_C_FILES-$(CONFIG_SIPR_DECODER) += sipr.c acelp_pitch_delay.c \
celp_math.c acelp_vectors.c \
acelp_filters.c celp_filters.c \
sipr16k.c
AVCODEC_C_FILES-$(CONFIG_SMACKAUD_DECODER) += smacker.c
AVCODEC_C_FILES-$(CONFIG_SMACKER_DECODER) += smacker.c
AVCODEC_C_FILES-$(CONFIG_SMC_DECODER) += smc.c
AVCODEC_C_FILES-$(CONFIG_SNOW_DECODER) += snow.c rangecoder.c
AVCODEC_C_FILES-$(CONFIG_SNOW_ENCODER) += snow.c rangecoder.c motion_est.c \
ratecontrol.c h263.c \
mpegvideo.c error_resilience.c \
ituh263enc.c mpegvideo_enc.c \
mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_SOL_DPCM_DECODER) += dpcm.c
AVCODEC_C_FILES-$(CONFIG_SONIC_DECODER) += sonic.c
AVCODEC_C_FILES-$(CONFIG_SONIC_ENCODER) += sonic.c
AVCODEC_C_FILES-$(CONFIG_SONIC_LS_ENCODER) += sonic.c
AVCODEC_C_FILES-$(CONFIG_SP5X_DECODER) += sp5xdec.c mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_SUNRAST_DECODER) += sunrast.c
AVCODEC_C_FILES-$(CONFIG_SVQ1_DECODER) += svq1dec.c svq1.c h263.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_SVQ1_ENCODER) += svq1enc.c svq1.c \
motion_est.c h263.c \
mpegvideo.c error_resilience.c \
ituh263enc.c mpegvideo_enc.c \
ratecontrol.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_SVQ3_DECODER) += h264.c svq3.c \
h264_loopfilter.c h264_direct.c \
h264_sei.c h264_ps.c h264_refs.c \
h264_cavlc.c h264_cabac.c cabac.c \
mpegvideo.c error_resilience.c \
svq1dec.c svq1.c h263.c
AVCODEC_C_FILES-$(CONFIG_TARGA_DECODER) += targa.c
AVCODEC_C_FILES-$(CONFIG_TARGA_ENCODER) += targaenc.c rle.c
AVCODEC_C_FILES-$(CONFIG_THEORA_DECODER) += xiph.c
AVCODEC_C_FILES-$(CONFIG_THP_DECODER) += mjpegdec.c mjpeg.c
AVCODEC_C_FILES-$(CONFIG_TIERTEXSEQVIDEO_DECODER) += tiertexseqv.c
AVCODEC_C_FILES-$(CONFIG_TIFF_DECODER) += tiff.c lzw.c faxcompr.c
AVCODEC_C_FILES-$(CONFIG_TIFF_ENCODER) += tiffenc.c rle.c lzwenc.c
AVCODEC_C_FILES-$(CONFIG_TMV_DECODER) += tmv.c cga_data.c
AVCODEC_C_FILES-$(CONFIG_TRUEMOTION1_DECODER) += truemotion1.c
AVCODEC_C_FILES-$(CONFIG_TRUEMOTION2_DECODER) += truemotion2.c
AVCODEC_C_FILES-$(CONFIG_TRUESPEECH_DECODER) += truespeech.c
AVCODEC_C_FILES-$(CONFIG_TSCC_DECODER) += tscc.c msrledec.c
AVCODEC_C_FILES-$(CONFIG_TTA_DECODER) += tta.c
AVCODEC_C_FILES-$(CONFIG_TWINVQ_DECODER) += twinvq.c celp_math.c
AVCODEC_C_FILES-$(CONFIG_TXD_DECODER) += txd.c s3tc.c
AVCODEC_C_FILES-$(CONFIG_ULTI_DECODER) += ulti.c
AVCODEC_C_FILES-$(CONFIG_V210_DECODER) += v210dec.c
AVCODEC_C_FILES-$(CONFIG_V210_ENCODER) += v210enc.c
AVCODEC_C_FILES-$(CONFIG_V210X_DECODER) += v210x.c
AVCODEC_C_FILES-$(CONFIG_VB_DECODER) += vb.c
AVCODEC_C_FILES-$(CONFIG_VC1_DECODER) += vc1dec.c vc1.c vc1data.c vc1dsp.c \
msmpeg4.c msmpeg4data.c \
intrax8.c intrax8dsp.c
AVCODEC_C_FILES-$(CONFIG_VC1_DXVA2_HWACCEL) += dxva2_vc1.c
AVCODEC_C_FILES-$(CONFIG_VC1_VAAPI_HWACCEL) += vaapi_vc1.c
AVCODEC_C_FILES-$(CONFIG_VCR1_DECODER) += vcr1.c
AVCODEC_C_FILES-$(CONFIG_VCR1_ENCODER) += vcr1.c
AVCODEC_C_FILES-$(CONFIG_VMDAUDIO_DECODER) += vmdav.c
AVCODEC_C_FILES-$(CONFIG_VMDVIDEO_DECODER) += vmdav.c
AVCODEC_C_FILES-$(CONFIG_VMNC_DECODER) += vmnc.c
AVCODEC_C_FILES-$(CONFIG_VORBIS_DECODER) += vorbis_dec.c vorbis.c \
vorbis_data.c xiph.c
AVCODEC_C_FILES-$(CONFIG_VORBIS_ENCODER) += vorbis_enc.c vorbis.c \
vorbis_data.c
AVCODEC_C_FILES-$(CONFIG_VP3_DECODER) += vp3.c vp3dsp.c
AVCODEC_C_FILES-$(CONFIG_VP5_DECODER) += vp5.c vp56.c vp56data.c vp56dsp.c \
vp3dsp.c
AVCODEC_C_FILES-$(CONFIG_VP6_DECODER) += vp6.c vp56.c vp56data.c vp56dsp.c \
vp3dsp.c vp6dsp.c huffman.c
AVCODEC_C_FILES-$(CONFIG_VQA_DECODER) += vqavideo.c
AVCODEC_C_FILES-$(CONFIG_WAVPACK_DECODER) += wavpack.c
AVCODEC_C_FILES-$(CONFIG_WMAPRO_DECODER) += wmaprodec.c wma.c
AVCODEC_C_FILES-$(CONFIG_WMAV1_DECODER) += wmadec.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAV1_ENCODER) += wmaenc.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAV2_DECODER) += wmadec.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAV2_ENCODER) += wmaenc.c wma.c aactab.c
AVCODEC_C_FILES-$(CONFIG_WMAVOICE_DECODER) += wmavoice.c \
celp_math.c celp_filters.c \
acelp_vectors.c acelp_filters.c
AVCODEC_C_FILES-$(CONFIG_WMV1_DECODER) += msmpeg4.c msmpeg4data.c
AVCODEC_C_FILES-$(CONFIG_WMV2_DECODER) += wmv2dec.c wmv2.c \
msmpeg4.c msmpeg4data.c \
intrax8.c intrax8dsp.c
AVCODEC_C_FILES-$(CONFIG_WMV2_ENCODER) += wmv2enc.c wmv2.c \
msmpeg4.c msmpeg4data.c \
mpeg4videodec.c ituh263dec.c h263dec.c
AVCODEC_C_FILES-$(CONFIG_WNV1_DECODER) += wnv1.c
AVCODEC_C_FILES-$(CONFIG_WS_SND1_DECODER) += ws-snd1.c
AVCODEC_C_FILES-$(CONFIG_XAN_DPCM_DECODER) += dpcm.c
AVCODEC_C_FILES-$(CONFIG_XAN_WC3_DECODER) += xan.c
AVCODEC_C_FILES-$(CONFIG_XAN_WC4_DECODER) += xan.c
AVCODEC_C_FILES-$(CONFIG_XL_DECODER) += xl.c
AVCODEC_C_FILES-$(CONFIG_XSUB_DECODER) += xsubdec.c
AVCODEC_C_FILES-$(CONFIG_XSUB_ENCODER) += xsubenc.c
AVCODEC_C_FILES-$(CONFIG_YOP_DECODER) += yop.c
AVCODEC_C_FILES-$(CONFIG_ZLIB_DECODER) += lcldec.c
AVCODEC_C_FILES-$(CONFIG_ZLIB_ENCODER) += lclenc.c
AVCODEC_C_FILES-$(CONFIG_ZMBV_DECODER) += zmbv.c
AVCODEC_C_FILES-$(CONFIG_ZMBV_ENCODER) += zmbvenc.c
 
AVCODEC_C_FILES-$(CONFIG_PCM_ALAW_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_ALAW_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_BLURAY_DECODER) += pcm-mpeg.c
AVCODEC_C_FILES-$(CONFIG_PCM_DVD_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_DVD_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F32LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_F64LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_MULAW_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_MULAW_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S8_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S8_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S16LE_PLANAR_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24DAUD_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24DAUD_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S24LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_S32LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U8_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U8_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U16LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U24LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32BE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32BE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32LE_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_U32LE_ENCODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_ZORK_DECODER) += pcm.c
AVCODEC_C_FILES-$(CONFIG_PCM_ZORK_ENCODER) += pcm.c
 
AVCODEC_C_FILES-$(CONFIG_ADPCM_4XM_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_ADX_DECODER) += adxdec.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_ADX_ENCODER) += adxenc.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_CT_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_MAXIS_XA_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_R1_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_R2_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_R3_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_EA_XAS_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_G726_DECODER) += g726.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_G726_ENCODER) += g726.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_AMV_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_DK3_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_DK4_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_EA_EACS_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_EA_SEAD_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_ISS_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_QT_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_QT_ENCODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_SMJPEG_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_WAV_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_WAV_ENCODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_IMA_WS_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_MS_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_MS_ENCODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SBPRO_2_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SBPRO_3_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SBPRO_4_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SWF_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_SWF_ENCODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_THP_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_XA_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_YAMAHA_DECODER) += adpcm.c
AVCODEC_C_FILES-$(CONFIG_ADPCM_YAMAHA_ENCODER) += adpcm.c
 
AVCODEC_C_FILES-$(CONFIG_ADTS_MUXER) += mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_CAF_DEMUXER) += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_DV_DEMUXER) += dvdata.c
AVCODEC_C_FILES-$(CONFIG_DV_MUXER) += dvdata.c
AVCODEC_C_FILES-$(CONFIG_FLAC_DEMUXER) += flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_FLAC_MUXER) += flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_FLV_DEMUXER) += mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_GXF_DEMUXER) += mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_IFF_DEMUXER) += iff.c
AVCODEC_C_FILES-$(CONFIG_MATROSKA_AUDIO_MUXER) += xiph.c mpeg4audio.c \
flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_MATROSKA_DEMUXER) += mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_MATROSKA_MUXER) += xiph.c mpeg4audio.c \
flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_MOV_DEMUXER) += mpeg4audio.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPEGTS_MUXER) += mpegvideo.c mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_NUT_MUXER) += mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_OGG_DEMUXER) += flacdec.c flacdata.c flac.c \
dirac.c mpeg12data.c
AVCODEC_C_FILES-$(CONFIG_OGG_MUXER) += xiph.c flacdec.c flacdata.c flac.c
AVCODEC_C_FILES-$(CONFIG_RTP_MUXER) += mpegvideo.c
AVCODEC_C_FILES-$(CONFIG_WEBM_MUXER) += xiph.c mpeg4audio.c \
flacdec.c flacdata.c flac.c
 
AVCODEC_C_FILES-$(CONFIG_LIBDIRAC_DECODER) += libdiracdec.c
AVCODEC_C_FILES-$(CONFIG_LIBDIRAC_ENCODER) += libdiracenc.c libdirac_libschro.c
AVCODEC_C_FILES-$(CONFIG_LIBFAAC_ENCODER) += libfaac.c
AVCODEC_C_FILES-$(CONFIG_LIBFAAD_DECODER) += libfaad.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_DECODER) += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_ENCODER) += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_MS_DECODER) += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBGSM_MS_ENCODER) += libgsm.c
AVCODEC_C_FILES-$(CONFIG_LIBMP3LAME_ENCODER) += libmp3lame.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENCORE_AMRNB_DECODER) += libopencore-amr.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENCORE_AMRNB_ENCODER) += libopencore-amr.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENCORE_AMRWB_DECODER) += libopencore-amr.c
AVCODEC_C_FILES-$(CONFIG_LIBOPENJPEG_DECODER) += libopenjpeg.c
AVCODEC_C_FILES-$(CONFIG_LIBSCHROEDINGER_DECODER) += libschroedingerdec.c \
libschroedinger.c \
libdirac_libschro.c
AVCODEC_C_FILES-$(CONFIG_LIBSCHROEDINGER_ENCODER) += libschroedingerenc.c \
libschroedinger.c \
libdirac_libschro.c
AVCODEC_C_FILES-$(CONFIG_LIBSPEEX_DECODER) += libspeexdec.c
AVCODEC_C_FILES-$(CONFIG_LIBTHEORA_ENCODER) += libtheoraenc.c
AVCODEC_C_FILES-$(CONFIG_LIBVORBIS_ENCODER) += libvorbis.c
AVCODEC_C_FILES-$(CONFIG_LIBVPX_DECODER) += libvpxdec.c
AVCODEC_C_FILES-$(CONFIG_LIBVPX_ENCODER) += libvpxenc.c
AVCODEC_C_FILES-$(CONFIG_LIBX264_ENCODER) += libx264.c
AVCODEC_C_FILES-$(CONFIG_LIBXVID_ENCODER) += libxvidff.c libxvid_rc.c
 
AVCODEC_C_FILES-$(CONFIG_AAC_PARSER) += aac_parser.c aac_ac3_parser.c \
mpeg4audio.c
AVCODEC_C_FILES-$(CONFIG_AC3_PARSER) += ac3_parser.c ac3tab.c \
aac_ac3_parser.c
AVCODEC_C_FILES-$(CONFIG_CAVSVIDEO_PARSER) += cavs_parser.c
AVCODEC_C_FILES-$(CONFIG_DCA_PARSER) += dca_parser.c
AVCODEC_C_FILES-$(CONFIG_DIRAC_PARSER) += dirac_parser.c
AVCODEC_C_FILES-$(CONFIG_DNXHD_PARSER) += dnxhd_parser.c
AVCODEC_C_FILES-$(CONFIG_DVBSUB_PARSER) += dvbsub_parser.c
AVCODEC_C_FILES-$(CONFIG_DVDSUB_PARSER) += dvdsub_parser.c
AVCODEC_C_FILES-$(CONFIG_H261_PARSER) += h261_parser.c
AVCODEC_C_FILES-$(CONFIG_H263_PARSER) += h263_parser.c
AVCODEC_C_FILES-$(CONFIG_H264_PARSER) += h264_parser.c h264.c \
cabac.c \
h264_refs.c h264_sei.c h264_direct.c \
h264_loopfilter.c h264_cabac.c \
h264_cavlc.c h264_ps.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_MJPEG_PARSER) += mjpeg_parser.c
AVCODEC_C_FILES-$(CONFIG_MLP_PARSER) += mlp_parser.c mlp.c
AVCODEC_C_FILES-$(CONFIG_MPEG4VIDEO_PARSER) += mpeg4video_parser.c h263.c \
mpegvideo.c error_resilience.c \
mpeg4videodec.c mpeg4video.c \
ituh263dec.c h263dec.c
AVCODEC_C_FILES-$(CONFIG_MPEGAUDIO_PARSER) += mpegaudio_parser.c \
mpegaudiodecheader.c mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_MPEGVIDEO_PARSER) += mpegvideo_parser.c \
mpeg12.c mpeg12data.c \
mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_PNM_PARSER) += pnm_parser.c pnm.c
AVCODEC_C_FILES-$(CONFIG_VC1_PARSER) += vc1_parser.c vc1.c vc1data.c \
msmpeg4.c msmpeg4data.c mpeg4video.c \
h263.c mpegvideo.c error_resilience.c
AVCODEC_C_FILES-$(CONFIG_VP3_PARSER) += vp3_parser.c
 
AVCODEC_C_FILES-$(CONFIG_AAC_ADTSTOASC_BSF) += aac_adtstoasc_bsf.c
AVCODEC_C_FILES-$(CONFIG_DUMP_EXTRADATA_BSF) += dump_extradata_bsf.c
AVCODEC_C_FILES-$(CONFIG_H264_MP4TOANNEXB_BSF) += h264_mp4toannexb_bsf.c
AVCODEC_C_FILES-$(CONFIG_IMX_DUMP_HEADER_BSF) += imx_dump_header_bsf.c
AVCODEC_C_FILES-$(CONFIG_MJPEGA_DUMP_HEADER_BSF) += mjpega_dump_header_bsf.c
AVCODEC_C_FILES-$(CONFIG_MOV2TEXTSUB_BSF) += movsub_bsf.c
AVCODEC_C_FILES-$(CONFIG_MP3_HEADER_COMPRESS_BSF) += mp3_header_compress_bsf.c
AVCODEC_C_FILES-$(CONFIG_MP3_HEADER_DECOMPRESS_BSF) += mp3_header_decompress_bsf.c \
mpegaudiodata.c
AVCODEC_C_FILES-$(CONFIG_NOISE_BSF) += noise_bsf.c
AVCODEC_C_FILES-$(CONFIG_REMOVE_EXTRADATA_BSF) += remove_extradata_bsf.c
AVCODEC_C_FILES-$(CONFIG_TEXT2MOVSUB_BSF) += movsub_bsf.c
 
AVCODEC_C_FILES-$(HAVE_BEOSTHREADS) += beosthread.c
AVCODEC_C_FILES-$(HAVE_OS2THREADS) += os2thread.c
AVCODEC_C_FILES-$(HAVE_PTHREADS) += pthread.c
AVCODEC_C_FILES-$(HAVE_W32THREADS) += w32thread.c
 
AVCODEC_C_FILES-$(CONFIG_MLIB) += mlib/dsputil_mlib.c \
 
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
 
NEON-FILES-$(CONFIG_FFT) += arm/fft_neon.S.neon \
 
NEON-FILES-$(CONFIG_MDCT) += arm/mdct_neon.S.neon \
 
NEON-FILES-$(CONFIG_RDFT) += arm/rdft_neon.S.neon \
 
NEON-FILES-$(CONFIG_H264DSP) += arm/h264dsp_neon.S.neon \
arm/h264idct_neon.S.neon \
arm/h264pred_neon.S.neon \
 
NEON-FILES-$(CONFIG_DCA_DECODER) += arm/dcadsp_neon.S.neon \
arm/synth_filter_neon.S.neon \
 
NEON-FILES-$(CONFIG_VP3_DECODER) += arm/vp3dsp_neon.S.neon
 
NEON-FILES-$(CONFIG_VP5_DECODER) += arm/vp56dsp_neon.S.neon
NEON-FILES-$(CONFIG_VP6_DECODER) += arm/vp56dsp_neon.S.neon
 
AVCODEC_ARM_C_FILES-$(HAVE_NEON) += arm/dsputil_init_neon.c.neon.neon.neon.neon.neon.neon \
arm/dsputil_neon.S.neon \
arm/int_neon.S.neon \
arm/simple_idct_neon.S.neon \
$(NEON-FILES-yes)
 
 
AVCODEC_ARM_C_FILES += $(AVCODEC_ARM_C_FILES-yes)
 
AVCODEC_ARM_SRC_FILES = $(addprefix libavcodec/, $(sort $(AVCODEC_ARM_C_FILES)))
 
AVFORMAT_C_FILES = allformats.c \
cutils.c \
metadata.c \
metadata_compat.c \
options.c \
os_support.c \
sdp.c \
seek.c \
utils.c \
 
AVFORMAT_C_FILES-$(CONFIG_AAC_DEMUXER) += raw.c id3v1.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_AC3_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_AC3_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_ADTS_MUXER) += adtsenc.c
AVFORMAT_C_FILES-$(CONFIG_AEA_DEMUXER) += aea.c raw.c
AVFORMAT_C_FILES-$(CONFIG_AIFF_DEMUXER) += aiffdec.c riff.c raw.c
AVFORMAT_C_FILES-$(CONFIG_AIFF_MUXER) += aiffenc.c riff.c
AVFORMAT_C_FILES-$(CONFIG_AMR_DEMUXER) += amr.c
AVFORMAT_C_FILES-$(CONFIG_AMR_MUXER) += amr.c
AVFORMAT_C_FILES-$(CONFIG_ANM_DEMUXER) += anm.c
AVFORMAT_C_FILES-$(CONFIG_APC_DEMUXER) += apc.c
AVFORMAT_C_FILES-$(CONFIG_APE_DEMUXER) += ape.c apetag.c
AVFORMAT_C_FILES-$(CONFIG_ASF_DEMUXER) += asfdec.c asf.c asfcrypt.c \
riff.c avlanguage.c
AVFORMAT_C_FILES-$(CONFIG_ASF_MUXER) += asfenc.c asf.c riff.c
AVFORMAT_C_FILES-$(CONFIG_ASS_DEMUXER) += assdec.c
AVFORMAT_C_FILES-$(CONFIG_ASS_MUXER) += assenc.c
AVFORMAT_C_FILES-$(CONFIG_AU_DEMUXER) += au.c raw.c
AVFORMAT_C_FILES-$(CONFIG_AU_MUXER) += au.c
AVFORMAT_C_FILES-$(CONFIG_AVI_DEMUXER) += avidec.c riff.c avi.c
AVFORMAT_C_FILES-$(CONFIG_AVI_MUXER) += avienc.c riff.c avi.c
AVFORMAT_C_FILES-$(CONFIG_AVISYNTH) += avisynth.c
AVFORMAT_C_FILES-$(CONFIG_AVM2_MUXER) += swfenc.c
AVFORMAT_C_FILES-$(CONFIG_AVS_DEMUXER) += avs.c vocdec.c voc.c
AVFORMAT_C_FILES-$(CONFIG_BETHSOFTVID_DEMUXER) += bethsoftvid.c
AVFORMAT_C_FILES-$(CONFIG_BFI_DEMUXER) += bfi.c
AVFORMAT_C_FILES-$(CONFIG_BINK_DEMUXER) += bink.c
AVFORMAT_C_FILES-$(CONFIG_C93_DEMUXER) += c93.c vocdec.c voc.c
AVFORMAT_C_FILES-$(CONFIG_CAF_DEMUXER) += cafdec.c caf.c mov.c riff.c isom.c
AVFORMAT_C_FILES-$(CONFIG_CAVSVIDEO_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_CDG_DEMUXER) += cdg.c
AVFORMAT_C_FILES-$(CONFIG_CRC_MUXER) += crcenc.c
AVFORMAT_C_FILES-$(CONFIG_DAUD_DEMUXER) += daud.c
AVFORMAT_C_FILES-$(CONFIG_DAUD_MUXER) += daud.c
AVFORMAT_C_FILES-$(CONFIG_DIRAC_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_DIRAC_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_DNXHD_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_DNXHD_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_DSICIN_DEMUXER) += dsicin.c
AVFORMAT_C_FILES-$(CONFIG_DTS_DEMUXER) += raw.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_DTS_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_DV_DEMUXER) += dv.c
AVFORMAT_C_FILES-$(CONFIG_DV_MUXER) += dvenc.c
AVFORMAT_C_FILES-$(CONFIG_DXA_DEMUXER) += dxa.c riff.c
AVFORMAT_C_FILES-$(CONFIG_EA_CDATA_DEMUXER) += eacdata.c
AVFORMAT_C_FILES-$(CONFIG_EA_DEMUXER) += electronicarts.c
AVFORMAT_C_FILES-$(CONFIG_EAC3_DEMUXER) += raw.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_EAC3_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_FFM_DEMUXER) += ffmdec.c
AVFORMAT_C_FILES-$(CONFIG_FFM_MUXER) += ffmenc.c
AVFORMAT_C_FILES-$(CONFIG_FILMSTRIP_DEMUXER) += filmstripdec.c
AVFORMAT_C_FILES-$(CONFIG_FILMSTRIP_MUXER) += filmstripenc.c
AVFORMAT_C_FILES-$(CONFIG_FLAC_DEMUXER) += flacdec.c raw.c id3v1.c \
id3v2.c oggparsevorbis.c \
vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_FLAC_MUXER) += flacenc.c flacenc_header.c \
vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_FLIC_DEMUXER) += flic.c
AVFORMAT_C_FILES-$(CONFIG_FLV_DEMUXER) += flvdec.c
AVFORMAT_C_FILES-$(CONFIG_FLV_MUXER) += flvenc.c avc.c
AVFORMAT_C_FILES-$(CONFIG_FOURXM_DEMUXER) += 4xm.c
AVFORMAT_C_FILES-$(CONFIG_FRAMECRC_MUXER) += framecrcenc.c
AVFORMAT_C_FILES-$(CONFIG_GIF_MUXER) += gif.c
AVFORMAT_C_FILES-$(CONFIG_GSM_DEMUXER) += raw.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_GXF_DEMUXER) += gxf.c
AVFORMAT_C_FILES-$(CONFIG_GXF_MUXER) += gxfenc.c audiointerleave.c
AVFORMAT_C_FILES-$(CONFIG_H261_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_H261_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_H263_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_H263_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_H264_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_H264_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_IDCIN_DEMUXER) += idcin.c
AVFORMAT_C_FILES-$(CONFIG_IFF_DEMUXER) += iff.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2_DEMUXER) += img2.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2_MUXER) += img2.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2PIPE_DEMUXER) += img2.c
AVFORMAT_C_FILES-$(CONFIG_IMAGE2PIPE_MUXER) += img2.c
AVFORMAT_C_FILES-$(CONFIG_INGENIENT_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_IPMOVIE_DEMUXER) += ipmovie.c
AVFORMAT_C_FILES-$(CONFIG_ISS_DEMUXER) += iss.c
AVFORMAT_C_FILES-$(CONFIG_IV8_DEMUXER) += iv8.c
AVFORMAT_C_FILES-$(CONFIG_LMLM4_DEMUXER) += lmlm4.c
AVFORMAT_C_FILES-$(CONFIG_M4V_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_M4V_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MATROSKA_DEMUXER) += matroskadec.c matroska.c \
riff.c isom.c rmdec.c rm.c
AVFORMAT_C_FILES-$(CONFIG_MATROSKA_MUXER) += matroskaenc.c matroska.c \
riff.c isom.c avc.c \
flacenc_header.c
AVFORMAT_C_FILES-$(CONFIG_MJPEG_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MJPEG_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MLP_DEMUXER) += raw.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_MLP_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MM_DEMUXER) += mm.c
AVFORMAT_C_FILES-$(CONFIG_MMF_DEMUXER) += mmf.c raw.c
AVFORMAT_C_FILES-$(CONFIG_MMF_MUXER) += mmf.c riff.c
AVFORMAT_C_FILES-$(CONFIG_MOV_DEMUXER) += mov.c riff.c isom.c
AVFORMAT_C_FILES-$(CONFIG_MOV_MUXER) += movenc.c riff.c isom.c avc.c movenchint.c
AVFORMAT_C_FILES-$(CONFIG_MP2_MUXER) += mp3.c id3v1.c
AVFORMAT_C_FILES-$(CONFIG_MP3_DEMUXER) += mp3.c id3v1.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_MP3_MUXER) += mp3.c id3v1.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_MPC_DEMUXER) += mpc.c id3v1.c id3v2.c apetag.c
AVFORMAT_C_FILES-$(CONFIG_MPC8_DEMUXER) += mpc8.c
AVFORMAT_C_FILES-$(CONFIG_MPEG1SYSTEM_MUXER) += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG1VCD_MUXER) += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2DVD_MUXER) += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2VOB_MUXER) += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2SVCD_MUXER) += mpegenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEG1VIDEO_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MPEG2VIDEO_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MPEGPS_DEMUXER) += mpeg.c
AVFORMAT_C_FILES-$(CONFIG_MPEGTS_DEMUXER) += mpegts.c
AVFORMAT_C_FILES-$(CONFIG_MPEGTS_MUXER) += mpegtsenc.c adtsenc.c
AVFORMAT_C_FILES-$(CONFIG_MPEGVIDEO_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_MPJPEG_MUXER) += mpjpeg.c
AVFORMAT_C_FILES-$(CONFIG_MSNWC_TCP_DEMUXER) += msnwc_tcp.c
AVFORMAT_C_FILES-$(CONFIG_MTV_DEMUXER) += mtv.c
AVFORMAT_C_FILES-$(CONFIG_MVI_DEMUXER) += mvi.c
AVFORMAT_C_FILES-$(CONFIG_MXF_DEMUXER) += mxfdec.c mxf.c
AVFORMAT_C_FILES-$(CONFIG_MXF_MUXER) += mxfenc.c mxf.c audiointerleave.c
AVFORMAT_C_FILES-$(CONFIG_NC_DEMUXER) += ncdec.c
AVFORMAT_C_FILES-$(CONFIG_NSV_DEMUXER) += nsvdec.c
AVFORMAT_C_FILES-$(CONFIG_NULL_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_NUT_DEMUXER) += nutdec.c nut.c riff.c
AVFORMAT_C_FILES-$(CONFIG_NUT_MUXER) += nutenc.c nut.c riff.c
AVFORMAT_C_FILES-$(CONFIG_NUV_DEMUXER) += nuv.c riff.c
AVFORMAT_C_FILES-$(CONFIG_OGG_DEMUXER) += oggdec.c \
oggparsedirac.c \
oggparseflac.c \
oggparseogm.c \
oggparseskeleton.c \
oggparsespeex.c \
oggparsetheora.c \
oggparsevorbis.c \
riff.c \
vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_OGG_MUXER) += oggenc.c \
vorbiscomment.c
AVFORMAT_C_FILES-$(CONFIG_OMA_DEMUXER) += oma.c raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_ALAW_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_ALAW_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F32LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_F64LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_MULAW_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_MULAW_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S16LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S24LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S32LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S8_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_S8_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U16LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U24LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32BE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32BE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32LE_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U32LE_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U8_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PCM_U8_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_PVA_DEMUXER) += pva.c
AVFORMAT_C_FILES-$(CONFIG_QCP_DEMUXER) += qcp.c
AVFORMAT_C_FILES-$(CONFIG_R3D_DEMUXER) += r3d.c
AVFORMAT_C_FILES-$(CONFIG_RAWVIDEO_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_RAWVIDEO_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_RL2_DEMUXER) += rl2.c
AVFORMAT_C_FILES-$(CONFIG_RM_DEMUXER) += rmdec.c rm.c
AVFORMAT_C_FILES-$(CONFIG_RM_MUXER) += rmenc.c rm.c
AVFORMAT_C_FILES-$(CONFIG_ROQ_DEMUXER) += idroq.c
AVFORMAT_C_FILES-$(CONFIG_ROQ_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_RPL_DEMUXER) += rpl.c
AVFORMAT_C_FILES-$(CONFIG_RTP_MUXER) += rtp.c \
rtpenc_aac.c \
rtpenc_amr.c \
rtpenc_h263.c \
rtpenc_mpv.c \
rtpenc.c \
rtpenc_h264.c \
avc.c
AVFORMAT_C_FILES-$(CONFIG_RTSP_DEMUXER) += rtsp.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_RTSP_MUXER) += rtsp.c rtspenc.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_SDP_DEMUXER) += rtsp.c \
rdt.c \
rtp.c \
rtpdec.c \
rtpdec_amr.c \
rtpdec_asf.c \
rtpdec_h263.c \
rtpdec_h264.c \
rtpdec_xiph.c
AVFORMAT_C_FILES-$(CONFIG_SEGAFILM_DEMUXER) += segafilm.c
AVFORMAT_C_FILES-$(CONFIG_SHORTEN_DEMUXER) += raw.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_SIFF_DEMUXER) += siff.c
AVFORMAT_C_FILES-$(CONFIG_SMACKER_DEMUXER) += smacker.c
AVFORMAT_C_FILES-$(CONFIG_SOL_DEMUXER) += sol.c raw.c
AVFORMAT_C_FILES-$(CONFIG_SOX_DEMUXER) += soxdec.c raw.c
AVFORMAT_C_FILES-$(CONFIG_SOX_MUXER) += soxenc.c
AVFORMAT_C_FILES-$(CONFIG_SPDIF_MUXER) += spdif.c
AVFORMAT_C_FILES-$(CONFIG_STR_DEMUXER) += psxstr.c
AVFORMAT_C_FILES-$(CONFIG_SWF_DEMUXER) += swfdec.c
AVFORMAT_C_FILES-$(CONFIG_SWF_MUXER) += swfenc.c
AVFORMAT_C_FILES-$(CONFIG_THP_DEMUXER) += thp.c
AVFORMAT_C_FILES-$(CONFIG_TIERTEXSEQ_DEMUXER) += tiertexseq.c
AVFORMAT_C_FILES-$(CONFIG_TMV_DEMUXER) += tmv.c
AVFORMAT_C_FILES-$(CONFIG_TRUEHD_DEMUXER) += raw.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_TRUEHD_MUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_TTA_DEMUXER) += tta.c id3v1.c id3v2.c
AVFORMAT_C_FILES-$(CONFIG_TXD_DEMUXER) += txd.c
AVFORMAT_C_FILES-$(CONFIG_VC1_DEMUXER) += raw.c
AVFORMAT_C_FILES-$(CONFIG_VC1T_DEMUXER) += vc1test.c
AVFORMAT_C_FILES-$(CONFIG_VC1T_MUXER) += vc1testenc.c
AVFORMAT_C_FILES-$(CONFIG_VMD_DEMUXER) += sierravmd.c
AVFORMAT_C_FILES-$(CONFIG_VOC_DEMUXER) += vocdec.c voc.c
AVFORMAT_C_FILES-$(CONFIG_VOC_MUXER) += vocenc.c voc.c
AVFORMAT_C_FILES-$(CONFIG_VQF_DEMUXER) += vqf.c
AVFORMAT_C_FILES-$(CONFIG_W64_DEMUXER) += wav.c riff.c raw.c
AVFORMAT_C_FILES-$(CONFIG_WAV_DEMUXER) += wav.c riff.c raw.c
AVFORMAT_C_FILES-$(CONFIG_WAV_MUXER) += wav.c riff.c
AVFORMAT_C_FILES-$(CONFIG_WC3_DEMUXER) += wc3movie.c
AVFORMAT_C_FILES-$(CONFIG_WEBM_MUXER) += matroskaenc.c matroska.c \
riff.c isom.c avc.c \
flacenc_header.c
AVFORMAT_C_FILES-$(CONFIG_WSAUD_DEMUXER) += westwood.c
AVFORMAT_C_FILES-$(CONFIG_WSVQA_DEMUXER) += westwood.c
AVFORMAT_C_FILES-$(CONFIG_WV_DEMUXER) += wv.c apetag.c id3v1.c
AVFORMAT_C_FILES-$(CONFIG_XA_DEMUXER) += xa.c
AVFORMAT_C_FILES-$(CONFIG_YOP_DEMUXER) += yop.c
AVFORMAT_C_FILES-$(CONFIG_YUV4MPEGPIPE_MUXER) += yuv4mpeg.c
AVFORMAT_C_FILES-$(CONFIG_YUV4MPEGPIPE_DEMUXER) += yuv4mpeg.c
 
AVFORMAT_C_FILES-$(CONFIG_LIBNUT_DEMUXER) += libnut.c riff.c
AVFORMAT_C_FILES-$(CONFIG_LIBNUT_MUXER) += libnut.c riff.c
 
AVFORMAT_C_FILES+= avio.c aviobuf.c
 
AVFORMAT_C_FILES-$(CONFIG_FILE_PROTOCOL) += file.c
AVFORMAT_C_FILES-$(CONFIG_GOPHER_PROTOCOL) += gopher.c
AVFORMAT_C_FILES-$(CONFIG_HTTP_PROTOCOL) += http.c httpauth.c
AVFORMAT_C_FILES-$(CONFIG_PIPE_PROTOCOL) += file.c
 
RTMP-FILES-$(CONFIG_LIBRTMP) = librtmp.c
RTMP-FILES-$(!CONFIG_LIBRTMP) = rtmpproto.c rtmppkt.c
AVFORMAT_C_FILES-$(CONFIG_RTMP_PROTOCOL) += $(RTMP-FILES-yes)
 
AVFORMAT_C_FILES-$(CONFIG_RTP_PROTOCOL) += rtpproto.c
AVFORMAT_C_FILES-$(CONFIG_TCP_PROTOCOL) += tcp.c
AVFORMAT_C_FILES-$(CONFIG_UDP_PROTOCOL) += udp.c
AVFORMAT_C_FILES-$(CONFIG_CONCAT_PROTOCOL) += concat.c
 
AVFORMAT_C_FILES-$(CONFIG_JACK_INDEV) += timefilter.c
 
AVFORMAT_C_FILES += $(AVFORMAT_C_FILES-yes)
 
AVFORMAT_SRC_FILES = $(addprefix libavformat/, $(sort $(AVFORMAT_C_FILES)))
 
SWSCALE_C_FILES = options.c rgb2rgb.c swscale.c utils.c yuv2rgb.c
 
LOCAL_SRC_FILES := \
$(AVUTIL_SRC_FILES) \
$(AVCODEC_SRC_FILES) \
$(AVCODEC_ARM_SRC_FILES) \
$(AVFORMAT_SRC_FILES)
 
LOCAL_ARM_MODE := arm
 
include $(BUILD_SHARED_LIBRARY)

