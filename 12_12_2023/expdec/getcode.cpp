#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<double> alfas;
    vector<int> ns;
    for(int i = 0; i < 40; i++)
        alfas.push_back(double(i)*0.05);
    for(int i = 2; i <= 7; i++)
        ns.push_back(i);
    int amt = alfas.size()*ns.size();
    int nsteps = 13;
    cout << "echo -n '' > /tmp/pre.txt" << endl;
    cout << "echo -n '' > progress.txt" << endl;
    for(int i = 0; i < alfas.size(); i++)
        for(int j = 0; j < ns.size(); j++) {
            cout << "echo '"<< i*ns.size()+j << '/' << amt <<  "' >> progress.txt" << endl;
            cout << "sh decexp.sh " << alfas[i] << ' ' << ns[j] << ' ' << nsteps << " prefile.kf channel.kf strat.kf" << endl;
        }
    cout << "echo '" << amt << '/' << amt << "' >> progress.txt" << endl;
}
