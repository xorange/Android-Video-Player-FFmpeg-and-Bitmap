package sysu.ss.xu;

import java.nio.ByteBuffer;

import sysu.ss.xu.PlayerActivity.PlayerView;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;

public class PlayerActivity extends Activity {
	
	private PlayerView playerView;
	
	public void onCreate(android.os.Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		DisplayMetrics dm = new DisplayMetrics();  
		this.getWindowManager().getDefaultDisplay().getMetrics(dm);
		playerView = new PlayerView(this, dm.widthPixels, dm.heightPixels);
	    setContentView(playerView);
	    
	    playerView.setContext(this);
	    
	    Bundle bundle = getIntent().getExtras();
	    playerView.play(bundle.getString("filePath"));
	}

	
	class PlayerView extends View implements Runnable {     	  
    	
        private Bitmap bitmap;
		private Paint p;
		private FFmpeg ff;
		private int width;
		private int height;
		private byte[] nativePixels;
		private ByteBuffer buffer;
		private int displayWidth;
		private int displayHeight;
		private PlayerActivity playerActivity;

		public PlayerView(Context context, int DisplayWidth, int DisplayHeight) {  
            super(context);
            
            this.displayWidth = DisplayWidth; 
            this.displayHeight = DisplayHeight;
            p = new Paint();
        }
        
		public void setContext(PlayerActivity playerActivity) {
			this.playerActivity = playerActivity;
		}

		public void play(String filePath) {
			Log.i("playerView", "to play: " + filePath);
			
			ff = FFmpeg.getInstance();
			ff.openFile(filePath);
	        width = ff.getWidth();
	        height = ff.getHeight();
	        
	        /* adjust orientation */
	        if(width > height) {
	        	playerActivity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
	        	ff.setScreenSize(displayHeight, displayWidth);
	        }
	        ff.setScreenSize(displayWidth, displayHeight);
	        
	        ff.prepareResources();
	        
	        bitmap = Bitmap.createBitmap(displayWidth, displayHeight, Bitmap.Config.RGB_565);
	        
	        /* 开启线程 */  
	        new Thread(this).start();
		}

		public void onDraw(Canvas canvas){
        	super.onDraw(canvas);  
        	
//        	canvas.drawColor(Color.GREEN);
        	
        	nativePixels = ff.getNextDecodedFrame();
        	if(nativePixels != null) {
        		buffer = ByteBuffer.wrap(nativePixels);
            	bitmap.copyPixelsFromBuffer(buffer);
        	}        	
        	
            canvas.drawBitmap(bitmap, 0, 0, p);
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
