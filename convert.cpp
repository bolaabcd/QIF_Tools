#include <bits/stdc++.h>

using namespace std;

int main() {
	int cases = 0;
	ostringstream sstr;
	sstr << fixed << setprecision(6);
	while(!cin.eof()) {
		string name = "";
		getline(cin,name);
		if(name.size() == 0)
			continue;
		name = name.substr(strlen("> Variable "),name.size()-strlen("> Variable  hyper"));
		string line = "";
		getline(cin,line);
		vector<double> outers;
		vector<vector<double>> inners;
		vector<string> inner_vals;
		while(line.size() > 0 and line[0] != '>') {
			if(line[0] == ' ') {
				string inner_v = line.substr(12,8);
				double inner = atof(inner_v.c_str());
				inners.back().push_back(inner);
				string inner_name = "";
				inner_name = line.substr(22);
				if(inner_vals.size() < inners.back().size())
					inner_vals.push_back(inner_name);
				else
					assert(inner_vals[inners.back().size()-1] == inner_name);
			} else {
				string outer_v = line.substr(0,8);
				double outer = atof(outer_v.c_str());
				outers.push_back(outer);
				string inner_v = line.substr(12,8);
				double inner = atof(inner_v.c_str());
				inners.push_back({inner});

				string inner_name = "";
				inner_name = line.substr(22);
				if(inner_vals.size() < inners.back().size())
					inner_vals.push_back(inner_name);
				else
					assert(inner_vals[inners.back().size()-1] == inner_name);
			}
			line = "";
			getline(cin,line);
		}
		
		assert(inners.size() != 0);
		sstr << name << endl;
		sstr << outers.size() << ' ' << inners[0].size() << endl;
		for(int i = 1; i < inners.size(); i++)
			assert(inners[i].size() == inners[0].size());
		for(int i = 0; i < inner_vals.size(); i++)
			sstr << inner_vals[i] << endl;
		for(int i = 0; i < outers.size(); i++)
			sstr << outers[i] << ' ';
		sstr << endl;
		for(int i = 0; i < inners.size(); i++) {
			for(int j = 0; j < inners[i].size(); j++)
				sstr << inners[i][j] << ' ';
			sstr << endl;
		}
		//sstr << endl;
		cases++;
		getline(cin,line);
		getline(cin,line);
	}
	cout << cases << endl << sstr.str();
}

/*
number of cases

name
number of inners, number of elements per inner
names of each inner element
Probability of each outer (space-separated)
space-separeted inner1
space-separeted inner2
.
.
.
*/
