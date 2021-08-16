#include <cstdlib>
#include <iostream>

#define K_VALUES 10
#define NUMBER_OF_TRIALS 1000

int get_number() {
	return arc4random_uniform(K_VALUES);
}

int main() {
	double  counts[K_VALUES];
	double  expected_values[K_VALUES];
	for (int i = 0; i < K_VALUES; i++) {
		expected_values[i] = NUMBER_OF_TRIALS/K_VALUES;
		counts[i] = 0;
	}
	for (int i = 0; i < NUMBER_OF_TRIALS; i++) {
		counts[get_number()] += 1;
	}
	double V = 0;
	for (int i = 0; i < K_VALUES; i++) {
		double diff = counts[i]-expected_values[i];
		V += (diff*diff)/expected_values[i];
	}
	std::cout << V << std::endl;
	return 0;
}
