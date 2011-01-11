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

using namespace std;

class HMM {
	public:
		//Constructor functions
		HMM(int,int,map<int,map<int,double> >, map<int,map<int,double> >);
		HMM();
		//End constructor functions
		
		//Getters and setters
		int getStates();								//Tested
		void setStates(int);								//Tested
			
		int getObservations();								//Tested
		void setObservations(int);							//Tested
		
		double* getTransitionProbabilities();						//Tested
		void setTransitionProbabilities(double*);					//Tested
		
		double* getObservationProbabilities();						//Tested
		void setObservationProbabilities(double*);					//Tested
		//End getters and setters
		
		void initialiseUniform();							//Tested
		
		//Trains the model for the given observation vector
		void trainModel(double*);					
		double sequenceProbability(vector<int>);					//Tested
		vector<int> viterbiSequence(double*);
		
		double likelihood();
		
		//Testing and debugging
		void printObservations();							//Tested
		void printPriorProbabilities();							//Tested
		void printTransitionProbabilities();						//Tested
		void printObservationProbabilities();						//Tested
		//End testing and debugging
		
	private:
		//HMM variables
		int number_of_states,number_of_observations;
		double *prior_probabilities;
		map<int, map<int, double> > transition_probabilities;
		map<int, map<int, double> > observation_probabilities;
		
		double *observations;
		//End HMM variables
		
		//Baum-Welch functions
		double current_likelihood;
		void initialiseParameters();
		
		void eStep();
			double forwardProbability(int,int);
			double backwardProbability(int,int);
			
		void mStep();
			void maximisePriors();
			void maximiseTransitions();
				void updateTransition(int,int);
			void maximiseObservationDistribution();
		//End Baum-Welch functions
			
		//Viterbi Functions
};

#endif