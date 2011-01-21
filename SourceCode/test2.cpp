#include <iostream>
#include <map>
#include <cmath>
#include <vector>

using namespace std;

int main()
{
	char* filename = "test_observations";
	ifstream test(filename);
	string line;
	getline(test,line);
	cout << line << endl;
	
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