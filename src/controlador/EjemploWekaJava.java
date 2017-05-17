package controlador;
import weka.classifiers.bayes.NaiveBayesUpdateable;
import weka.classifiers.trees.J48;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;



public class EjemploWekaJava {

	public static void main(String[] args) throws Exception {
		
		BufferedReader reader = new BufferedReader(
		                             new FileReader("file generator/values.arff"));
		Instances data = new Instances(reader);
		reader.close();
		// setting class attribute
		data.setClassIndex(data.numAttributes() - 1);
		
		System.out.println(data);
		
		 String[] options = new String[1];
		 options[0] = "-U";            // unpruned tree
		 J48 tree = new J48();         // new instance of tree
		 tree.setOptions(options);     // set the options
		 tree.buildClassifier(data);  
		 System.out.println(tree);
		 
		    // load data
		    ArffLoader loader = new ArffLoader();
		    loader.setFile(new File("file generator/values.arff"));
		    Instances structure = loader.getStructure();
		    structure.setClassIndex(structure.numAttributes() - 1);

		    // train NaiveBayes
		    NaiveBayesUpdateable nb = new NaiveBayesUpdateable();
		    nb.buildClassifier(structure);
		    Instance current;
		    while ((current = loader.getNextInstance(structure)) != null)
		      nb.updateClassifier(current);

		    // output generated model
		    System.out.println(nb);

	}

}
