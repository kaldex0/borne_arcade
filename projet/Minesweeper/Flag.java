import MG2D.geometrie.Point;
import MG2D.geometrie.Texture;

public class Flag implements Button{

    /* Attributs */
    private boolean state = false;
    
    /* Constructeurs */
    public Flag() {
        this.state = false;
    }

    public Flag(boolean state) {
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
         * Si le bouton est actif, on affiche un caractere "D", sinon un espace.
         */
        if (this.state) {
            System.out.print("D");
        } else {
            System.out.print(" ");
        }
    }

    @Override
    public void actionButton(Tile c, Board board) {
        /**
         * Si le bouton est actif, on change l'etat du drapeau.
         */
        if (this.state) {
            c.switchFlag(board);
        }
    }

    @Override
    public Texture selection(int sizeTile, int width, int height) {
        /**
         * On cree un carre bleu a la position et taille de la case.
         */
        if (this.state) {
            return new Texture("./img/Minesweeper_flag.png", new Point(width - 3*sizeTile,height-2*sizeTile), sizeTile, sizeTile);
        } else {
            return new Texture("./img/Minesweeper_flag.png", new Point(width - 3*sizeTile,height-2*sizeTile), sizeTile, sizeTile);
        }    
    }
}
