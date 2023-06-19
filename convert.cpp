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
		vector<map<string,double>> inners;
		set<string> inner_vals;
		while(line.size() > 0 and line[0] != '>') {
			if(line[0] == ' ') {
				string inner_v = line.substr(12,8);
				double inner = atof(inner_v.c_str());
				string inner_name = "";
				inner_name = line.substr(22);
				inner_vals.insert(inner_name);
				inners.back()[inner_name] = inner;
			} else {
				string outer_v = line.substr(0,8);
				double outer = atof(outer_v.c_str());
				outers.push_back(outer);
				string inner_v = line.substr(11,8);
				double inner = atof(inner_v.c_str());

				string inner_name = "";
				inner_name = line.substr(22);
				inners.push_back(map<string,double>{{inner_name,inner}});
				inner_vals.insert(inner_name);
			}
			line = "";
			getline(cin,line);
		}
		
		assert(inners.size() != 0);
		sstr << name << endl;
		sstr << inner_vals.size() << ' ' << outers.size() << endl;
		for(string s : inner_vals)
			sstr << s << endl;
		for(int i = 0; i < outers.size(); i++)
			sstr << outers[i] << ' ';
		sstr << endl;
		for(int i = 0; i < inners.size(); i++) {
			for(string j: inner_vals) {
				sstr << inners[i][j] << ' ';
			}
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
number of inner elements, number of inners
names of each inner element
Probability of each inner (space-separated)
space-separeted inner1
space-separeted inner2
.
.
.
*/
