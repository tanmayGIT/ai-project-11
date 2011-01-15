#include <iostream>
#include <map>
#include <cmath>
#include <vector>

using namespace std;

int main()
{
	double a[3] = {1,2,3};
	double b[3] = {1,2,3};
	
	vector<double> av,bv;
	
	for(size_t d = 0; d < 3; ++d)
	{
		av.push_back(a[d]);
		bv.push_back(b[d]);
	}
	
	vector<double> c;
	c.assign(10,3);
	for(size_t d = 0; d < c.size(); ++d)
		cout << c[d] << " ";
	cout << endl;
	
	vector<vector<double> > D;
	D.assign(10,c);
	
	cout << c.size() << endl;
	cout << D[0].size() << endl;
	for(size_t d1 = 0; d1 < D.size(); ++d1)
	{
		for(size_t d2 = 0; d2 < D[d1].size(); ++d2)
			cout << D[d1][d2] << " ";
		cout << endl;
	}
	
// 	av+bv;
}

// vector<double> vector::operator+ (const vector<double>& a) const
// {
// 	vector<double> result;
// 	for(size_t d = 0; d < a.size(); ++d)
// 		result.push_back(this->[d]+a[d]);
// 	return result;
// }

// vector<T,Allocator>& operator+ (const vector<T,Allocator>& x)
// {
// 	vector<T,Allocator> result;
// 	for(size_t d = 0; d < x.size(); ++d)
// 		result.push_back(this->first[d]+x[d])
// }

// vector<double> vector::operator+(vector<double a, vector<double> b)
// {
// 	vector<double> result;
// 	for(size_t d = 0; d < a.size(); ++d)
// 		result.push_back(a[d]+b[d]);
// 	return result;
// }

// // define overloaded + (plus) operator
// complx complx::operator+ (const complx& c) const
// {
//       complx result;
//       result.real = (this->real + c.real);
//       result.imag = (this->imag + c.imag);
//       return result;
// }