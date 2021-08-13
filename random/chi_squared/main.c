#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdio.h>

#define DEGREE_OF_FREEDOM 30
#define NUMBER_OF_TRIALS 300

double chi_square(int observed[], double  expected[], int size) {
	double V = 0;
	for (int i = 0; i < size; i++) {
		double diff = observed[i]-expected[i];
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

void dice_example() {
	int observed[] = {2, 4, 10, 12, 22, 29, 21, 15, 14, 9, 6};
	double  expected[] = {4, 8, 12, 16, 20, 24, 20, 16, 12, 8, 4};
	double chi_value = chi_square(observed, expected, 11);
	printf("%f\n", chi_value);
	printf("z-score: %f\n", z_score(10, chi_value));
}

int main() {
	srand(time(NULL));
	double average = 0.0;
	for (int i = 0; i < 10; i++) {
		int observed[DEGREE_OF_FREEDOM];
		double expected[DEGREE_OF_FREEDOM];
		for (int i = 0; i < DEGREE_OF_FREEDOM; i++) {
			observed[i] = 0;
			expected[i] = (double)NUMBER_OF_TRIALS/DEGREE_OF_FREEDOM;
			//printf("%f\n", expected[i]);
		}
		for (int i = 0; i < NUMBER_OF_TRIALS; i++) {
			//observed[DEGREE_OF_FREEDOM-(rand()%DEGREE_OF_FREEDOM)-1] += 1;
			observed[i%DEGREE_OF_FREEDOM] += 1;
		}
		double chi_value = chi_square(observed, expected, DEGREE_OF_FREEDOM);
		//printf("%f\n", chi_value);
		double score = z_score(DEGREE_OF_FREEDOM, chi_value);
		//printf("z-score: %f\n", score);
		average += score;
		printf("average: %f\n", average/i);
	}
}

