import MG2D.geometrie.Point;
import MG2D.geometrie.Rectangle;
import MG2D.geometrie.Texture;


public class BoiteImage extends Boite{

    Texture image;

    BoiteImage(Rectangle rectangle, String image) {
	super(rectangle);
	this.image = new Texture(image+"/photo_small.png", new Point(760, 648));
    }

    public Texture getImage() {
	return this.image;
    }

    public void setImage(String chemin) {
	String photoPath = chemin + "/photo_small.png";
	java.io.File photoFile = new java.io.File(photoPath);
	
	if(photoFile.exists()){
	    this.image.setImg(photoPath);
	} else {
	    // Fallback à l'image par défaut
	    this.image.setImg("img/fond.png");
	}
	//this.image.setTaille(400, 320);
    }

}
