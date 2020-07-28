#include<iostream>
#include<fstream>
#include<stdio.h>

using namespace std;

//Employee class Declaration
class Employee{
	public:
        int EmpID;
        char Emp_name[20];
        float salary;

	public:
        void read();
        void display();
        //will return employee ID
        int getEmpID()
			{ return EmpID;}
        //will return employee salary
        int getSalary()
			{ return salary;}
        //will update employee salary
        float updateSalary(float s)
			{ salary=s;
			  return salary;}
};

//Read employee record
void Employee::read(){
    cout<<"Enter employee ID: ";
    cin>>EmpID;
    fflush(stdin);
    cout<<"Enter employee name: ";
    fflush(stdin);
    cin.getline(Emp_name,20);
    fflush(stdin);
    cout<<"Enter salary: ";
    cin>>salary;
}

//Display employee record
void Employee::display()
{
    cout<<EmpID<<"\t"<<Emp_name<<"\t"<<salary<<endl;
}

//global declaration
fstream file;

//Will delete file when program is being executed
//because we are create file in append mode
void deleteExistingFile(){
    remove("EMPLOYEE.DAT");
}

//function to append record into file
void appendToFille(){
    Employee    x;

    //Read employee record from user
    x.read();

    file.open("EMPLOYEE.DAT",ios::binary|ios::app);
    if(!file){
        cout<<"ERROR IN CREATING FILE\n";
        return;
    }
    //write into file
    file.write((char*)&x,sizeof(x));
    file.close();
    cout<<"Record added sucessfully.\n";
}

void displayAll(){
    Employee x;

    file.open("EMPLOYEE.DAT",ios::binary|ios::in);
    if(!file){
        cout<<"ERROR IN OPENING FILE \n";
        return;
    }
    while(file){
    if(file.read((char*)&x,sizeof(x)))
        if(x.getSalary()>=10000 && x.getSalary()<=20000)
            x.display();
    }
  file.close();
}

void searchForRecord(){
    //read employee id
    Employee    x;
    int id;
    int isFound=0;

    cout<<"Enter employee ID: ";
    cin>>id;


    file.open("EMPLOYEE.DAT",ios::binary|ios::in);
    if(!file){
        cout<<"ERROR IN OPENING FILE \n";
        return;
    }
    while(file){
        if(file.read((char*)&x,sizeof(x))){
            if(x.getEmpID()==id){
                cout<<"RECORD FOUND\n";
                x.display();
                isFound=1;
                break;
            }
        }
    }
    if(isFound==0){
        cout<<"Record not found!!!\n";
    }
    file.close();
}

//Function to increase salary
void increaseSalary(){
    //read employee id
    Employee    x;
    int id;
    int isFound=0;
    float sal,y;

    cout<<"enter employee ID \n";
    cin>>id;


    file.open("EMPLOYEE.DAT",ios::binary|ios::in);
    if(!file){
        cout<<"ERROR IN OPENING FILE \n";
        return;
    }
    while(file){
        if(file.read((char*)&x,sizeof(x))){
            if(x.getEmpID()==id){
                cout<<"Salary hike? ";
                cin>>sal;
                y=x.updateSalary(x.getSalary()+sal);
                isFound=1;
                break;
            }
        }
    }
    if(isFound==0){
        cout<<"Record not found!!!\n";
    }
    file.close();
    cout<<"Salary updated successfully."<<endl;
    cout<<"New salary is "<<y;
    x.salary =y;
}

/*Delete a record
void deleteRecord(){
    //read employee ID
    Employee    x;
    cout<<"Enter employee ID: ";
    cin>>EmpID;


    fstream fin;
    //read file in input mode
    file.open("EMPLOYEE.DAT",ios::binary|ios::in);
    //open file in write mode
    fin.open("TEMP.DAT",ios::binary|ios::out);

    if(!file){
        cout<<"Error in opening EMPLOYEE.DAT file!!!\n";
        return;
    }
    if(!fin){
        cout<<"Error in opening TEMP.DAT file!!!\n";
        return;
    }
    while(file){
        if(file.read((char*)&x,sizeof(x))){
            if(x.getEmpID()>newEmp.getEmpID()){
                fin.write((char*)&newEmp, sizeof(newEmp));
            }
            //no need to use else
            fin.write((char*)&x, sizeof(x));
        }
    }

    fin.close();
    file.close();

    rename("TEMP.DAT","EMPLOYEE.DAT");
    remove("TEMP.DAT");
    cout<<"Record inserted successfully."<<endl;
}*/

int main()
{
     char ch;

    //if required then only remove the file
     deleteExistingFile();

     do{
     int n;

     cout<<"ENTER CHOICE\n"<<"1.ADD AN EMPLOYEE\n"<<"2.DISPLAY\n"<<"3.SEARCH\n"<<"4.INCREASE SALARY\n"<<"5.INSERT RECORD\n";
     cout<<"Make a choice: ";
     cin>>n;


     switch(n){
          case 1:
            appendToFille();
            break;
          case 2 :
            displayAll();
            break;
          case 3:
            searchForRecord();
            break;
        case 4:
            increaseSalary();
            break;
        /*case 5:
            insertRecord();
            break;*/

          default :
                cout<<"Invalid Choice\n";
     }

     cout<<"Do you want to continue ? : ";
     cin>>ch;

     }while(ch=='Y'||ch=='y');

    return 0;
}

