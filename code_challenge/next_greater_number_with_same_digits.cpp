/* Find next greater number with same set of digits
 * Have the function MathChallenge(num) take the num parameter being passed 
 * and return the next number greater than num using the same digits.  
 * If a number has no greater permutations, return -1 (ie. 999).
 * Examples
 * Input:  n = 218765 Output: 251678
 * Input:  n = 1234 Output: 1243
 * Input: n = 4321 Output: -1 // Not Possible
 * Input: n = 534976 Output: 536479
 */
#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

std::vector<char> integerToArray(int num)
{
	std::vector<char> v;

	while (true)
	{
		v.insert(v.begin(), num % 10);
		num /= 10;
		if (num == 0)
		{
			return v;
		}
	}

	return v;
}

int arrayToInteger(char arr[], int n)
{
	int i = 0, num = 0;
	for (i = 0; i < n; i++)
	{
		num = num * 10 + arr[i];
	}

	return num;
}

void swap(char& a, char& b)
{
	char tmp = a;
	a = b;
	b = tmp;
}

int findGreaterNumberWithSameDigits(char arr[], int len)
{
	int i = 0;

	/* Start to find the position of the character that is bigger than the character
	 * in front of it, start from the rightmost part of arr
	 */
	for (i = len - 1; i > 0; i--)
	{
		if (arr[i] > arr[i - 1])
		{
			break;
		}
	}

	if (i == 0)
	{
		return (-1); // has no greater permutations
	}

	// find the smallest
	int x = arr[i - 1];
	int currSmallestIdx = i;
	for (int j = i + 1; j < len; j++)
	{
		if (arr[j] > x && arr[j] < arr[currSmallestIdx])
		{
			currSmallestIdx = j;
		}
	}
	// swap
	swap(arr[currSmallestIdx], arr[i - 1]);
	// sort in ascending order
	sort(arr + i, arr + len);

	return arrayToInteger(arr, len);
}

int MathChallenge(int num) {

	// code goes here  
	int resultNum = -1;
	std::vector<char> v = integerToArray(num);

	std::cout << "Input : " << num << " ";
	//std::cout << "[Debug] Num To Array: ";
	//for (int i = 0; i < v.size(); i++) {
	//	printf("%d ", v[i]);
	//}
	//std::cout << endl;

	resultNum = findGreaterNumberWithSameDigits(&v[0], v.size());

	return resultNum;
}

int main(void) 
{

	/*Input:  n = 218765 Output : 251678
	 * Input : n = 1234 Output : 1243
	 * Input : n = 4321 Output : -1 // Not Possible
	 * Input : n = 534976 Output : 536479
	 */
	fflush(stdout);
	printf("Output: %s\n", (MathChallenge(218765) == 251678) ? "251678 <Correct>" : "<Wrong> Expect output: 251678");
	fflush(stdout);
	printf("Output: %s\n", (MathChallenge(1234) == 1243) ? "1243 <Correct>" : "<Wrong> Expect output: 1243");
	fflush(stdout);
	printf("Output: %s\n", (MathChallenge(4321) == -1) ? "-1 <Correct>" : "<Wrong> Expect output: -1");
	fflush(stdout);
	printf("Output: %s\n", (MathChallenge(534976) == 536479) ? "536479 <Correct>" : "<Wrong> Expect output: 536479");

	return 0;
}