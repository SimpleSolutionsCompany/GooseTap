// LAB_2_CPP.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;
int main()
{
    int a=10, b=30, c=20;
    const int PI = 3.1415926535;
	cout << "The sum a b c : "<<a+b+c <<endl;
	int sum = a + b + c;

	cout << "The average of a b c : " << sum/3 << endl;
	cout << "The plosha of circle wit radius a " << PI*(a*a) << endl;
	cout << "The plosha of circle wit radius b " << PI * (b * b) << endl;
	cout << "The plosha of circle wit radius b " << PI * (b * b) << endl;

	if (a >= b && a >= c) {
		cout << "Max num is a: "<<a <<endl;
	}
	else if (b >= a && b >= c) {
		cout << "Max num is b: "<<b <<endl;
	}
	else if(c >= a && c >= b)
	{
		cout << "Max num is c: " << c << endl;
	}

	if (a <= b && a <= c) {
		cout << "Min num is a: " << a << endl;
	}
	else if (b <= a && b <= c) {
		cout << "Min num is b: " << b << endl;
	}
	else if (c <= a && c <= b)
	{
		cout << "Min num is c: " << c << endl;
	}

    
	

}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
