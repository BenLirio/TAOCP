#include <stdlib.h>
#include <math.h>
#include <stdio.h>

double chi_square(int observed[], int expected[], int size) {
	double V = 0;
	for (int i = 0; i < size; i++) {
		int diff = observed[i]-expected[i];
		V += (double)(diff*diff)/expected[i];
	}
	return V;
}

double distribution(double v, double x_p) {
	return (v) + (sqrt(2*v)*x_p) + ((2.0/3.0)*x_p*x_p) - (2.0/3.0);
}
double z_score(double v, double D) {
	return sqrt((3.0*D)/2 + 1 - (3.0*v)/2 + (9.0*v)/8)-(3*sqrt(2*v)/4);
}


int main() {
	int observed[] = {2, 4, 10, 12, 22, 29, 21, 15, 14, 9, 6};
	int expected[] = {4, 8, 12, 16, 20, 24, 20, 16, 12, 8, 4};
	double chi_value = chi_square(observed, expected, 11);
	printf("%f\n", chi_value);
	printf("z-score: %f\n", z_score(10, chi_value));
}

