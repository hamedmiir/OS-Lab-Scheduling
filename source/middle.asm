
_middle:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define O_CREATE  0x200


int
main(int argc, char* argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
        printf(1, "please insert exactly 7 numbers \n");
        exit();
    }

    int array[7], i, j, temp, num = 7;
    for(i = 0; i < 7; i++){
  11:	31 db                	xor    %ebx,%ebx
{
  13:	81 ec f8 07 00 00    	sub    $0x7f8,%esp
    if(argc != 8) {
  19:	83 39 08             	cmpl   $0x8,(%ecx)
{
  1c:	8b 71 04             	mov    0x4(%ecx),%esi
    if(argc != 8) {
  1f:	0f 85 40 01 00 00    	jne    165 <main+0x165>
  25:	8d 76 00             	lea    0x0(%esi),%esi
        array[i] = atoi(argv[i+1]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 74 9e 04          	pushl  0x4(%esi,%ebx,4)
  2f:	e8 3c 03 00 00       	call   370 <atoi>
  34:	89 84 9d fc f7 ff ff 	mov    %eax,-0x804(%ebp,%ebx,4)
    for(i = 0; i < 7; i++){
  3b:	83 c3 01             	add    $0x1,%ebx
  3e:	83 c4 10             	add    $0x10,%esp
  41:	83 fb 07             	cmp    $0x7,%ebx
  44:	75 e2                	jne    28 <main+0x28>
  46:	bb 06 00 00 00       	mov    $0x6,%ebx
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }

    for (i = 0; i < num; i++)
    {
        for (j = 0; j < (num - i - 1); j++)
  50:	31 c0                	xor    %eax,%eax
  52:	39 d8                	cmp    %ebx,%eax
  54:	7d 27                	jge    7d <main+0x7d>
        {
            if (array[j] > array[j + 1])
  56:	8b 94 85 fc f7 ff ff 	mov    -0x804(%ebp,%eax,4),%edx
  5d:	83 c0 01             	add    $0x1,%eax
  60:	8b 8c 85 fc f7 ff ff 	mov    -0x804(%ebp,%eax,4),%ecx
  67:	39 ca                	cmp    %ecx,%edx
  69:	7e e7                	jle    52 <main+0x52>
        for (j = 0; j < (num - i - 1); j++)
  6b:	39 d8                	cmp    %ebx,%eax
            {
                temp = array[j];
                array[j] = array[j + 1];
  6d:	89 8c 85 f8 f7 ff ff 	mov    %ecx,-0x808(%ebp,%eax,4)
                array[j + 1] = temp;
  74:	89 94 85 fc f7 ff ff 	mov    %edx,-0x804(%ebp,%eax,4)
        for (j = 0; j < (num - i - 1); j++)
  7b:	7c d9                	jl     56 <main+0x56>
  7d:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < num; i++)
  80:	83 fb ff             	cmp    $0xffffffff,%ebx
  83:	75 cb                	jne    50 <main+0x50>
            }
        }
    }

    char t, midInverse[1000];
    int cnt = 0, mid = array[3];
  85:	8b 8d 08 f8 ff ff    	mov    -0x7f8(%ebp),%ecx
    while(mid != 0) {
  8b:	85 c9                	test   %ecx,%ecx
  8d:	74 63                	je     f2 <main+0xf2>
    int cnt = 0, mid = array[3];
  8f:	31 db                	xor    %ebx,%ebx
        t = (mid % 10) + '0';
  91:	be 67 66 66 66       	mov    $0x66666667,%esi
  96:	eb 0a                	jmp    a2 <main+0xa2>
  98:	90                   	nop
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        midInverse[cnt] = t;
        mid = mid / 10;
        cnt ++;
  a0:	89 fb                	mov    %edi,%ebx
        t = (mid % 10) + '0';
  a2:	89 c8                	mov    %ecx,%eax
        cnt ++;
  a4:	8d 7b 01             	lea    0x1(%ebx),%edi
        t = (mid % 10) + '0';
  a7:	f7 ee                	imul   %esi
  a9:	89 c8                	mov    %ecx,%eax
  ab:	c1 f8 1f             	sar    $0x1f,%eax
  ae:	c1 fa 02             	sar    $0x2,%edx
  b1:	29 c2                	sub    %eax,%edx
  b3:	8d 04 92             	lea    (%edx,%edx,4),%eax
  b6:	01 c0                	add    %eax,%eax
  b8:	29 c1                	sub    %eax,%ecx
  ba:	83 c1 30             	add    $0x30,%ecx
    while(mid != 0) {
  bd:	85 d2                	test   %edx,%edx
        t = (mid % 10) + '0';
  bf:	88 8c 1d 18 f8 ff ff 	mov    %cl,-0x7e8(%ebp,%ebx,1)
        mid = mid / 10;
  c6:	89 d1                	mov    %edx,%ecx
    while(mid != 0) {
  c8:	75 d6                	jne    a0 <main+0xa0>
  ca:	8d 85 18 f8 ff ff    	lea    -0x7e8(%ebp),%eax
  d0:	8d 95 00 fc ff ff    	lea    -0x400(%ebp),%edx
  d6:	01 d8                	add    %ebx,%eax
  d8:	8d 9d 17 f8 ff ff    	lea    -0x7e9(%ebp),%ebx
  de:	66 90                	xchg   %ax,%ax
    }

    int n = 0;
    char middle[1000];
    for(i = cnt-1; i >= 0; i--) {
        middle[n] = midInverse[i];
  e0:	0f b6 08             	movzbl (%eax),%ecx
  e3:	83 e8 01             	sub    $0x1,%eax
  e6:	83 c2 01             	add    $0x1,%edx
  e9:	88 4a ff             	mov    %cl,-0x1(%edx)
    for(i = cnt-1; i >= 0; i--) {
  ec:	39 d8                	cmp    %ebx,%eax
  ee:	75 f0                	jne    e0 <main+0xe0>
  f0:	89 f9                	mov    %edi,%ecx
        n++;
    }
    middle[n] = '\n';
  f2:	c6 84 0d 00 fc ff ff 	movb   $0xa,-0x400(%ebp,%ecx,1)
  f9:	0a 
    
    printf(1, "proccess Id is %d \n", getpid());
  fa:	e8 98 03 00 00       	call   497 <getpid>
  ff:	51                   	push   %ecx
 100:	50                   	push   %eax
 101:	68 2c 09 00 00       	push   $0x92c
 106:	6a 01                	push   $0x1
 108:	e8 83 04 00 00       	call   590 <printf>
    int fileDesc;
    if( (fileDesc = open("result.txt", O_CREATE | O_WRONLY)) < 0) {
 10d:	5b                   	pop    %ebx
 10e:	5e                   	pop    %esi
 10f:	68 01 02 00 00       	push   $0x201
 114:	68 50 09 00 00       	push   $0x950
 119:	e8 39 03 00 00       	call   457 <open>
 11e:	83 c4 10             	add    $0x10,%esp
 121:	85 c0                	test   %eax,%eax
 123:	89 c3                	mov    %eax,%ebx
 125:	78 51                	js     178 <main+0x178>
        printf(1, "can't open file result.txt");
        exit();
    }
   
    if(write(fileDesc, middle, strlen(middle)) != strlen(middle)) {
 127:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
 12d:	83 ec 0c             	sub    $0xc,%esp
 130:	56                   	push   %esi
 131:	e8 da 00 00 00       	call   210 <strlen>
 136:	83 c4 0c             	add    $0xc,%esp
 139:	50                   	push   %eax
 13a:	56                   	push   %esi
 13b:	53                   	push   %ebx
 13c:	e8 f6 02 00 00       	call   437 <write>
 141:	89 c3                	mov    %eax,%ebx
 143:	89 34 24             	mov    %esi,(%esp)
 146:	e8 c5 00 00 00       	call   210 <strlen>
 14b:	83 c4 10             	add    $0x10,%esp
 14e:	39 c3                	cmp    %eax,%ebx
 150:	74 39                	je     18b <main+0x18b>
        printf(1, "Eror when writing in result.txt");
 152:	50                   	push   %eax
 153:	50                   	push   %eax
 154:	68 0c 09 00 00       	push   $0x90c
 159:	6a 01                	push   $0x1
 15b:	e8 30 04 00 00       	call   590 <printf>
        exit();
 160:	e8 b2 02 00 00       	call   417 <exit>
        printf(1, "please insert exactly 7 numbers \n");
 165:	57                   	push   %edi
 166:	57                   	push   %edi
 167:	68 e8 08 00 00       	push   $0x8e8
 16c:	6a 01                	push   $0x1
 16e:	e8 1d 04 00 00       	call   590 <printf>
        exit();
 173:	e8 9f 02 00 00       	call   417 <exit>
        printf(1, "can't open file result.txt");
 178:	52                   	push   %edx
 179:	52                   	push   %edx
 17a:	68 40 09 00 00       	push   $0x940
 17f:	6a 01                	push   $0x1
 181:	e8 0a 04 00 00       	call   590 <printf>
        exit();
 186:	e8 8c 02 00 00       	call   417 <exit>
    }
    exit();
 18b:	e8 87 02 00 00       	call   417 <exit>

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19a:	89 c2                	mov    %eax,%edx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	83 c1 01             	add    $0x1,%ecx
 1a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1a7:	83 c2 01             	add    $0x1,%edx
 1aa:	84 db                	test   %bl,%bl
 1ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 1af:	75 ef                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1b1:	5b                   	pop    %ebx
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ca:	0f b6 02             	movzbl (%edx),%eax
 1cd:	0f b6 19             	movzbl (%ecx),%ebx
 1d0:	84 c0                	test   %al,%al
 1d2:	75 1c                	jne    1f0 <strcmp+0x30>
 1d4:	eb 2a                	jmp    200 <strcmp+0x40>
 1d6:	8d 76 00             	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1e0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1e6:	83 c1 01             	add    $0x1,%ecx
 1e9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 1ec:	84 c0                	test   %al,%al
 1ee:	74 10                	je     200 <strcmp+0x40>
 1f0:	38 d8                	cmp    %bl,%al
 1f2:	74 ec                	je     1e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1f4:	29 d8                	sub    %ebx,%eax
}
 1f6:	5b                   	pop    %ebx
 1f7:	5d                   	pop    %ebp
 1f8:	c3                   	ret    
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 202:	29 d8                	sub    %ebx,%eax
}
 204:	5b                   	pop    %ebx
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 39 00             	cmpb   $0x0,(%ecx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 d2                	xor    %edx,%edx
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c2 01             	add    $0x1,%edx
 223:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 227:	89 d0                	mov    %edx,%eax
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 230:	31 c0                	xor    %eax,%eax
}
 232:	5d                   	pop    %ebp
 233:	c3                   	ret    
 234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 23a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	89 d0                	mov    %edx,%eax
 254:	5f                   	pop    %edi
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	74 1d                	je     28e <strchr+0x2e>
    if(*s == c)
 271:	38 d3                	cmp    %dl,%bl
 273:	89 d9                	mov    %ebx,%ecx
 275:	75 0d                	jne    284 <strchr+0x24>
 277:	eb 17                	jmp    290 <strchr+0x30>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 280:	38 ca                	cmp    %cl,%dl
 282:	74 0c                	je     290 <strchr+0x30>
  for(; *s; s++)
 284:	83 c0 01             	add    $0x1,%eax
 287:	0f b6 10             	movzbl (%eax),%edx
 28a:	84 d2                	test   %dl,%dl
 28c:	75 f2                	jne    280 <strchr+0x20>
      return (char*)s;
  return 0;
 28e:	31 c0                	xor    %eax,%eax
}
 290:	5b                   	pop    %ebx
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
 2a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a6:	31 f6                	xor    %esi,%esi
 2a8:	89 f3                	mov    %esi,%ebx
{
 2aa:	83 ec 1c             	sub    $0x1c,%esp
 2ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2b0:	eb 2f                	jmp    2e1 <gets+0x41>
 2b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2bb:	83 ec 04             	sub    $0x4,%esp
 2be:	6a 01                	push   $0x1
 2c0:	50                   	push   %eax
 2c1:	6a 00                	push   $0x0
 2c3:	e8 67 01 00 00       	call   42f <read>
    if(cc < 1)
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	85 c0                	test   %eax,%eax
 2cd:	7e 1c                	jle    2eb <gets+0x4b>
      break;
    buf[i++] = c;
 2cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d3:	83 c7 01             	add    $0x1,%edi
 2d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2d9:	3c 0a                	cmp    $0xa,%al
 2db:	74 23                	je     300 <gets+0x60>
 2dd:	3c 0d                	cmp    $0xd,%al
 2df:	74 1f                	je     300 <gets+0x60>
  for(i=0; i+1 < max; ){
 2e1:	83 c3 01             	add    $0x1,%ebx
 2e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e7:	89 fe                	mov    %edi,%esi
 2e9:	7c cd                	jl     2b8 <gets+0x18>
 2eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2f0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2f6:	5b                   	pop    %ebx
 2f7:	5e                   	pop    %esi
 2f8:	5f                   	pop    %edi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret    
 2fb:	90                   	nop
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 300:	8b 75 08             	mov    0x8(%ebp),%esi
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	01 de                	add    %ebx,%esi
 308:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 30a:	c6 03 00             	movb   $0x0,(%ebx)
}
 30d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 310:	5b                   	pop    %ebx
 311:	5e                   	pop    %esi
 312:	5f                   	pop    %edi
 313:	5d                   	pop    %ebp
 314:	c3                   	ret    
 315:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 325:	83 ec 08             	sub    $0x8,%esp
 328:	6a 00                	push   $0x0
 32a:	ff 75 08             	pushl  0x8(%ebp)
 32d:	e8 25 01 00 00       	call   457 <open>
  if(fd < 0)
 332:	83 c4 10             	add    $0x10,%esp
 335:	85 c0                	test   %eax,%eax
 337:	78 27                	js     360 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 339:	83 ec 08             	sub    $0x8,%esp
 33c:	ff 75 0c             	pushl  0xc(%ebp)
 33f:	89 c3                	mov    %eax,%ebx
 341:	50                   	push   %eax
 342:	e8 28 01 00 00       	call   46f <fstat>
  close(fd);
 347:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 34a:	89 c6                	mov    %eax,%esi
  close(fd);
 34c:	e8 ee 00 00 00       	call   43f <close>
  return r;
 351:	83 c4 10             	add    $0x10,%esp
}
 354:	8d 65 f8             	lea    -0x8(%ebp),%esp
 357:	89 f0                	mov    %esi,%eax
 359:	5b                   	pop    %ebx
 35a:	5e                   	pop    %esi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 360:	be ff ff ff ff       	mov    $0xffffffff,%esi
 365:	eb ed                	jmp    354 <stat+0x34>
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 377:	0f be 11             	movsbl (%ecx),%edx
 37a:	8d 42 d0             	lea    -0x30(%edx),%eax
 37d:	3c 09                	cmp    $0x9,%al
  n = 0;
 37f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 384:	77 1f                	ja     3a5 <atoi+0x35>
 386:	8d 76 00             	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 390:	8d 04 80             	lea    (%eax,%eax,4),%eax
 393:	83 c1 01             	add    $0x1,%ecx
 396:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 39a:	0f be 11             	movsbl (%ecx),%edx
 39d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
  return n;
}
 3a5:	5b                   	pop    %ebx
 3a6:	5d                   	pop    %ebp
 3a7:	c3                   	ret    
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	56                   	push   %esi
 3b4:	53                   	push   %ebx
 3b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b8:	8b 45 08             	mov    0x8(%ebp),%eax
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 db                	test   %ebx,%ebx
 3c0:	7e 14                	jle    3d6 <memmove+0x26>
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3d2:	39 d3                	cmp    %edx,%ebx
 3d4:	75 f2                	jne    3c8 <memmove+0x18>
  return vdst;
}
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003e0 <delay>:

void delay(int numberOfClocks)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	83 ec 04             	sub    $0x4,%esp
    int firstClock = uptime();
 3e7:	e8 c3 00 00 00       	call   4af <uptime>
 3ec:	89 c3                	mov    %eax,%ebx
    int incClock = uptime();
 3ee:	e8 bc 00 00 00       	call   4af <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 3f3:	03 5d 08             	add    0x8(%ebp),%ebx
 3f6:	39 d8                	cmp    %ebx,%eax
 3f8:	7c 0f                	jl     409 <delay+0x29>
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        incClock = uptime();
 400:	e8 aa 00 00 00       	call   4af <uptime>
    while(incClock >= (firstClock + numberOfClocks) )
 405:	39 d8                	cmp    %ebx,%eax
 407:	7d f7                	jge    400 <delay+0x20>
    }
}
 409:	83 c4 04             	add    $0x4,%esp
 40c:	5b                   	pop    %ebx
 40d:	5d                   	pop    %ebp
 40e:	c3                   	ret    

0000040f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 40f:	b8 01 00 00 00       	mov    $0x1,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <exit>:
SYSCALL(exit)
 417:	b8 02 00 00 00       	mov    $0x2,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <wait>:
SYSCALL(wait)
 41f:	b8 03 00 00 00       	mov    $0x3,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <pipe>:
SYSCALL(pipe)
 427:	b8 04 00 00 00       	mov    $0x4,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <read>:
SYSCALL(read)
 42f:	b8 05 00 00 00       	mov    $0x5,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <write>:
SYSCALL(write)
 437:	b8 10 00 00 00       	mov    $0x10,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <close>:
SYSCALL(close)
 43f:	b8 15 00 00 00       	mov    $0x15,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <kill>:
SYSCALL(kill)
 447:	b8 06 00 00 00       	mov    $0x6,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <exec>:
SYSCALL(exec)
 44f:	b8 07 00 00 00       	mov    $0x7,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <open>:
SYSCALL(open)
 457:	b8 0f 00 00 00       	mov    $0xf,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <mknod>:
SYSCALL(mknod)
 45f:	b8 11 00 00 00       	mov    $0x11,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <unlink>:
SYSCALL(unlink)
 467:	b8 12 00 00 00       	mov    $0x12,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <fstat>:
SYSCALL(fstat)
 46f:	b8 08 00 00 00       	mov    $0x8,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <link>:
SYSCALL(link)
 477:	b8 13 00 00 00       	mov    $0x13,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <mkdir>:
SYSCALL(mkdir)
 47f:	b8 14 00 00 00       	mov    $0x14,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <chdir>:
SYSCALL(chdir)
 487:	b8 09 00 00 00       	mov    $0x9,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <dup>:
SYSCALL(dup)
 48f:	b8 0a 00 00 00       	mov    $0xa,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <getpid>:
SYSCALL(getpid)
 497:	b8 0b 00 00 00       	mov    $0xb,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret    

0000049f <sbrk>:
SYSCALL(sbrk)
 49f:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret    

000004a7 <sleep>:
SYSCALL(sleep)
 4a7:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret    

000004af <uptime>:
SYSCALL(uptime)
 4af:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <incNum>:
SYSCALL(incNum)
 4b7:	b8 16 00 00 00       	mov    $0x16,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <getprocs>:
SYSCALL(getprocs)
 4bf:	b8 17 00 00 00       	mov    $0x17,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <set_burst_time>:
SYSCALL(set_burst_time)
 4c7:	b8 18 00 00 00       	mov    $0x18,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <set_priority>:
SYSCALL(set_priority)
 4cf:	b8 19 00 00 00       	mov    $0x19,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <set_lottery_ticket>:
SYSCALL(set_lottery_ticket)
 4d7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <set_sched_queue>:
SYSCALL(set_sched_queue)
 4df:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <show_processes_scheduling>:
SYSCALL(show_processes_scheduling)
 4e7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    
 4ef:	90                   	nop

000004f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f9:	85 d2                	test   %edx,%edx
{
 4fb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 4fe:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 500:	79 76                	jns    578 <printint+0x88>
 502:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 506:	74 70                	je     578 <printint+0x88>
    x = -xx;
 508:	f7 d8                	neg    %eax
    neg = 1;
 50a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 511:	31 f6                	xor    %esi,%esi
 513:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 516:	eb 0a                	jmp    522 <printint+0x32>
 518:	90                   	nop
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 520:	89 fe                	mov    %edi,%esi
 522:	31 d2                	xor    %edx,%edx
 524:	8d 7e 01             	lea    0x1(%esi),%edi
 527:	f7 f1                	div    %ecx
 529:	0f b6 92 64 09 00 00 	movzbl 0x964(%edx),%edx
  }while((x /= base) != 0);
 530:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 532:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 535:	75 e9                	jne    520 <printint+0x30>
  if(neg)
 537:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 53a:	85 c0                	test   %eax,%eax
 53c:	74 08                	je     546 <printint+0x56>
    buf[i++] = '-';
 53e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 543:	8d 7e 02             	lea    0x2(%esi),%edi
 546:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 54a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 54d:	8d 76 00             	lea    0x0(%esi),%esi
 550:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 553:	83 ec 04             	sub    $0x4,%esp
 556:	83 ee 01             	sub    $0x1,%esi
 559:	6a 01                	push   $0x1
 55b:	53                   	push   %ebx
 55c:	57                   	push   %edi
 55d:	88 45 d7             	mov    %al,-0x29(%ebp)
 560:	e8 d2 fe ff ff       	call   437 <write>

  while(--i >= 0)
 565:	83 c4 10             	add    $0x10,%esp
 568:	39 de                	cmp    %ebx,%esi
 56a:	75 e4                	jne    550 <printint+0x60>
    putc(fd, buf[i]);
}
 56c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 56f:	5b                   	pop    %ebx
 570:	5e                   	pop    %esi
 571:	5f                   	pop    %edi
 572:	5d                   	pop    %ebp
 573:	c3                   	ret    
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 578:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 57f:	eb 90                	jmp    511 <printint+0x21>
 581:	eb 0d                	jmp    590 <printf>
 583:	90                   	nop
 584:	90                   	nop
 585:	90                   	nop
 586:	90                   	nop
 587:	90                   	nop
 588:	90                   	nop
 589:	90                   	nop
 58a:	90                   	nop
 58b:	90                   	nop
 58c:	90                   	nop
 58d:	90                   	nop
 58e:	90                   	nop
 58f:	90                   	nop

00000590 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 599:	8b 75 0c             	mov    0xc(%ebp),%esi
 59c:	0f b6 1e             	movzbl (%esi),%ebx
 59f:	84 db                	test   %bl,%bl
 5a1:	0f 84 b3 00 00 00    	je     65a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 5a7:	8d 45 10             	lea    0x10(%ebp),%eax
 5aa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 5ad:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 5af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5b2:	eb 2f                	jmp    5e3 <printf+0x53>
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b8:	83 f8 25             	cmp    $0x25,%eax
 5bb:	0f 84 a7 00 00 00    	je     668 <printf+0xd8>
  write(fd, &c, 1);
 5c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5c4:	83 ec 04             	sub    $0x4,%esp
 5c7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5ca:	6a 01                	push   $0x1
 5cc:	50                   	push   %eax
 5cd:	ff 75 08             	pushl  0x8(%ebp)
 5d0:	e8 62 fe ff ff       	call   437 <write>
 5d5:	83 c4 10             	add    $0x10,%esp
 5d8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5db:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5df:	84 db                	test   %bl,%bl
 5e1:	74 77                	je     65a <printf+0xca>
    if(state == 0){
 5e3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5e5:	0f be cb             	movsbl %bl,%ecx
 5e8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5eb:	74 cb                	je     5b8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ed:	83 ff 25             	cmp    $0x25,%edi
 5f0:	75 e6                	jne    5d8 <printf+0x48>
      if(c == 'd'){
 5f2:	83 f8 64             	cmp    $0x64,%eax
 5f5:	0f 84 05 01 00 00    	je     700 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5fb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 601:	83 f9 70             	cmp    $0x70,%ecx
 604:	74 72                	je     678 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 606:	83 f8 73             	cmp    $0x73,%eax
 609:	0f 84 99 00 00 00    	je     6a8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60f:	83 f8 63             	cmp    $0x63,%eax
 612:	0f 84 08 01 00 00    	je     720 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 618:	83 f8 25             	cmp    $0x25,%eax
 61b:	0f 84 ef 00 00 00    	je     710 <printf+0x180>
  write(fd, &c, 1);
 621:	8d 45 e7             	lea    -0x19(%ebp),%eax
 624:	83 ec 04             	sub    $0x4,%esp
 627:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 62b:	6a 01                	push   $0x1
 62d:	50                   	push   %eax
 62e:	ff 75 08             	pushl  0x8(%ebp)
 631:	e8 01 fe ff ff       	call   437 <write>
 636:	83 c4 0c             	add    $0xc,%esp
 639:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 63c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 63f:	6a 01                	push   $0x1
 641:	50                   	push   %eax
 642:	ff 75 08             	pushl  0x8(%ebp)
 645:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 648:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 64a:	e8 e8 fd ff ff       	call   437 <write>
  for(i = 0; fmt[i]; i++){
 64f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 653:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 656:	84 db                	test   %bl,%bl
 658:	75 89                	jne    5e3 <printf+0x53>
    }
  }
}
 65a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 65d:	5b                   	pop    %ebx
 65e:	5e                   	pop    %esi
 65f:	5f                   	pop    %edi
 660:	5d                   	pop    %ebp
 661:	c3                   	ret    
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 668:	bf 25 00 00 00       	mov    $0x25,%edi
 66d:	e9 66 ff ff ff       	jmp    5d8 <printf+0x48>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 678:	83 ec 0c             	sub    $0xc,%esp
 67b:	b9 10 00 00 00       	mov    $0x10,%ecx
 680:	6a 00                	push   $0x0
 682:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 685:	8b 45 08             	mov    0x8(%ebp),%eax
 688:	8b 17                	mov    (%edi),%edx
 68a:	e8 61 fe ff ff       	call   4f0 <printint>
        ap++;
 68f:	89 f8                	mov    %edi,%eax
 691:	83 c4 10             	add    $0x10,%esp
      state = 0;
 694:	31 ff                	xor    %edi,%edi
        ap++;
 696:	83 c0 04             	add    $0x4,%eax
 699:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 69c:	e9 37 ff ff ff       	jmp    5d8 <printf+0x48>
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6ab:	8b 08                	mov    (%eax),%ecx
        ap++;
 6ad:	83 c0 04             	add    $0x4,%eax
 6b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6b3:	85 c9                	test   %ecx,%ecx
 6b5:	0f 84 8e 00 00 00    	je     749 <printf+0x1b9>
        while(*s != 0){
 6bb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 6be:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 6c0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 6c2:	84 c0                	test   %al,%al
 6c4:	0f 84 0e ff ff ff    	je     5d8 <printf+0x48>
 6ca:	89 75 d0             	mov    %esi,-0x30(%ebp)
 6cd:	89 de                	mov    %ebx,%esi
 6cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6d2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 6d5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6d8:	83 ec 04             	sub    $0x4,%esp
          s++;
 6db:	83 c6 01             	add    $0x1,%esi
 6de:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6e1:	6a 01                	push   $0x1
 6e3:	57                   	push   %edi
 6e4:	53                   	push   %ebx
 6e5:	e8 4d fd ff ff       	call   437 <write>
        while(*s != 0){
 6ea:	0f b6 06             	movzbl (%esi),%eax
 6ed:	83 c4 10             	add    $0x10,%esp
 6f0:	84 c0                	test   %al,%al
 6f2:	75 e4                	jne    6d8 <printf+0x148>
 6f4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 6f7:	31 ff                	xor    %edi,%edi
 6f9:	e9 da fe ff ff       	jmp    5d8 <printf+0x48>
 6fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 700:	83 ec 0c             	sub    $0xc,%esp
 703:	b9 0a 00 00 00       	mov    $0xa,%ecx
 708:	6a 01                	push   $0x1
 70a:	e9 73 ff ff ff       	jmp    682 <printf+0xf2>
 70f:	90                   	nop
  write(fd, &c, 1);
 710:	83 ec 04             	sub    $0x4,%esp
 713:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 716:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 719:	6a 01                	push   $0x1
 71b:	e9 21 ff ff ff       	jmp    641 <printf+0xb1>
        putc(fd, *ap);
 720:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 723:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 726:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 728:	6a 01                	push   $0x1
        ap++;
 72a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 72d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 730:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 733:	50                   	push   %eax
 734:	ff 75 08             	pushl  0x8(%ebp)
 737:	e8 fb fc ff ff       	call   437 <write>
        ap++;
 73c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 73f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 742:	31 ff                	xor    %edi,%edi
 744:	e9 8f fe ff ff       	jmp    5d8 <printf+0x48>
          s = "(null)";
 749:	bb 5b 09 00 00       	mov    $0x95b,%ebx
        while(*s != 0){
 74e:	b8 28 00 00 00       	mov    $0x28,%eax
 753:	e9 72 ff ff ff       	jmp    6ca <printf+0x13a>
 758:	66 90                	xchg   %ax,%ax
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	a1 38 0c 00 00       	mov    0xc38,%eax
{
 766:	89 e5                	mov    %esp,%ebp
 768:	57                   	push   %edi
 769:	56                   	push   %esi
 76a:	53                   	push   %ebx
 76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 76e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 778:	39 c8                	cmp    %ecx,%eax
 77a:	8b 10                	mov    (%eax),%edx
 77c:	73 32                	jae    7b0 <free+0x50>
 77e:	39 d1                	cmp    %edx,%ecx
 780:	72 04                	jb     786 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	39 d0                	cmp    %edx,%eax
 784:	72 32                	jb     7b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 786:	8b 73 fc             	mov    -0x4(%ebx),%esi
 789:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78c:	39 fa                	cmp    %edi,%edx
 78e:	74 30                	je     7c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 790:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 793:	8b 50 04             	mov    0x4(%eax),%edx
 796:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 799:	39 f1                	cmp    %esi,%ecx
 79b:	74 3a                	je     7d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 79d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 79f:	a3 38 0c 00 00       	mov    %eax,0xc38
}
 7a4:	5b                   	pop    %ebx
 7a5:	5e                   	pop    %esi
 7a6:	5f                   	pop    %edi
 7a7:	5d                   	pop    %ebp
 7a8:	c3                   	ret    
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b0:	39 d0                	cmp    %edx,%eax
 7b2:	72 04                	jb     7b8 <free+0x58>
 7b4:	39 d1                	cmp    %edx,%ecx
 7b6:	72 ce                	jb     786 <free+0x26>
{
 7b8:	89 d0                	mov    %edx,%eax
 7ba:	eb bc                	jmp    778 <free+0x18>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7c0:	03 72 04             	add    0x4(%edx),%esi
 7c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8b 12                	mov    (%edx),%edx
 7ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7cd:	8b 50 04             	mov    0x4(%eax),%edx
 7d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d3:	39 f1                	cmp    %esi,%ecx
 7d5:	75 c6                	jne    79d <free+0x3d>
    p->s.size += bp->s.size;
 7d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7da:	a3 38 0c 00 00       	mov    %eax,0xc38
    p->s.size += bp->s.size;
 7df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7e5:	89 10                	mov    %edx,(%eax)
}
 7e7:	5b                   	pop    %ebx
 7e8:	5e                   	pop    %esi
 7e9:	5f                   	pop    %edi
 7ea:	5d                   	pop    %ebp
 7eb:	c3                   	ret    
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 15 38 0c 00 00    	mov    0xc38,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8d 78 07             	lea    0x7(%eax),%edi
 805:	c1 ef 03             	shr    $0x3,%edi
 808:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 80b:	85 d2                	test   %edx,%edx
 80d:	0f 84 9d 00 00 00    	je     8b0 <malloc+0xc0>
 813:	8b 02                	mov    (%edx),%eax
 815:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 818:	39 cf                	cmp    %ecx,%edi
 81a:	76 6c                	jbe    888 <malloc+0x98>
 81c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 822:	bb 00 10 00 00       	mov    $0x1000,%ebx
 827:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 82a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 831:	eb 0e                	jmp    841 <malloc+0x51>
 833:	90                   	nop
 834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 838:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 83a:	8b 48 04             	mov    0x4(%eax),%ecx
 83d:	39 f9                	cmp    %edi,%ecx
 83f:	73 47                	jae    888 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 841:	39 05 38 0c 00 00    	cmp    %eax,0xc38
 847:	89 c2                	mov    %eax,%edx
 849:	75 ed                	jne    838 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 84b:	83 ec 0c             	sub    $0xc,%esp
 84e:	56                   	push   %esi
 84f:	e8 4b fc ff ff       	call   49f <sbrk>
  if(p == (char*)-1)
 854:	83 c4 10             	add    $0x10,%esp
 857:	83 f8 ff             	cmp    $0xffffffff,%eax
 85a:	74 1c                	je     878 <malloc+0x88>
  hp->s.size = nu;
 85c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 85f:	83 ec 0c             	sub    $0xc,%esp
 862:	83 c0 08             	add    $0x8,%eax
 865:	50                   	push   %eax
 866:	e8 f5 fe ff ff       	call   760 <free>
  return freep;
 86b:	8b 15 38 0c 00 00    	mov    0xc38,%edx
      if((p = morecore(nunits)) == 0)
 871:	83 c4 10             	add    $0x10,%esp
 874:	85 d2                	test   %edx,%edx
 876:	75 c0                	jne    838 <malloc+0x48>
        return 0;
  }
}
 878:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 87b:	31 c0                	xor    %eax,%eax
}
 87d:	5b                   	pop    %ebx
 87e:	5e                   	pop    %esi
 87f:	5f                   	pop    %edi
 880:	5d                   	pop    %ebp
 881:	c3                   	ret    
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 888:	39 cf                	cmp    %ecx,%edi
 88a:	74 54                	je     8e0 <malloc+0xf0>
        p->s.size -= nunits;
 88c:	29 f9                	sub    %edi,%ecx
 88e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 891:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 894:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 897:	89 15 38 0c 00 00    	mov    %edx,0xc38
}
 89d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8a0:	83 c0 08             	add    $0x8,%eax
}
 8a3:	5b                   	pop    %ebx
 8a4:	5e                   	pop    %esi
 8a5:	5f                   	pop    %edi
 8a6:	5d                   	pop    %ebp
 8a7:	c3                   	ret    
 8a8:	90                   	nop
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 8b0:	c7 05 38 0c 00 00 3c 	movl   $0xc3c,0xc38
 8b7:	0c 00 00 
 8ba:	c7 05 3c 0c 00 00 3c 	movl   $0xc3c,0xc3c
 8c1:	0c 00 00 
    base.s.size = 0;
 8c4:	b8 3c 0c 00 00       	mov    $0xc3c,%eax
 8c9:	c7 05 40 0c 00 00 00 	movl   $0x0,0xc40
 8d0:	00 00 00 
 8d3:	e9 44 ff ff ff       	jmp    81c <malloc+0x2c>
 8d8:	90                   	nop
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8e0:	8b 08                	mov    (%eax),%ecx
 8e2:	89 0a                	mov    %ecx,(%edx)
 8e4:	eb b1                	jmp    897 <malloc+0xa7>
