
_schedTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void lotteryTest();
void multilevelQueue();
void showProcessScheduling();

int main(int argc, char const *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    set_lottery_ticket(50, getpid());
  11:	e8 a1 07 00 00       	call   7b7 <getpid>
  16:	83 ec 08             	sub    $0x8,%esp
  19:	50                   	push   %eax
  1a:	6a 32                	push   $0x32
  1c:	e8 d6 07 00 00       	call   7f7 <set_lottery_ticket>
    multilevelQueue();
  21:	e8 0a 03 00 00       	call   330 <multilevelQueue>
    exit();
  26:	e8 0c 07 00 00       	call   737 <exit>
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <showProcessScheduling>:
}

void showProcessScheduling()
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
    show_processes_scheduling();
}
  33:	5d                   	pop    %ebp
    show_processes_scheduling();
  34:	e9 ce 07 00 00       	jmp    807 <show_processes_scheduling>
  39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000040 <priorityTest>:

void priorityTest()
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	56                   	push   %esi
  44:	53                   	push   %ebx
  set_sched_queue(PRIORITY, getpid());
  45:	e8 6d 07 00 00       	call   7b7 <getpid>
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	50                   	push   %eax
  4e:	6a 01                	push   $0x1
  50:	e8 aa 07 00 00       	call   7ff <set_sched_queue>
  set_priority(0, getpid());
  55:	e8 5d 07 00 00       	call   7b7 <getpid>
  5a:	59                   	pop    %ecx
  5b:	5b                   	pop    %ebx
  5c:	50                   	push   %eax
  5d:	6a 00                	push   $0x0
  int pid = getpid();
  5f:	bb 04 00 00 00       	mov    $0x4,%ebx
  set_priority(0, getpid());
  64:	e8 86 07 00 00       	call   7ef <set_priority>
  int pid = getpid();
  69:	e8 49 07 00 00       	call   7b7 <getpid>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c6                	mov    %eax,%esi
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
  73:	85 f6                	test   %esi,%esi
  75:	7f 49                	jg     c0 <priorityTest+0x80>
    for(i = 1; i < NCHILD; i++)
  77:	83 eb 01             	sub    $0x1,%ebx
  7a:	75 f7                	jne    73 <priorityTest+0x33>
                break;
            
        }
    }
       
    if(pid < 0)
  7c:	85 f6                	test   %esi,%esi
  7e:	0f 88 ab 00 00 00    	js     12f <priorityTest+0xef>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
  84:	74 48                	je     ce <priorityTest+0x8e>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD; i++)
            wait();
  86:	e8 b4 06 00 00       	call   73f <wait>
  8b:	e8 af 06 00 00       	call   73f <wait>
  90:	e8 aa 06 00 00       	call   73f <wait>
  95:	e8 a5 06 00 00       	call   73f <wait>
  9a:	e8 a0 06 00 00       	call   73f <wait>
        printf(1, "Main user program finished pid %d\n", getpid());
  9f:	e8 13 07 00 00       	call   7b7 <getpid>
  a4:	83 ec 04             	sub    $0x4,%esp
  a7:	50                   	push   %eax
  a8:	68 2c 0c 00 00       	push   $0xc2c
  ad:	6a 01                	push   $0x1
  af:	e8 fc 07 00 00       	call   8b0 <printf>
  b4:	83 c4 10             	add    $0x10,%esp
    }
}
  b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ba:	5b                   	pop    %ebx
  bb:	5e                   	pop    %esi
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    
  be:	66 90                	xchg   %ax,%ax
            pid = fork();
  c0:	e8 6a 06 00 00       	call   72f <fork>
            if(pid > 0)
  c5:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
  c8:	89 c6                	mov    %eax,%esi
            if(pid > 0)
  ca:	7f 44                	jg     110 <priorityTest+0xd0>
            if(pid == 0 )
  cc:	75 a9                	jne    77 <priorityTest+0x37>
        ownPid = getpid();
  ce:	e8 e4 06 00 00       	call   7b7 <getpid>
  d3:	bb 40 0d 03 00       	mov    $0x30d40,%ebx
  d8:	89 c6                	mov    %eax,%esi
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(200000000);
  e0:	83 ec 0c             	sub    $0xc,%esp
  e3:	68 00 c2 eb 0b       	push   $0xbebc200
  e8:	e8 13 06 00 00       	call   700 <delay>
        for(i = 0 ; i < 200000 ; i++)
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	83 eb 01             	sub    $0x1,%ebx
  f3:	75 eb                	jne    e0 <priorityTest+0xa0>
        printf(1, "%d\n", ownPid);
  f5:	83 ec 04             	sub    $0x4,%esp
  f8:	56                   	push   %esi
  f9:	68 14 0c 00 00       	push   $0xc14
  fe:	6a 01                	push   $0x1
 100:	e8 ab 07 00 00       	call   8b0 <printf>
 105:	83 c4 10             	add    $0x10,%esp
}
 108:	8d 65 f8             	lea    -0x8(%ebp),%esp
 10b:	5b                   	pop    %ebx
 10c:	5e                   	pop    %esi
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
 10f:	90                   	nop
            set_sched_queue(PRIORITY, pid);
 110:	83 ec 08             	sub    $0x8,%esp
 113:	50                   	push   %eax
 114:	6a 01                	push   $0x1
 116:	e8 e4 06 00 00       	call   7ff <set_sched_queue>
            set_priority(10-i, pid);
 11b:	58                   	pop    %eax
 11c:	8d 43 05             	lea    0x5(%ebx),%eax
 11f:	5a                   	pop    %edx
 120:	56                   	push   %esi
 121:	50                   	push   %eax
 122:	e8 c8 06 00 00       	call   7ef <set_priority>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	e9 48 ff ff ff       	jmp    77 <priorityTest+0x37>
        printf(2, "fork error\n");
 12f:	83 ec 08             	sub    $0x8,%esp
 132:	68 08 0c 00 00       	push   $0xc08
 137:	6a 02                	push   $0x2
 139:	e8 72 07 00 00       	call   8b0 <printf>
 13e:	83 c4 10             	add    $0x10,%esp
}
 141:	8d 65 f8             	lea    -0x8(%ebp),%esp
 144:	5b                   	pop    %ebx
 145:	5e                   	pop    %esi
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    
 148:	90                   	nop
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <SJFTest>:

void SJFTest(){
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	56                   	push   %esi
 154:	53                   	push   %ebx

  int pid = getpid();
   set_sched_queue(SJF, getpid());
 155:	bb 04 00 00 00       	mov    $0x4,%ebx
  int pid = getpid();
 15a:	e8 58 06 00 00       	call   7b7 <getpid>
 15f:	89 c6                	mov    %eax,%esi
   set_sched_queue(SJF, getpid());
 161:	e8 51 06 00 00       	call   7b7 <getpid>
 166:	83 ec 08             	sub    $0x8,%esp
 169:	50                   	push   %eax
 16a:	6a 02                	push   $0x2
 16c:	e8 8e 06 00 00       	call   7ff <set_sched_queue>
 171:	83 c4 10             	add    $0x10,%esp
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
 174:	85 f6                	test   %esi,%esi
 176:	7f 50                	jg     1c8 <SJFTest+0x78>
    for(i = 1; i < NCHILD; i++)
 178:	83 eb 01             	sub    $0x1,%ebx
 17b:	75 f7                	jne    174 <SJFTest+0x24>
            if(pid == 0 )
                break;
        }
    }
       
    if(pid < 0)
 17d:	85 f6                	test   %esi,%esi
 17f:	0f 88 ae 00 00 00    	js     233 <SJFTest+0xe3>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
 185:	74 4f                	je     1d6 <SJFTest+0x86>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD + 1; i++)
            wait();
 187:	e8 b3 05 00 00       	call   73f <wait>
 18c:	e8 ae 05 00 00       	call   73f <wait>
 191:	e8 a9 05 00 00       	call   73f <wait>
 196:	e8 a4 05 00 00       	call   73f <wait>
 19b:	e8 9f 05 00 00       	call   73f <wait>
 1a0:	e8 9a 05 00 00       	call   73f <wait>
        printf(1, "Main user program finished pid %d\n", getpid());
 1a5:	e8 0d 06 00 00       	call   7b7 <getpid>
 1aa:	83 ec 04             	sub    $0x4,%esp
 1ad:	50                   	push   %eax
 1ae:	68 2c 0c 00 00       	push   $0xc2c
 1b3:	6a 01                	push   $0x1
 1b5:	e8 f6 06 00 00       	call   8b0 <printf>
 1ba:	83 c4 10             	add    $0x10,%esp
    }
}
 1bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c0:	5b                   	pop    %ebx
 1c1:	5e                   	pop    %esi
 1c2:	5d                   	pop    %ebp
 1c3:	c3                   	ret    
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            pid = fork();
 1c8:	e8 62 05 00 00       	call   72f <fork>
            if(pid > 0)
 1cd:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 1d0:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 1d2:	7f 4c                	jg     220 <SJFTest+0xd0>
            if(pid == 0 )
 1d4:	75 a2                	jne    178 <SJFTest+0x28>
        ownPid = getpid();
 1d6:	e8 dc 05 00 00       	call   7b7 <getpid>
 1db:	bb 20 4e 00 00       	mov    $0x4e20,%ebx
 1e0:	89 c6                	mov    %eax,%esi
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(200000000);
 1e8:	83 ec 0c             	sub    $0xc,%esp
 1eb:	68 00 c2 eb 0b       	push   $0xbebc200
 1f0:	e8 0b 05 00 00       	call   700 <delay>
        for(i = 0 ; i < 20000 ; i++)
 1f5:	83 c4 10             	add    $0x10,%esp
 1f8:	83 eb 01             	sub    $0x1,%ebx
 1fb:	75 eb                	jne    1e8 <SJFTest+0x98>
        printf(1, "%d\n", ownPid);
 1fd:	83 ec 04             	sub    $0x4,%esp
 200:	56                   	push   %esi
 201:	68 14 0c 00 00       	push   $0xc14
 206:	6a 01                	push   $0x1
 208:	e8 a3 06 00 00       	call   8b0 <printf>
 20d:	83 c4 10             	add    $0x10,%esp
}
 210:	8d 65 f8             	lea    -0x8(%ebp),%esp
 213:	5b                   	pop    %ebx
 214:	5e                   	pop    %esi
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                set_sched_queue(SJF, pid);
 220:	83 ec 08             	sub    $0x8,%esp
 223:	50                   	push   %eax
 224:	6a 02                	push   $0x2
 226:	e8 d4 05 00 00       	call   7ff <set_sched_queue>
 22b:	83 c4 10             	add    $0x10,%esp
 22e:	e9 45 ff ff ff       	jmp    178 <SJFTest+0x28>
        printf(2, "fork error\n");
 233:	83 ec 08             	sub    $0x8,%esp
 236:	68 08 0c 00 00       	push   $0xc08
 23b:	6a 02                	push   $0x2
 23d:	e8 6e 06 00 00       	call   8b0 <printf>
 242:	83 c4 10             	add    $0x10,%esp
}
 245:	8d 65 f8             	lea    -0x8(%ebp),%esp
 248:	5b                   	pop    %ebx
 249:	5e                   	pop    %esi
 24a:	5d                   	pop    %ebp
 24b:	c3                   	ret    
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <lotteryTest>:

void lotteryTest(){
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
  int pid = getpid();
 255:	bb 04 00 00 00       	mov    $0x4,%ebx
 25a:	e8 58 05 00 00       	call   7b7 <getpid>
 25f:	89 c6                	mov    %eax,%esi
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
 261:	85 f6                	test   %esi,%esi
 263:	7f 33                	jg     298 <lotteryTest+0x48>
    for(i = 1; i < NCHILD; i++)
 265:	83 eb 01             	sub    $0x1,%ebx
 268:	75 f7                	jne    261 <lotteryTest+0x11>
            
        }
            
    }
       
    if(pid < 0)
 26a:	85 f6                	test   %esi,%esi
 26c:	0f 88 9d 00 00 00    	js     30f <lotteryTest+0xbf>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
 272:	74 32                	je     2a6 <lotteryTest+0x56>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD; i++)
            wait();
 274:	e8 c6 04 00 00       	call   73f <wait>
 279:	e8 c1 04 00 00       	call   73f <wait>
 27e:	e8 bc 04 00 00       	call   73f <wait>
 283:	e8 b7 04 00 00       	call   73f <wait>
    }
}
 288:	8d 65 f8             	lea    -0x8(%ebp),%esp
 28b:	5b                   	pop    %ebx
 28c:	5e                   	pop    %esi
 28d:	5d                   	pop    %ebp
            wait();
 28e:	e9 ac 04 00 00       	jmp    73f <wait>
 293:	90                   	nop
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            pid = fork();
 298:	e8 92 04 00 00       	call   72f <fork>
            if(pid > 0)
 29d:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 2a0:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 2a2:	7f 4c                	jg     2f0 <lotteryTest+0xa0>
            if(pid == 0 )
 2a4:	75 bf                	jne    265 <lotteryTest+0x15>
        ownPid = getpid();
 2a6:	e8 0c 05 00 00       	call   7b7 <getpid>
 2ab:	bb 00 2d 31 01       	mov    $0x1312d00,%ebx
 2b0:	89 c6                	mov    %eax,%esi
 2b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(2000000000);
 2b8:	83 ec 0c             	sub    $0xc,%esp
 2bb:	68 00 94 35 77       	push   $0x77359400
 2c0:	e8 3b 04 00 00       	call   700 <delay>
        for(i = 0 ; i < 20000000 ; i++)
 2c5:	83 c4 10             	add    $0x10,%esp
 2c8:	83 eb 01             	sub    $0x1,%ebx
 2cb:	75 eb                	jne    2b8 <lotteryTest+0x68>
        printf(1, "%d\n", ownPid);
 2cd:	83 ec 04             	sub    $0x4,%esp
 2d0:	56                   	push   %esi
 2d1:	68 14 0c 00 00       	push   $0xc14
 2d6:	6a 01                	push   $0x1
 2d8:	e8 d3 05 00 00       	call   8b0 <printf>
 2dd:	83 c4 10             	add    $0x10,%esp
}
 2e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e3:	5b                   	pop    %ebx
 2e4:	5e                   	pop    %esi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                set_sched_queue(LOTTERY, pid);
 2f0:	83 ec 08             	sub    $0x8,%esp
 2f3:	50                   	push   %eax
 2f4:	6a 03                	push   $0x3
 2f6:	e8 04 05 00 00       	call   7ff <set_sched_queue>
                set_lottery_ticket(10-i, pid);
 2fb:	58                   	pop    %eax
 2fc:	8d 43 05             	lea    0x5(%ebx),%eax
 2ff:	5a                   	pop    %edx
 300:	56                   	push   %esi
 301:	50                   	push   %eax
 302:	e8 f0 04 00 00       	call   7f7 <set_lottery_ticket>
 307:	83 c4 10             	add    $0x10,%esp
 30a:	e9 56 ff ff ff       	jmp    265 <lotteryTest+0x15>
        printf(2, "fork error\n");
 30f:	83 ec 08             	sub    $0x8,%esp
 312:	68 08 0c 00 00       	push   $0xc08
 317:	6a 02                	push   $0x2
 319:	e8 92 05 00 00       	call   8b0 <printf>
 31e:	83 c4 10             	add    $0x10,%esp
}
 321:	8d 65 f8             	lea    -0x8(%ebp),%esp
 324:	5b                   	pop    %ebx
 325:	5e                   	pop    %esi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <multilevelQueue>:

void multilevelQueue() {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
                    set_sched_queue(SJF, pid);
                }
                else if( i < NCHILD * 3)
                {
                    set_sched_queue(LOTTERY, pid);
                    set_lottery_ticket(NCHILD * 3 - i, pid);
 336:	bf 0f 00 00 00       	mov    $0xf,%edi
    for(i = 0; i < 3 * NCHILD; i++)
 33b:	31 db                	xor    %ebx,%ebx
void multilevelQueue() {
 33d:	83 ec 0c             	sub    $0xc,%esp
    int pid = getpid();
 340:	e8 72 04 00 00       	call   7b7 <getpid>
 345:	89 c6                	mov    %eax,%esi
 347:	eb 0f                	jmp    358 <multilevelQueue+0x28>
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 3 * NCHILD; i++)
 350:	83 c3 01             	add    $0x1,%ebx
 353:	83 fb 0f             	cmp    $0xf,%ebx
 356:	74 38                	je     390 <multilevelQueue+0x60>
        if(pid > 0)
 358:	85 f6                	test   %esi,%esi
 35a:	7e f4                	jle    350 <multilevelQueue+0x20>
            pid = fork();
 35c:	e8 ce 03 00 00       	call   72f <fork>
            if(pid > 0)
 361:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 364:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 366:	7e 70                	jle    3d8 <multilevelQueue+0xa8>
                if(i < NCHILD)
 368:	83 fb 04             	cmp    $0x4,%ebx
 36b:	0f 8e b7 00 00 00    	jle    428 <multilevelQueue+0xf8>
                else if( i < NCHILD * 2)
 371:	83 fb 09             	cmp    $0x9,%ebx
 374:	0f 8f d6 00 00 00    	jg     450 <multilevelQueue+0x120>
                    set_sched_queue(SJF, pid);
 37a:	83 ec 08             	sub    $0x8,%esp
    for(i = 0; i < 3 * NCHILD; i++)
 37d:	83 c3 01             	add    $0x1,%ebx
                    set_sched_queue(SJF, pid);
 380:	50                   	push   %eax
 381:	6a 02                	push   $0x2
 383:	e8 77 04 00 00       	call   7ff <set_sched_queue>
 388:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 3 * NCHILD; i++)
 38b:	83 fb 0f             	cmp    $0xf,%ebx
 38e:	75 c8                	jne    358 <multilevelQueue+0x28>
            }
        }
            
    }
       
    if(pid < 0)
 390:	85 f6                	test   %esi,%esi
 392:	0f 88 f8 00 00 00    	js     490 <multilevelQueue+0x160>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0 && (queue == LOTTERY || queue == SJF))
 398:	74 4d                	je     3e7 <multilevelQueue+0xb7>
    {
        printf(1, "IO bound process with pid %d finished\n", getpid());
    }
    else
    {
        show_processes_scheduling();
 39a:	bb 0f 00 00 00       	mov    $0xf,%ebx
 39f:	e8 63 04 00 00       	call   807 <show_processes_scheduling>
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int i;
        for(i = 0; i < NCHILD * 3 ; i++)
            wait();
 3a8:	e8 92 03 00 00       	call   73f <wait>
        for(i = 0; i < NCHILD * 3 ; i++)
 3ad:	83 eb 01             	sub    $0x1,%ebx
 3b0:	75 f6                	jne    3a8 <multilevelQueue+0x78>
        printf(1, "main program wirh pid %d finished\n", getpid());
 3b2:	e8 00 04 00 00       	call   7b7 <getpid>
 3b7:	83 ec 04             	sub    $0x4,%esp
 3ba:	50                   	push   %eax
 3bb:	68 50 0c 00 00       	push   $0xc50
 3c0:	6a 01                	push   $0x1
 3c2:	e8 e9 04 00 00       	call   8b0 <printf>
 3c7:	83 c4 10             	add    $0x10,%esp
    }
 3ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cd:	5b                   	pop    %ebx
 3ce:	5e                   	pop    %esi
 3cf:	5f                   	pop    %edi
 3d0:	5d                   	pop    %ebp
 3d1:	c3                   	ret    
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(pid == 0 )
 3d8:	0f 85 72 ff ff ff    	jne    350 <multilevelQueue+0x20>
                queue = i < NCHILD ? PRIORITY : i < NCHILD * 2 ? SJF : LOTTERY;
 3de:	83 fb 04             	cmp    $0x4,%ebx
 3e1:	0f 8e 89 00 00 00    	jle    470 <multilevelQueue+0x140>
    for(i = 0; i < 3 * NCHILD; i++)
 3e7:	bb 90 d0 03 00       	mov    $0x3d090,%ebx
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            delay(2000000000);
 3f0:	83 ec 0c             	sub    $0xc,%esp
 3f3:	68 00 94 35 77       	push   $0x77359400
 3f8:	e8 03 03 00 00       	call   700 <delay>
        for(i = 0 ; i < 250000 ; i++)
 3fd:	83 c4 10             	add    $0x10,%esp
 400:	83 eb 01             	sub    $0x1,%ebx
 403:	75 eb                	jne    3f0 <multilevelQueue+0xc0>
        printf(1, "pid %d finished\n", getpid());
 405:	e8 ad 03 00 00       	call   7b7 <getpid>
 40a:	83 ec 04             	sub    $0x4,%esp
 40d:	50                   	push   %eax
 40e:	68 18 0c 00 00       	push   $0xc18
 413:	6a 01                	push   $0x1
 415:	e8 96 04 00 00       	call   8b0 <printf>
    {
 41a:	83 c4 10             	add    $0x10,%esp
 41d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 420:	5b                   	pop    %ebx
 421:	5e                   	pop    %esi
 422:	5f                   	pop    %edi
 423:	5d                   	pop    %ebp
 424:	c3                   	ret    
 425:	8d 76 00             	lea    0x0(%esi),%esi
                    set_sched_queue(PRIORITY, pid);
 428:	83 ec 08             	sub    $0x8,%esp
 42b:	50                   	push   %eax
 42c:	6a 01                	push   $0x1
 42e:	e8 cc 03 00 00       	call   7ff <set_sched_queue>
                    set_priority(NCHILD * 3 - i, pid);
 433:	59                   	pop    %ecx
 434:	58                   	pop    %eax
 435:	89 f8                	mov    %edi,%eax
 437:	56                   	push   %esi
 438:	29 d8                	sub    %ebx,%eax
 43a:	50                   	push   %eax
 43b:	e8 af 03 00 00       	call   7ef <set_priority>
 440:	83 c4 10             	add    $0x10,%esp
 443:	e9 08 ff ff ff       	jmp    350 <multilevelQueue+0x20>
 448:	90                   	nop
 449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    set_sched_queue(LOTTERY, pid);
 450:	83 ec 08             	sub    $0x8,%esp
 453:	50                   	push   %eax
 454:	6a 03                	push   $0x3
 456:	e8 a4 03 00 00       	call   7ff <set_sched_queue>
                    set_lottery_ticket(NCHILD * 3 - i, pid);
 45b:	58                   	pop    %eax
 45c:	89 f8                	mov    %edi,%eax
 45e:	5a                   	pop    %edx
 45f:	29 d8                	sub    %ebx,%eax
 461:	56                   	push   %esi
 462:	50                   	push   %eax
 463:	e8 8f 03 00 00       	call   7f7 <set_lottery_ticket>
 468:	83 c4 10             	add    $0x10,%esp
 46b:	e9 e0 fe ff ff       	jmp    350 <multilevelQueue+0x20>
        printf(1, "IO bound process with pid %d finished\n", getpid());
 470:	e8 42 03 00 00       	call   7b7 <getpid>
 475:	83 ec 04             	sub    $0x4,%esp
 478:	50                   	push   %eax
 479:	68 74 0c 00 00       	push   $0xc74
 47e:	6a 01                	push   $0x1
 480:	e8 2b 04 00 00       	call   8b0 <printf>
 485:	83 c4 10             	add    $0x10,%esp
 488:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48b:	5b                   	pop    %ebx
 48c:	5e                   	pop    %esi
 48d:	5f                   	pop    %edi
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    
        printf(2, "fork error\n");
 490:	83 ec 08             	sub    $0x8,%esp
 493:	68 08 0c 00 00       	push   $0xc08
 498:	6a 02                	push   $0x2
 49a:	e8 11 04 00 00       	call   8b0 <printf>
 49f:	83 c4 10             	add    $0x10,%esp
 4a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a5:	5b                   	pop    %ebx
 4a6:	5e                   	pop    %esi
 4a7:	5f                   	pop    %edi
 4a8:	5d                   	pop    %ebp
 4a9:	c3                   	ret    
 4aa:	66 90                	xchg   %ax,%ax
 4ac:	66 90                	xchg   %ax,%ax
 4ae:	66 90                	xchg   %ax,%ax

000004b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	53                   	push   %ebx
 4b4:	8b 45 08             	mov    0x8(%ebp),%eax
 4b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4ba:	89 c2                	mov    %eax,%edx
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4c0:	83 c1 01             	add    $0x1,%ecx
 4c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 4c7:	83 c2 01             	add    $0x1,%edx
 4ca:	84 db                	test   %bl,%bl
 4cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 4cf:	75 ef                	jne    4c0 <strcpy+0x10>
    ;
  return os;
}
 4d1:	5b                   	pop    %ebx
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	8b 55 08             	mov    0x8(%ebp),%edx
 4e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4ea:	0f b6 02             	movzbl (%edx),%eax
 4ed:	0f b6 19             	movzbl (%ecx),%ebx
 4f0:	84 c0                	test   %al,%al
 4f2:	75 1c                	jne    510 <strcmp+0x30>
 4f4:	eb 2a                	jmp    520 <strcmp+0x40>
 4f6:	8d 76 00             	lea    0x0(%esi),%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 500:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 503:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 506:	83 c1 01             	add    $0x1,%ecx
 509:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 50c:	84 c0                	test   %al,%al
 50e:	74 10                	je     520 <strcmp+0x40>
 510:	38 d8                	cmp    %bl,%al
 512:	74 ec                	je     500 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 514:	29 d8                	sub    %ebx,%eax
}
 516:	5b                   	pop    %ebx
 517:	5d                   	pop    %ebp
 518:	c3                   	ret    
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 520:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 522:	29 d8                	sub    %ebx,%eax
}
 524:	5b                   	pop    %ebx
 525:	5d                   	pop    %ebp
 526:	c3                   	ret    
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000530 <strlen>:

uint
strlen(const char *s)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 536:	80 39 00             	cmpb   $0x0,(%ecx)
 539:	74 15                	je     550 <strlen+0x20>
 53b:	31 d2                	xor    %edx,%edx
 53d:	8d 76 00             	lea    0x0(%esi),%esi
 540:	83 c2 01             	add    $0x1,%edx
 543:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 547:	89 d0                	mov    %edx,%eax
 549:	75 f5                	jne    540 <strlen+0x10>
    ;
  return n;
}
 54b:	5d                   	pop    %ebp
 54c:	c3                   	ret    
 54d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 550:	31 c0                	xor    %eax,%eax
}
 552:	5d                   	pop    %ebp
 553:	c3                   	ret    
 554:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 55a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000560 <memset>:

void*
memset(void *dst, int c, uint n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 567:	8b 4d 10             	mov    0x10(%ebp),%ecx
 56a:	8b 45 0c             	mov    0xc(%ebp),%eax
 56d:	89 d7                	mov    %edx,%edi
 56f:	fc                   	cld    
 570:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 572:	89 d0                	mov    %edx,%eax
 574:	5f                   	pop    %edi
 575:	5d                   	pop    %ebp
 576:	c3                   	ret    
 577:	89 f6                	mov    %esi,%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000580 <strchr>:

char*
strchr(const char *s, char c)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	8b 45 08             	mov    0x8(%ebp),%eax
 587:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 58a:	0f b6 10             	movzbl (%eax),%edx
 58d:	84 d2                	test   %dl,%dl
 58f:	74 1d                	je     5ae <strchr+0x2e>
    if(*s == c)
 591:	38 d3                	cmp    %dl,%bl
 593:	89 d9                	mov    %ebx,%ecx
 595:	75 0d                	jne    5a4 <strchr+0x24>
 597:	eb 17                	jmp    5b0 <strchr+0x30>
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a0:	38 ca                	cmp    %cl,%dl
 5a2:	74 0c                	je     5b0 <strchr+0x30>
  for(; *s; s++)
 5a4:	83 c0 01             	add    $0x1,%eax
 5a7:	0f b6 10             	movzbl (%eax),%edx
 5aa:	84 d2                	test   %dl,%dl
 5ac:	75 f2                	jne    5a0 <strchr+0x20>
      return (char*)s;
  return 0;
 5ae:	31 c0                	xor    %eax,%eax
}
 5b0:	5b                   	pop    %ebx
 5b1:	5d                   	pop    %ebp
 5b2:	c3                   	ret    
 5b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005c0 <gets>:

char*
gets(char *buf, int max)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5c6:	31 f6                	xor    %esi,%esi
 5c8:	89 f3                	mov    %esi,%ebx
{
 5ca:	83 ec 1c             	sub    $0x1c,%esp
 5cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 5d0:	eb 2f                	jmp    601 <gets+0x41>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 5d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5db:	83 ec 04             	sub    $0x4,%esp
 5de:	6a 01                	push   $0x1
 5e0:	50                   	push   %eax
 5e1:	6a 00                	push   $0x0
 5e3:	e8 67 01 00 00       	call   74f <read>
    if(cc < 1)
 5e8:	83 c4 10             	add    $0x10,%esp
 5eb:	85 c0                	test   %eax,%eax
 5ed:	7e 1c                	jle    60b <gets+0x4b>
      break;
    buf[i++] = c;
 5ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5f3:	83 c7 01             	add    $0x1,%edi
 5f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 5f9:	3c 0a                	cmp    $0xa,%al
 5fb:	74 23                	je     620 <gets+0x60>
 5fd:	3c 0d                	cmp    $0xd,%al
 5ff:	74 1f                	je     620 <gets+0x60>
  for(i=0; i+1 < max; ){
 601:	83 c3 01             	add    $0x1,%ebx
 604:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 607:	89 fe                	mov    %edi,%esi
 609:	7c cd                	jl     5d8 <gets+0x18>
 60b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 60d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 610:	c6 03 00             	movb   $0x0,(%ebx)
}
 613:	8d 65 f4             	lea    -0xc(%ebp),%esp
 616:	5b                   	pop    %ebx
 617:	5e                   	pop    %esi
 618:	5f                   	pop    %edi
 619:	5d                   	pop    %ebp
 61a:	c3                   	ret    
 61b:	90                   	nop
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	8b 75 08             	mov    0x8(%ebp),%esi
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	01 de                	add    %ebx,%esi
 628:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 62a:	c6 03 00             	movb   $0x0,(%ebx)
}
 62d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 630:	5b                   	pop    %ebx
 631:	5e                   	pop    %esi
 632:	5f                   	pop    %edi
 633:	5d                   	pop    %ebp
 634:	c3                   	ret    
 635:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <stat>:

int
stat(const char *n, struct stat *st)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	56                   	push   %esi
 644:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 645:	83 ec 08             	sub    $0x8,%esp
 648:	6a 00                	push   $0x0
 64a:	ff 75 08             	pushl  0x8(%ebp)
 64d:	e8 25 01 00 00       	call   777 <open>
  if(fd < 0)
 652:	83 c4 10             	add    $0x10,%esp
 655:	85 c0                	test   %eax,%eax
 657:	78 27                	js     680 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 659:	83 ec 08             	sub    $0x8,%esp
 65c:	ff 75 0c             	pushl  0xc(%ebp)
 65f:	89 c3                	mov    %eax,%ebx
 661:	50                   	push   %eax
 662:	e8 28 01 00 00       	call   78f <fstat>
  close(fd);
 667:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 66a:	89 c6                	mov    %eax,%esi
  close(fd);
 66c:	e8 ee 00 00 00       	call   75f <close>
  return r;
 671:	83 c4 10             	add    $0x10,%esp
}
 674:	8d 65 f8             	lea    -0x8(%ebp),%esp
 677:	89 f0                	mov    %esi,%eax
 679:	5b                   	pop    %ebx
 67a:	5e                   	pop    %esi
 67b:	5d                   	pop    %ebp
 67c:	c3                   	ret    
 67d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 680:	be ff ff ff ff       	mov    $0xffffffff,%esi
 685:	eb ed                	jmp    674 <stat+0x34>
 687:	89 f6                	mov    %esi,%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <atoi>:

int
atoi(const char *s)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	53                   	push   %ebx
 694:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 697:	0f be 11             	movsbl (%ecx),%edx
 69a:	8d 42 d0             	lea    -0x30(%edx),%eax
 69d:	3c 09                	cmp    $0x9,%al
  n = 0;
 69f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 6a4:	77 1f                	ja     6c5 <atoi+0x35>
 6a6:	8d 76 00             	lea    0x0(%esi),%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 6b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6b3:	83 c1 01             	add    $0x1,%ecx
 6b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 6ba:	0f be 11             	movsbl (%ecx),%edx
 6bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6c0:	80 fb 09             	cmp    $0x9,%bl
 6c3:	76 eb                	jbe    6b0 <atoi+0x20>
  return n;
}
 6c5:	5b                   	pop    %ebx
 6c6:	5d                   	pop    %ebp
 6c7:	c3                   	ret    
 6c8:	90                   	nop
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	56                   	push   %esi
 6d4:	53                   	push   %ebx
 6d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6d8:	8b 45 08             	mov    0x8(%ebp),%eax
 6db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6de:	85 db                	test   %ebx,%ebx
 6e0:	7e 14                	jle    6f6 <memmove+0x26>
 6e2:	31 d2                	xor    %edx,%edx
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 6e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 6ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 6ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 6f2:	39 d3                	cmp    %edx,%ebx
 6f4:	75 f2                	jne    6e8 <memmove+0x18>
  return vdst;
}
 6f6:	5b                   	pop    %ebx
 6f7:	5e                   	pop    %esi
 6f8:	5d                   	pop    %ebp
 6f9:	c3                   	ret    
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000700 <delay>:

void delay(int numberOfClocks)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	53                   	push   %ebx
 704:	83 ec 04             	sub    $0x4,%esp
    int firstClock = uptime();
 707:	e8 c3 00 00 00       	call   7cf <uptime>
 70c:	89 c3                	mov    %eax,%ebx
    int incClock = uptime();
 70e:	e8 bc 00 00 00       	call   7cf <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 713:	03 5d 08             	add    0x8(%ebp),%ebx
 716:	39 d8                	cmp    %ebx,%eax
 718:	7c 0f                	jl     729 <delay+0x29>
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        incClock = uptime();
 720:	e8 aa 00 00 00       	call   7cf <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 725:	39 d8                	cmp    %ebx,%eax
 727:	7d f7                	jge    720 <delay+0x20>
    }
}
 729:	83 c4 04             	add    $0x4,%esp
 72c:	5b                   	pop    %ebx
 72d:	5d                   	pop    %ebp
 72e:	c3                   	ret    

0000072f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 72f:	b8 01 00 00 00       	mov    $0x1,%eax
 734:	cd 40                	int    $0x40
 736:	c3                   	ret    

00000737 <exit>:
SYSCALL(exit)
 737:	b8 02 00 00 00       	mov    $0x2,%eax
 73c:	cd 40                	int    $0x40
 73e:	c3                   	ret    

0000073f <wait>:
SYSCALL(wait)
 73f:	b8 03 00 00 00       	mov    $0x3,%eax
 744:	cd 40                	int    $0x40
 746:	c3                   	ret    

00000747 <pipe>:
SYSCALL(pipe)
 747:	b8 04 00 00 00       	mov    $0x4,%eax
 74c:	cd 40                	int    $0x40
 74e:	c3                   	ret    

0000074f <read>:
SYSCALL(read)
 74f:	b8 05 00 00 00       	mov    $0x5,%eax
 754:	cd 40                	int    $0x40
 756:	c3                   	ret    

00000757 <write>:
SYSCALL(write)
 757:	b8 10 00 00 00       	mov    $0x10,%eax
 75c:	cd 40                	int    $0x40
 75e:	c3                   	ret    

0000075f <close>:
SYSCALL(close)
 75f:	b8 15 00 00 00       	mov    $0x15,%eax
 764:	cd 40                	int    $0x40
 766:	c3                   	ret    

00000767 <kill>:
SYSCALL(kill)
 767:	b8 06 00 00 00       	mov    $0x6,%eax
 76c:	cd 40                	int    $0x40
 76e:	c3                   	ret    

0000076f <exec>:
SYSCALL(exec)
 76f:	b8 07 00 00 00       	mov    $0x7,%eax
 774:	cd 40                	int    $0x40
 776:	c3                   	ret    

00000777 <open>:
SYSCALL(open)
 777:	b8 0f 00 00 00       	mov    $0xf,%eax
 77c:	cd 40                	int    $0x40
 77e:	c3                   	ret    

0000077f <mknod>:
SYSCALL(mknod)
 77f:	b8 11 00 00 00       	mov    $0x11,%eax
 784:	cd 40                	int    $0x40
 786:	c3                   	ret    

00000787 <unlink>:
SYSCALL(unlink)
 787:	b8 12 00 00 00       	mov    $0x12,%eax
 78c:	cd 40                	int    $0x40
 78e:	c3                   	ret    

0000078f <fstat>:
SYSCALL(fstat)
 78f:	b8 08 00 00 00       	mov    $0x8,%eax
 794:	cd 40                	int    $0x40
 796:	c3                   	ret    

00000797 <link>:
SYSCALL(link)
 797:	b8 13 00 00 00       	mov    $0x13,%eax
 79c:	cd 40                	int    $0x40
 79e:	c3                   	ret    

0000079f <mkdir>:
SYSCALL(mkdir)
 79f:	b8 14 00 00 00       	mov    $0x14,%eax
 7a4:	cd 40                	int    $0x40
 7a6:	c3                   	ret    

000007a7 <chdir>:
SYSCALL(chdir)
 7a7:	b8 09 00 00 00       	mov    $0x9,%eax
 7ac:	cd 40                	int    $0x40
 7ae:	c3                   	ret    

000007af <dup>:
SYSCALL(dup)
 7af:	b8 0a 00 00 00       	mov    $0xa,%eax
 7b4:	cd 40                	int    $0x40
 7b6:	c3                   	ret    

000007b7 <getpid>:
SYSCALL(getpid)
 7b7:	b8 0b 00 00 00       	mov    $0xb,%eax
 7bc:	cd 40                	int    $0x40
 7be:	c3                   	ret    

000007bf <sbrk>:
SYSCALL(sbrk)
 7bf:	b8 0c 00 00 00       	mov    $0xc,%eax
 7c4:	cd 40                	int    $0x40
 7c6:	c3                   	ret    

000007c7 <sleep>:
SYSCALL(sleep)
 7c7:	b8 0d 00 00 00       	mov    $0xd,%eax
 7cc:	cd 40                	int    $0x40
 7ce:	c3                   	ret    

000007cf <uptime>:
SYSCALL(uptime)
 7cf:	b8 0e 00 00 00       	mov    $0xe,%eax
 7d4:	cd 40                	int    $0x40
 7d6:	c3                   	ret    

000007d7 <incNum>:
SYSCALL(incNum)
 7d7:	b8 16 00 00 00       	mov    $0x16,%eax
 7dc:	cd 40                	int    $0x40
 7de:	c3                   	ret    

000007df <getprocs>:
SYSCALL(getprocs)
 7df:	b8 17 00 00 00       	mov    $0x17,%eax
 7e4:	cd 40                	int    $0x40
 7e6:	c3                   	ret    

000007e7 <set_burst_time>:
SYSCALL(set_burst_time)
 7e7:	b8 18 00 00 00       	mov    $0x18,%eax
 7ec:	cd 40                	int    $0x40
 7ee:	c3                   	ret    

000007ef <set_priority>:
SYSCALL(set_priority)
 7ef:	b8 19 00 00 00       	mov    $0x19,%eax
 7f4:	cd 40                	int    $0x40
 7f6:	c3                   	ret    

000007f7 <set_lottery_ticket>:
SYSCALL(set_lottery_ticket)
 7f7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7fc:	cd 40                	int    $0x40
 7fe:	c3                   	ret    

000007ff <set_sched_queue>:
SYSCALL(set_sched_queue)
 7ff:	b8 1b 00 00 00       	mov    $0x1b,%eax
 804:	cd 40                	int    $0x40
 806:	c3                   	ret    

00000807 <show_processes_scheduling>:
SYSCALL(show_processes_scheduling)
 807:	b8 1c 00 00 00       	mov    $0x1c,%eax
 80c:	cd 40                	int    $0x40
 80e:	c3                   	ret    
 80f:	90                   	nop

00000810 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 819:	85 d2                	test   %edx,%edx
{
 81b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 81e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 820:	79 76                	jns    898 <printint+0x88>
 822:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 826:	74 70                	je     898 <printint+0x88>
    x = -xx;
 828:	f7 d8                	neg    %eax
    neg = 1;
 82a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 831:	31 f6                	xor    %esi,%esi
 833:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 836:	eb 0a                	jmp    842 <printint+0x32>
 838:	90                   	nop
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 840:	89 fe                	mov    %edi,%esi
 842:	31 d2                	xor    %edx,%edx
 844:	8d 7e 01             	lea    0x1(%esi),%edi
 847:	f7 f1                	div    %ecx
 849:	0f b6 92 a4 0c 00 00 	movzbl 0xca4(%edx),%edx
  }while((x /= base) != 0);
 850:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 852:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 855:	75 e9                	jne    840 <printint+0x30>
  if(neg)
 857:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 85a:	85 c0                	test   %eax,%eax
 85c:	74 08                	je     866 <printint+0x56>
    buf[i++] = '-';
 85e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 863:	8d 7e 02             	lea    0x2(%esi),%edi
 866:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 86a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
 870:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 873:	83 ec 04             	sub    $0x4,%esp
 876:	83 ee 01             	sub    $0x1,%esi
 879:	6a 01                	push   $0x1
 87b:	53                   	push   %ebx
 87c:	57                   	push   %edi
 87d:	88 45 d7             	mov    %al,-0x29(%ebp)
 880:	e8 d2 fe ff ff       	call   757 <write>

  while(--i >= 0)
 885:	83 c4 10             	add    $0x10,%esp
 888:	39 de                	cmp    %ebx,%esi
 88a:	75 e4                	jne    870 <printint+0x60>
    putc(fd, buf[i]);
}
 88c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88f:	5b                   	pop    %ebx
 890:	5e                   	pop    %esi
 891:	5f                   	pop    %edi
 892:	5d                   	pop    %ebp
 893:	c3                   	ret    
 894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 898:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 89f:	eb 90                	jmp    831 <printint+0x21>
 8a1:	eb 0d                	jmp    8b0 <printf>
 8a3:	90                   	nop
 8a4:	90                   	nop
 8a5:	90                   	nop
 8a6:	90                   	nop
 8a7:	90                   	nop
 8a8:	90                   	nop
 8a9:	90                   	nop
 8aa:	90                   	nop
 8ab:	90                   	nop
 8ac:	90                   	nop
 8ad:	90                   	nop
 8ae:	90                   	nop
 8af:	90                   	nop

000008b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8bc:	0f b6 1e             	movzbl (%esi),%ebx
 8bf:	84 db                	test   %bl,%bl
 8c1:	0f 84 b3 00 00 00    	je     97a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 8c7:	8d 45 10             	lea    0x10(%ebp),%eax
 8ca:	83 c6 01             	add    $0x1,%esi
  state = 0;
 8cd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 8cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8d2:	eb 2f                	jmp    903 <printf+0x53>
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 8d8:	83 f8 25             	cmp    $0x25,%eax
 8db:	0f 84 a7 00 00 00    	je     988 <printf+0xd8>
  write(fd, &c, 1);
 8e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8e4:	83 ec 04             	sub    $0x4,%esp
 8e7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 8ea:	6a 01                	push   $0x1
 8ec:	50                   	push   %eax
 8ed:	ff 75 08             	pushl  0x8(%ebp)
 8f0:	e8 62 fe ff ff       	call   757 <write>
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 8fb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 8ff:	84 db                	test   %bl,%bl
 901:	74 77                	je     97a <printf+0xca>
    if(state == 0){
 903:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 905:	0f be cb             	movsbl %bl,%ecx
 908:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 90b:	74 cb                	je     8d8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 90d:	83 ff 25             	cmp    $0x25,%edi
 910:	75 e6                	jne    8f8 <printf+0x48>
      if(c == 'd'){
 912:	83 f8 64             	cmp    $0x64,%eax
 915:	0f 84 05 01 00 00    	je     a20 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 91b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 921:	83 f9 70             	cmp    $0x70,%ecx
 924:	74 72                	je     998 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 926:	83 f8 73             	cmp    $0x73,%eax
 929:	0f 84 99 00 00 00    	je     9c8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 92f:	83 f8 63             	cmp    $0x63,%eax
 932:	0f 84 08 01 00 00    	je     a40 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 938:	83 f8 25             	cmp    $0x25,%eax
 93b:	0f 84 ef 00 00 00    	je     a30 <printf+0x180>
  write(fd, &c, 1);
 941:	8d 45 e7             	lea    -0x19(%ebp),%eax
 944:	83 ec 04             	sub    $0x4,%esp
 947:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 94b:	6a 01                	push   $0x1
 94d:	50                   	push   %eax
 94e:	ff 75 08             	pushl  0x8(%ebp)
 951:	e8 01 fe ff ff       	call   757 <write>
 956:	83 c4 0c             	add    $0xc,%esp
 959:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 95c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 95f:	6a 01                	push   $0x1
 961:	50                   	push   %eax
 962:	ff 75 08             	pushl  0x8(%ebp)
 965:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 968:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 96a:	e8 e8 fd ff ff       	call   757 <write>
  for(i = 0; fmt[i]; i++){
 96f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 973:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 976:	84 db                	test   %bl,%bl
 978:	75 89                	jne    903 <printf+0x53>
    }
  }
}
 97a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 97d:	5b                   	pop    %ebx
 97e:	5e                   	pop    %esi
 97f:	5f                   	pop    %edi
 980:	5d                   	pop    %ebp
 981:	c3                   	ret    
 982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 988:	bf 25 00 00 00       	mov    $0x25,%edi
 98d:	e9 66 ff ff ff       	jmp    8f8 <printf+0x48>
 992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 998:	83 ec 0c             	sub    $0xc,%esp
 99b:	b9 10 00 00 00       	mov    $0x10,%ecx
 9a0:	6a 00                	push   $0x0
 9a2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 9a5:	8b 45 08             	mov    0x8(%ebp),%eax
 9a8:	8b 17                	mov    (%edi),%edx
 9aa:	e8 61 fe ff ff       	call   810 <printint>
        ap++;
 9af:	89 f8                	mov    %edi,%eax
 9b1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9b4:	31 ff                	xor    %edi,%edi
        ap++;
 9b6:	83 c0 04             	add    $0x4,%eax
 9b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9bc:	e9 37 ff ff ff       	jmp    8f8 <printf+0x48>
 9c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9cb:	8b 08                	mov    (%eax),%ecx
        ap++;
 9cd:	83 c0 04             	add    $0x4,%eax
 9d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 9d3:	85 c9                	test   %ecx,%ecx
 9d5:	0f 84 8e 00 00 00    	je     a69 <printf+0x1b9>
        while(*s != 0){
 9db:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 9de:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 9e0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 9e2:	84 c0                	test   %al,%al
 9e4:	0f 84 0e ff ff ff    	je     8f8 <printf+0x48>
 9ea:	89 75 d0             	mov    %esi,-0x30(%ebp)
 9ed:	89 de                	mov    %ebx,%esi
 9ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9f2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 9f5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9f8:	83 ec 04             	sub    $0x4,%esp
          s++;
 9fb:	83 c6 01             	add    $0x1,%esi
 9fe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a01:	6a 01                	push   $0x1
 a03:	57                   	push   %edi
 a04:	53                   	push   %ebx
 a05:	e8 4d fd ff ff       	call   757 <write>
        while(*s != 0){
 a0a:	0f b6 06             	movzbl (%esi),%eax
 a0d:	83 c4 10             	add    $0x10,%esp
 a10:	84 c0                	test   %al,%al
 a12:	75 e4                	jne    9f8 <printf+0x148>
 a14:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a17:	31 ff                	xor    %edi,%edi
 a19:	e9 da fe ff ff       	jmp    8f8 <printf+0x48>
 a1e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a20:	83 ec 0c             	sub    $0xc,%esp
 a23:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a28:	6a 01                	push   $0x1
 a2a:	e9 73 ff ff ff       	jmp    9a2 <printf+0xf2>
 a2f:	90                   	nop
  write(fd, &c, 1);
 a30:	83 ec 04             	sub    $0x4,%esp
 a33:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a36:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a39:	6a 01                	push   $0x1
 a3b:	e9 21 ff ff ff       	jmp    961 <printf+0xb1>
        putc(fd, *ap);
 a40:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a43:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a46:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a48:	6a 01                	push   $0x1
        ap++;
 a4a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a4d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a50:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a53:	50                   	push   %eax
 a54:	ff 75 08             	pushl  0x8(%ebp)
 a57:	e8 fb fc ff ff       	call   757 <write>
        ap++;
 a5c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a5f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a62:	31 ff                	xor    %edi,%edi
 a64:	e9 8f fe ff ff       	jmp    8f8 <printf+0x48>
          s = "(null)";
 a69:	bb 9c 0c 00 00       	mov    $0xc9c,%ebx
        while(*s != 0){
 a6e:	b8 28 00 00 00       	mov    $0x28,%eax
 a73:	e9 72 ff ff ff       	jmp    9ea <printf+0x13a>
 a78:	66 90                	xchg   %ax,%ax
 a7a:	66 90                	xchg   %ax,%ax
 a7c:	66 90                	xchg   %ax,%ax
 a7e:	66 90                	xchg   %ax,%ax

00000a80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a81:	a1 ac 10 00 00       	mov    0x10ac,%eax
{
 a86:	89 e5                	mov    %esp,%ebp
 a88:	57                   	push   %edi
 a89:	56                   	push   %esi
 a8a:	53                   	push   %ebx
 a8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a98:	39 c8                	cmp    %ecx,%eax
 a9a:	8b 10                	mov    (%eax),%edx
 a9c:	73 32                	jae    ad0 <free+0x50>
 a9e:	39 d1                	cmp    %edx,%ecx
 aa0:	72 04                	jb     aa6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	39 d0                	cmp    %edx,%eax
 aa4:	72 32                	jb     ad8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 aa6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 aa9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aac:	39 fa                	cmp    %edi,%edx
 aae:	74 30                	je     ae0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ab0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ab3:	8b 50 04             	mov    0x4(%eax),%edx
 ab6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ab9:	39 f1                	cmp    %esi,%ecx
 abb:	74 3a                	je     af7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 abd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 abf:	a3 ac 10 00 00       	mov    %eax,0x10ac
}
 ac4:	5b                   	pop    %ebx
 ac5:	5e                   	pop    %esi
 ac6:	5f                   	pop    %edi
 ac7:	5d                   	pop    %ebp
 ac8:	c3                   	ret    
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad0:	39 d0                	cmp    %edx,%eax
 ad2:	72 04                	jb     ad8 <free+0x58>
 ad4:	39 d1                	cmp    %edx,%ecx
 ad6:	72 ce                	jb     aa6 <free+0x26>
{
 ad8:	89 d0                	mov    %edx,%eax
 ada:	eb bc                	jmp    a98 <free+0x18>
 adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ae0:	03 72 04             	add    0x4(%edx),%esi
 ae3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ae6:	8b 10                	mov    (%eax),%edx
 ae8:	8b 12                	mov    (%edx),%edx
 aea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 aed:	8b 50 04             	mov    0x4(%eax),%edx
 af0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 af3:	39 f1                	cmp    %esi,%ecx
 af5:	75 c6                	jne    abd <free+0x3d>
    p->s.size += bp->s.size;
 af7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 afa:	a3 ac 10 00 00       	mov    %eax,0x10ac
    p->s.size += bp->s.size;
 aff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b02:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b05:	89 10                	mov    %edx,(%eax)
}
 b07:	5b                   	pop    %ebx
 b08:	5e                   	pop    %esi
 b09:	5f                   	pop    %edi
 b0a:	5d                   	pop    %ebp
 b0b:	c3                   	ret    
 b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	57                   	push   %edi
 b14:	56                   	push   %esi
 b15:	53                   	push   %ebx
 b16:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b1c:	8b 15 ac 10 00 00    	mov    0x10ac,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b22:	8d 78 07             	lea    0x7(%eax),%edi
 b25:	c1 ef 03             	shr    $0x3,%edi
 b28:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b2b:	85 d2                	test   %edx,%edx
 b2d:	0f 84 9d 00 00 00    	je     bd0 <malloc+0xc0>
 b33:	8b 02                	mov    (%edx),%eax
 b35:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b38:	39 cf                	cmp    %ecx,%edi
 b3a:	76 6c                	jbe    ba8 <malloc+0x98>
 b3c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b42:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b47:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b4a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b51:	eb 0e                	jmp    b61 <malloc+0x51>
 b53:	90                   	nop
 b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b58:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b5a:	8b 48 04             	mov    0x4(%eax),%ecx
 b5d:	39 f9                	cmp    %edi,%ecx
 b5f:	73 47                	jae    ba8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b61:	39 05 ac 10 00 00    	cmp    %eax,0x10ac
 b67:	89 c2                	mov    %eax,%edx
 b69:	75 ed                	jne    b58 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b6b:	83 ec 0c             	sub    $0xc,%esp
 b6e:	56                   	push   %esi
 b6f:	e8 4b fc ff ff       	call   7bf <sbrk>
  if(p == (char*)-1)
 b74:	83 c4 10             	add    $0x10,%esp
 b77:	83 f8 ff             	cmp    $0xffffffff,%eax
 b7a:	74 1c                	je     b98 <malloc+0x88>
  hp->s.size = nu;
 b7c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b7f:	83 ec 0c             	sub    $0xc,%esp
 b82:	83 c0 08             	add    $0x8,%eax
 b85:	50                   	push   %eax
 b86:	e8 f5 fe ff ff       	call   a80 <free>
  return freep;
 b8b:	8b 15 ac 10 00 00    	mov    0x10ac,%edx
      if((p = morecore(nunits)) == 0)
 b91:	83 c4 10             	add    $0x10,%esp
 b94:	85 d2                	test   %edx,%edx
 b96:	75 c0                	jne    b58 <malloc+0x48>
        return 0;
  }
}
 b98:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b9b:	31 c0                	xor    %eax,%eax
}
 b9d:	5b                   	pop    %ebx
 b9e:	5e                   	pop    %esi
 b9f:	5f                   	pop    %edi
 ba0:	5d                   	pop    %ebp
 ba1:	c3                   	ret    
 ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ba8:	39 cf                	cmp    %ecx,%edi
 baa:	74 54                	je     c00 <malloc+0xf0>
        p->s.size -= nunits;
 bac:	29 f9                	sub    %edi,%ecx
 bae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bb1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bb4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 bb7:	89 15 ac 10 00 00    	mov    %edx,0x10ac
}
 bbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bc0:	83 c0 08             	add    $0x8,%eax
}
 bc3:	5b                   	pop    %ebx
 bc4:	5e                   	pop    %esi
 bc5:	5f                   	pop    %edi
 bc6:	5d                   	pop    %ebp
 bc7:	c3                   	ret    
 bc8:	90                   	nop
 bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 bd0:	c7 05 ac 10 00 00 b0 	movl   $0x10b0,0x10ac
 bd7:	10 00 00 
 bda:	c7 05 b0 10 00 00 b0 	movl   $0x10b0,0x10b0
 be1:	10 00 00 
    base.s.size = 0;
 be4:	b8 b0 10 00 00       	mov    $0x10b0,%eax
 be9:	c7 05 b4 10 00 00 00 	movl   $0x0,0x10b4
 bf0:	00 00 00 
 bf3:	e9 44 ff ff ff       	jmp    b3c <malloc+0x2c>
 bf8:	90                   	nop
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c00:	8b 08                	mov    (%eax),%ecx
 c02:	89 0a                	mov    %ecx,(%edx)
 c04:	eb b1                	jmp    bb7 <malloc+0xa7>
