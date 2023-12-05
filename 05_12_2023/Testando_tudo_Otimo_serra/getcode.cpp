#include <iostream>

using namespace std;

int main() {
    int m = 14;
    int n = (1<<m);
    cout << "echo -n '' > /tmp/pre.txt" << endl;
    cout << "echo -n '' > progress.txt" << endl;
    for(int i = 0; i < n; i++) {
        cout << "sh testone.sh 1 " << m << ' ' << '"';
        cout << i%2;
        for(int j = 1; j < m; j++)
            cout << ' ' << ((i>>j)&1);
        cout << '"' << ' ' << i <<  " prefile.kf channel.kf strat.kf & " << endl;
        if (i%50 == 49) {
            cout << "wait" << endl;
            for(int k = i-49; k <= i; k++) {
                cout << "rm /tmp/sim" << k << ".kf" << endl;
                cout << "rm /tmp/sim" << k << ".txt" << endl;
                cout << "rm /tmp/simini" << k << ".kf" << endl;
                cout << "rm /tmp/simini" << k << ".txt" << endl;
                cout << "echo " << i/50 << '/' << n/50 << endl;
                cout << "echo " << i/50 << '/' << n/50 << " >> progress.txt" << endl;
            }
        }
    }
    cout << "wait" << endl;
    cout << "mv /tmp/vulnsall.txt vals.txt" << endl;
}
