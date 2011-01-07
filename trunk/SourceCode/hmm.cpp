// Hidden Markov model class
// Hand writing recognition Januari project, MSc AI, University of Amsterdam
// Thijs Kooi, 2011

// The Baum-Welch algorithm, an instance of the EM-algorithm, is used to train the output probabilities
// To output the most likely sequence, the Viterbi algorithm, a dynamic programming method, is applied.

#include "hmm.h"

int main()
{
	//Testing
	HMM model;
	model.setStates(16);
	model.setObservations(16);
	double *observations;
	model.trainModel(observations);
}

//Constructors
HMM::HMM() { }

HMM::HMM(int ns, int no, map<int, map<int, double> > t, map<int, map<int, double> > o)
{
	number_of_states = ns;
	number_of_observations = no;
	transition_probabilities = t;
	observation_probabilities = o;
}
//End constructors

//Getters and setters
int HMM::getStates(){ return number_of_states;  }
int HMM::getObservations(){ return number_of_observations; }
void HMM::setStates(int s){ number_of_states = s;  }
void HMM::setObservations(int o){ number_of_observations = o; }
//End getters and setters

//Training functions
void HMM::trainModel(double* observations)
{
	cout << "Training model..." << endl;
	int converged=0;
	initialiseParameters();
	while(!converged)
	{
		eStep(observations);
		mStep(observations);
		converged =1;
	}
	cout << "Done!" << endl;
}

void HMM::initialiseParameters()
{
	//Initialise elements of transition map
	//The model is assumed to have only forward connections, therefore a sort of diagonal matrix with non-zero elements also above the diagonal
	for(size_t i = 0; i < number_of_states; ++i)
		for(size_t j = i; j < number_of_states; ++j)
			transition_probabilities[i][j] = 1.0;
		
	//Initialise uniform probabilities
	//It can only transfer to either itself or the next state, therefore we do not need to do any calculations with the size of the matrix
	for(map<int, map<int,double> >::iterator i = transition_probabilities.begin(); i != transition_probabilities.end(); ++i)
		for(map<int, double>::iterator j = (*i).second.begin(); j != (*i).second.end(); ++j)
			(*j).second/=2.0;
		
	prior_probabilities = new double[number_of_states];
	//Initialise uniform prior probabilities
	for(size_t i = 0; i < number_of_states; ++i)
		prior_probabilities[i] = 1.0/number_of_states;
	
	//Initialise uniform probabilities for observations
	for(size_t i = 0; i < number_of_states; ++i)
		for(size_t j = i; j < number_of_observations; ++j)
			observation_probabilities[i][j] = 1.0;
		
	for(map<int, map<int,double> >::iterator i = transition_probabilities.begin(); i != transition_probabilities.end(); ++i)
		for(map<int, double>::iterator j = (*i).second.begin(); j != (*i).second.end(); ++j)
			(*j).second/=(*i).second.size();
	
}

//Find posterior distribution of the latent variables
void HMM::eStep(double *observations)
{
}

double forwardProbabilitty(double *observations)
{
	return 0;
}

double backwardProbability(double *observations)
{
	return 0;
}

void HMM::mStep(double *observations)
{
}

void HMM::maximisePriors(double* observations)
{
}

void HMM::maximiseTransitions(double* observations)
{
}

void HMM::maximiseObservationDistribution(double* observations)
{
}
//End training functions