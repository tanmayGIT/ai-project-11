// Gaussian mixture model class
// Hand writing recognition Januari project, MSc AI, University of Amsterdam
// Thijs Kooi, 2011

#include "gmm.h"

double PI = 4.0*atan(1.0);

int main()
{
	vector<vector<double> > A;
	vector<double> b;
	double test[3][3] = {{2.0,3.0,4.0},{3.0,4.0,5.0},{2.0,5.0,6.0}};
	
	GMM testGMM;
			
	for(size_t i = 0; i < 3; ++i)
	{
		b.clear();
		for(size_t j = 0; j < 3; ++j)
			b.push_back(test[i][j]);
		A.push_back(b);
	}
	
	cout << "Determinant of matrix: " << endl;
	for(size_t i = 0; i < 3; ++i)
	{
		for(size_t j = 0; j < 3; ++j)
			cout << A[i][j] << " ";
		cout << endl;
	}
	cout << testGMM.testDeterminant(A) << endl;
}

//Constructor
GMM::GMM(int) { }

double GMM::gmmProb(vector<double> x)
{
	double product = 0.0;
	for(size_t k = 0; k < mixture_components; ++k)
		product*=priors[k]*gmmProb(x,k);
	return product;
}

double GMM::gmmProb(vector<double> x, int component_number)
{
	double normalisation_constant = 1.0/( pow((2.0*PI),data_dimension/2.0) * pow(determinant(covariances[component_number]),0.5) );
	double exponent = -0.5*mahalanobisDistance(x,means[component_number],covariances[component_number]);
	
	return normalisation_constant*exp(exponent);
}

//Math functions
double GMM::mahalanobisDistance(vector<double> x,vector<double> mean,vector<vector<double> > covariance)
{
	vector<double> difference;
	for(size_t d = 0; d < data_dimension; ++d)
		difference[d] = x[d]-mean[d];
	
	vector<vector<double> > inverse_covariance = inverse(covariance);
	
	vector<double> distance ;
	for(size_t d = 0; d < data_dimension; ++d)
		distance[d]==innerProduct(difference,inverse_covariance[d]);
	
	return innerProduct(distance,difference);
}

double GMM::innerProduct(vector<double> a, vector<double> b)
{
	double sum = 0.0;
	for(size_t d = 0; d < a.size(); ++d)
		sum+=a[d]*b[d];
	return sum;
}

double GMM::determinant(vector<vector<double> > A)
{
	double det = 0.0;
	if(A.size() == 2)
		det = A[0][0]*A[1][1] - A[1][0]*A[0][1];
	else
	{
		for(size_t d = 0; d < A.size(); ++d)
		{
			double det = 0.0;	
			if(d%2 == 0)
				det+=A[1][d]*minor(A,1,d);
			else
				det-=A[1][d]*minor(A,1,d);
		}
	}	
	return det;
}

vector<vector<double> > GMM::minor(vector<vector<double> > A, int m, int n)
{
	A.erase(A.begin()+m);
	for(size_t j = 0; j < A.size(); ++j)
		A[j].erase(A[j].begin()+n);
	
	return A;
}

vector<vector<double> > GMM::inverse(vector<vector<double> > A)
{
// 	double *B = new double[(data_dimension-1)*(data_dimension-1)];
// 	double **minor = new double*[data_dimension-1];
// 	for(size_t d = 0; d < data_dimension-1; ++d)
// 		minor[d] = B+(d*(data_dimension-1));
// 	
// 	for(size_t d = 0; d < data_dimension; ++d)
// 		for(size_t e = 0; e < data_dimension; ++e)
	return A;
}
//End math functions

//Getters and setters
int GMM::getMixtureComponents() { return mixture_components; }
void GMM::setMixtureComponents(int N) { mixture_components =  N; }

int GMM::getPrior(int component_number) { return priors[component_number]; }
void GMM::setPrior(int component_number,double probability) { priors[component_number] = probability; }

vector<double> GMM::getMean(int component_number) { return means[component_number]; }
void GMM::setMean(int component_number,vector<double> mean) { means[component_number] = mean; }

vector<vector<double> > GMM::getCovariance(int component_number) { return covariances[component_number]; } 
void GMM::setCovariance(int component_number, vector<vector<double> >covariance) { covariances[component_number] = covariance; }
//End getters and setters

// //Print functions
// void GMM::printPrior(int component_number);
// void GMM::printMean(int component_number);
// void GMM::printCovariance(int component_number);
// //end print functions

// Testing and debugging
void testMahalanobisDistance(vector<double>,vector<double>,vector<vector<double> >);
void testInnerProduct(vector<double>,vector<double>);
void GMM::testDeterminant(vector<vector<double> > A)
{
	cout << "Determinant of matrix: " << endl;
	for(size_t i = 0; i < A.size(); ++i)
	{
		for(size_t j = 0; j < A[i].size(); ++j)
			cout << A[i][j] << " ";
		cout << endl;
	}
	cout << "is: " << determinant(A) << endl;
}
void testInverse(vector<vector<double> >, vector<vector<double> >);
void testMVNPDF(vector<double>);
void testGMM(vector<double>);
// end 