
_setQueue:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h" // for using file defines
#include "user.h" // for using from strlen


int main(int argc, char const *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
    int pid, queue;
    char buf[1024];
    printf(1, "enter pid : ");
    pid = atoi(buf);
  10:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
{
  16:	81 ec 14 04 00 00    	sub    $0x414,%esp
    printf(1, "enter pid : ");
  1c:	68 d8 07 00 00       	push   $0x7d8
  21:	6a 01                	push   $0x1
  23:	e8 58 04 00 00       	call   480 <printf>
    pid = atoi(buf);
  28:	89 1c 24             	mov    %ebx,(%esp)
  2b:	e8 30 02 00 00       	call   260 <atoi>
    read(1, buf, 1024);
  30:	83 c4 0c             	add    $0xc,%esp
  33:	68 00 04 00 00       	push   $0x400
  38:	53                   	push   %ebx
  39:	6a 01                	push   $0x1
  3b:	e8 df 02 00 00       	call   31f <read>
    pid = atoi(buf);
  40:	89 1c 24             	mov    %ebx,(%esp)
  43:	e8 18 02 00 00       	call   260 <atoi>
  48:	89 c6                	mov    %eax,%esi
    printf(1, "enter queue number : ");
  4a:	58                   	pop    %eax
  4b:	5a                   	pop    %edx
  4c:	68 e5 07 00 00       	push   $0x7e5
  51:	6a 01                	push   $0x1
  53:	e8 28 04 00 00       	call   480 <printf>
    read(1, buf, 1024);
  58:	83 c4 0c             	add    $0xc,%esp
  5b:	68 00 04 00 00       	push   $0x400
  60:	53                   	push   %ebx
  61:	6a 01                	push   $0x1
  63:	e8 b7 02 00 00       	call   31f <read>
    queue = atoi(buf);
  68:	89 1c 24             	mov    %ebx,(%esp)
  6b:	e8 f0 01 00 00       	call   260 <atoi>
    set_sched_queue(queue, pid);
  70:	59                   	pop    %ecx
  71:	5b                   	pop    %ebx
  72:	56                   	push   %esi
  73:	50                   	push   %eax
  74:	e8 56 03 00 00       	call   3cf <set_sched_queue>
    exit();
  79:	e8 89 02 00 00       	call   307 <exit>
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1c                	jne    e0 <strcmp+0x30>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  d6:	83 c1 01             	add    $0x1,%ecx
  d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x40>
  e0:	38 d8                	cmp    %bl,%al
  e2:	74 ec                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e4:	29 d8                	sub    %ebx,%eax
}
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d9                	mov    %ebx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	31 f6                	xor    %esi,%esi
 198:	89 f3                	mov    %esi,%ebx
{
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 67 01 00 00       	call   31f <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	89 fe                	mov    %edi,%esi
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 25 01 00 00       	call   347 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 28 01 00 00       	call   35f <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 ee 00 00 00       	call   32f <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2c2:	39 d3                	cmp    %edx,%ebx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
  return vdst;
}
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <delay>:

void delay(int numberOfClocks)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	83 ec 04             	sub    $0x4,%esp
    int firstClock = uptime();
 2d7:	e8 c3 00 00 00       	call   39f <uptime>
 2dc:	89 c3                	mov    %eax,%ebx
    int incClock = uptime();
 2de:	e8 bc 00 00 00       	call   39f <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 2e3:	03 5d 08             	add    0x8(%ebp),%ebx
 2e6:	39 d8                	cmp    %ebx,%eax
 2e8:	7c 0f                	jl     2f9 <delay+0x29>
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        incClock = uptime();
 2f0:	e8 aa 00 00 00       	call   39f <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 2f5:	39 d8                	cmp    %ebx,%eax
 2f7:	7d f7                	jge    2f0 <delay+0x20>
    }
}
 2f9:	83 c4 04             	add    $0x4,%esp
 2fc:	5b                   	pop    %ebx
 2fd:	5d                   	pop    %ebp
 2fe:	c3                   	ret    

000002ff <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ff:	b8 01 00 00 00       	mov    $0x1,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <exit>:
SYSCALL(exit)
 307:	b8 02 00 00 00       	mov    $0x2,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <wait>:
SYSCALL(wait)
 30f:	b8 03 00 00 00       	mov    $0x3,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <pipe>:
SYSCALL(pipe)
 317:	b8 04 00 00 00       	mov    $0x4,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <read>:
SYSCALL(read)
 31f:	b8 05 00 00 00       	mov    $0x5,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <write>:
SYSCALL(write)
 327:	b8 10 00 00 00       	mov    $0x10,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <close>:
SYSCALL(close)
 32f:	b8 15 00 00 00       	mov    $0x15,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <kill>:
SYSCALL(kill)
 337:	b8 06 00 00 00       	mov    $0x6,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <exec>:
SYSCALL(exec)
 33f:	b8 07 00 00 00       	mov    $0x7,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <open>:
SYSCALL(open)
 347:	b8 0f 00 00 00       	mov    $0xf,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <mknod>:
SYSCALL(mknod)
 34f:	b8 11 00 00 00       	mov    $0x11,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <unlink>:
SYSCALL(unlink)
 357:	b8 12 00 00 00       	mov    $0x12,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <fstat>:
SYSCALL(fstat)
 35f:	b8 08 00 00 00       	mov    $0x8,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <link>:
SYSCALL(link)
 367:	b8 13 00 00 00       	mov    $0x13,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <mkdir>:
SYSCALL(mkdir)
 36f:	b8 14 00 00 00       	mov    $0x14,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <chdir>:
SYSCALL(chdir)
 377:	b8 09 00 00 00       	mov    $0x9,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <dup>:
SYSCALL(dup)
 37f:	b8 0a 00 00 00       	mov    $0xa,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <getpid>:
SYSCALL(getpid)
 387:	b8 0b 00 00 00       	mov    $0xb,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <sbrk>:
SYSCALL(sbrk)
 38f:	b8 0c 00 00 00       	mov    $0xc,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <sleep>:
SYSCALL(sleep)
 397:	b8 0d 00 00 00       	mov    $0xd,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <uptime>:
SYSCALL(uptime)
 39f:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <incNum>:
SYSCALL(incNum)
 3a7:	b8 16 00 00 00       	mov    $0x16,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <getprocs>:
SYSCALL(getprocs)
 3af:	b8 17 00 00 00       	mov    $0x17,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <set_burst_time>:
SYSCALL(set_burst_time)
 3b7:	b8 18 00 00 00       	mov    $0x18,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <set_priority>:
SYSCALL(set_priority)
 3bf:	b8 19 00 00 00       	mov    $0x19,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <set_lottery_ticket>:
SYSCALL(set_lottery_ticket)
 3c7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <set_sched_queue>:
SYSCALL(set_sched_queue)
 3cf:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <show_processes_scheduling>:
SYSCALL(show_processes_scheduling)
 3d7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3e9:	85 d2                	test   %edx,%edx
{
 3eb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 3ee:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3f0:	79 76                	jns    468 <printint+0x88>
 3f2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3f6:	74 70                	je     468 <printint+0x88>
    x = -xx;
 3f8:	f7 d8                	neg    %eax
    neg = 1;
 3fa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 401:	31 f6                	xor    %esi,%esi
 403:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 406:	eb 0a                	jmp    412 <printint+0x32>
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 410:	89 fe                	mov    %edi,%esi
 412:	31 d2                	xor    %edx,%edx
 414:	8d 7e 01             	lea    0x1(%esi),%edi
 417:	f7 f1                	div    %ecx
 419:	0f b6 92 04 08 00 00 	movzbl 0x804(%edx),%edx
  }while((x /= base) != 0);
 420:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 422:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 425:	75 e9                	jne    410 <printint+0x30>
  if(neg)
 427:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 42a:	85 c0                	test   %eax,%eax
 42c:	74 08                	je     436 <printint+0x56>
    buf[i++] = '-';
 42e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 433:	8d 7e 02             	lea    0x2(%esi),%edi
 436:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 43a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 443:	83 ec 04             	sub    $0x4,%esp
 446:	83 ee 01             	sub    $0x1,%esi
 449:	6a 01                	push   $0x1
 44b:	53                   	push   %ebx
 44c:	57                   	push   %edi
 44d:	88 45 d7             	mov    %al,-0x29(%ebp)
 450:	e8 d2 fe ff ff       	call   327 <write>

  while(--i >= 0)
 455:	83 c4 10             	add    $0x10,%esp
 458:	39 de                	cmp    %ebx,%esi
 45a:	75 e4                	jne    440 <printint+0x60>
    putc(fd, buf[i]);
}
 45c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5f                   	pop    %edi
 462:	5d                   	pop    %ebp
 463:	c3                   	ret    
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 468:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 46f:	eb 90                	jmp    401 <printint+0x21>
 471:	eb 0d                	jmp    480 <printf>
 473:	90                   	nop
 474:	90                   	nop
 475:	90                   	nop
 476:	90                   	nop
 477:	90                   	nop
 478:	90                   	nop
 479:	90                   	nop
 47a:	90                   	nop
 47b:	90                   	nop
 47c:	90                   	nop
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	90                   	nop

00000480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 489:	8b 75 0c             	mov    0xc(%ebp),%esi
 48c:	0f b6 1e             	movzbl (%esi),%ebx
 48f:	84 db                	test   %bl,%bl
 491:	0f 84 b3 00 00 00    	je     54a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 497:	8d 45 10             	lea    0x10(%ebp),%eax
 49a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 49d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 49f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4a2:	eb 2f                	jmp    4d3 <printf+0x53>
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4a8:	83 f8 25             	cmp    $0x25,%eax
 4ab:	0f 84 a7 00 00 00    	je     558 <printf+0xd8>
  write(fd, &c, 1);
 4b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4b4:	83 ec 04             	sub    $0x4,%esp
 4b7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4ba:	6a 01                	push   $0x1
 4bc:	50                   	push   %eax
 4bd:	ff 75 08             	pushl  0x8(%ebp)
 4c0:	e8 62 fe ff ff       	call   327 <write>
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 4cb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4cf:	84 db                	test   %bl,%bl
 4d1:	74 77                	je     54a <printf+0xca>
    if(state == 0){
 4d3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4d5:	0f be cb             	movsbl %bl,%ecx
 4d8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4db:	74 cb                	je     4a8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4dd:	83 ff 25             	cmp    $0x25,%edi
 4e0:	75 e6                	jne    4c8 <printf+0x48>
      if(c == 'd'){
 4e2:	83 f8 64             	cmp    $0x64,%eax
 4e5:	0f 84 05 01 00 00    	je     5f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4eb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4f1:	83 f9 70             	cmp    $0x70,%ecx
 4f4:	74 72                	je     568 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4f6:	83 f8 73             	cmp    $0x73,%eax
 4f9:	0f 84 99 00 00 00    	je     598 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4ff:	83 f8 63             	cmp    $0x63,%eax
 502:	0f 84 08 01 00 00    	je     610 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 508:	83 f8 25             	cmp    $0x25,%eax
 50b:	0f 84 ef 00 00 00    	je     600 <printf+0x180>
  write(fd, &c, 1);
 511:	8d 45 e7             	lea    -0x19(%ebp),%eax
 514:	83 ec 04             	sub    $0x4,%esp
 517:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 51b:	6a 01                	push   $0x1
 51d:	50                   	push   %eax
 51e:	ff 75 08             	pushl  0x8(%ebp)
 521:	e8 01 fe ff ff       	call   327 <write>
 526:	83 c4 0c             	add    $0xc,%esp
 529:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 52c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 52f:	6a 01                	push   $0x1
 531:	50                   	push   %eax
 532:	ff 75 08             	pushl  0x8(%ebp)
 535:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 538:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 53a:	e8 e8 fd ff ff       	call   327 <write>
  for(i = 0; fmt[i]; i++){
 53f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 543:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 546:	84 db                	test   %bl,%bl
 548:	75 89                	jne    4d3 <printf+0x53>
    }
  }
}
 54a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 54d:	5b                   	pop    %ebx
 54e:	5e                   	pop    %esi
 54f:	5f                   	pop    %edi
 550:	5d                   	pop    %ebp
 551:	c3                   	ret    
 552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 558:	bf 25 00 00 00       	mov    $0x25,%edi
 55d:	e9 66 ff ff ff       	jmp    4c8 <printf+0x48>
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 568:	83 ec 0c             	sub    $0xc,%esp
 56b:	b9 10 00 00 00       	mov    $0x10,%ecx
 570:	6a 00                	push   $0x0
 572:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 575:	8b 45 08             	mov    0x8(%ebp),%eax
 578:	8b 17                	mov    (%edi),%edx
 57a:	e8 61 fe ff ff       	call   3e0 <printint>
        ap++;
 57f:	89 f8                	mov    %edi,%eax
 581:	83 c4 10             	add    $0x10,%esp
      state = 0;
 584:	31 ff                	xor    %edi,%edi
        ap++;
 586:	83 c0 04             	add    $0x4,%eax
 589:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 58c:	e9 37 ff ff ff       	jmp    4c8 <printf+0x48>
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 598:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 59b:	8b 08                	mov    (%eax),%ecx
        ap++;
 59d:	83 c0 04             	add    $0x4,%eax
 5a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 5a3:	85 c9                	test   %ecx,%ecx
 5a5:	0f 84 8e 00 00 00    	je     639 <printf+0x1b9>
        while(*s != 0){
 5ab:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 5ae:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 5b0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 5b2:	84 c0                	test   %al,%al
 5b4:	0f 84 0e ff ff ff    	je     4c8 <printf+0x48>
 5ba:	89 75 d0             	mov    %esi,-0x30(%ebp)
 5bd:	89 de                	mov    %ebx,%esi
 5bf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5c2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5c8:	83 ec 04             	sub    $0x4,%esp
          s++;
 5cb:	83 c6 01             	add    $0x1,%esi
 5ce:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5d1:	6a 01                	push   $0x1
 5d3:	57                   	push   %edi
 5d4:	53                   	push   %ebx
 5d5:	e8 4d fd ff ff       	call   327 <write>
        while(*s != 0){
 5da:	0f b6 06             	movzbl (%esi),%eax
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	84 c0                	test   %al,%al
 5e2:	75 e4                	jne    5c8 <printf+0x148>
 5e4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 5e7:	31 ff                	xor    %edi,%edi
 5e9:	e9 da fe ff ff       	jmp    4c8 <printf+0x48>
 5ee:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5f0:	83 ec 0c             	sub    $0xc,%esp
 5f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5f8:	6a 01                	push   $0x1
 5fa:	e9 73 ff ff ff       	jmp    572 <printf+0xf2>
 5ff:	90                   	nop
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 606:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 609:	6a 01                	push   $0x1
 60b:	e9 21 ff ff ff       	jmp    531 <printf+0xb1>
        putc(fd, *ap);
 610:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 616:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 618:	6a 01                	push   $0x1
        ap++;
 61a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 61d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 620:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 623:	50                   	push   %eax
 624:	ff 75 08             	pushl  0x8(%ebp)
 627:	e8 fb fc ff ff       	call   327 <write>
        ap++;
 62c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 62f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 632:	31 ff                	xor    %edi,%edi
 634:	e9 8f fe ff ff       	jmp    4c8 <printf+0x48>
          s = "(null)";
 639:	bb fb 07 00 00       	mov    $0x7fb,%ebx
        while(*s != 0){
 63e:	b8 28 00 00 00       	mov    $0x28,%eax
 643:	e9 72 ff ff ff       	jmp    5ba <printf+0x13a>
 648:	66 90                	xchg   %ax,%ax
 64a:	66 90                	xchg   %ax,%ax
 64c:	66 90                	xchg   %ax,%ax
 64e:	66 90                	xchg   %ax,%ax

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	a1 d4 0a 00 00       	mov    0xad4,%eax
{
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 65e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 668:	39 c8                	cmp    %ecx,%eax
 66a:	8b 10                	mov    (%eax),%edx
 66c:	73 32                	jae    6a0 <free+0x50>
 66e:	39 d1                	cmp    %edx,%ecx
 670:	72 04                	jb     676 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 672:	39 d0                	cmp    %edx,%eax
 674:	72 32                	jb     6a8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 676:	8b 73 fc             	mov    -0x4(%ebx),%esi
 679:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 67c:	39 fa                	cmp    %edi,%edx
 67e:	74 30                	je     6b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 680:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 683:	8b 50 04             	mov    0x4(%eax),%edx
 686:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 689:	39 f1                	cmp    %esi,%ecx
 68b:	74 3a                	je     6c7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 68d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 68f:	a3 d4 0a 00 00       	mov    %eax,0xad4
}
 694:	5b                   	pop    %ebx
 695:	5e                   	pop    %esi
 696:	5f                   	pop    %edi
 697:	5d                   	pop    %ebp
 698:	c3                   	ret    
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a0:	39 d0                	cmp    %edx,%eax
 6a2:	72 04                	jb     6a8 <free+0x58>
 6a4:	39 d1                	cmp    %edx,%ecx
 6a6:	72 ce                	jb     676 <free+0x26>
{
 6a8:	89 d0                	mov    %edx,%eax
 6aa:	eb bc                	jmp    668 <free+0x18>
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6b0:	03 72 04             	add    0x4(%edx),%esi
 6b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b6:	8b 10                	mov    (%eax),%edx
 6b8:	8b 12                	mov    (%edx),%edx
 6ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6bd:	8b 50 04             	mov    0x4(%eax),%edx
 6c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	75 c6                	jne    68d <free+0x3d>
    p->s.size += bp->s.size;
 6c7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6ca:	a3 d4 0a 00 00       	mov    %eax,0xad4
    p->s.size += bp->s.size;
 6cf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6d2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6d5:	89 10                	mov    %edx,(%eax)
}
 6d7:	5b                   	pop    %ebx
 6d8:	5e                   	pop    %esi
 6d9:	5f                   	pop    %edi
 6da:	5d                   	pop    %ebp
 6db:	c3                   	ret    
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ec:	8b 15 d4 0a 00 00    	mov    0xad4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8d 78 07             	lea    0x7(%eax),%edi
 6f5:	c1 ef 03             	shr    $0x3,%edi
 6f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6fb:	85 d2                	test   %edx,%edx
 6fd:	0f 84 9d 00 00 00    	je     7a0 <malloc+0xc0>
 703:	8b 02                	mov    (%edx),%eax
 705:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 708:	39 cf                	cmp    %ecx,%edi
 70a:	76 6c                	jbe    778 <malloc+0x98>
 70c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 712:	bb 00 10 00 00       	mov    $0x1000,%ebx
 717:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 71a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 721:	eb 0e                	jmp    731 <malloc+0x51>
 723:	90                   	nop
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 728:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 72a:	8b 48 04             	mov    0x4(%eax),%ecx
 72d:	39 f9                	cmp    %edi,%ecx
 72f:	73 47                	jae    778 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 731:	39 05 d4 0a 00 00    	cmp    %eax,0xad4
 737:	89 c2                	mov    %eax,%edx
 739:	75 ed                	jne    728 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 73b:	83 ec 0c             	sub    $0xc,%esp
 73e:	56                   	push   %esi
 73f:	e8 4b fc ff ff       	call   38f <sbrk>
  if(p == (char*)-1)
 744:	83 c4 10             	add    $0x10,%esp
 747:	83 f8 ff             	cmp    $0xffffffff,%eax
 74a:	74 1c                	je     768 <malloc+0x88>
  hp->s.size = nu;
 74c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 74f:	83 ec 0c             	sub    $0xc,%esp
 752:	83 c0 08             	add    $0x8,%eax
 755:	50                   	push   %eax
 756:	e8 f5 fe ff ff       	call   650 <free>
  return freep;
 75b:	8b 15 d4 0a 00 00    	mov    0xad4,%edx
      if((p = morecore(nunits)) == 0)
 761:	83 c4 10             	add    $0x10,%esp
 764:	85 d2                	test   %edx,%edx
 766:	75 c0                	jne    728 <malloc+0x48>
        return 0;
  }
}
 768:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 76b:	31 c0                	xor    %eax,%eax
}
 76d:	5b                   	pop    %ebx
 76e:	5e                   	pop    %esi
 76f:	5f                   	pop    %edi
 770:	5d                   	pop    %ebp
 771:	c3                   	ret    
 772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 778:	39 cf                	cmp    %ecx,%edi
 77a:	74 54                	je     7d0 <malloc+0xf0>
        p->s.size -= nunits;
 77c:	29 f9                	sub    %edi,%ecx
 77e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 781:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 784:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 787:	89 15 d4 0a 00 00    	mov    %edx,0xad4
}
 78d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 790:	83 c0 08             	add    $0x8,%eax
}
 793:	5b                   	pop    %ebx
 794:	5e                   	pop    %esi
 795:	5f                   	pop    %edi
 796:	5d                   	pop    %ebp
 797:	c3                   	ret    
 798:	90                   	nop
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7a0:	c7 05 d4 0a 00 00 d8 	movl   $0xad8,0xad4
 7a7:	0a 00 00 
 7aa:	c7 05 d8 0a 00 00 d8 	movl   $0xad8,0xad8
 7b1:	0a 00 00 
    base.s.size = 0;
 7b4:	b8 d8 0a 00 00       	mov    $0xad8,%eax
 7b9:	c7 05 dc 0a 00 00 00 	movl   $0x0,0xadc
 7c0:	00 00 00 
 7c3:	e9 44 ff ff ff       	jmp    70c <malloc+0x2c>
 7c8:	90                   	nop
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7d0:	8b 08                	mov    (%eax),%ecx
 7d2:	89 0a                	mov    %ecx,(%edx)
 7d4:	eb b1                	jmp    787 <malloc+0xa7>
