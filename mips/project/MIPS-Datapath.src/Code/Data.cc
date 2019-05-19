
 
#include "Data.h"

Data::Data(int numBits)
{
	this->numBits = numBits;
	// Fill vector to correct size with false (0). 
	for(int i = 0; i < numBits; i++)
	{
		bits.push_back(false);
	}
}

Data::Data(const Data& newData)
{
	int minLength = min(numBits, newData.size());
	for(int i = 0; i < minLength; i++)
	{
		bits[i] = newData.get(i);
	}
}

bool Data::get(int i) const
{
	if((i >= 0) && (i < numBits))
	{
		return bits[i]; 
	}
	return false;
}
