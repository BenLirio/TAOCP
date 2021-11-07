#include <stdlib.h>
#include <iostream>
#include <limits>

#define N_TRIALS 50

uint32_t cdf(uint32_t x) {
	return x;
}

uint32_t random_value() {
	return arc4random();
}

int left(int idx) {
	return (idx<<1);
}
int right(int idx) {
	return (idx<<1)+1;
}
int parent(int idx) {
	return idx>>1;
}

void min_heapify(uint32_t *vals, int idx) {
	uint32_t smallest_idx = idx;
	if (left(idx)-1 < N_TRIALS && vals[left(idx)-1] < vals[smallest_idx-1]) {
		smallest_idx = left(idx);
	}
	if (right(idx)-1 < N_TRIALS && vals[right(idx)-1] < vals[smallest_idx-1]) {
		smallest_idx = right(idx);
	}
	if (idx == smallest_idx) {
		return;
	}
	uint32_t tmp = vals[smallest_idx-1];
	vals[smallest_idx-1] = vals[idx-1];
	vals[idx-1] = tmp;
	min_heapify(vals, smallest_idx);
}

void sort(uint32_t *vals) {
	for (int i = N_TRIALS/2; i >= 1; i--) {
		min_heapify(vals, i);
	}
	uint32_t sorted_vals[N_TRIALS];
	for (int i = 0; i < N_TRIALS; i++) {
		sorted_vals[i] = vals[0];
		vals[0] = std::numeric_limits<uint32_t>::max();
		min_heapify(vals, 1);
	}
	for (int i = 0; i < N_TRIALS; i++) {
		vals[i] = sorted_vals[i];
	}
}

int main() {
	uint32_t experiment_outcome[N_TRIALS];
	for (int i = 0; i < N_TRIALS; i++) {
		experiment_outcome[i] = random_value();
	}
	sort(experiment_outcome);
	
	uint32_t step = std::numeric_limits<uint32_t>::max()/N_TRIALS;
	uint32_t Kminus = 0;
	uint32_t Kplus = 0;
	for (int i = 0; i < N_TRIALS; i++) {
		uint32_t curKminus = step*(i+1) - cdf(experiment_outcome[i]);
		if (curKminus > Kminus) {
			Kminus = curKminus;
		}
		uint32_t curKplus = cdf(experiment_outcome[i]) - step*i;
		if (curKplus > Kplus) {
			Kplus = curKplus;
		}
		
	}
	std::cout << (double)Kminus/std::numeric_limits<uint32_t>::max() << std::endl;
	std::cout << (double)Kplus/std::numeric_limits<uint32_t>::max() << std::endl;
	return 0;
}
