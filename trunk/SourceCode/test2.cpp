#include <iostream>
#include <map>
#include <cmath>
#include <vector>

using namespace std;

int main()
{
	vector<vector<double> > A;
	vector<double> b;
	double test[3][3] = {{2.0,3.0,4.0},{3.0,4.0,5.0},{2.0,5.0,6.0}};
			
	for(size_t i = 0; i < 3; ++i)
	{
		b.clear();
		for(size_t j = 0; j < 3; ++j)
			b.push_back(test[i][j]);
		A.push_back(b);
	}
	
	for(size_t i = 0; i < A.size(); ++i)
	{
		for(size_t j = 0; j < A[j].size(); ++j)
			cout << A[i][j] << " ";
		cout << endl;
	}
	
	int m,n;
	m = 0;
	n = 2;
	
	A.erase(A.begin()+m);
	for(size_t j = 0; j < A.size(); ++j)
		A[j].erase(A[j].begin()+n);
	cout << "Minor: " << endl;
	
	for(size_t i = 0; i < A.size(); ++i)
	{
		for(size_t j = 0; j < A[i].size(); ++j)
			cout << A[i][j] << " ";
		cout << endl;
	}
	
}