package interfaz;

import javax.swing.JFrame;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JLabel;
import javax.swing.JPanel;

import controlador.CalculadoraParo;

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
		panelPrincipal.setSize(494, 356);
		panelPrincipal.setBorder(BorderFactory.createTitledBorder(BorderFactory.createLoweredBevelBorder(),"Formulario"));
		
		JLabel lblSexo = new JLabel("Sexo");
		lblSexo.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblSexo.setBounds(35, 43, 55, 14);
		panelPrincipal.add(lblSexo);
		
		JLabel lblSector = new JLabel("Sector Profesional");
		lblSector.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblSector.setBounds(34, 85, 151, 14);
		panelPrincipal.add(lblSector);
		
		JLabel lblEstudios = new JLabel("Estudios");
		lblEstudios.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblEstudios.setBounds(34, 129, 94, 14);
		panelPrincipal.add(lblEstudios);
		
		JLabel lblTrimestre = new JLabel("Mes");
		lblTrimestre.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblTrimestre.setBounds(34, 171, 87, 14);
		panelPrincipal.add(lblTrimestre);
		
		JComboBox comboSexo = new JComboBox();
		comboSexo.setModel(new DefaultComboBoxModel(new String[] {"hombre", "mujer"}));
		comboSexo.setBounds(196, 40, 263, 20);
		panelPrincipal.add(comboSexo);
		
		JComboBox comboSector = new JComboBox();
		comboSector.setModel(new DefaultComboBoxModel(new String[] {"Actividades_administrativas_y_servicios_auxiliares,", "Actividades_artísticas_recreativas_y_de_entretenimiento", "Actividades_de_los_hogares_como_empleadores_de_personal_doméstico", "Actividades_de_organizaciones_y_organismos_extraterritoriales", "Actividades_financieras_y_de_seguros, Actividades_inmobiliarias", "Actividades_profesionales_científicas_y_técnicas", "Actividades_sanitarias_y_de_servicios_sociales", "Administración_pública_y_defensa;_seguridad_social_obligatoria", "Agricultura_ganadería_silvicultura_y_pesca", "Comercio_al_por_mayores_y_al_por_menores;_reparación_de_vehículos_de_motor_y_motocicletas", "Construcción", "Educación", "Hostelería", "Industria_manufacturera", "Industrias_extractivas", "Información_y_comunicaciones", "Otros_servicios", "Sin_actividad_económica", "Suministros_de_agua_actividades_de_saneamiento_gestión_de_residuos_y_descontaminación", "Suministros_de_energía_eléctrica_gas_vapor_y_aire_acondicionado", "Transporte_y_almacenamiento"}));
		comboSector.setBounds(196, 82, 263, 20);
		panelPrincipal.add(comboSector);
		
		JComboBox comboEstudios = new JComboBox();
		comboEstudios.setModel(new DefaultComboBoxModel(new String[] {"Analfabetos", "Primaria", "Secundaria", "Universitario", "FP"}));
		comboEstudios.setBounds(196, 126, 263, 20);
		panelPrincipal.add(comboEstudios);
		
		JComboBox comboMes = new JComboBox();
		comboMes.setModel(new DefaultComboBoxModel(new String[] {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"}));
		comboMes.setBounds(196, 168, 263, 20);
		panelPrincipal.add(comboMes);
		
		JComboBox comboEdad = new JComboBox();
		comboEdad.setModel(new DefaultComboBoxModel(new String[] {"menor_25","mayor_25"}));
		comboEdad.setBounds(196, 250, 263, 20);
		panelPrincipal.add(comboEdad);
		
		JComboBox comboAnio = new JComboBox();
		comboAnio.setModel(new DefaultComboBoxModel(new String[] {"2017"}));
		comboAnio.setBounds(197, 210, 263, 20);
		panelPrincipal.add(comboAnio);
		
		JButton btnCalcular = new JButton("Calcular");
		btnCalcular.setBounds(159, 296, 150, 48);
		panelPrincipal.add(btnCalcular);
		
		btnCalcular.addActionListener( new ActionListener(){

			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				//2017,Junio,hombre,mayor_25,Construcción,Universitario,no
				try {
					CalculadoraParo.calcular( comboAnio.getSelectedItem().toString(), comboMes.getSelectedItem().toString() ,comboSexo.getSelectedItem().toString(),
							comboEdad.getSelectedItem().toString(), 
							comboSector.getSelectedItem().toString(),
							comboEstudios.getSelectedItem().toString());
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			
		});
		
		getContentPane().add(panelPrincipal);
		
		
		JLabel lblAo = new JLabel("Año");
		lblAo.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblAo.setBounds(35, 213, 87, 14);
		panelPrincipal.add(lblAo);
		
		JLabel lblEdad = new JLabel("Edad");
		lblEdad.setFont(new Font("Source Sans Pro", Font.PLAIN, 17));
		lblEdad.setBounds(35, 253, 70, 15);
		panelPrincipal.add(lblEdad);
		setSize(500,400);
		setVisible(true);
		setResizable(false);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
	}
}
