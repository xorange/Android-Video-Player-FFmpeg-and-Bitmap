package sysu.ss.xu;

import android.util.Log;

public class FFmpeg {
	
	private static FFmpeg singleton;
	
	static {
    	System.loadLibrary("ffmpeg");
        System.loadLibrary("pack");
    }
	
	// hello world
	public native static String stringFromJNI();
	// test if global variables shared value in different Java calls
	public native void nativeTest();
	// test. //ok
	public native int[] jniIntArray();
	
	public native String play(String filePath);
	
	// ffmpeg api
	private native void avRegisterAll();
	private native boolean avOpenInputFile(String filePath);
	private native boolean avFindStreamInfo();
	private native boolean findVideoStream();
	private native boolean avcodecFindDecoder();
	private native boolean avcodecOpen();
	private native void avcodecAllocFrame();
	private native void avFree();	  
	private native void avcodecClose();	  
	private native void avCloseInputFile();
	
	// functional call
	public native String getCodecName();
	public native int getWidth();
	public native int getHeight();
	public native int getBitRate();
	public native boolean allocateBuffer();
	public native void setScreenSize(int sWidth, int sHeight);
	public native byte[] getNextDecodedFrame();
	
	private FFmpeg() {
		avRegisterAll();
	}
	
	public static FFmpeg getInstance() {
		if( singleton == null )
			singleton = new FFmpeg();
		
		return singleton;
	}
	

	public void playFile(String filePath) {
		// TODO Auto-generated method stub
		
		init(filePath);
		
		getNextDecodedFrame();
		
		
	}
	
	private boolean init(String filePath) {
		
        if( avOpenInputFile(filePath) )
        	Log.i("ff", "success open");
        else {
        	Log.i("ff", "failed open");
        	return false;
        }
        
        if( avFindStreamInfo() )
        	Log.i("ff", "success find stream info");
        else {
        	Log.i("ff", "failed find stream info");
        	return false;
        }
        
        if( findVideoStream() )
        	Log.i("ff", "success find stream");
        else {
        	Log.i("ff", "failed find stream");
        	return false;
        }
        
        if( avcodecFindDecoder() )
        	Log.i("ff", "success find decoder");
        else {
        	Log.i("ff", "failed find decoder");
        	return false;
        }
        
    	if( avcodecOpen() )
    		Log.i("ff", "success codec open");
        else {
        	Log.i("ff", "failed codec open");
        	return false;
        }    	
    	Log.i("ff", getCodecName());
    	
    	return true;
	}
	
	public void cleanUp() {
		avFree();	  
		avcodecClose();	  
		avCloseInputFile();
	}
	
	public boolean openFile(String filePath) {
		return init(filePath);
	}
	
	public boolean isMediaFile(String filePath) {
		avRegisterAll();
        if( avOpenInputFile(filePath) ) {
        	avCloseInputFile();
        	return true;
        }
        else
        	return false;
	}
	public void prepareResources() {
		avcodecAllocFrame();
    	
    	allocateBuffer();
	}

}
