package controlador;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import interfaz.VentanaResultado;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.J48;
import weka.core.Instances;

public class CalculadoraParo {
	
	
	//2017,Junio,hombre,mayor_25,Construcción,Universitario,no
	public static void calcular(String anio ,String mes, String sexo, String edad, String sector, String estudio) throws Exception {
		
		creaFichero(anio, mes, sexo, edad, sector, estudio);
		System.out.println("Fichero creado");
		calculador();
		
	}

	private static void creaFichero(String anio, String mes, String sexo, String edad, String sector, String estudio) {
		
		
		FileWriter fichero;
        BufferedWriter bw;
		try {
			
			String cabecera = "@relation paro.symbolic \n\n";
			cabecera+= "@attribute año {2017, 2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009}\n";
			cabecera+= "@attribute mes {Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre}\n";
			cabecera+= "@attribute sexo {hombre, mujer}\n";
			cabecera+= "@attribute edad {mayor_25, menor_25}\n";
			cabecera+= "@attribute sector {Actividades_administrativas_y_servicios_auxiliares, Actividades_artísticas_recreativas_y_de_entretenimiento, Actividades_de_los_hogares_como_empleadores_de_personal_doméstico, Actividades_de_organizaciones_y_organismos_extraterritoriales, Actividades_financieras_y_de_seguros, Actividades_inmobiliarias, Actividades_profesionales_científicas_y_técnicas, Actividades_sanitarias_y_de_servicios_sociales, Administración_pública_y_defensa;_seguridad_social_obligatoria, Agricultura_ganadería_silvicultura_y_pesca, Comercio_al_por_mayores_y_al_por_menores;_reparación_de_vehículos_de_motor_y_motocicletas, Construcción, Educación, Hostelería, Industria_manufacturera, Industrias_extractivas, Información_y_comunicaciones, Otros_servicios, Sin_actividad_económica, Suministros_de_agua_actividades_de_saneamiento_gestión_de_residuos_y_descontaminación, Suministros_de_energía_eléctrica_gas_vapor_y_aire_acondicionado, Transporte_y_almacenamiento} \n";
			cabecera+= "@attribute estudios {Analfabetos, Primaria, Secundaria, Universitario, FP}\n";
			cabecera+= "@attribute paro {si, no}\n";
			cabecera+= "\n\n";
			cabecera+= "@data\n";
			cabecera+= anio + "," + mes + "," + sexo + "," + edad + "," + sector + "," + estudio + "," + "no";
			
			fichero = new FileWriter("resultado.arff");
			bw = new BufferedWriter(fichero); 
			System.out.println(cabecera);
			bw.write(cabecera);
			
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	
	private static void calculador() throws Exception {
		// TODO Auto-generated method stub
				BufferedReader reader = new BufferedReader(
		                new FileReader("values.arff"));
		Instances train = new Instances(reader);
		reader.close();
		reader = new BufferedReader(new FileReader("resultado.arff"));
		Instances test  = new Instances(reader);
		reader.close();
		train.setClassIndex(train.numAttributes() - 1);
		test.setClassIndex(train.numAttributes() - 1);
		//System.out.println(train.attribute(train.numAttributes() - 1));
		
		
		Classifier cls = new J48();
		cls.buildClassifier(train);
		// evaluate classifier and print some statistics
		Evaluation eval = new Evaluation(train);
		eval.evaluateModel(cls, test);
		if(eval.pctCorrect() == 100.0)
			new VentanaResultado("No vas a estar en paro.");
		else
			new VentanaResultado("Lo siento bro, aun no sales.");
		
	}

}
