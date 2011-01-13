#include <iostream>
#include <map>
#include <cmath>
#include <vector>

using namespace std;

int main()
{
	vector<vector<double> > A;
	vector<double> b;
	for(size_t i = 0; i < 3; ++i)
	{
		b.clear();
		for(size_t j = 0; j < 3; ++j)
			b.push_back(i*j);
		A.push_back(b);
	}
			
	double **test = new double*[A.size()];
	for(size_t i = 0; i < 3; ++i)
		test[i] = new double[A[i].size()];
	
	for(size_t i = 0; i < 3; ++i)
		for(size_t j = 0; j < 3; ++j)
			test[i][j] = A[i][j];
			
	for(size_t i = 0; i < 3; ++i)
	{
		for(size_t j = 0; j < 3; ++j)
			cout << test[i][j] << " ";
		cout << endl;
	}
}