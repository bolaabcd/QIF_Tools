#include <iostream>
#include <ios>

using namespace std;

#define endl '\n'

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    int nbits, n; 
    cin >> nbits >> n;
    for(int i = 0; i < nbits; i++) {
        cout << (1&(n>>i)) << ' ';
    }
    cout << endl;
}
