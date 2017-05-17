package interfaz;

import javax.swing.JFrame;
import javax.swing.JLabel;

public class VentanaResultado extends JFrame {

	public VentanaResultado(String resultado) {
		
		initVentana();
		JLabel result = new JLabel(resultado);
		add(result);
	}

	private void initVentana() {
		
		setSize(250,100);
		setVisible(true);
		setResizable(false);
		setLocationRelativeTo(null);
		setTitle("Resultado");
		
	}

}
