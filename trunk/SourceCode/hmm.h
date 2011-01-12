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
		HMM(int number_of_states, int number_of_observations);				//Tested
		HMM(int,int,double *prior_probabilities, map<int,map<int,double> > transition_probabilities, map<int,map<int,double> > observation_probabilities);
		HMM(int,vector<GMM>);
		//End constructor functions
		
		//Getters and setters
		int getStates();								//Tested
		int getNumberOfObservations();							//Tested
		//End getters and setters
		
		void trainModel(int*,int);					
		double stateSequenceProbability(vector<int>);					//Tested
		double observationSequenceProbability(int*,int);
		int* viterbiSequence(int*,int);
		
		//Print functions
		void printObservations();							//Tested
		void printPriorProbabilities();							//Tested
		void printTransitionProbabilities();						//Tested
		void printObservationProbabilities();						//Tested
		//Print functions
		
	private:
		//HMM variables
		int number_of_states,number_of_observations,observation_dimension,observation_sequence_length;
		double *prior_probabilities;
		map<int, map<int, double> > transition_probabilities;
		map<int, map<int, double> > observation_probabilities;
		
		int *observations;
		//End HMM variables
		
		void initialiseUniform();							//Tested
		
		//Baum-Welch functions
		double current_likelihood;
		
		void eStep();
			double forwardProbability(int,int);
			double backwardProbability(int,int);
			double stateProbability(int,int);
			double stateToStateProbability(int,int,int);
			map<int, map<int, double> > gamma;
			map<int, map<int, map<int, double> > > xi;
			
		void mStep();
			void maximisePriors();
			void maximiseTransitions();
				void updateTransition(int,int);
			void maximiseObservationDistribution();
				void updateObservationDistribution(int,int);
		//End Baum-Welch functions
			
		//Viterbi Functions
		double highestPathProbability(int, int, double**,int);
		double maxValue(double*, int);
		//End Viterbi functions
};

#endif