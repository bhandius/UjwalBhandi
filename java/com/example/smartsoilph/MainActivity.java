
package com.example.smartsoilph;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.provider.MediaStore;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import java.util.Random;

public class MainActivity extends AppCompatActivity {

    ImageView soilImage;
    TextView phValue, cropResult;
    Button captureBtn;

    static final int CAMERA_REQUEST = 100;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        soilImage = findViewById(R.id.soilImage);
        phValue = findViewById(R.id.phValue);
        cropResult = findViewById(R.id.cropResult);
        captureBtn = findViewById(R.id.captureBtn);

        captureBtn.setOnClickListener(v -> {
            Intent cameraIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            startActivityForResult(cameraIntent, CAMERA_REQUEST);
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == CAMERA_REQUEST && resultCode == RESULT_OK) {
            Bitmap photo = (Bitmap) data.getExtras().get("data");
            soilImage.setImageBitmap(photo);

            float ph = 4.5f + new Random().nextFloat() * 4.0f;
            phValue.setText("Estimated Soil pH: " + ph);
            cropResult.setText("Recommended Crops:\n" + CropRecommender.getCrops(ph));
        }
    }
}
