
 
#ifndef COLOR_H_
#define COLOR_H_

#include <GL/glut.h>

struct Color
{
	Color(){ init = false; };
	Color(GLfloat r, GLfloat g, GLfloat b, GLfloat a)
	{ 
		// Set initial values.
		this->c[0] = r; 
		this->c[1] = g; 
		this->c[2] = b;
		this->c[3] = a;
		init = true;
	}
	GLfloat c[4];
	bool init;
};

#endif /*COLOR_H_*/
