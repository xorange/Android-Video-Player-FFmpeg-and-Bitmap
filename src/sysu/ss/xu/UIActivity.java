package sysu.ss.xu;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.ShortBuffer;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Environment;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import android.graphics.drawable.Drawable;


/**
 * TODO:
 * file info
 * 
 * @author Oliver Z.Q. Xu
 *
 */
public class UIActivity extends Activity {
	

	private FileBrowser browser;
	private FFmpeg ffmpeg;
	private UIActivity context;
	private PlayerActivity player;


	/** Called when the activity is first created. */
    @Override    
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        this.setContentView(R.layout.main);
        
        context = this;
        browser = new FileBrowser(this);
        ffmpeg = FFmpeg.getInstance();
        
       
        player = new PlayerActivity();
        
        openUI();
        
        Button ok = (Button) findViewById(R.id.playButton);
        ok.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				
				if( !browser.hasSelected() ) {
					Toast.makeText(context, "Please select an item and click OK.", Toast.LENGTH_SHORT).show();
					return;
				}
				
				String path = browser.getPath();
				String item = browser.getSelectedItem();
				
				if(browser.hasSelected()) {
					
					if (item == "...") {
		    			 browseFiles( addUpperDirectory(path) );
		    		 }
		    		 else if ( isFile( path + "/" + item ) ) {
		    			 if( ffmpeg.isMediaFile( path + "/" + item ) ) {
		    				 play( path + "/" + item );
		    			 }
		    		 }
		    		 else {
			    		 browseFiles( path + "/" + item );
		    		 }
				}				 
			}

			private void play(String filePath) {				
				Intent intent = new Intent(UIActivity.this, PlayerActivity.class);
				intent.putExtra("filePath", filePath);
				startActivity(intent);
			}
		});
        
    }

	private void openUI() {
		String path = Environment.getExternalStorageDirectory().getAbsolutePath();
		
		browseFiles(path);
	}

	
	private void browseFiles(String path) {
		final String[] items = getPathItems(path);
    	
		browser.clear();
    	browser.setItems(path, items);
    	browser.show();
	}

	private String[] getPathItems(String path) {
		String[] transItems = new String[1000];
    	File directoryFile = new File(path);
    	File[] file = directoryFile.listFiles();
    	
    	int i = 1;
    	boolean isRootDirectory = isRoot(path);
    	if(isRootDirectory) {
    		i = 0;
    	}
    	else {
    		transItems[0] = "...";
    	}
    	
    	for(File mCurrentFile:file) {
    		if(i >= 100) {
    			break;
    		}
    		transItems[i]=mCurrentFile.getName();
    		i++;
    	}
    	
    	String[] transItems_1 = new String[i];
    	int j= 0;
    	for(j = 0 ; j < i;j++) {
    		transItems_1[j] = transItems[j];
    	}
    	
    	return transItems_1;
	}

	private String addUpperDirectory(String filePath) {
		int i = filePath.lastIndexOf("/");
    	if(i == 0) {
    		return "is root";
    	}
    	return filePath.substring(0, i);
	}

	private boolean isRoot(String filePath) {
		if(addUpperDirectory(filePath)=="is root") {
    		return true;
    	}
    	return false;
	}
	
	private boolean isFile(String path) {
		File attemptedOpen = new File(path);
		return ( !attemptedOpen.isDirectory() );
	}

}