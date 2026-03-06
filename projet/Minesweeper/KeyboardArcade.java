import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

/**
 * Implante l'interface KeyListener pour gerer les evenements clavier.
 *
 * Cette classe est concue pour fonctionner avec MG2D et etre utilisee
 * avec la classe Board pour gerer les entrees clavier du jeu.
 *
 * Joysticks :
 * joyJ1
 * - joyJ1Up
 * - joyJ1Down
 * - joyJ1Left
 * - joyJ1Right
 *
 * Boutons :
 * ButtonJ1
 * (bas)
 * - ButtonJ1A -> creuser
 * - ButtonJ1B -> drapeau
 * - ButtonJ1C
 * (haut)
 * - ButtonJ1X -> retour
 * - ButtonJ1Y -> difficulte
 * - ButtonJ1Z
 */
public class KeyboardArcade implements KeyListener {

    // Attributs
    private boolean up; // enfoncé
    private boolean upTrigger; // apputé puis relâché
    private boolean down;
    private boolean downTrigger;
    private boolean left;
    private boolean leftTrigger;
    private boolean right;
    private boolean rightTrigger;

    private boolean buttonA;
    private boolean buttonATrigger;
    private boolean buttonB;
    private boolean buttonBTrigger;
    private boolean buttonC;
    private boolean buttonCTrigger;
    private boolean buttonX;
    private boolean buttonXTrigger;
    private boolean buttonY;
    private boolean buttonYTrigger;
    private boolean buttonZ;
    private boolean buttonZTrigger;

    public KeyboardArcade() {
        // Constructeur
        this.up = this.upTrigger = this.down = this.downTrigger = false;
        this.left = this.leftTrigger = this.right = this.rightTrigger = false;

        this.buttonA = this.buttonATrigger = this.buttonB = this.buttonBTrigger = false;
        this.buttonC = this.buttonCTrigger = this.buttonX = this.buttonXTrigger = false;
        this.buttonY = this.buttonYTrigger = this.buttonZ = this.buttonZTrigger = false;
    }

    public boolean isUp() {
        return this.up;
    }

    public boolean isUpTrigger() {
        boolean temp = this.upTrigger;
        this.upTrigger = false;
        return temp;
    }

    public boolean isDown() {
        return this.down;
    }

    public boolean isDownTrigger() {
        boolean temp = this.downTrigger;
        this.downTrigger = false;
        return temp;
    }

    public boolean isLeft() {
        return this.left;
    }

    public boolean isLeftTrigger() {
        boolean temp = this.leftTrigger;
        this.leftTrigger = false;
        return temp;
    }

    public boolean isRight() {
        return this.right;
    }

    public boolean isRightTrigger() {
        boolean temp = this.rightTrigger;
        this.rightTrigger = false;
        return temp;
    }

    public boolean isButtonA() {
        return this.buttonA;
    }

    public boolean isButtonATrigger() {
        boolean temp = this.buttonATrigger;
        this.buttonATrigger = false;
        return temp;
    }

    public boolean isButtonB() {
        return this.buttonB;
    }

    public boolean isButtonBTrigger() {
        boolean temp = this.buttonBTrigger;
        this.buttonBTrigger = false;
        return temp;
    }

    public boolean isButtonC() {
        return this.buttonC;
    }

    public boolean isButtonCTrigger() {
        boolean temp = this.buttonCTrigger;
        this.buttonCTrigger = false;
        return temp;
    }

    public boolean isButtonX() {
        return this.buttonX;
    }

    public boolean isButtonXTrigger() {
        boolean temp = this.buttonXTrigger;
        this.buttonXTrigger = false;
        return temp;
    }

    public boolean isButtonY() {
        return this.buttonY;
    }

    public boolean isButtonYTrigger() {
        boolean temp = this.buttonYTrigger;
        this.buttonYTrigger = false;
        return temp;
    }

    public boolean isButtonZ() {
        return this.buttonZ;
    }

    public boolean isButtonZTrigger() {
        boolean temp = this.buttonZTrigger;
        this.buttonZTrigger = false;
        return temp;
    }

    // Methodes

    public void reinitialize() {
        this.up = this.upTrigger = this.down = this.downTrigger = false;
        this.left = this.leftTrigger = this.right = this.rightTrigger = false;

        this.buttonA = this.buttonATrigger = this.buttonB = this.buttonBTrigger = false;
        this.buttonC = this.buttonCTrigger = this.buttonX = this.buttonXTrigger = false;
        this.buttonY = this.buttonYTrigger = this.buttonZ = this.buttonZTrigger = false;
    }

    @Override
    public void keyReleased(KeyEvent e) {
        // System.out.println("Key released: " + e.getKeyCode());
        switch (e.getKeyCode()) {
            case KeyEvent.VK_UP:
                this.up = false;
                this.upTrigger = true;
                break;
            case KeyEvent.VK_DOWN:
                this.down = false;
                this.downTrigger = true;
                break;
            case KeyEvent.VK_LEFT:
                this.left = false;
                this.leftTrigger = true;
                break;
            case KeyEvent.VK_RIGHT:
                this.right = false;
                this.rightTrigger = true;
                break;

            case KeyEvent.VK_A:
                this.buttonA = false;
                this.buttonATrigger = true;
                break;
            case KeyEvent.VK_B:
                this.buttonB = false;
                this.buttonBTrigger = true;
                break;
            case KeyEvent.VK_C:
                this.buttonC = false;
                this.buttonCTrigger = true;
                break;

            case KeyEvent.VK_X:
                this.buttonX = false;
                this.buttonXTrigger = true;
                break;
            case KeyEvent.VK_Y:
                this.buttonY = false;
                this.buttonYTrigger = true;
                break;
            case KeyEvent.VK_Z:
                this.buttonZ = false;
                this.buttonZTrigger = true;
                break;

            default:
        }
    }

    @Override
    public void keyTyped(KeyEvent e) {
        // Not used
    }

    @Override
    public void keyPressed(KeyEvent e) {
        // System.out.println("Key pressed: " + e.getKeyCode());
        switch (e.getKeyCode()) {
            case KeyEvent.VK_UP:
                this.up = true;
                break;
            case KeyEvent.VK_DOWN:
                this.down = true;
                break;
            case KeyEvent.VK_LEFT:
                this.left = true;
                break;
            case KeyEvent.VK_RIGHT:
                this.right = true;
                break;

            case KeyEvent.VK_A:
                this.buttonA = true;
                break;
            case KeyEvent.VK_B:
                this.buttonB = true;
                break;
            case KeyEvent.VK_C:
                this.buttonC = true;
                break;

            case KeyEvent.VK_X:
                this.buttonX = true;
                break;
            case KeyEvent.VK_Y:
                this.buttonY = true;
                break;
            case KeyEvent.VK_Z:
                this.buttonZ = true;
                break;

            default:
        }
    }
}
