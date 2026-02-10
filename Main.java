public class Main {
    public static void main(String[] args){
	try{
	    Graphique g = new Graphique();
	    while(true){
		try{
		    // Thread.sleep(250);
		}catch(Exception e){};
		g.selectionJeu();
	    }
	}catch(Exception e){
	    System.err.println("ERREUR FATALE:");
	    e.printStackTrace();
	    System.exit(1);
	}
    }
}
