
package com.example.smartsoilph;

public class CropRecommender {

    public static String getCrops(float ph) {
        if (ph < 5.5) {
            return "Rice\nPotato\nSweet Potato";
        } else if (ph < 6.5) {
            return "Wheat\nMaize\nTomato";
        } else if (ph < 7.5) {
            return "Sugarcane\nCotton\nSoybean";
        } else {
            return "Barley\nSpinach\nBeetroot";
        }
    }
}
