import java.io.File;

import MG2D.geometrie.Point;
import MG2D.geometrie.Rectangle;
import MG2D.geometrie.Texture;


public class BoiteImage extends Boite{

    private static final String PLACEHOLDER = "img/blancTransparent.png";

    Texture image;

    BoiteImage(Rectangle rectangle, String image) {
	super(rectangle);
	this.image = new Texture(resolveImage(image), new Point(Graphique.sx(760), Graphique.sy(648)));
    }

    public Texture getImage() {
	return this.image;
    }

    public void setImage(String chemin) {
    this.image.setImg(resolveImage(chemin));
    //this.image.setTaille(400, 320);
    }

    private static String resolveImage(String basePath) {
    String candidate = basePath + "/photo_small.png";
    if (new File(candidate).exists()) {
        return candidate;
    }
    System.err.println("photo_small.png manquante pour: " + basePath);
    return PLACEHOLDER;
    }

}
