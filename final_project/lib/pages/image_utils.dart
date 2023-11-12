import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> drawVerticalTextOnImage(File imageFile, String topText, String bottomText) async {
    img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());
    if (originalImage == null) {
      throw Exception('Unable to decode image');
    }

    int blackColor = img.getColor(0, 0, 0);
    int maxFontSize = originalImage.height ~/ 20;

    // Define the position for the top text
    int topTextXPosition = 50;
    int topTextYPosition = 50;

    // Define the position for the bottom text
    int bottomTextXPosition = 10; // Adjusted position for vertical text
    int bottomTextYPosition = originalImage.height ~/ 2; // Centered position for the bottom text

    // Draw the top text
    img.drawString(originalImage, img.arial_48, topTextXPosition, topTextYPosition, topText, color: blackColor);

    // Draw the bottom text in vertical orientation
    drawVerticalText(originalImage, bottomTextXPosition, bottomTextYPosition, bottomText, color: blackColor);

    // Save the edited image
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/meme_${DateTime.now().millisecondsSinceEpoch}.png';

    File editedImage = File(imagePath);
    editedImage.writeAsBytesSync(img.encodePng(originalImage));

    print("Image saved at: $imagePath");

    return editedImage;
  }

  static void drawVerticalText(img.Image image, int x, int y, String text, {int color = 0xFF000000}) {
    int fontSize = 48; // Font size
    int spacing = fontSize + 4; // Spacing between characters
    for (int i = 0; i < text.length; i++) {
      img.drawString(image, img.arial_48, x, y + i * spacing, text[i], color: color);
    }
  }
}
