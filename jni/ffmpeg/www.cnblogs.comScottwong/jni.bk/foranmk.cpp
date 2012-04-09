#include<iostream>
#include<fstream>

using namespace std;

int main()
{
const char filename[] = "Android.mk";
const char ofile[] = "Android";
ofstream fo;
ifstream fi;
string line;

fo.open(ofile);
fi.open(filename);
if(fi.is_open())
{
	cout << "file opened." << endl;
	while(fi.good())
	{
		getline(fi, line);
		cout << line << endl;
		fo << line.substr(6) << endl;
	}
}
else
{
	cout << "file open err." << endl;
}

fo.close();
fi.close();

return 0;
}
