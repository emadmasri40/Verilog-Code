/*
 *  
 *  MIPS-Datapath - Graphical MIPS CPU Simulator.
 *  Copyright 2008 Andrew Gascoyne-Cecil.
 * 
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 *  Contact: gascoyne+mips@gmail.com
 * 
 */
 
#ifndef CONFIG_H_
#define CONFIG_H_

#include <wx/colour.h>
#include <map>
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

enum configName		
{
	BAD_NAME = 0,
	CONFIG_MIN_NAME = 1,
	COMPONENT_COLOUR = 1,
	PIPEREG_COLOUR,
	STAGE1_COLOUR,
	STAGE2_COLOUR,
	STAGE3_COLOUR,
	STAGE4_COLOUR,
	STAGE5_COLOUR,
	TEXT_COLOUR,
	FADE_COLOUR,
	BORDER_COLOUR,
	LINK_COLOUR,
	BACKGROUND_COLOUR,
	SHOW_LEFT_PANEL,
	SHOW_INSTRUCTION_FIELDS,
	SHOW_SIMPLE_LAYOUT,
	SHOW_PIPELINE_LAYOUT,
	SHOW_FORWARDING_LAYOUT,
	SHOW_CONTROL_LINES,
	SHOW_PC_LINES,
	SHOW_POPUPS,
	HIGHLIGHT_SINGLE_INSTRUCTION,
	SHOW_BOLD_DATA_LINES,	
	SHOW_FORMAT_BIN,
	SHOW_FORMAT_DEC,
	SHOW_FORMAT_HEX,
	SIMULATOR_SASH_POS,
	EDITOR_SASH_POS,
	CONFIG_MAX_NAME,
};


class Config
{
	public:

		static Config* Instance();
		wxColour getColour(configName name);
		bool getBool(configName name);
		uint getNumber(configName name);
		void setColour(configName name, wxColour newColour);
		bool isNameAColour(configName name){ return nameIsColour[name]; };
		void setBool(configName name, bool newBool);
		void setNumber(configName name, uint newNum);
		void save();
	protected:
		Config();
		Config(const Config&);
		Config& operator=(const Config&);
	private:
					
		enum Symbol
		{
			SYM_BAD,
			SYM_MIN,
			SYM_NUM,
			SYM_COLON,
			SYM_COMMA,
			SYM_SEMICOL,
			SYM_NAME,
			SYM_EOF,
		};
		void setDefaults();
		bool parse();
		void readConfigValue();
		void readToLineEnd();
		void skipSpaces();
		void getSymbol(Symbol & s, uint & num, configName & name);
		void getNumber(uint & num);
		void getName(configName & name);
		void getChar();
		static Config* pinstance;
		map<configName, wxColour> colours;
		map<configName, bool> bools;
		map<configName, uint> numbers;
		map<configName, string> names;
		map<configName, bool> nameIsColour;
		map<configName, bool> isNameANumber;
		map<string, configName> snames;
		ifstream configFile;	
		Symbol curSymbol;
		char curch;
		bool eofile;
};

#endif /*CONFIG_H_*/
