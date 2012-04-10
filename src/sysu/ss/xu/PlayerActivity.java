package sysu.ss.xu;

import java.nio.ByteBuffer;
import java.nio.ShortBuffer;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.TextView;
import android.graphics.drawable.Drawable;

public class PlayerActivity extends Activity {
	

	/** Called when the activity is first created. */
    @Override    
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
//        test();
        
        DisplayMetrics dm = new DisplayMetrics();  
        this.getWindowManager().getDefaultDisplay().getMetrics(dm);
        setContentView(new PlayerView(this, dm.widthPixels, dm.heightPixels));
        
        
    }
    
    
    private void test() {
    	FFmpeg ff = new FFmpeg();
        
        
        ff.openFile("/mnt/sdcard/mpeg2.m2v");
        int width = ff.getWidth();
        int height = ff.getHeight();
        int bitrate = ff.getBitRate();
        
        Log.i("main", "w " + width);
        Log.i("main", "h " + height);
        Log.i("main", "br " + bitrate);
        int linesize = width * height;
        byte[] pixels = ff.getNextDecodedFrame();
	}


	class PlayerView extends View implements Runnable {     	  
    	
        private Bitmap bitmap;
		private Paint p;
		private FFmpeg ff;
		private int width;
		private int height;
		private int bitmapWidth;
		private byte[] nativePixels;
		private int[] pixels;
		private ByteBuffer buffer;


		public PlayerView(Context context, int DisplayWidth, int DisplayHeight) {  
            super(context);
            
            //b = BitmapFactory.decodeResource(this.getResources(), R.drawable.qq);
            p = new Paint();
            
//            testSetPixel();
            
            ff = new FFmpeg();
            ff.openFile("/mnt/sdcard/mpeg2.m2v");
            //ff.openFile("/mnt/sdcard/a.mp4");
            width = ff.getWidth();
            height = ff.getHeight();
            
//            bitmap = Bitmap.createBitmap(DisplayWidth, DisplayHeight, Bitmap.Config.RGB_565);
            bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
            
            Log.i("view", "ff w " + width);
            Log.i("view", "ff h " + height);
            
            nativePixels = ff.getNextDecodedFrame();
            Log.i("view", "native.length " + nativePixels.length);
            Log.i("view", "needed bytes of pixels " + (width * height * 2));
            
//            buffer = ShortBuffer.allocate(width * height);
            buffer = ByteBuffer.wrap(nativePixels);
            
//        	renderCopy();
//            testRenderCopy();
            
            bitmap.copyPixelsFromBuffer(buffer);
            
            /* 开启线程 */  
            new Thread(this).start();  
            
            Log.i("player view", "constructor");
        } 
		
        private void testRenderCopy() {
			// TODO Auto-generated method stub
        	int rIndex, gIndex, bIndex;
        	short temp;
        	rIndex = 0;
        	gIndex = width * height;
        	bIndex = width * height * 2;
        	temp = 0x0000;
        	
        	Log.i("test", "native R " + Integer.toHexString(nativePixels[rIndex]));
        	Log.i("test", "native G " + Integer.toHexString(nativePixels[gIndex]));
        	Log.i("test", "native B " + Integer.toHexString(nativePixels[bIndex]));
        	
        	temp = (short) (nativePixels[rIndex] << 11);
        	Log.i("test", Integer.toHexString(temp));
    		temp = (short) (temp | ((short) (nativePixels[gIndex] << 5)));
    		Log.i("test", Integer.toHexString(temp));
    		temp = (short) (temp | ((short) (nativePixels[bIndex])));
    		Log.i("test", Integer.toHexString(temp));
		}

		private void testSetPixel() {
        	 bitmap.setHasAlpha(true);
             
             byte r = 0;	r <<= 3;
             byte g = (byte) 255;	g <<= 2;
             byte b = 0;	b <<= 3;
             int pixelValue=Color.argb(255, r, g, b);
             for(int j = 0; j < 30; j++)
             {
             	for(int i = 0; i < 30; i++) {
             		bitmap.setPixel(30 + i, 30 + j, pixelValue);
                 }
             }
		}
        
		public void onDraw(Canvas canvas){
        	super.onDraw(canvas);  
        	
        	canvas.drawColor(Color.GREEN);
        	
        	nativePixels = ff.getNextDecodedFrame();
        	buffer = ByteBuffer.wrap(nativePixels);
        	bitmap.copyPixelsFromBuffer(buffer);
        	
            canvas.drawBitmap(bitmap, 0, 0, p);
        	
        	
        }
        
        
        private void renderCopy() {
			//TODO
        	int rIndex, gIndex, bIndex;
        	short temp;
        	rIndex = 0;
        	gIndex = width * height;
        	bIndex = width * height * 2;
        	temp = 0x0000;
        	
        	buffer.rewind();
        	for(int loop = 0; loop < buffer.capacity(); loop++) {
        		temp = (short) (nativePixels[rIndex] << 11);
        		temp = (short) (temp | ((short) (nativePixels[gIndex] << 5)));
        		temp = (short) (temp | ((short) (nativePixels[bIndex])));
//        		buffer.put( temp );
        		
        		++rIndex;
        		++gIndex;
        		++bIndex;
        	}
        	buffer.rewind();
		}
		public void run() {  
            while (!Thread.currentThread().isInterrupted()) {  
                try {  
                    Thread.sleep(100);  
                } catch (InterruptedException e) {  
                    Thread.currentThread().interrupt();  
                }  
                // 使用 postInvalidate 可以直接在线程中更新界面  
                postInvalidate();  
            }  
        }
    }
}