#include <iostream>
#include <ios>

using namespace std;

#define endl '\n'

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    int n = 5;
    for(int i = 0; i < (1<<n); i++) {
        for(int j = n-1; j >= 0; j--)
            cout << !!(i & (1<<j)) << ' ';
        cout << endl;
    }
}
