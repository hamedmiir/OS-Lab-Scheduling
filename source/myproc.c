#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
// #include "stdio.h"

int main(int argc ,char* argv[])
{
    int num = argc;
    incNum(num);
    printf(1 ,"Orginal number is %d\n",num);
    getprocs();

    exit();
}