package controlador;
import weka.classifiers.*;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.RandomTree;
import weka.core.Instances;

import java.io.BufferedReader;
import java.io.FileReader;



@SuppressWarnings("unused")
public class EjemploWekaJava {

	public static void main(String[] args) throws Exception {
		
		BufferedReader reader = new BufferedReader(
		                             new FileReader("values.arff"));
		Instances train = new Instances(reader);
		reader.close();
				reader = new BufferedReader(new FileReader("prueba.arff"));
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
			 System.out.println("No vas a estar en paro.");
		 else
		 System.out.println("Lo siento bro, aun no sales.");
		 //System.out.println(eval.toSummaryString("\nResults\n======\n", false));

	}

}
