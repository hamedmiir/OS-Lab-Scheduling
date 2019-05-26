#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_incNum(int num)
{
  num++;
  cprintf("increased and print in kernel surface %d\n",num);
  return 22;
}

int
sys_getprocs()
{
  return getprocs();
}

void sys_set_burst_time()
{
  int burst_time;
  argint(0, &burst_time);
  int pid;
  argint(1, &pid);
  find_and_set_burst_time(burst_time , pid);
}
void sys_set_priority()
{
  int priority;
  argint(0, &priority);
  int pid;
  argint(1, &pid);
  find_and_set_priority(priority, pid);
}

void sys_set_lottery_ticket(){
  int lottery_ticket;
  argint(0, &lottery_ticket);
  int pid;
  argint(1, &pid);
  find_and_set_lottery_ticket(lottery_ticket , pid);
}

void sys_set_sched_queue()
{
  int qeue_number;
  argint(0, &qeue_number);
  int pid;
  argint(1, &pid);
  find_and_set_sched_queue(qeue_number, pid);
}

void sys_show_processes_scheduling()
{
  show_all_processes_scheduling();
}