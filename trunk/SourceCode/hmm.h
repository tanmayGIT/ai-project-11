#ifndef HMM_H
#define HMM_H

#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <map>

#include "gmm.h"

using namespace std;

class HMM {
	public:
		//Constructor functions
		HMM(int number_of_states, int number_of_observations, int observation_dimension);//Tested
		HMM(int number_of_states, int number_of_observations, int observation_dimension, int topology);
		HMM(int,int,int,double *prior_probabilities, map<int,map<int,double> > transition_probabilities, map<int,map<int,map<int,double> > > observation_probabilities);
		HMM(int,vector<GMM>);
		HMM(int,vector<GMM>,int topology);
		//End constructor functions
		
		//Getters and setters
		int getStates();								//Tested
		int getNumberOfObservations();							//Tested
		int getObservationDimension();
		//End getters and setters
		
		void trainModel(double**,int);					
		double stateSequenceProbability(vector<int>);					//Tested
		double observationSequenceProbability(double**,int);				//Tested for uniform model
		int* viterbiSequence(double**,int);
		
		//Print functions
		void printObservations();							//Tested
		void printPriorProbabilities();							//Tested
		void printTransitionProbabilities();						//Tested
		void printObservationProbabilities();						//Tested
		//Print functions
		
		double** readTestFile(int,int,int);
		double* processLine(string,int);
		
	private:
		//HMM variables
		int number_of_states,number_of_observations,observation_dimension,observation_sequence_length;
		double *prior_probabilities;
		map<int, map<int, double> > transition_probabilities;
		map<int, map<int, map<int, double> > > observation_probabilities;
		
		double observationProbability(int,int);
		
		double **observations;
		
		//0: discrete observation distribution, 1: Gaussian distributition, 2: mixture of Gaussians
		int gaussian;
		vector<GMM> mixture_model;
		//End HMM variables
		
		//Initialisation functions
		void initialiseUniform();							//Tested
		void initialiseLanguageModel();							//Tested
		void initialiseUniformObservations();						//Tested
		//end initialisation functions
		
		//Baum-Welch functions
		double current_likelihood;
		
		void eStep();
			//A postiori probability tables
			map<int, map<int, double> > gamma;
			map<int, map<int, double> > alpha;
			map<int, map<int, double> > beta;
			map<int, map<int, map<int, double> > > gmm_gamma;
			map<int, map<int, map<int, double> > > xi;

			//A postiori probability funtions
			double forwardProbability(int,int);					//Tested
			double backwardProbability(int,int);					//Tested
			double stateProbability(int,int);
			double stateProbability(int,int,int);
			double stateToStateProbability(int,int,int);
			
			
		void mStep();
			void maximisePriors();
			void maximiseTransitions();
				void updateTransition(int,int);
			void maximiseObservationDistribution();
				void updateObservationDistribution(int,int,int);
				double updateGaussianMean(int,int);
				vector<vector<double> > updateGaussianCovariance(int,vector<double>);
				void updateGMMparameters();
					void updateGMMweights(int);
					void updateGMMmean(int);
					void updateGMMcovariance(int);
		//End Baum-Welch functions
			
		//Viterbi Functions
		double highestPathProbability(int, int, double**,int);
		double maxValue(double*, int);
		//End Viterbi functions
};

#endif