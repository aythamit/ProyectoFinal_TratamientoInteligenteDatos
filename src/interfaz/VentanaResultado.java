package interfaz;

import javax.swing.JFrame;
import javax.swing.JLabel;

public class VentanaResultado extends JFrame {

	public VentanaResultado(String resultado) {
		
		initVentana();
		getContentPane().setLayout(null);
		JLabel result = new JLabel(resultado);
		result.setBounds(10, 0, 244, 71);
		getContentPane().add(result);
	}

	private void initVentana() {
		
		setSize(300,100);
		setVisible(true);
		setResizable(false);
		setLocationRelativeTo(null);
		setTitle("Resultado");
		
	}

}
