#include "types.h"
#include "stat.h"
#include "user.h"

#define O_RDONLY  0x000
#define O_WRONLY  0x001
#define O_RDWR    0x002
#define O_CREATE  0x200


int
main(int argc, char* argv[])
{
    if(argc != 8) {
        printf(1, "please insert exactly 7 numbers \n");
        exit();
    }

    int array[7], i, j, temp, num = 7;
    for(i = 0; i < 7; i++){
        array[i] = atoi(argv[i+1]);
    }

    for (i = 0; i < num; i++)
    {
        for (j = 0; j < (num - i - 1); j++)
        {
            if (array[j] > array[j + 1])
            {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }

    char t, midInverse[1000];
    int cnt = 0, mid = array[3];
    while(mid != 0) {
        t = (mid % 10) + '0';
        midInverse[cnt] = t;
        mid = mid / 10;
        cnt ++;
    }

    int n = 0;
    char middle[1000];
    for(i = cnt-1; i >= 0; i--) {
        middle[n] = midInverse[i];
        n++;
    }
    middle[n] = '\n';
    
    printf(1, "proccess Id is %d \n", getpid());
    int fileDesc;
    if( (fileDesc = open("result.txt", O_CREATE | O_WRONLY)) < 0) {
        printf(1, "can't open file result.txt");
        exit();
    }
   
    if(write(fileDesc, middle, strlen(middle)) != strlen(middle)) {
        printf(1, "Eror when writing in result.txt");
        exit();
    }
    exit();
}