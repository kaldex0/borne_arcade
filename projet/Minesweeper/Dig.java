import MG2D.geometrie.Point;
import MG2D.geometrie.Texture;

public class Dig implements Button {

    /* Attributs */
    private boolean state = false;

    /* Constructeurs */
    public Dig() {
        this.state = false;
    }

    public Dig(boolean state) {
        this.state = state;
    }

    /* Accesseurs */
    public boolean getState() {
        return this.state;
    }

    /* Mutateurs */
    public void setState(boolean state) {
        this.state = state;
    }

    /* Methodes */
    @Override
    public void display() {
        /**
         * Si le bouton est actif, on affiche un caractere "C", sinon un espace.
         */
        if (this.state) {
            System.out.print("C");
        } else {
            System.out.print(" ");
        }
    }

    @Override
    public void actionButton(Tile c, Board board) {
        /**
         * Si le bouton est actif, on decouvre la case.
         */
        if (this.state) {
            c.discover(board);
        }
    }

    @Override
    public Texture selection(int sizeTile, int width, int height) {
        /**
         * On cree un carre bleu a la position et taille de la case.
         */
        if (this.state) {
            return new Texture("./img/Minesweeper_questionmark_true.png",
                    new Point(2 * sizeTile, height - 2 * sizeTile), sizeTile, sizeTile);
        } else {
            return new Texture("./img/Minesweeper_questionmark.png", new Point(2 * sizeTile, height - 2 * sizeTile),
                    sizeTile, sizeTile);
        }
    }
}
