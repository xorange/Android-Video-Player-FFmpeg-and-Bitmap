package sysu.ss.xu;

import android.util.Log;

public class FFmpeg {
	
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
	public native void avRegisterAll();
	public native boolean avOpenInputFile(String filePath);
	public native boolean avFindStreamInfo();
	public native boolean findVideoStream();
	public native boolean avcodecFindDecoder();
	public native boolean avcodecOpen();
	public native void avcodecAllocFrame();
	
	// functional call
	public native String getCodecName();
	public native int getWidth();
	public native int getHeight();
	public native int getBitRate();
	public native boolean allocateBuffer();
	public native byte[] getNextDecodedFrame();
	

	public void playFile(String filePath) {
		// TODO Auto-generated method stub
		
		init(filePath);
		
		getNextDecodedFrame();
		
		
	}
	
	private void init(String filePath) {
		avRegisterAll();
        if( avOpenInputFile(filePath) )
        	Log.i("ff", "success open");
        else {
        	Log.i("ff", "failed open");
        	return;
        }
        
        if( avFindStreamInfo() )
        	Log.i("ff", "success find stream info");
        else {
        	Log.i("ff", "failed find stream info");
        	return;
        }
        
        if( findVideoStream() )
        	Log.i("ff", "success find stream");
        else {
        	Log.i("ff", "failed find stream");
        	return;
        }
        
        if( avcodecFindDecoder() )
        	Log.i("ff", "success find decoder");
        else {
        	Log.i("ff", "failed find decoder");
        	return;
        }
        
    	if( avcodecOpen() )
    		Log.i("ff", "success codec open");
        else {
        	Log.i("ff", "failed codec open");
        	return;
        }    	
    	Log.i("ff", getCodecName());
    	
    	avcodecAllocFrame();
    	
    	if( allocateBuffer() )
    		Log.i("ff", "success allocate buffer");
    	else {
    		Log.i("ff", "failed allocate buffer");
    		return;
    	}
	}
	
	public void openFile(String filePath) {
		init(filePath);
	}

}
