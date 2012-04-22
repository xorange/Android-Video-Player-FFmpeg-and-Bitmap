package sysu.ss.xu;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.text.SpannableString;
import android.text.InputFilter.LengthFilter;
import android.text.style.ImageSpan;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class FileBrowser {

	private Activity activity;
	private LayoutInflater inflater;
	private String path;
	private String[] items;
	private LinearLayout browseFilePanel;
	private boolean selected;
	private int selectedIndex;
	
	private final int falseColor = Color.BLUE;
	private final int trueColor = Color.RED;
	private Drawable selectedIcon;
	private FFmpeg ffmpeg;
	private boolean isMediaFile;
	protected String codecName;
	protected int width;
	protected int height;
	protected String toastString;

	public FileBrowser(Activity activity) {
		this.activity = activity;
		inflater = activity.getLayoutInflater();
		browseFilePanel = (LinearLayout) activity.findViewById(R.id.browseFilePanel);
		
		selected = false;
		selectedIndex = -1;
		selectedIcon = activity.getResources().getDrawable(R.drawable.question_red);
		ffmpeg = FFmpeg.getInstance();
	}

	public void setItems(String path, String[] items) {
		this.path = path;
		this.items = items;
	}

	public void show() {
		clearViews();
		pack();
	}

	private void pack() {
		
		/* init */
		int length = items.length;
		LinearLayout fileView[] = new LinearLayout[length];
		
		/* pack */
		for (int index = 0; index < length; index++) {
			fileView[index] = (LinearLayout) inflater.inflate(R.layout.file, null).findViewById(R.id.fileView);
			
			/* textview[0] */
			TextView fileFlag = (TextView) fileView[index].getChildAt(0);
			fileFlag.setBackgroundColor(falseColor);
			
			/* textview[1] */
			TextView text = (TextView) fileView[index].getChildAt(1);
			text.setText(items[index]);
			
			if( ffmpeg.isMediaFile( path + "/" + items[index] ) )
				isMediaFile = true;
			else
				isMediaFile = false;
			addSelectEventListener(text, index, fileView, isMediaFile);
			if( isMediaFile == true ) {
				addQueryEventListener(fileFlag, text, index);
			}
			browseFilePanel.addView(fileView[index]);
		}
	}

	private void addQueryEventListener(TextView fileFlag, final TextView text, final int index) {
		fileFlag.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				String filePath = path + "/" + items[index];
				
				ffmpeg.openFile(filePath);
				codecName = ffmpeg.getCodecName();
				width = ffmpeg.getWidth();
				height = ffmpeg.getHeight();
				ffmpeg.cleanUp();
				
				toastString = "Codec: " + codecName + "  Width: " + width + "  Height: " + height;
			
				Toast.makeText(activity, toastString, Toast.LENGTH_LONG);
				text.setText(toastString);
				
			}
		});
	}

	private void addSelectEventListener(final TextView text, final int index, final LinearLayout[] fileView, final boolean isSelectedMediaFile) {
		text.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if(selected == true) {
					fileView[selectedIndex].getChildAt(0).setBackgroundColor(falseColor);
					( (TextView) fileView[selectedIndex].getChildAt(1) ).setText(items[selectedIndex]);
					
					selected = false;
					selectedIndex = -1;
				}
				
				fileView[index].getChildAt(0).setBackgroundColor(trueColor);
		        
				if( isSelectedMediaFile == true ) {
					fileView[index].getChildAt(0).setBackgroundDrawable(selectedIcon);
				}
		        
				
				
				
				selected = true;
				selectedIndex = index;
			}
		});
	}

	private void clearViews() {
		browseFilePanel.removeAllViews();
	}

	public String getSelectedItem() {
		return items[selectedIndex];
	}

	public String getPath() {
		return path;
	}

	public void clear() {
		selected = false;
		selectedIndex = -1;
	}

	public boolean hasSelected() {
		return selected;
	}

}
