
#ifndef DATA_H_
#define DATA_H_

#include <vector>
#include <algorithm>

using namespace std;

class Data
{
	public:
		Data(){};
		Data(int numBits);
		Data(const Data& newData);
		int size() const { return bits.size(); };
		bool get(int i) const;
	private:
		vector<bool> bits;
		int numBits;
};

#endif /*DATA_H_*/
