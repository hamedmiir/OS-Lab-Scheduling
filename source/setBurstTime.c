#include "types.h"
#include "stat.h"
#include "fcntl.h" // for using file defines
#include "user.h" // for using from strlen


int main(int argc, char const *argv[])
{
    int pid, burst_time;
    char buf[1024];
    printf(1, "enter pid : ");
    pid = atoi(buf);
    read(1, buf, 1024);
    pid = atoi(buf);
    printf(1, "enter burst time : ");
    read(1, buf, 1024);
    burst_time = atoi(buf);
    set_burst_time(burst_time, pid);
    exit();
}