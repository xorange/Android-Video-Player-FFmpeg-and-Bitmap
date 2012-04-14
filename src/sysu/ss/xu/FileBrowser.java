package sysu.ss.xu;

import android.app.Activity;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.LinearLayout;
import android.widget.TextView;

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

	public FileBrowser(Activity activity) {
		this.activity = activity;
		inflater = activity.getLayoutInflater();
		browseFilePanel = (LinearLayout) activity.findViewById(R.id.browseFilePanel);
		
		selected = false;
		selectedIndex = -1;
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
			
			TextView fileFlag = (TextView) fileView[index].getChildAt(0);
			fileFlag.setBackgroundColor(falseColor);
			
			TextView text = (TextView) fileView[index].getChildAt(1);
			text.setText(items[index]);
			addListener(text, index, fileView);
			browseFilePanel.addView(fileView[index]);
		}
	}

	private void addListener(TextView text, final int index, final LinearLayout[] fileView) {
		text.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if(selected == true) {
					fileView[selectedIndex].getChildAt(0).setBackgroundColor(falseColor);
					
					selected = false;
					selectedIndex = -1;
				}
								
				fileView[index].getChildAt(0).setBackgroundColor(trueColor);
				
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
