
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
  11:	e8 c1 07 00 00       	call   7d7 <getpid>
  16:	83 ec 08             	sub    $0x8,%esp
  19:	50                   	push   %eax
  1a:	6a 32                	push   $0x32
  1c:	e8 f6 07 00 00       	call   817 <set_lottery_ticket>
    multilevelQueue();
  21:	e8 0a 03 00 00       	call   330 <multilevelQueue>
    exit();
  26:	e8 2c 07 00 00       	call   757 <exit>
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
  34:	e9 ee 07 00 00       	jmp    827 <show_processes_scheduling>
  39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000040 <priorityTest>:

void priorityTest()
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	56                   	push   %esi
  44:	53                   	push   %ebx
  set_sched_queue(PRIORITY, getpid());
  45:	e8 8d 07 00 00       	call   7d7 <getpid>
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	50                   	push   %eax
  4e:	6a 01                	push   $0x1
  50:	e8 ca 07 00 00       	call   81f <set_sched_queue>
  set_priority(0, getpid());
  55:	e8 7d 07 00 00       	call   7d7 <getpid>
  5a:	59                   	pop    %ecx
  5b:	5b                   	pop    %ebx
  5c:	50                   	push   %eax
  5d:	6a 00                	push   $0x0
  int pid = getpid();
  5f:	bb 03 00 00 00       	mov    $0x3,%ebx
  set_priority(0, getpid());
  64:	e8 a6 07 00 00       	call   80f <set_priority>
  int pid = getpid();
  69:	e8 69 07 00 00       	call   7d7 <getpid>
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
  86:	e8 d4 06 00 00       	call   75f <wait>
  8b:	e8 cf 06 00 00       	call   75f <wait>
  90:	e8 ca 06 00 00       	call   75f <wait>
  95:	e8 c5 06 00 00       	call   75f <wait>
        printf(1, "Main user program finished pid %d\n", getpid());
  9a:	e8 38 07 00 00       	call   7d7 <getpid>
  9f:	83 ec 04             	sub    $0x4,%esp
  a2:	50                   	push   %eax
  a3:	68 4c 0c 00 00       	push   $0xc4c
  a8:	6a 01                	push   $0x1
  aa:	e8 21 08 00 00       	call   8d0 <printf>
  af:	83 c4 10             	add    $0x10,%esp
    }
}
  b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  b5:	5b                   	pop    %ebx
  b6:	5e                   	pop    %esi
  b7:	5d                   	pop    %ebp
  b8:	c3                   	ret    
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            pid = fork();
  c0:	e8 8a 06 00 00       	call   74f <fork>
            if(pid > 0)
  c5:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
  c8:	89 c6                	mov    %eax,%esi
            if(pid > 0)
  ca:	7f 44                	jg     110 <priorityTest+0xd0>
            if(pid == 0 )
  cc:	75 a9                	jne    77 <priorityTest+0x37>
        ownPid = getpid();
  ce:	e8 04 07 00 00       	call   7d7 <getpid>
  d3:	bb 40 0d 03 00       	mov    $0x30d40,%ebx
  d8:	89 c6                	mov    %eax,%esi
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(200000000);
  e0:	83 ec 0c             	sub    $0xc,%esp
  e3:	68 00 c2 eb 0b       	push   $0xbebc200
  e8:	e8 33 06 00 00       	call   720 <delay>
        for(i = 0 ; i < 200000 ; i++)
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	83 eb 01             	sub    $0x1,%ebx
  f3:	75 eb                	jne    e0 <priorityTest+0xa0>
        printf(1, "%d\n", ownPid);
  f5:	83 ec 04             	sub    $0x4,%esp
  f8:	56                   	push   %esi
  f9:	68 34 0c 00 00       	push   $0xc34
  fe:	6a 01                	push   $0x1
 100:	e8 cb 07 00 00       	call   8d0 <printf>
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
 116:	e8 04 07 00 00       	call   81f <set_sched_queue>
            set_priority(10-i, pid);
 11b:	58                   	pop    %eax
 11c:	8d 43 06             	lea    0x6(%ebx),%eax
 11f:	5a                   	pop    %edx
 120:	56                   	push   %esi
 121:	50                   	push   %eax
 122:	e8 e8 06 00 00       	call   80f <set_priority>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	e9 48 ff ff ff       	jmp    77 <priorityTest+0x37>
        printf(2, "fork error\n");
 12f:	83 ec 08             	sub    $0x8,%esp
 132:	68 28 0c 00 00       	push   $0xc28
 137:	6a 02                	push   $0x2
 139:	e8 92 07 00 00       	call   8d0 <printf>
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
 155:	bb 0c 00 00 00       	mov    $0xc,%ebx
  int pid = getpid();
 15a:	e8 78 06 00 00       	call   7d7 <getpid>
 15f:	89 c6                	mov    %eax,%esi
   set_sched_queue(SJF, getpid());
 161:	e8 71 06 00 00       	call   7d7 <getpid>
 166:	83 ec 08             	sub    $0x8,%esp
 169:	50                   	push   %eax
 16a:	6a 02                	push   $0x2
 16c:	e8 ae 06 00 00       	call   81f <set_sched_queue>
 171:	83 c4 10             	add    $0x10,%esp
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
 174:	85 f6                	test   %esi,%esi
 176:	7f 50                	jg     1c8 <SJFTest+0x78>
 178:	83 c3 02             	add    $0x2,%ebx
    for(i = 1; i < NCHILD; i++)
 17b:	83 fb 12             	cmp    $0x12,%ebx
 17e:	75 f4                	jne    174 <SJFTest+0x24>
            if(pid == 0 )
                break;
        }
    }
       
    if(pid < 0)
 180:	85 f6                	test   %esi,%esi
 182:	0f 88 b4 00 00 00    	js     23c <SJFTest+0xec>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
 188:	74 4c                	je     1d6 <SJFTest+0x86>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD + 1; i++)
            wait();
 18a:	e8 d0 05 00 00       	call   75f <wait>
 18f:	e8 cb 05 00 00       	call   75f <wait>
 194:	e8 c6 05 00 00       	call   75f <wait>
 199:	e8 c1 05 00 00       	call   75f <wait>
 19e:	e8 bc 05 00 00       	call   75f <wait>
        printf(1, "Main user program finished pid %d\n", getpid());
 1a3:	e8 2f 06 00 00       	call   7d7 <getpid>
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	50                   	push   %eax
 1ac:	68 4c 0c 00 00       	push   $0xc4c
 1b1:	6a 01                	push   $0x1
 1b3:	e8 18 07 00 00       	call   8d0 <printf>
 1b8:	83 c4 10             	add    $0x10,%esp
    }
}
 1bb:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1be:	5b                   	pop    %ebx
 1bf:	5e                   	pop    %esi
 1c0:	5d                   	pop    %ebp
 1c1:	c3                   	ret    
 1c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            pid = fork();
 1c8:	e8 82 05 00 00       	call   74f <fork>
            if(pid > 0)
 1cd:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 1d0:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 1d2:	7f 4c                	jg     220 <SJFTest+0xd0>
            if(pid == 0 )
 1d4:	75 a2                	jne    178 <SJFTest+0x28>
        ownPid = getpid();
 1d6:	e8 fc 05 00 00       	call   7d7 <getpid>
 1db:	bb 20 4e 00 00       	mov    $0x4e20,%ebx
 1e0:	89 c6                	mov    %eax,%esi
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(200000000);
 1e8:	83 ec 0c             	sub    $0xc,%esp
 1eb:	68 00 c2 eb 0b       	push   $0xbebc200
 1f0:	e8 2b 05 00 00       	call   720 <delay>
        for(i = 0 ; i < 20000 ; i++)
 1f5:	83 c4 10             	add    $0x10,%esp
 1f8:	83 eb 01             	sub    $0x1,%ebx
 1fb:	75 eb                	jne    1e8 <SJFTest+0x98>
        printf(1, "%d\n", ownPid);
 1fd:	83 ec 04             	sub    $0x4,%esp
 200:	56                   	push   %esi
 201:	68 34 0c 00 00       	push   $0xc34
 206:	6a 01                	push   $0x1
 208:	e8 c3 06 00 00       	call   8d0 <printf>
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
 226:	e8 f4 05 00 00       	call   81f <set_sched_queue>
                set_burst_time(10 + 2*i, pid);
 22b:	58                   	pop    %eax
 22c:	5a                   	pop    %edx
 22d:	56                   	push   %esi
 22e:	53                   	push   %ebx
 22f:	e8 d3 05 00 00       	call   807 <set_burst_time>
 234:	83 c4 10             	add    $0x10,%esp
 237:	e9 3c ff ff ff       	jmp    178 <SJFTest+0x28>
        printf(2, "fork error\n");
 23c:	83 ec 08             	sub    $0x8,%esp
 23f:	68 28 0c 00 00       	push   $0xc28
 244:	6a 02                	push   $0x2
 246:	e8 85 06 00 00       	call   8d0 <printf>
 24b:	83 c4 10             	add    $0x10,%esp
}
 24e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5d                   	pop    %ebp
 254:	c3                   	ret    
 255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <lotteryTest>:

void lotteryTest(){
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
  int pid = getpid();
 265:	bb 03 00 00 00       	mov    $0x3,%ebx
 26a:	e8 68 05 00 00       	call   7d7 <getpid>
 26f:	89 c6                	mov    %eax,%esi
    
    int i;
    for(i = 1; i < NCHILD; i++)
    {
        if(pid > 0)
 271:	85 f6                	test   %esi,%esi
 273:	7f 2b                	jg     2a0 <lotteryTest+0x40>
    for(i = 1; i < NCHILD; i++)
 275:	83 eb 01             	sub    $0x1,%ebx
 278:	75 f7                	jne    271 <lotteryTest+0x11>
            
        }
            
    }
       
    if(pid < 0)
 27a:	85 f6                	test   %esi,%esi
 27c:	0f 88 8d 00 00 00    	js     30f <lotteryTest+0xaf>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0)
 282:	74 2a                	je     2ae <lotteryTest+0x4e>
    }
    else
    {
        int i;
        for(i = 0; i < NCHILD; i++)
            wait();
 284:	e8 d6 04 00 00       	call   75f <wait>
 289:	e8 d1 04 00 00       	call   75f <wait>
 28e:	e8 cc 04 00 00       	call   75f <wait>
    }
}
 293:	8d 65 f8             	lea    -0x8(%ebp),%esp
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
            wait();
 299:	e9 c1 04 00 00       	jmp    75f <wait>
 29e:	66 90                	xchg   %ax,%ax
            pid = fork();
 2a0:	e8 aa 04 00 00       	call   74f <fork>
            if(pid > 0)
 2a5:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 2a8:	89 c6                	mov    %eax,%esi
            if(pid > 0)
 2aa:	7f 44                	jg     2f0 <lotteryTest+0x90>
            if(pid == 0 )
 2ac:	75 c7                	jne    275 <lotteryTest+0x15>
        ownPid = getpid();
 2ae:	e8 24 05 00 00       	call   7d7 <getpid>
 2b3:	bb 00 2d 31 01       	mov    $0x1312d00,%ebx
 2b8:	89 c6                	mov    %eax,%esi
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            delay(2000000000);
 2c0:	83 ec 0c             	sub    $0xc,%esp
 2c3:	68 00 94 35 77       	push   $0x77359400
 2c8:	e8 53 04 00 00       	call   720 <delay>
        for(i = 0 ; i < 20000000 ; i++)
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	83 eb 01             	sub    $0x1,%ebx
 2d3:	75 eb                	jne    2c0 <lotteryTest+0x60>
        printf(1, "%d\n", ownPid);
 2d5:	83 ec 04             	sub    $0x4,%esp
 2d8:	56                   	push   %esi
 2d9:	68 34 0c 00 00       	push   $0xc34
 2de:	6a 01                	push   $0x1
 2e0:	e8 eb 05 00 00       	call   8d0 <printf>
 2e5:	83 c4 10             	add    $0x10,%esp
}
 2e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2eb:	5b                   	pop    %ebx
 2ec:	5e                   	pop    %esi
 2ed:	5d                   	pop    %ebp
 2ee:	c3                   	ret    
 2ef:	90                   	nop
                set_sched_queue(LOTTERY, pid);
 2f0:	83 ec 08             	sub    $0x8,%esp
 2f3:	50                   	push   %eax
 2f4:	6a 03                	push   $0x3
 2f6:	e8 24 05 00 00       	call   81f <set_sched_queue>
                set_lottery_ticket(10-i, pid);
 2fb:	58                   	pop    %eax
 2fc:	8d 43 06             	lea    0x6(%ebx),%eax
 2ff:	5a                   	pop    %edx
 300:	56                   	push   %esi
 301:	50                   	push   %eax
 302:	e8 10 05 00 00       	call   817 <set_lottery_ticket>
 307:	83 c4 10             	add    $0x10,%esp
 30a:	e9 66 ff ff ff       	jmp    275 <lotteryTest+0x15>
        printf(2, "fork error\n");
 30f:	83 ec 08             	sub    $0x8,%esp
 312:	68 28 0c 00 00       	push   $0xc28
 317:	6a 02                	push   $0x2
 319:	e8 b2 05 00 00       	call   8d0 <printf>
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
                    set_priority(NCHILD * 3 - i, pid);
                }
                else if( i < NCHILD * 2)
                {
                    set_sched_queue(SJF, pid);
                    set_burst_time(NCHILD * 5 - i, pid);
 336:	be 14 00 00 00       	mov    $0x14,%esi
    for(i = 0; i < 3 * NCHILD; i++)
 33b:	31 db                	xor    %ebx,%ebx
void multilevelQueue() {
 33d:	83 ec 0c             	sub    $0xc,%esp
    int pid = getpid();
 340:	e8 92 04 00 00       	call   7d7 <getpid>
 345:	89 c7                	mov    %eax,%edi
 347:	eb 0f                	jmp    358 <multilevelQueue+0x28>
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 3 * NCHILD; i++)
 350:	83 c3 01             	add    $0x1,%ebx
 353:	83 fb 0c             	cmp    $0xc,%ebx
 356:	74 50                	je     3a8 <multilevelQueue+0x78>
        if(pid > 0)
 358:	85 ff                	test   %edi,%edi
 35a:	7e f4                	jle    350 <multilevelQueue+0x20>
            pid = fork();
 35c:	e8 ee 03 00 00       	call   74f <fork>
            if(pid > 0)
 361:	83 f8 00             	cmp    $0x0,%eax
            pid = fork();
 364:	89 c7                	mov    %eax,%edi
            if(pid > 0)
 366:	0f 8e 84 00 00 00    	jle    3f0 <multilevelQueue+0xc0>
                if(i < NCHILD)
 36c:	83 fb 03             	cmp    $0x3,%ebx
 36f:	0f 8e cb 00 00 00    	jle    440 <multilevelQueue+0x110>
                else if( i < NCHILD * 2)
 375:	83 fb 07             	cmp    $0x7,%ebx
 378:	0f 8f ea 00 00 00    	jg     468 <multilevelQueue+0x138>
                    set_sched_queue(SJF, pid);
 37e:	83 ec 08             	sub    $0x8,%esp
 381:	50                   	push   %eax
 382:	6a 02                	push   $0x2
 384:	e8 96 04 00 00       	call   81f <set_sched_queue>
                    set_burst_time(NCHILD * 5 - i, pid);
 389:	59                   	pop    %ecx
 38a:	58                   	pop    %eax
 38b:	89 f0                	mov    %esi,%eax
 38d:	57                   	push   %edi
 38e:	29 d8                	sub    %ebx,%eax
    for(i = 0; i < 3 * NCHILD; i++)
 390:	83 c3 01             	add    $0x1,%ebx
                    set_burst_time(NCHILD * 5 - i, pid);
 393:	50                   	push   %eax
 394:	e8 6e 04 00 00       	call   807 <set_burst_time>
 399:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 3 * NCHILD; i++)
 39c:	83 fb 0c             	cmp    $0xc,%ebx
 39f:	75 b7                	jne    358 <multilevelQueue+0x28>
 3a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            }
        }
            
    }
       
    if(pid < 0)
 3a8:	85 ff                	test   %edi,%edi
 3aa:	0f 88 00 01 00 00    	js     4b0 <multilevelQueue+0x180>
    {
        printf(2, "fork error\n");
    }
    else if(pid == 0 && (queue == LOTTERY || queue == SJF))
 3b0:	74 4d                	je     3ff <multilevelQueue+0xcf>
    {
        printf(1, "IO bound process with pid %d finished\n", getpid());
    }
    else
    {
        show_processes_scheduling();
 3b2:	bb 0c 00 00 00       	mov    $0xc,%ebx
 3b7:	e8 6b 04 00 00       	call   827 <show_processes_scheduling>
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int i;
        for(i = 0; i < NCHILD * 3 ; i++)
            wait();
 3c0:	e8 9a 03 00 00       	call   75f <wait>
        for(i = 0; i < NCHILD * 3 ; i++)
 3c5:	83 eb 01             	sub    $0x1,%ebx
 3c8:	75 f6                	jne    3c0 <multilevelQueue+0x90>
        printf(1, "main program with pid %d finished\n", getpid());
 3ca:	e8 08 04 00 00       	call   7d7 <getpid>
 3cf:	83 ec 04             	sub    $0x4,%esp
 3d2:	50                   	push   %eax
 3d3:	68 70 0c 00 00       	push   $0xc70
 3d8:	6a 01                	push   $0x1
 3da:	e8 f1 04 00 00       	call   8d0 <printf>
 3df:	83 c4 10             	add    $0x10,%esp
    }
 3e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e5:	5b                   	pop    %ebx
 3e6:	5e                   	pop    %esi
 3e7:	5f                   	pop    %edi
 3e8:	5d                   	pop    %ebp
 3e9:	c3                   	ret    
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(pid == 0 )
 3f0:	0f 85 5a ff ff ff    	jne    350 <multilevelQueue+0x20>
                queue = i < NCHILD ? PRIORITY : i < NCHILD * 2 ? SJF : LOTTERY;
 3f6:	83 fb 03             	cmp    $0x3,%ebx
 3f9:	0f 8e 91 00 00 00    	jle    490 <multilevelQueue+0x160>
    for(i = 0; i < 3 * NCHILD; i++)
 3ff:	bb 90 d0 03 00       	mov    $0x3d090,%ebx
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            delay(2000000000);
 408:	83 ec 0c             	sub    $0xc,%esp
 40b:	68 00 94 35 77       	push   $0x77359400
 410:	e8 0b 03 00 00       	call   720 <delay>
        for(i = 0 ; i < 250000 ; i++)
 415:	83 c4 10             	add    $0x10,%esp
 418:	83 eb 01             	sub    $0x1,%ebx
 41b:	75 eb                	jne    408 <multilevelQueue+0xd8>
        printf(1, "pid %d finished\n", getpid());
 41d:	e8 b5 03 00 00       	call   7d7 <getpid>
 422:	83 ec 04             	sub    $0x4,%esp
 425:	50                   	push   %eax
 426:	68 38 0c 00 00       	push   $0xc38
 42b:	6a 01                	push   $0x1
 42d:	e8 9e 04 00 00       	call   8d0 <printf>
    {
 432:	83 c4 10             	add    $0x10,%esp
 435:	8d 65 f4             	lea    -0xc(%ebp),%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5f                   	pop    %edi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	8d 76 00             	lea    0x0(%esi),%esi
                    set_sched_queue(PRIORITY, pid);
 440:	83 ec 08             	sub    $0x8,%esp
 443:	50                   	push   %eax
 444:	6a 01                	push   $0x1
 446:	e8 d4 03 00 00       	call   81f <set_sched_queue>
                    set_priority(NCHILD * 3 - i, pid);
 44b:	58                   	pop    %eax
 44c:	b8 0c 00 00 00       	mov    $0xc,%eax
 451:	5a                   	pop    %edx
 452:	29 d8                	sub    %ebx,%eax
 454:	57                   	push   %edi
 455:	50                   	push   %eax
 456:	e8 b4 03 00 00       	call   80f <set_priority>
 45b:	83 c4 10             	add    $0x10,%esp
 45e:	e9 ed fe ff ff       	jmp    350 <multilevelQueue+0x20>
 463:	90                   	nop
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                    set_sched_queue(LOTTERY, pid);
 468:	83 ec 08             	sub    $0x8,%esp
 46b:	50                   	push   %eax
 46c:	6a 03                	push   $0x3
 46e:	e8 ac 03 00 00       	call   81f <set_sched_queue>
                    set_lottery_ticket(NCHILD * 4 - i, pid);
 473:	58                   	pop    %eax
 474:	b8 10 00 00 00       	mov    $0x10,%eax
 479:	5a                   	pop    %edx
 47a:	29 d8                	sub    %ebx,%eax
 47c:	57                   	push   %edi
 47d:	50                   	push   %eax
 47e:	e8 94 03 00 00       	call   817 <set_lottery_ticket>
 483:	83 c4 10             	add    $0x10,%esp
 486:	e9 c5 fe ff ff       	jmp    350 <multilevelQueue+0x20>
 48b:	90                   	nop
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "IO bound process with pid %d finished\n", getpid());
 490:	e8 42 03 00 00       	call   7d7 <getpid>
 495:	83 ec 04             	sub    $0x4,%esp
 498:	50                   	push   %eax
 499:	68 94 0c 00 00       	push   $0xc94
 49e:	6a 01                	push   $0x1
 4a0:	e8 2b 04 00 00       	call   8d0 <printf>
 4a5:	83 c4 10             	add    $0x10,%esp
 4a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ab:	5b                   	pop    %ebx
 4ac:	5e                   	pop    %esi
 4ad:	5f                   	pop    %edi
 4ae:	5d                   	pop    %ebp
 4af:	c3                   	ret    
        printf(2, "fork error\n");
 4b0:	83 ec 08             	sub    $0x8,%esp
 4b3:	68 28 0c 00 00       	push   $0xc28
 4b8:	6a 02                	push   $0x2
 4ba:	e8 11 04 00 00       	call   8d0 <printf>
 4bf:	83 c4 10             	add    $0x10,%esp
 4c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c5:	5b                   	pop    %ebx
 4c6:	5e                   	pop    %esi
 4c7:	5f                   	pop    %edi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    
 4ca:	66 90                	xchg   %ax,%ax
 4cc:	66 90                	xchg   %ax,%ax
 4ce:	66 90                	xchg   %ax,%ax

000004d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 45 08             	mov    0x8(%ebp),%eax
 4d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4da:	89 c2                	mov    %eax,%edx
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e0:	83 c1 01             	add    $0x1,%ecx
 4e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 4e7:	83 c2 01             	add    $0x1,%edx
 4ea:	84 db                	test   %bl,%bl
 4ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 4ef:	75 ef                	jne    4e0 <strcpy+0x10>
    ;
  return os;
}
 4f1:	5b                   	pop    %ebx
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000500 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 55 08             	mov    0x8(%ebp),%edx
 507:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 50a:	0f b6 02             	movzbl (%edx),%eax
 50d:	0f b6 19             	movzbl (%ecx),%ebx
 510:	84 c0                	test   %al,%al
 512:	75 1c                	jne    530 <strcmp+0x30>
 514:	eb 2a                	jmp    540 <strcmp+0x40>
 516:	8d 76 00             	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 520:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 523:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 526:	83 c1 01             	add    $0x1,%ecx
 529:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 52c:	84 c0                	test   %al,%al
 52e:	74 10                	je     540 <strcmp+0x40>
 530:	38 d8                	cmp    %bl,%al
 532:	74 ec                	je     520 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 534:	29 d8                	sub    %ebx,%eax
}
 536:	5b                   	pop    %ebx
 537:	5d                   	pop    %ebp
 538:	c3                   	ret    
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 540:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 542:	29 d8                	sub    %ebx,%eax
}
 544:	5b                   	pop    %ebx
 545:	5d                   	pop    %ebp
 546:	c3                   	ret    
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <strlen>:

uint
strlen(const char *s)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 556:	80 39 00             	cmpb   $0x0,(%ecx)
 559:	74 15                	je     570 <strlen+0x20>
 55b:	31 d2                	xor    %edx,%edx
 55d:	8d 76 00             	lea    0x0(%esi),%esi
 560:	83 c2 01             	add    $0x1,%edx
 563:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 567:	89 d0                	mov    %edx,%eax
 569:	75 f5                	jne    560 <strlen+0x10>
    ;
  return n;
}
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret    
 56d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 570:	31 c0                	xor    %eax,%eax
}
 572:	5d                   	pop    %ebp
 573:	c3                   	ret    
 574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 57a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000580 <memset>:

void*
memset(void *dst, int c, uint n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 587:	8b 4d 10             	mov    0x10(%ebp),%ecx
 58a:	8b 45 0c             	mov    0xc(%ebp),%eax
 58d:	89 d7                	mov    %edx,%edi
 58f:	fc                   	cld    
 590:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 592:	89 d0                	mov    %edx,%eax
 594:	5f                   	pop    %edi
 595:	5d                   	pop    %ebp
 596:	c3                   	ret    
 597:	89 f6                	mov    %esi,%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005a0 <strchr>:

char*
strchr(const char *s, char c)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
 5a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 5aa:	0f b6 10             	movzbl (%eax),%edx
 5ad:	84 d2                	test   %dl,%dl
 5af:	74 1d                	je     5ce <strchr+0x2e>
    if(*s == c)
 5b1:	38 d3                	cmp    %dl,%bl
 5b3:	89 d9                	mov    %ebx,%ecx
 5b5:	75 0d                	jne    5c4 <strchr+0x24>
 5b7:	eb 17                	jmp    5d0 <strchr+0x30>
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c0:	38 ca                	cmp    %cl,%dl
 5c2:	74 0c                	je     5d0 <strchr+0x30>
  for(; *s; s++)
 5c4:	83 c0 01             	add    $0x1,%eax
 5c7:	0f b6 10             	movzbl (%eax),%edx
 5ca:	84 d2                	test   %dl,%dl
 5cc:	75 f2                	jne    5c0 <strchr+0x20>
      return (char*)s;
  return 0;
 5ce:	31 c0                	xor    %eax,%eax
}
 5d0:	5b                   	pop    %ebx
 5d1:	5d                   	pop    %ebp
 5d2:	c3                   	ret    
 5d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <gets>:

char*
gets(char *buf, int max)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5e6:	31 f6                	xor    %esi,%esi
 5e8:	89 f3                	mov    %esi,%ebx
{
 5ea:	83 ec 1c             	sub    $0x1c,%esp
 5ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 5f0:	eb 2f                	jmp    621 <gets+0x41>
 5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 5f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5fb:	83 ec 04             	sub    $0x4,%esp
 5fe:	6a 01                	push   $0x1
 600:	50                   	push   %eax
 601:	6a 00                	push   $0x0
 603:	e8 67 01 00 00       	call   76f <read>
    if(cc < 1)
 608:	83 c4 10             	add    $0x10,%esp
 60b:	85 c0                	test   %eax,%eax
 60d:	7e 1c                	jle    62b <gets+0x4b>
      break;
    buf[i++] = c;
 60f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 613:	83 c7 01             	add    $0x1,%edi
 616:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 619:	3c 0a                	cmp    $0xa,%al
 61b:	74 23                	je     640 <gets+0x60>
 61d:	3c 0d                	cmp    $0xd,%al
 61f:	74 1f                	je     640 <gets+0x60>
  for(i=0; i+1 < max; ){
 621:	83 c3 01             	add    $0x1,%ebx
 624:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 627:	89 fe                	mov    %edi,%esi
 629:	7c cd                	jl     5f8 <gets+0x18>
 62b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 62d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 630:	c6 03 00             	movb   $0x0,(%ebx)
}
 633:	8d 65 f4             	lea    -0xc(%ebp),%esp
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    
 63b:	90                   	nop
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 640:	8b 75 08             	mov    0x8(%ebp),%esi
 643:	8b 45 08             	mov    0x8(%ebp),%eax
 646:	01 de                	add    %ebx,%esi
 648:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 64a:	c6 03 00             	movb   $0x0,(%ebx)
}
 64d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 650:	5b                   	pop    %ebx
 651:	5e                   	pop    %esi
 652:	5f                   	pop    %edi
 653:	5d                   	pop    %ebp
 654:	c3                   	ret    
 655:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <stat>:

int
stat(const char *n, struct stat *st)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	56                   	push   %esi
 664:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 665:	83 ec 08             	sub    $0x8,%esp
 668:	6a 00                	push   $0x0
 66a:	ff 75 08             	pushl  0x8(%ebp)
 66d:	e8 25 01 00 00       	call   797 <open>
  if(fd < 0)
 672:	83 c4 10             	add    $0x10,%esp
 675:	85 c0                	test   %eax,%eax
 677:	78 27                	js     6a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 679:	83 ec 08             	sub    $0x8,%esp
 67c:	ff 75 0c             	pushl  0xc(%ebp)
 67f:	89 c3                	mov    %eax,%ebx
 681:	50                   	push   %eax
 682:	e8 28 01 00 00       	call   7af <fstat>
  close(fd);
 687:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 68a:	89 c6                	mov    %eax,%esi
  close(fd);
 68c:	e8 ee 00 00 00       	call   77f <close>
  return r;
 691:	83 c4 10             	add    $0x10,%esp
}
 694:	8d 65 f8             	lea    -0x8(%ebp),%esp
 697:	89 f0                	mov    %esi,%eax
 699:	5b                   	pop    %ebx
 69a:	5e                   	pop    %esi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret    
 69d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6a5:	eb ed                	jmp    694 <stat+0x34>
 6a7:	89 f6                	mov    %esi,%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006b0 <atoi>:

int
atoi(const char *s)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	53                   	push   %ebx
 6b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6b7:	0f be 11             	movsbl (%ecx),%edx
 6ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 6bd:	3c 09                	cmp    $0x9,%al
  n = 0;
 6bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 6c4:	77 1f                	ja     6e5 <atoi+0x35>
 6c6:	8d 76 00             	lea    0x0(%esi),%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 6d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6d3:	83 c1 01             	add    $0x1,%ecx
 6d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 6da:	0f be 11             	movsbl (%ecx),%edx
 6dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6e0:	80 fb 09             	cmp    $0x9,%bl
 6e3:	76 eb                	jbe    6d0 <atoi+0x20>
  return n;
}
 6e5:	5b                   	pop    %ebx
 6e6:	5d                   	pop    %ebp
 6e7:	c3                   	ret    
 6e8:	90                   	nop
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	56                   	push   %esi
 6f4:	53                   	push   %ebx
 6f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6f8:	8b 45 08             	mov    0x8(%ebp),%eax
 6fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6fe:	85 db                	test   %ebx,%ebx
 700:	7e 14                	jle    716 <memmove+0x26>
 702:	31 d2                	xor    %edx,%edx
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 708:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 70c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 70f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 712:	39 d3                	cmp    %edx,%ebx
 714:	75 f2                	jne    708 <memmove+0x18>
  return vdst;
}
 716:	5b                   	pop    %ebx
 717:	5e                   	pop    %esi
 718:	5d                   	pop    %ebp
 719:	c3                   	ret    
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000720 <delay>:

void delay(int numberOfClocks)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	53                   	push   %ebx
 724:	83 ec 04             	sub    $0x4,%esp
    int firstClock = uptime();
 727:	e8 c3 00 00 00       	call   7ef <uptime>
 72c:	89 c3                	mov    %eax,%ebx
    int incClock = uptime();
 72e:	e8 bc 00 00 00       	call   7ef <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 733:	03 5d 08             	add    0x8(%ebp),%ebx
 736:	39 d8                	cmp    %ebx,%eax
 738:	7c 0f                	jl     749 <delay+0x29>
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        incClock = uptime();
 740:	e8 aa 00 00 00       	call   7ef <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 745:	39 d8                	cmp    %ebx,%eax
 747:	7d f7                	jge    740 <delay+0x20>
    }
}
 749:	83 c4 04             	add    $0x4,%esp
 74c:	5b                   	pop    %ebx
 74d:	5d                   	pop    %ebp
 74e:	c3                   	ret    

0000074f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 74f:	b8 01 00 00 00       	mov    $0x1,%eax
 754:	cd 40                	int    $0x40
 756:	c3                   	ret    

00000757 <exit>:
SYSCALL(exit)
 757:	b8 02 00 00 00       	mov    $0x2,%eax
 75c:	cd 40                	int    $0x40
 75e:	c3                   	ret    

0000075f <wait>:
SYSCALL(wait)
 75f:	b8 03 00 00 00       	mov    $0x3,%eax
 764:	cd 40                	int    $0x40
 766:	c3                   	ret    

00000767 <pipe>:
SYSCALL(pipe)
 767:	b8 04 00 00 00       	mov    $0x4,%eax
 76c:	cd 40                	int    $0x40
 76e:	c3                   	ret    

0000076f <read>:
SYSCALL(read)
 76f:	b8 05 00 00 00       	mov    $0x5,%eax
 774:	cd 40                	int    $0x40
 776:	c3                   	ret    

00000777 <write>:
SYSCALL(write)
 777:	b8 10 00 00 00       	mov    $0x10,%eax
 77c:	cd 40                	int    $0x40
 77e:	c3                   	ret    

0000077f <close>:
SYSCALL(close)
 77f:	b8 15 00 00 00       	mov    $0x15,%eax
 784:	cd 40                	int    $0x40
 786:	c3                   	ret    

00000787 <kill>:
SYSCALL(kill)
 787:	b8 06 00 00 00       	mov    $0x6,%eax
 78c:	cd 40                	int    $0x40
 78e:	c3                   	ret    

0000078f <exec>:
SYSCALL(exec)
 78f:	b8 07 00 00 00       	mov    $0x7,%eax
 794:	cd 40                	int    $0x40
 796:	c3                   	ret    

00000797 <open>:
SYSCALL(open)
 797:	b8 0f 00 00 00       	mov    $0xf,%eax
 79c:	cd 40                	int    $0x40
 79e:	c3                   	ret    

0000079f <mknod>:
SYSCALL(mknod)
 79f:	b8 11 00 00 00       	mov    $0x11,%eax
 7a4:	cd 40                	int    $0x40
 7a6:	c3                   	ret    

000007a7 <unlink>:
SYSCALL(unlink)
 7a7:	b8 12 00 00 00       	mov    $0x12,%eax
 7ac:	cd 40                	int    $0x40
 7ae:	c3                   	ret    

000007af <fstat>:
SYSCALL(fstat)
 7af:	b8 08 00 00 00       	mov    $0x8,%eax
 7b4:	cd 40                	int    $0x40
 7b6:	c3                   	ret    

000007b7 <link>:
SYSCALL(link)
 7b7:	b8 13 00 00 00       	mov    $0x13,%eax
 7bc:	cd 40                	int    $0x40
 7be:	c3                   	ret    

000007bf <mkdir>:
SYSCALL(mkdir)
 7bf:	b8 14 00 00 00       	mov    $0x14,%eax
 7c4:	cd 40                	int    $0x40
 7c6:	c3                   	ret    

000007c7 <chdir>:
SYSCALL(chdir)
 7c7:	b8 09 00 00 00       	mov    $0x9,%eax
 7cc:	cd 40                	int    $0x40
 7ce:	c3                   	ret    

000007cf <dup>:
SYSCALL(dup)
 7cf:	b8 0a 00 00 00       	mov    $0xa,%eax
 7d4:	cd 40                	int    $0x40
 7d6:	c3                   	ret    

000007d7 <getpid>:
SYSCALL(getpid)
 7d7:	b8 0b 00 00 00       	mov    $0xb,%eax
 7dc:	cd 40                	int    $0x40
 7de:	c3                   	ret    

000007df <sbrk>:
SYSCALL(sbrk)
 7df:	b8 0c 00 00 00       	mov    $0xc,%eax
 7e4:	cd 40                	int    $0x40
 7e6:	c3                   	ret    

000007e7 <sleep>:
SYSCALL(sleep)
 7e7:	b8 0d 00 00 00       	mov    $0xd,%eax
 7ec:	cd 40                	int    $0x40
 7ee:	c3                   	ret    

000007ef <uptime>:
SYSCALL(uptime)
 7ef:	b8 0e 00 00 00       	mov    $0xe,%eax
 7f4:	cd 40                	int    $0x40
 7f6:	c3                   	ret    

000007f7 <incNum>:
SYSCALL(incNum)
 7f7:	b8 16 00 00 00       	mov    $0x16,%eax
 7fc:	cd 40                	int    $0x40
 7fe:	c3                   	ret    

000007ff <getprocs>:
SYSCALL(getprocs)
 7ff:	b8 17 00 00 00       	mov    $0x17,%eax
 804:	cd 40                	int    $0x40
 806:	c3                   	ret    

00000807 <set_burst_time>:
SYSCALL(set_burst_time)
 807:	b8 18 00 00 00       	mov    $0x18,%eax
 80c:	cd 40                	int    $0x40
 80e:	c3                   	ret    

0000080f <set_priority>:
SYSCALL(set_priority)
 80f:	b8 19 00 00 00       	mov    $0x19,%eax
 814:	cd 40                	int    $0x40
 816:	c3                   	ret    

00000817 <set_lottery_ticket>:
SYSCALL(set_lottery_ticket)
 817:	b8 1a 00 00 00       	mov    $0x1a,%eax
 81c:	cd 40                	int    $0x40
 81e:	c3                   	ret    

0000081f <set_sched_queue>:
SYSCALL(set_sched_queue)
 81f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 824:	cd 40                	int    $0x40
 826:	c3                   	ret    

00000827 <show_processes_scheduling>:
SYSCALL(show_processes_scheduling)
 827:	b8 1c 00 00 00       	mov    $0x1c,%eax
 82c:	cd 40                	int    $0x40
 82e:	c3                   	ret    
 82f:	90                   	nop

00000830 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 839:	85 d2                	test   %edx,%edx
{
 83b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 83e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 840:	79 76                	jns    8b8 <printint+0x88>
 842:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 846:	74 70                	je     8b8 <printint+0x88>
    x = -xx;
 848:	f7 d8                	neg    %eax
    neg = 1;
 84a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 851:	31 f6                	xor    %esi,%esi
 853:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 856:	eb 0a                	jmp    862 <printint+0x32>
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 860:	89 fe                	mov    %edi,%esi
 862:	31 d2                	xor    %edx,%edx
 864:	8d 7e 01             	lea    0x1(%esi),%edi
 867:	f7 f1                	div    %ecx
 869:	0f b6 92 c4 0c 00 00 	movzbl 0xcc4(%edx),%edx
  }while((x /= base) != 0);
 870:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 872:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 875:	75 e9                	jne    860 <printint+0x30>
  if(neg)
 877:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 87a:	85 c0                	test   %eax,%eax
 87c:	74 08                	je     886 <printint+0x56>
    buf[i++] = '-';
 87e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 883:	8d 7e 02             	lea    0x2(%esi),%edi
 886:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 88a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 88d:	8d 76 00             	lea    0x0(%esi),%esi
 890:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 893:	83 ec 04             	sub    $0x4,%esp
 896:	83 ee 01             	sub    $0x1,%esi
 899:	6a 01                	push   $0x1
 89b:	53                   	push   %ebx
 89c:	57                   	push   %edi
 89d:	88 45 d7             	mov    %al,-0x29(%ebp)
 8a0:	e8 d2 fe ff ff       	call   777 <write>

  while(--i >= 0)
 8a5:	83 c4 10             	add    $0x10,%esp
 8a8:	39 de                	cmp    %ebx,%esi
 8aa:	75 e4                	jne    890 <printint+0x60>
    putc(fd, buf[i]);
}
 8ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8af:	5b                   	pop    %ebx
 8b0:	5e                   	pop    %esi
 8b1:	5f                   	pop    %edi
 8b2:	5d                   	pop    %ebp
 8b3:	c3                   	ret    
 8b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8b8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8bf:	eb 90                	jmp    851 <printint+0x21>
 8c1:	eb 0d                	jmp    8d0 <printf>
 8c3:	90                   	nop
 8c4:	90                   	nop
 8c5:	90                   	nop
 8c6:	90                   	nop
 8c7:	90                   	nop
 8c8:	90                   	nop
 8c9:	90                   	nop
 8ca:	90                   	nop
 8cb:	90                   	nop
 8cc:	90                   	nop
 8cd:	90                   	nop
 8ce:	90                   	nop
 8cf:	90                   	nop

000008d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
 8d5:	53                   	push   %ebx
 8d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8dc:	0f b6 1e             	movzbl (%esi),%ebx
 8df:	84 db                	test   %bl,%bl
 8e1:	0f 84 b3 00 00 00    	je     99a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 8e7:	8d 45 10             	lea    0x10(%ebp),%eax
 8ea:	83 c6 01             	add    $0x1,%esi
  state = 0;
 8ed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 8ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8f2:	eb 2f                	jmp    923 <printf+0x53>
 8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 8f8:	83 f8 25             	cmp    $0x25,%eax
 8fb:	0f 84 a7 00 00 00    	je     9a8 <printf+0xd8>
  write(fd, &c, 1);
 901:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 904:	83 ec 04             	sub    $0x4,%esp
 907:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 90a:	6a 01                	push   $0x1
 90c:	50                   	push   %eax
 90d:	ff 75 08             	pushl  0x8(%ebp)
 910:	e8 62 fe ff ff       	call   777 <write>
 915:	83 c4 10             	add    $0x10,%esp
 918:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 91b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 91f:	84 db                	test   %bl,%bl
 921:	74 77                	je     99a <printf+0xca>
    if(state == 0){
 923:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 925:	0f be cb             	movsbl %bl,%ecx
 928:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 92b:	74 cb                	je     8f8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 92d:	83 ff 25             	cmp    $0x25,%edi
 930:	75 e6                	jne    918 <printf+0x48>
      if(c == 'd'){
 932:	83 f8 64             	cmp    $0x64,%eax
 935:	0f 84 05 01 00 00    	je     a40 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 93b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 941:	83 f9 70             	cmp    $0x70,%ecx
 944:	74 72                	je     9b8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 946:	83 f8 73             	cmp    $0x73,%eax
 949:	0f 84 99 00 00 00    	je     9e8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 94f:	83 f8 63             	cmp    $0x63,%eax
 952:	0f 84 08 01 00 00    	je     a60 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 958:	83 f8 25             	cmp    $0x25,%eax
 95b:	0f 84 ef 00 00 00    	je     a50 <printf+0x180>
  write(fd, &c, 1);
 961:	8d 45 e7             	lea    -0x19(%ebp),%eax
 964:	83 ec 04             	sub    $0x4,%esp
 967:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 96b:	6a 01                	push   $0x1
 96d:	50                   	push   %eax
 96e:	ff 75 08             	pushl  0x8(%ebp)
 971:	e8 01 fe ff ff       	call   777 <write>
 976:	83 c4 0c             	add    $0xc,%esp
 979:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 97c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 97f:	6a 01                	push   $0x1
 981:	50                   	push   %eax
 982:	ff 75 08             	pushl  0x8(%ebp)
 985:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 988:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 98a:	e8 e8 fd ff ff       	call   777 <write>
  for(i = 0; fmt[i]; i++){
 98f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 993:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 996:	84 db                	test   %bl,%bl
 998:	75 89                	jne    923 <printf+0x53>
    }
  }
}
 99a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 99d:	5b                   	pop    %ebx
 99e:	5e                   	pop    %esi
 99f:	5f                   	pop    %edi
 9a0:	5d                   	pop    %ebp
 9a1:	c3                   	ret    
 9a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 9a8:	bf 25 00 00 00       	mov    $0x25,%edi
 9ad:	e9 66 ff ff ff       	jmp    918 <printf+0x48>
 9b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9b8:	83 ec 0c             	sub    $0xc,%esp
 9bb:	b9 10 00 00 00       	mov    $0x10,%ecx
 9c0:	6a 00                	push   $0x0
 9c2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 9c5:	8b 45 08             	mov    0x8(%ebp),%eax
 9c8:	8b 17                	mov    (%edi),%edx
 9ca:	e8 61 fe ff ff       	call   830 <printint>
        ap++;
 9cf:	89 f8                	mov    %edi,%eax
 9d1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9d4:	31 ff                	xor    %edi,%edi
        ap++;
 9d6:	83 c0 04             	add    $0x4,%eax
 9d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9dc:	e9 37 ff ff ff       	jmp    918 <printf+0x48>
 9e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9eb:	8b 08                	mov    (%eax),%ecx
        ap++;
 9ed:	83 c0 04             	add    $0x4,%eax
 9f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 9f3:	85 c9                	test   %ecx,%ecx
 9f5:	0f 84 8e 00 00 00    	je     a89 <printf+0x1b9>
        while(*s != 0){
 9fb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 9fe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 a00:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 a02:	84 c0                	test   %al,%al
 a04:	0f 84 0e ff ff ff    	je     918 <printf+0x48>
 a0a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 a0d:	89 de                	mov    %ebx,%esi
 a0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a12:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 a15:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a18:	83 ec 04             	sub    $0x4,%esp
          s++;
 a1b:	83 c6 01             	add    $0x1,%esi
 a1e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a21:	6a 01                	push   $0x1
 a23:	57                   	push   %edi
 a24:	53                   	push   %ebx
 a25:	e8 4d fd ff ff       	call   777 <write>
        while(*s != 0){
 a2a:	0f b6 06             	movzbl (%esi),%eax
 a2d:	83 c4 10             	add    $0x10,%esp
 a30:	84 c0                	test   %al,%al
 a32:	75 e4                	jne    a18 <printf+0x148>
 a34:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a37:	31 ff                	xor    %edi,%edi
 a39:	e9 da fe ff ff       	jmp    918 <printf+0x48>
 a3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a40:	83 ec 0c             	sub    $0xc,%esp
 a43:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a48:	6a 01                	push   $0x1
 a4a:	e9 73 ff ff ff       	jmp    9c2 <printf+0xf2>
 a4f:	90                   	nop
  write(fd, &c, 1);
 a50:	83 ec 04             	sub    $0x4,%esp
 a53:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a59:	6a 01                	push   $0x1
 a5b:	e9 21 ff ff ff       	jmp    981 <printf+0xb1>
        putc(fd, *ap);
 a60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a66:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a68:	6a 01                	push   $0x1
        ap++;
 a6a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a6d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a73:	50                   	push   %eax
 a74:	ff 75 08             	pushl  0x8(%ebp)
 a77:	e8 fb fc ff ff       	call   777 <write>
        ap++;
 a7c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a7f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a82:	31 ff                	xor    %edi,%edi
 a84:	e9 8f fe ff ff       	jmp    918 <printf+0x48>
          s = "(null)";
 a89:	bb bc 0c 00 00       	mov    $0xcbc,%ebx
        while(*s != 0){
 a8e:	b8 28 00 00 00       	mov    $0x28,%eax
 a93:	e9 72 ff ff ff       	jmp    a0a <printf+0x13a>
 a98:	66 90                	xchg   %ax,%ax
 a9a:	66 90                	xchg   %ax,%ax
 a9c:	66 90                	xchg   %ax,%ax
 a9e:	66 90                	xchg   %ax,%ax

00000aa0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aa0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa1:	a1 cc 10 00 00       	mov    0x10cc,%eax
{
 aa6:	89 e5                	mov    %esp,%ebp
 aa8:	57                   	push   %edi
 aa9:	56                   	push   %esi
 aaa:	53                   	push   %ebx
 aab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 aae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab8:	39 c8                	cmp    %ecx,%eax
 aba:	8b 10                	mov    (%eax),%edx
 abc:	73 32                	jae    af0 <free+0x50>
 abe:	39 d1                	cmp    %edx,%ecx
 ac0:	72 04                	jb     ac6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac2:	39 d0                	cmp    %edx,%eax
 ac4:	72 32                	jb     af8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ac6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ac9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 acc:	39 fa                	cmp    %edi,%edx
 ace:	74 30                	je     b00 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ad0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ad3:	8b 50 04             	mov    0x4(%eax),%edx
 ad6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ad9:	39 f1                	cmp    %esi,%ecx
 adb:	74 3a                	je     b17 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 add:	89 08                	mov    %ecx,(%eax)
  freep = p;
 adf:	a3 cc 10 00 00       	mov    %eax,0x10cc
}
 ae4:	5b                   	pop    %ebx
 ae5:	5e                   	pop    %esi
 ae6:	5f                   	pop    %edi
 ae7:	5d                   	pop    %ebp
 ae8:	c3                   	ret    
 ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af0:	39 d0                	cmp    %edx,%eax
 af2:	72 04                	jb     af8 <free+0x58>
 af4:	39 d1                	cmp    %edx,%ecx
 af6:	72 ce                	jb     ac6 <free+0x26>
{
 af8:	89 d0                	mov    %edx,%eax
 afa:	eb bc                	jmp    ab8 <free+0x18>
 afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b00:	03 72 04             	add    0x4(%edx),%esi
 b03:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b06:	8b 10                	mov    (%eax),%edx
 b08:	8b 12                	mov    (%edx),%edx
 b0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b0d:	8b 50 04             	mov    0x4(%eax),%edx
 b10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b13:	39 f1                	cmp    %esi,%ecx
 b15:	75 c6                	jne    add <free+0x3d>
    p->s.size += bp->s.size;
 b17:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b1a:	a3 cc 10 00 00       	mov    %eax,0x10cc
    p->s.size += bp->s.size;
 b1f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b22:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b25:	89 10                	mov    %edx,(%eax)
}
 b27:	5b                   	pop    %ebx
 b28:	5e                   	pop    %esi
 b29:	5f                   	pop    %edi
 b2a:	5d                   	pop    %ebp
 b2b:	c3                   	ret    
 b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b30:	55                   	push   %ebp
 b31:	89 e5                	mov    %esp,%ebp
 b33:	57                   	push   %edi
 b34:	56                   	push   %esi
 b35:	53                   	push   %ebx
 b36:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b3c:	8b 15 cc 10 00 00    	mov    0x10cc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b42:	8d 78 07             	lea    0x7(%eax),%edi
 b45:	c1 ef 03             	shr    $0x3,%edi
 b48:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b4b:	85 d2                	test   %edx,%edx
 b4d:	0f 84 9d 00 00 00    	je     bf0 <malloc+0xc0>
 b53:	8b 02                	mov    (%edx),%eax
 b55:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b58:	39 cf                	cmp    %ecx,%edi
 b5a:	76 6c                	jbe    bc8 <malloc+0x98>
 b5c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b62:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b67:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b6a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b71:	eb 0e                	jmp    b81 <malloc+0x51>
 b73:	90                   	nop
 b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b7a:	8b 48 04             	mov    0x4(%eax),%ecx
 b7d:	39 f9                	cmp    %edi,%ecx
 b7f:	73 47                	jae    bc8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b81:	39 05 cc 10 00 00    	cmp    %eax,0x10cc
 b87:	89 c2                	mov    %eax,%edx
 b89:	75 ed                	jne    b78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b8b:	83 ec 0c             	sub    $0xc,%esp
 b8e:	56                   	push   %esi
 b8f:	e8 4b fc ff ff       	call   7df <sbrk>
  if(p == (char*)-1)
 b94:	83 c4 10             	add    $0x10,%esp
 b97:	83 f8 ff             	cmp    $0xffffffff,%eax
 b9a:	74 1c                	je     bb8 <malloc+0x88>
  hp->s.size = nu;
 b9c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b9f:	83 ec 0c             	sub    $0xc,%esp
 ba2:	83 c0 08             	add    $0x8,%eax
 ba5:	50                   	push   %eax
 ba6:	e8 f5 fe ff ff       	call   aa0 <free>
  return freep;
 bab:	8b 15 cc 10 00 00    	mov    0x10cc,%edx
      if((p = morecore(nunits)) == 0)
 bb1:	83 c4 10             	add    $0x10,%esp
 bb4:	85 d2                	test   %edx,%edx
 bb6:	75 c0                	jne    b78 <malloc+0x48>
        return 0;
  }
}
 bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bbb:	31 c0                	xor    %eax,%eax
}
 bbd:	5b                   	pop    %ebx
 bbe:	5e                   	pop    %esi
 bbf:	5f                   	pop    %edi
 bc0:	5d                   	pop    %ebp
 bc1:	c3                   	ret    
 bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 bc8:	39 cf                	cmp    %ecx,%edi
 bca:	74 54                	je     c20 <malloc+0xf0>
        p->s.size -= nunits;
 bcc:	29 f9                	sub    %edi,%ecx
 bce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bd1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bd4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 bd7:	89 15 cc 10 00 00    	mov    %edx,0x10cc
}
 bdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 be0:	83 c0 08             	add    $0x8,%eax
}
 be3:	5b                   	pop    %ebx
 be4:	5e                   	pop    %esi
 be5:	5f                   	pop    %edi
 be6:	5d                   	pop    %ebp
 be7:	c3                   	ret    
 be8:	90                   	nop
 be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 bf0:	c7 05 cc 10 00 00 d0 	movl   $0x10d0,0x10cc
 bf7:	10 00 00 
 bfa:	c7 05 d0 10 00 00 d0 	movl   $0x10d0,0x10d0
 c01:	10 00 00 
    base.s.size = 0;
 c04:	b8 d0 10 00 00       	mov    $0x10d0,%eax
 c09:	c7 05 d4 10 00 00 00 	movl   $0x0,0x10d4
 c10:	00 00 00 
 c13:	e9 44 ff ff ff       	jmp    b5c <malloc+0x2c>
 c18:	90                   	nop
 c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c20:	8b 08                	mov    (%eax),%ecx
 c22:	89 0a                	mov    %ecx,(%edx)
 c24:	eb b1                	jmp    bd7 <malloc+0xa7>
