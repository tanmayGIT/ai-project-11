#ifndef GMM_H
#define GMM_H

#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <map>

using namespace std;

class GMM {
	public:
		//Constructors
		GMM(int);
		GMM(int,int);
		GMM(vector<double>,vector<vector<double> > );
		//end constructors
		
		void initialiseParameters();
		void initialiseRandomMean(double **data, int number_of_datapoints, int data_dimension);
		double getDataMaximum(double**,int,int);
		double getDataMinimum(double**,int,int);
		
		//Testing and debugging, will be removed later
		vector<double> arrayToVector(double*, int);								//Tested
		void printMatrix(vector<vector<double> >);
		void printMatrix(vector<double>);
		//end 
		
		vector<double> vectorAdd(vector<double>, vector<double>);
		vector<vector<double> > vectorAdd(vector<vector<double> >, vector<vector<double> >);
		vector<double> vectorSubtract(vector<double>, vector<double>);
		vector<double> vectorScalarProduct(vector<double>, double);
		vector<vector<double> > vectorScalarProduct(vector<vector<double> >, double);
		double innerProduct(vector<double>, vector<double>);							//Tested
		vector<vector<double> > outerProduct(vector<double>, vector<double>);					//Tested
		
// 		void EM(double** observations);

		double gmmProb(vector<double> x);			//returns the probability of x under the current mixture model
		double gmmProb(vector<double> x, int component_number); //returns the probability of x under the given mixture component
// 		double likelihood();

		//Getters and setters
		int getMixtureComponents();
		void setMixtureComponents(int);
		
		int getDimension();
		void setDimension(int);
		
		double getPrior(int component_number);
		void setPrior(int component_number,double probability);
		
		vector<double> getMean(int component_number);
		void setMean(vector<double> mean);
		void setMean(int component_number,vector<double> mean);
		
		vector<vector<double> > getCovariance(int component_number);
		void setCovariance(vector<vector<double> >);
		void setCovariance(int component_number, vector<vector<double> > covariance);
		//End getters and setters
		
		//Print functions
		void printPrior(int component_number);
		void printMean(int component_number);
		void printCovariance(int component_number);
		void printParameters(int component_number);
		//end print functions
		
	private:
		//GMM variables
		int mixture_components;
		int data_dimension;
		vector<double> priors;					//vector of priors for mixture components
		vector<vector<double> > means;				//matrix of means for mixture components
		vector<vector<vector<double> > > covariances;		//tensor of covariances for mixture components
		//End GMM variables
		
		//math functions
		double gausianProb(vector<double> x, vector<double> mean, vector<vector<double> > covariance);
		double mahalanobisDistance(vector<double> x,vector<double> mean,vector<vector<double> > covariance);	//Tested
		double determinant(vector<vector<double> >);								//Tested
		vector<vector<double> > getMinor(vector<vector<double> >, int, int); 					//Tested
		vector<vector<double> > inverse(vector<vector<double> >);						//Tested
		vector<vector<double> > transpose(vector<vector<double> >);						//Tested
		//end math functions
};

#endif