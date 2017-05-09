package interfaz;

import javax.swing.JFrame;
import java.awt.GridBagLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;

import java.awt.GridBagConstraints;
import java.awt.Font;
import javax.swing.JComboBox;
import javax.swing.BorderFactory;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import java.awt.Color;

public class VentanaPrincipal extends JFrame{
	
	private JPanel panelPrincipal;
	
	
	public VentanaPrincipal(){
		panelPrincipal = new JPanel();
		panelPrincipal.setLocation(0, 0);
		setForeground(Color.WHITE);
		setTitle("Proyecto TID - Calcula Paro");
		getContentPane().setLayout(null);
		panelPrincipal.setLayout(null);
		panelPrincipal.setSize(494, 321);
		panelPrincipal.setBorder(BorderFactory.createTitledBorder(BorderFactory.createLoweredBevelBorder(),"Formulario"));
		
		JLabel lblSexo = new JLabel("Sexo");
		lblSexo.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblSexo.setBounds(35, 43, 38, 14);
		panelPrincipal.add(lblSexo);
		
		JLabel lblSector = new JLabel("Sector Profesional");
		lblSector.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblSector.setBounds(34, 85, 151, 14);
		panelPrincipal.add(lblSector);
		
		JLabel lblEstudios = new JLabel("Estudios");
		lblEstudios.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblEstudios.setBounds(34, 129, 94, 14);
		panelPrincipal.add(lblEstudios);
		
		JLabel lblTrimestre = new JLabel("Trimestre");
		lblTrimestre.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblTrimestre.setBounds(34, 171, 87, 14);
		panelPrincipal.add(lblTrimestre);
		
		JComboBox comboSexo = new JComboBox();
		comboSexo.setModel(new DefaultComboBoxModel(new String[] {"Hombre", "Mujer"}));
		comboSexo.setBounds(196, 40, 263, 20);
		panelPrincipal.add(comboSexo);
		
		JComboBox comboSector = new JComboBox();
		comboSector.setModel(new DefaultComboBoxModel(new String[] {"Actividades administrativas y servicios auxiliares", "Actividades art\u00EDsticas recreativas y de entretenimiento", "Actividades de los hogares como empleadores de personal dom\u00E9stico", "Actividades de organizaciones y organismos extraterritoriales", "Actividades financieras y de seguros", "Actividades inmobiliarias", "Actividades profesionales, cient\u00EDficas y t\u00E9cnicas", "Actividades sanitarias y de servicios sociales", "Administraci\u00F3n p\u00FAblica y defensa; seguridad social obligatoria", "Agricultura, ganader\u00EDa, silvicultura y pesca", "Comercio al por mayores y al por menores; reparaci\u00F3n de veh\u00EDculos de motor y motocicletas", "Construcci\u00F3n", "Educaci\u00F3n", "Hosteler\u00EDa", "Industria manufacturera", "Industrias extractivas", "Informaci\u00F3n y comunicaciones", "Otros servicios", "Sin actividad econ\u00F3mica", "Suministros de agua, actividades de saneamiento gesti\u00F3n de residuos y descontaminaci\u00F3n", "Suministros de energ\u00EDa el\u00E9ctrica, gas, vapor y aire acondicionado", "Transporte y almacenamiento"}));
		comboSector.setBounds(196, 82, 263, 20);
		panelPrincipal.add(comboSector);
		
		JComboBox comboEstudios = new JComboBox();
		comboEstudios.setModel(new DefaultComboBoxModel(new String[] {"Analfabeto", "Educacion Primaria", "Educacion Secundaria", "Estudios Universitarios", "Formacion Profesional"}));
		comboEstudios.setBounds(196, 126, 263, 20);
		panelPrincipal.add(comboEstudios);
		
		JComboBox comboTrimestre = new JComboBox();
		comboTrimestre.setModel(new DefaultComboBoxModel(new String[] {"Primero Ene/Feb/Mar", "Segundo Abr/May/Jun", "Tercero Jul/Ago/Sep", "Cuarto Oct/Nov/Dic"}));
		comboTrimestre.setBounds(196, 168, 263, 20);
		panelPrincipal.add(comboTrimestre);
		
		JButton btnCalcular = new JButton("Calcular");
		btnCalcular.setBounds(140, 224, 150, 48);
		panelPrincipal.add(btnCalcular);
		
		getContentPane().add(panelPrincipal);
		setSize(500,320);
		setVisible(true);
		setResizable(false);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
	}
}
