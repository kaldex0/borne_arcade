import java.io.IOException;

import MG2D.geometrie.Texture;
import MG2D.Couleur;
import MG2D.geometrie.Point;
import MG2D.geometrie.Triangle;
import MG2D.Clavier;


public class Pointeur {
    private int value;
    private Texture triangleGauche;
    private Texture triangleDroite;
    private Texture rectangleCentre;

    public Pointeur(){
	this.triangleGauche = new Texture("img/star.png", new Point(30, 492), 40,40);
	// this.triangleDroite = new Triangle(Couleur .ROUGE, new Point(550, 560), new Point(520, 510), new Point(550, 460), true);
	this.triangleDroite = new Texture("img/star.png", new Point(530, 492), 40,40);
	this.rectangleCentre = new Texture("img/select2.png", new Point(80, 460), 440, 100);
	this.value = Graphique.tableau.length-1;
    }

    public void lancerJeu(ClavierBorneArcade clavier){
	System.out.println("LANCEMENT DU JEU: " + Graphique.tableau[getValue()].getNom());
	try {
	    Graphique.stopMusiqueFond();
	    String cmdLine = "./"+Graphique.tableau[getValue()].getNom()+".sh";
	    System.out.println("Exécution: " + cmdLine);
	    Process process = Runtime.getRuntime().exec(cmdLine);
	    process.waitFor();
	    System.out.println("Jeu terminé");
	    Graphique.lectureMusiqueFond();
	    } catch (IOException e) {
		System.err.println("ERREUR: Impossible de lancer le jeu!");
		e.printStackTrace();
	    } catch(Exception e){
		System.err.println("ERREUR lors de l'exécution du jeu:");
			e.printStackTrace();
	    }
    }

    public int getValue() {
	return value;
    }

    public void setValue(int value) {
	this.value = value;
    }

    public Texture getTriangleGauche() {
	return triangleGauche;
    }

    public void setTriangleGauche(Texture triangleGauche) {
	this.triangleGauche = triangleGauche;
    }

    public Texture getTriangleDroite() {
	return triangleDroite;
    }

    public void setTriangleDroite(Texture triangleDroite) {
	this.triangleDroite = triangleDroite;
    }

    public Texture getRectangleCentre() {
	return rectangleCentre;
    }

    public void setRectangleCentre(Texture rectangleCentre) {
	this.rectangleCentre = rectangleCentre;
    }

}
