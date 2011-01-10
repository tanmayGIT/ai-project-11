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
		HMM(int,int,map<int,map<int,double> >, map<int,map<int,double> >);//Constructor functions
		HMM();
		
		//Getters and setters
		int getStates();
		int getObservations();
		void setStates(int);
		void setObservations(int);
		//End getters and setters
		
		void trainModel(double*);
		vector<int> viterbiSequence(double*);
		
		double likelihood();
		
		//Testing and debugging
		void printObservations();
		void printTransitionProbabilities();
		void printObservationProbabilities();
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