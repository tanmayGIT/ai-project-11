void testMahalanobisDistance(vector<double>);
void testInnerProduct(vector<double>,vector<double>);
void testOuterProduct(vector<double>,vector<double>);
void testDeterminant(vector<vector<double> >);
void testInverse(vector<vector<double> >);
void testTranspose(vector<vector<double> >);
void testMVNPDF(vector<double>);
void testGMM(vector<double>);

void GMM::testMahalanobisDistance(vector<double> x)
{
	cout << mahalanobisDistance(x, means[0],covariances[0]) << endl;
}

void GMM::testInnerProduct(vector<double> a,vector<double> b)
{
	cout << innerProduct(a,b) << endl;
}

void GMM::testOuterProduct(vector<double> a, vector<double> b)
{
	vector<vector<double> > output = outerProduct(a,b);
	
	for(size_t i = 0; i < a.size(); ++i)
	{
		for(size_t j = 0; j < b.size(); ++j)
			cout << output[i][j] << " ";
		cout << endl;
	}		
}

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

void GMM::testInverse(vector<vector<double> > A)
{
	vector<vector<double> > Ainverse = inverse(A);
	cout << "Inverse of :" << endl;
	printMatrix(A);
	cout << "Is: " << endl;
	printMatrix(Ainverse);
}

void GMM::testMVNPDF(vector<double>)
{
}
void GMM::testGMM(vector<double>)
{
}
void GMM::testTranspose(vector<vector<double> > A)
{
	vector<vector<double> > Atranspose = transpose(A);
	cout << "Transpose of :" << endl;
	printMatrix(A);
	cout << "Is: " << endl;
	printMatrix(Atranspose);
}

