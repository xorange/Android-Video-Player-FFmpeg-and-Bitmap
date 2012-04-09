package sysu.ss.xu;

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
        
      
        
//        TextView  tv = new TextView(this);
//        setContentView(tv);
//        
        FFmpeg ff = new FFmpeg();
        
        
        ff.openFile("/mnt/sdcard/ipod.m4v");
        int width = ff.getWidth();
        int height = ff.getHeight();
        int bitrate = ff.getBitRate();
        
        Log.i("main", "w " + width);
        Log.i("main", "h " + height);
        Log.i("main", "br " + bitrate);
        byte[] pixels = ff.getNextDecodedFrame();
        Log.i("main", "" + pixels.length);
		Log.i("main", "0 " + pixels[0]);
		Log.i("main", "1 " + pixels[width * height]);
		Log.i("main", "2 " + pixels[width * height * 2]);
        
        
        
        
        
        
        //setContentView(R.layout.main);
//        DisplayMetrics dm = new DisplayMetrics();  
//        this.getWindowManager().getDefaultDisplay().getMetrics(dm);
//        setContentView(new PlayerView(this, dm.widthPixels, dm.heightPixels));
//        DisplayMetrics dm = new DisplayMetrics();  
//        this.getWindowManager().getDefaultDisplay().getMetrics(dm);
//        gv = new GameView(this,dm.widthPixels,dm.heightPixels);  
//        setContentView(gv);  
    }
    
    
    class PlayerView extends View implements Runnable {     	  
    	
        private Bitmap bitmap;
		private Paint p;
		private FFmpeg ff;
		private int width;
		private int height;
		private int bitrate;
		private int[] framePixels;
		private int bitmapWidth;


		public PlayerView(Context context, int DisplayWidth, int DisplayHeight) {  
            super(context);
            
            bitmap = Bitmap.createBitmap(DisplayWidth, DisplayHeight, Bitmap.Config.RGB_565);
            //b = BitmapFactory.decodeResource(this.getResources(), R.drawable.qq);
            p = new Paint();
            
            Log.i("pp", "w: " + DisplayWidth + " h: " + DisplayHeight);

            bitmapWidth = bitmap.getWidth();
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
            
            ff = new FFmpeg();
            ff.openFile("/mnt/sdcard/ipod.m4v");
            width = ff.getWidth();
            height = ff.getHeight();
            bitrate = ff.getBitRate();
            
            Log.i("bm", "w " + width);
            Log.i("bm", "h " + height);
            Log.i("bm", "br " + bitrate);
            
            /* 开启线程 */  
            new Thread(this).start();  
            
            Log.i("player view", "constructor");
        }      
        public void onDraw(Canvas canvas){
        	super.onDraw(canvas);  
        	
        	canvas.drawColor(Color.RED);
        	
        	//framePixels = ff.getNextDecodedFrame();
        	ff.getNextDecodedFrame();
        	//bitmap.setPixels(framePixels, 0, bitmapWidth, 0, 0, width, height);
            
            //canvas.drawBitmap(bitmap, 0, 0, p);
        	
        	
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