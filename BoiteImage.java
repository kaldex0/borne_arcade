import java.io.File;

import MG2D.geometrie.Point;
import MG2D.geometrie.Rectangle;
import MG2D.geometrie.Texture;


public class BoiteImage extends Boite{

    private static final String IMAGE_PAR_DEFAUT = "img/fond.png";

    Texture image;

    BoiteImage(Rectangle rectangle, String image) {
	super(rectangle);
	this.image = new Texture(cheminImage(image), new Point(760, 648));
    }

    public Texture getImage() {
	return this.image;
    }

    public void setImage(String chemin) {
    this.image.setImg(cheminImage(chemin));
	//this.image.setTaille(400, 320);
    }

    private String cheminImage(String dossierJeu) {
    String candidate = dossierJeu + "/photo_small.png";
    if(new File(candidate).isFile()){
        return candidate;
    }
    return IMAGE_PAR_DEFAUT;
    }

}
