
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 00 c6 10 80       	mov    $0x8010c600,%esp
8010002d:	b8 10 32 10 80       	mov    $0x80103210,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 34 c6 10 80       	mov    $0x8010c634,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 7d 10 80       	push   $0x80107d60
80100051:	68 00 c6 10 80       	push   $0x8010c600
80100056:	e8 35 4f 00 00       	call   80104f90 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 4c 0d 11 80 fc 	movl   $0x80110cfc,0x80110d4c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 50 0d 11 80 fc 	movl   $0x80110cfc,0x80110d50
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba fc 0c 11 80       	mov    $0x80110cfc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 7d 10 80       	push   $0x80107d67
80100097:	50                   	push   %eax
80100098:	e8 c3 4d 00 00       	call   80104e60 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 0d 11 80       	mov    0x80110d50,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d fc 0c 11 80       	cmp    $0x80110cfc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 00 c6 10 80       	push   $0x8010c600
801000e4:	e8 e7 4f 00 00       	call   801050d0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 50 0d 11 80    	mov    0x80110d50,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 4c 0d 11 80    	mov    0x80110d4c,%ebx
80100126:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 00 c6 10 80       	push   $0x8010c600
80100162:	e8 29 50 00 00       	call   80105190 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 2e 4d 00 00       	call   80104ea0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 23 00 00       	call   80102490 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 7d 10 80       	push   $0x80107d6e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 8d 4d 00 00       	call   80104f40 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 c7 22 00 00       	jmp    80102490 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 7d 10 80       	push   $0x80107d7f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 4c 4d 00 00       	call   80104f40 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 fc 4c 00 00       	call   80104f00 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010020b:	e8 c0 4e 00 00       	call   801050d0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 50 0d 11 80       	mov    0x80110d50,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 50 0d 11 80       	mov    0x80110d50,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 00 c6 10 80 	movl   $0x8010c600,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 2f 4f 00 00       	jmp    80105190 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 7d 10 80       	push   $0x80107d86
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 4b 18 00 00       	call   80101ad0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010028c:	e8 3f 4e 00 00       	call   801050d0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 e0 0f 11 80    	mov    0x80110fe0,%edx
801002a7:	39 15 e4 0f 11 80    	cmp    %edx,0x80110fe4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 60 b5 10 80       	push   $0x8010b560
801002c0:	68 e0 0f 11 80       	push   $0x80110fe0
801002c5:	e8 d6 3d 00 00       	call   801040a0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 e0 0f 11 80    	mov    0x80110fe0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 e4 0f 11 80    	cmp    0x80110fe4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 c0 38 00 00       	call   80103ba0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 60 b5 10 80       	push   $0x8010b560
801002ef:	e8 9c 4e 00 00       	call   80105190 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 f4 16 00 00       	call   801019f0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 e0 0f 11 80       	mov    %eax,0x80110fe0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 60 0f 11 80 	movsbl -0x7feef0a0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 60 b5 10 80       	push   $0x8010b560
8010034d:	e8 3e 4e 00 00       	call   80105190 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 96 16 00 00       	call   801019f0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 e0 0f 11 80    	mov    %edx,0x80110fe0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 94 b5 10 80 00 	movl   $0x0,0x8010b594
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 f2 26 00 00       	call   80102aa0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 7d 10 80       	push   $0x80107d8d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 9f 88 10 80 	movl   $0x8010889f,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 d3 4b 00 00       	call   80104fb0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 7d 10 80       	push   $0x80107da1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 98 b5 10 80 01 	movl   $0x1,0x8010b598
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 98 b5 10 80    	mov    0x8010b598,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 31 65 00 00       	call   80106970 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 7f 64 00 00       	call   80106970 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 73 64 00 00       	call   80106970 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 67 64 00 00       	call   80106970 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 67 4d 00 00       	call   80105290 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 9a 4c 00 00       	call   801051e0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 a5 7d 10 80       	push   $0x80107da5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 d0 7d 10 80 	movzbl -0x7fef8230(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 bc 14 00 00       	call   80101ad0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010061b:	e8 b0 4a 00 00       	call   801050d0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 60 b5 10 80       	push   $0x8010b560
80100647:	e8 44 4b 00 00       	call   80105190 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 9b 13 00 00       	call   801019f0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 94 b5 10 80       	mov    0x8010b594,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 60 b5 10 80       	push   $0x8010b560
8010071f:	e8 6c 4a 00 00       	call   80105190 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba b8 7d 10 80       	mov    $0x80107db8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 60 b5 10 80       	push   $0x8010b560
801007f0:	e8 db 48 00 00       	call   801050d0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 bf 7d 10 80       	push   $0x80107dbf
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <InsertNewCmd>:
{
80100810:	55                   	push   %ebp
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
80100811:	ba 67 66 66 66       	mov    $0x66666667,%edx
{
80100816:	89 e5                	mov    %esp,%ebp
80100818:	57                   	push   %edi
80100819:	56                   	push   %esi
8010081a:	53                   	push   %ebx
8010081b:	83 ec 10             	sub    $0x10,%esp
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
8010081e:	8b 3d 34 b5 10 80    	mov    0x8010b534,%edi
80100824:	8b 1d e4 0f 11 80    	mov    0x80110fe4,%ebx
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
8010082a:	68 80 00 00 00       	push   $0x80
8010082f:	6a 00                	push   $0x0
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
80100831:	89 f8                	mov    %edi,%eax
80100833:	83 e3 7f             	and    $0x7f,%ebx
80100836:	f7 ea                	imul   %edx
80100838:	89 f8                	mov    %edi,%eax
8010083a:	c1 f8 1f             	sar    $0x1f,%eax
8010083d:	d1 fa                	sar    %edx
8010083f:	29 c2                	sub    %eax,%edx
80100841:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100844:	29 c7                	sub    %eax,%edi
80100846:	c1 e7 07             	shl    $0x7,%edi
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
80100849:	8d b7 00 10 11 80    	lea    -0x7feef000(%edi),%esi
8010084f:	56                   	push   %esi
80100850:	e8 8b 49 00 00       	call   801051e0 <memset>
    while( i != ((input.e - 1)%INPUT_BUF)){
80100855:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
8010085a:	83 c4 10             	add    $0x10,%esp
    int j = 0;
8010085d:	31 d2                	xor    %edx,%edx
    while( i != ((input.e - 1)%INPUT_BUF)){
8010085f:	83 e8 01             	sub    $0x1,%eax
80100862:	83 e0 7f             	and    $0x7f,%eax
80100865:	39 d8                	cmp    %ebx,%eax
80100867:	74 22                	je     8010088b <InsertNewCmd+0x7b>
80100869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                  temp_buf[temp_cur][j] = input.buf[i];
80100870:	0f b6 8b 60 0f 11 80 	movzbl -0x7feef0a0(%ebx),%ecx
                  i = (i + 1) % INPUT_BUF;
80100877:	83 c3 01             	add    $0x1,%ebx
8010087a:	83 e3 7f             	and    $0x7f,%ebx
                  temp_buf[temp_cur][j] = input.buf[i];
8010087d:	88 8c 17 00 10 11 80 	mov    %cl,-0x7feef000(%edi,%edx,1)
                  j++;
80100884:	83 c2 01             	add    $0x1,%edx
    while( i != ((input.e - 1)%INPUT_BUF)){
80100887:	39 c3                	cmp    %eax,%ebx
80100889:	75 e5                	jne    80100870 <InsertNewCmd+0x60>
8010088b:	b8 20 b5 10 80       	mov    $0x8010b520,%eax
      history.PervCmd[i] = history.PervCmd[i-1];
80100890:	8b 48 0c             	mov    0xc(%eax),%ecx
80100893:	83 e8 04             	sub    $0x4,%eax
80100896:	89 48 14             	mov    %ecx,0x14(%eax)
      history.size[i] = history.size[i-1];
80100899:	8b 48 2c             	mov    0x2c(%eax),%ecx
8010089c:	89 48 30             	mov    %ecx,0x30(%eax)
    for(int i = 4 ; i > 0 ; i--){
8010089f:	3d 10 b5 10 80       	cmp    $0x8010b510,%eax
801008a4:	75 ea                	jne    80100890 <InsertNewCmd+0x80>
    history.PervCmd[0] = temp_buf[temp_cur];
801008a6:	89 35 20 b5 10 80    	mov    %esi,0x8010b520
    history.size[0] = j;
801008ac:	89 15 3c b5 10 80    	mov    %edx,0x8010b53c
}
801008b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008b5:	5b                   	pop    %ebx
801008b6:	5e                   	pop    %esi
801008b7:	5f                   	pop    %edi
801008b8:	5d                   	pop    %ebp
801008b9:	c3                   	ret    
801008ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008c0 <killLine>:
  while(input.e != input.w &&
801008c0:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
801008c5:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801008cb:	74 53                	je     80100920 <killLine+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008cd:	83 e8 01             	sub    $0x1,%eax
801008d0:	89 c2                	mov    %eax,%edx
801008d2:	83 e2 7f             	and    $0x7f,%edx
  while(input.e != input.w &&
801008d5:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801008dc:	74 42                	je     80100920 <killLine+0x60>
{
801008de:	55                   	push   %ebp
801008df:	89 e5                	mov    %esp,%ebp
801008e1:	83 ec 08             	sub    $0x8,%esp
801008e4:	eb 1b                	jmp    80100901 <killLine+0x41>
801008e6:	8d 76 00             	lea    0x0(%esi),%esi
801008e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008f0:	83 e8 01             	sub    $0x1,%eax
801008f3:	89 c2                	mov    %eax,%edx
801008f5:	83 e2 7f             	and    $0x7f,%edx
  while(input.e != input.w &&
801008f8:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801008ff:	74 1c                	je     8010091d <killLine+0x5d>
        input.e--;
80100901:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
        consputc(BACKSPACE);
80100906:	b8 00 01 00 00       	mov    $0x100,%eax
8010090b:	e8 00 fb ff ff       	call   80100410 <consputc>
  while(input.e != input.w &&
80100910:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100915:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
8010091b:	75 d3                	jne    801008f0 <killLine+0x30>
}
8010091d:	c9                   	leave  
8010091e:	c3                   	ret    
8010091f:	90                   	nop
80100920:	f3 c3                	repz ret 
80100922:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100930 <fillBuf>:
{
80100930:	55                   	push   %ebp
80100931:	89 e5                	mov    %esp,%ebp
80100933:	56                   	push   %esi
80100934:	53                   	push   %ebx
  killLine();
80100935:	e8 86 ff ff ff       	call   801008c0 <killLine>
  for(int i = 0; i < history.size[history.cursor] ; i++)
8010093a:	a1 38 b5 10 80       	mov    0x8010b538,%eax
8010093f:	8b 1c 85 3c b5 10 80 	mov    -0x7fef4ac4(,%eax,4),%ebx
80100946:	85 db                	test   %ebx,%ebx
80100948:	7e 32                	jle    8010097c <fillBuf+0x4c>
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
8010094a:	8b 34 85 20 b5 10 80 	mov    -0x7fef4ae0(,%eax,4),%esi
80100951:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100956:	01 c3                	add    %eax,%ebx
80100958:	29 c6                	sub    %eax,%esi
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100960:	8d 50 01             	lea    0x1(%eax),%edx
80100963:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
80100969:	0f b6 0c 30          	movzbl (%eax,%esi,1),%ecx
8010096d:	83 e0 7f             	and    $0x7f,%eax
  for(int i = 0; i < history.size[history.cursor] ; i++)
80100970:	39 da                	cmp    %ebx,%edx
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
80100972:	88 88 60 0f 11 80    	mov    %cl,-0x7feef0a0(%eax)
80100978:	89 d0                	mov    %edx,%eax
  for(int i = 0; i < history.size[history.cursor] ; i++)
8010097a:	75 e4                	jne    80100960 <fillBuf+0x30>
}
8010097c:	5b                   	pop    %ebx
8010097d:	5e                   	pop    %esi
8010097e:	5d                   	pop    %ebp
8010097f:	c3                   	ret    

80100980 <IncCursor>:
  if (history.cursor == 4)
80100980:	8b 0d 38 b5 10 80    	mov    0x8010b538,%ecx
{
80100986:	55                   	push   %ebp
80100987:	89 e5                	mov    %esp,%ebp
  if (history.cursor == 4)
80100989:	83 f9 04             	cmp    $0x4,%ecx
8010098c:	74 2a                	je     801009b8 <IncCursor+0x38>
  history.cursor = (history.cursor + 1) % 5;
8010098e:	83 c1 01             	add    $0x1,%ecx
80100991:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100996:	89 c8                	mov    %ecx,%eax
80100998:	f7 ea                	imul   %edx
8010099a:	89 c8                	mov    %ecx,%eax
8010099c:	c1 f8 1f             	sar    $0x1f,%eax
8010099f:	d1 fa                	sar    %edx
801009a1:	29 c2                	sub    %eax,%edx
801009a3:	8d 04 92             	lea    (%edx,%edx,4),%eax
801009a6:	29 c1                	sub    %eax,%ecx
      if ( history.cursor == history.cmd_count) 
801009a8:	3b 0d 34 b5 10 80    	cmp    0x8010b534,%ecx
  history.cursor = (history.cursor + 1) % 5;
801009ae:	89 ca                	mov    %ecx,%edx
801009b0:	89 0d 38 b5 10 80    	mov    %ecx,0x8010b538
      if ( history.cursor == history.cmd_count) 
801009b6:	74 08                	je     801009c0 <IncCursor+0x40>
}
801009b8:	5d                   	pop    %ebp
801009b9:	c3                   	ret    
801009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        history.cursor = history.cmd_count - 1;
801009c0:	83 ea 01             	sub    $0x1,%edx
801009c3:	89 15 38 b5 10 80    	mov    %edx,0x8010b538
}
801009c9:	5d                   	pop    %ebp
801009ca:	c3                   	ret    
801009cb:	90                   	nop
801009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009d0 <DecCursor>:
  if ( history.cursor < 0)
801009d0:	a1 38 b5 10 80       	mov    0x8010b538,%eax
{
801009d5:	55                   	push   %ebp
801009d6:	89 e5                	mov    %esp,%ebp
  if ( history.cursor < 0)
801009d8:	85 c0                	test   %eax,%eax
801009da:	78 08                	js     801009e4 <DecCursor+0x14>
  history.cursor = history.cursor - 1;
801009dc:	83 e8 01             	sub    $0x1,%eax
801009df:	a3 38 b5 10 80       	mov    %eax,0x8010b538
}
801009e4:	5d                   	pop    %ebp
801009e5:	c3                   	ret    
801009e6:	8d 76 00             	lea    0x0(%esi),%esi
801009e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009f0 <printInput>:
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	53                   	push   %ebx
801009f4:	83 ec 04             	sub    $0x4,%esp
  int i = input.w % INPUT_BUF;
801009f7:	8b 1d e4 0f 11 80    	mov    0x80110fe4,%ebx
801009fd:	eb 10                	jmp    80100a0f <printInput+0x1f>
801009ff:	90                   	nop
    consputc(input.buf[i]);
80100a00:	0f be 83 60 0f 11 80 	movsbl -0x7feef0a0(%ebx),%eax
    i = (i + 1) % INPUT_BUF;
80100a07:	83 c3 01             	add    $0x1,%ebx
    consputc(input.buf[i]);
80100a0a:	e8 01 fa ff ff       	call   80100410 <consputc>
  while( i != (input.e % INPUT_BUF)){ 
80100a0f:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
  int i = input.w % INPUT_BUF;
80100a14:	83 e3 7f             	and    $0x7f,%ebx
  while( i != (input.e % INPUT_BUF)){ 
80100a17:	83 e0 7f             	and    $0x7f,%eax
80100a1a:	39 d8                	cmp    %ebx,%eax
80100a1c:	75 e2                	jne    80100a00 <printInput+0x10>
}
80100a1e:	83 c4 04             	add    $0x4,%esp
80100a21:	5b                   	pop    %ebx
80100a22:	5d                   	pop    %ebp
80100a23:	c3                   	ret    
80100a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100a30 <KeyDownPressed.part.0>:
if (history.cursor == -1){
80100a30:	a1 38 b5 10 80       	mov    0x8010b538,%eax
80100a35:	83 f8 ff             	cmp    $0xffffffff,%eax
80100a38:	74 1e                	je     80100a58 <KeyDownPressed.part.0+0x28>
KeyDownPressed()
80100a3a:	55                   	push   %ebp
80100a3b:	89 e5                	mov    %esp,%ebp
80100a3d:	83 ec 08             	sub    $0x8,%esp
  if ( history.cursor < 0)
80100a40:	85 c0                	test   %eax,%eax
80100a42:	78 08                	js     80100a4c <KeyDownPressed.part.0+0x1c>
  history.cursor = history.cursor - 1;
80100a44:	83 e8 01             	sub    $0x1,%eax
80100a47:	a3 38 b5 10 80       	mov    %eax,0x8010b538
  fillBuf();
80100a4c:	e8 df fe ff ff       	call   80100930 <fillBuf>
}
80100a51:	c9                   	leave  
  printInput();
80100a52:	eb 9c                	jmp    801009f0 <printInput>
80100a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  killLine();
80100a58:	e9 63 fe ff ff       	jmp    801008c0 <killLine>
80100a5d:	8d 76 00             	lea    0x0(%esi),%esi

80100a60 <KeyUpPressed>:
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	53                   	push   %ebx
80100a64:	83 ec 04             	sub    $0x4,%esp
  if ( history.cmd_count == 0) 
80100a67:	8b 1d 34 b5 10 80    	mov    0x8010b534,%ebx
80100a6d:	85 db                	test   %ebx,%ebx
80100a6f:	74 47                	je     80100ab8 <KeyUpPressed+0x58>
  if (history.cursor == 4)
80100a71:	8b 0d 38 b5 10 80    	mov    0x8010b538,%ecx
80100a77:	83 f9 04             	cmp    $0x4,%ecx
80100a7a:	74 2a                	je     80100aa6 <KeyUpPressed+0x46>
  history.cursor = (history.cursor + 1) % 5;
80100a7c:	83 c1 01             	add    $0x1,%ecx
80100a7f:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100a84:	89 c8                	mov    %ecx,%eax
80100a86:	f7 ea                	imul   %edx
80100a88:	89 c8                	mov    %ecx,%eax
80100a8a:	c1 f8 1f             	sar    $0x1f,%eax
80100a8d:	d1 fa                	sar    %edx
80100a8f:	29 c2                	sub    %eax,%edx
80100a91:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100a94:	29 c1                	sub    %eax,%ecx
80100a96:	8d 43 ff             	lea    -0x1(%ebx),%eax
80100a99:	89 ca                	mov    %ecx,%edx
80100a9b:	39 cb                	cmp    %ecx,%ebx
80100a9d:	0f 44 d0             	cmove  %eax,%edx
80100aa0:	89 15 38 b5 10 80    	mov    %edx,0x8010b538
  fillBuf();
80100aa6:	e8 85 fe ff ff       	call   80100930 <fillBuf>
}
80100aab:	83 c4 04             	add    $0x4,%esp
80100aae:	5b                   	pop    %ebx
80100aaf:	5d                   	pop    %ebp
  printInput();
80100ab0:	e9 3b ff ff ff       	jmp    801009f0 <printInput>
80100ab5:	8d 76 00             	lea    0x0(%esi),%esi
}
80100ab8:	83 c4 04             	add    $0x4,%esp
80100abb:	5b                   	pop    %ebx
80100abc:	5d                   	pop    %ebp
80100abd:	c3                   	ret    
80100abe:	66 90                	xchg   %ax,%ax

80100ac0 <KeyDownPressed>:
  if ( history.cmd_count == 0) 
80100ac0:	a1 34 b5 10 80       	mov    0x8010b534,%eax
{
80100ac5:	55                   	push   %ebp
80100ac6:	89 e5                	mov    %esp,%ebp
  if ( history.cmd_count == 0) 
80100ac8:	85 c0                	test   %eax,%eax
80100aca:	74 0c                	je     80100ad8 <KeyDownPressed+0x18>
}
80100acc:	5d                   	pop    %ebp
80100acd:	e9 5e ff ff ff       	jmp    80100a30 <KeyDownPressed.part.0>
80100ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ad8:	5d                   	pop    %ebp
80100ad9:	c3                   	ret    
80100ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ae0 <consoleintr>:
{
80100ae0:	55                   	push   %ebp
80100ae1:	89 e5                	mov    %esp,%ebp
80100ae3:	57                   	push   %edi
80100ae4:	56                   	push   %esi
80100ae5:	53                   	push   %ebx
  int c, doprocdump = 0;
80100ae6:	31 ff                	xor    %edi,%edi
{
80100ae8:	83 ec 18             	sub    $0x18,%esp
80100aeb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100aee:	68 60 b5 10 80       	push   $0x8010b560
80100af3:	e8 d8 45 00 00       	call   801050d0 <acquire>
  while((c = getc()) >= 0){
80100af8:	83 c4 10             	add    $0x10,%esp
80100afb:	90                   	nop
80100afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b00:	ff d6                	call   *%esi
80100b02:	85 c0                	test   %eax,%eax
80100b04:	89 c3                	mov    %eax,%ebx
80100b06:	0f 88 b4 00 00 00    	js     80100bc0 <consoleintr+0xe0>
    switch(c){
80100b0c:	83 fb 15             	cmp    $0x15,%ebx
80100b0f:	0f 84 cb 00 00 00    	je     80100be0 <consoleintr+0x100>
80100b15:	0f 8e 85 00 00 00    	jle    80100ba0 <consoleintr+0xc0>
80100b1b:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100b21:	0f 84 19 01 00 00    	je     80100c40 <consoleintr+0x160>
80100b27:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100b2d:	0f 84 ed 00 00 00    	je     80100c20 <consoleintr+0x140>
80100b33:	83 fb 7f             	cmp    $0x7f,%ebx
80100b36:	0f 84 b4 00 00 00    	je     80100bf0 <consoleintr+0x110>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100b3c:	85 db                	test   %ebx,%ebx
80100b3e:	74 c0                	je     80100b00 <consoleintr+0x20>
80100b40:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100b45:	89 c2                	mov    %eax,%edx
80100b47:	2b 15 e0 0f 11 80    	sub    0x80110fe0,%edx
80100b4d:	83 fa 7f             	cmp    $0x7f,%edx
80100b50:	77 ae                	ja     80100b00 <consoleintr+0x20>
80100b52:	8d 50 01             	lea    0x1(%eax),%edx
80100b55:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100b58:	83 fb 0d             	cmp    $0xd,%ebx
        input.buf[input.e++ % INPUT_BUF] = c;
80100b5b:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
        c = (c == '\r') ? '\n' : c;
80100b61:	0f 84 f9 00 00 00    	je     80100c60 <consoleintr+0x180>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b67:	88 98 60 0f 11 80    	mov    %bl,-0x7feef0a0(%eax)
        consputc(c);
80100b6d:	89 d8                	mov    %ebx,%eax
80100b6f:	e8 9c f8 ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b74:	83 fb 0a             	cmp    $0xa,%ebx
80100b77:	0f 84 f4 00 00 00    	je     80100c71 <consoleintr+0x191>
80100b7d:	83 fb 04             	cmp    $0x4,%ebx
80100b80:	0f 84 eb 00 00 00    	je     80100c71 <consoleintr+0x191>
80100b86:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
80100b8b:	83 e8 80             	sub    $0xffffff80,%eax
80100b8e:	39 05 e8 0f 11 80    	cmp    %eax,0x80110fe8
80100b94:	0f 85 66 ff ff ff    	jne    80100b00 <consoleintr+0x20>
80100b9a:	e9 d7 00 00 00       	jmp    80100c76 <consoleintr+0x196>
80100b9f:	90                   	nop
    switch(c){
80100ba0:	83 fb 08             	cmp    $0x8,%ebx
80100ba3:	74 4b                	je     80100bf0 <consoleintr+0x110>
80100ba5:	83 fb 10             	cmp    $0x10,%ebx
80100ba8:	75 92                	jne    80100b3c <consoleintr+0x5c>
  while((c = getc()) >= 0){
80100baa:	ff d6                	call   *%esi
80100bac:	85 c0                	test   %eax,%eax
      doprocdump = 1;
80100bae:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
80100bb3:	89 c3                	mov    %eax,%ebx
80100bb5:	0f 89 51 ff ff ff    	jns    80100b0c <consoleintr+0x2c>
80100bbb:	90                   	nop
80100bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100bc0:	83 ec 0c             	sub    $0xc,%esp
80100bc3:	68 60 b5 10 80       	push   $0x8010b560
80100bc8:	e8 c3 45 00 00       	call   80105190 <release>
  if(doprocdump) {
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	85 ff                	test   %edi,%edi
80100bd2:	75 7c                	jne    80100c50 <consoleintr+0x170>
}
80100bd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bd7:	5b                   	pop    %ebx
80100bd8:	5e                   	pop    %esi
80100bd9:	5f                   	pop    %edi
80100bda:	5d                   	pop    %ebp
80100bdb:	c3                   	ret    
80100bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      killLine();
80100be0:	e8 db fc ff ff       	call   801008c0 <killLine>
      break;
80100be5:	e9 16 ff ff ff       	jmp    80100b00 <consoleintr+0x20>
80100bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(input.e != input.w){
80100bf0:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100bf5:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100bfb:	0f 84 ff fe ff ff    	je     80100b00 <consoleintr+0x20>
        input.e--;
80100c01:	83 e8 01             	sub    $0x1,%eax
80100c04:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
        consputc(BACKSPACE);
80100c09:	b8 00 01 00 00       	mov    $0x100,%eax
80100c0e:	e8 fd f7 ff ff       	call   80100410 <consputc>
80100c13:	e9 e8 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c18:	90                   	nop
80100c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ( history.cmd_count == 0) 
80100c20:	a1 34 b5 10 80       	mov    0x8010b534,%eax
80100c25:	85 c0                	test   %eax,%eax
80100c27:	0f 84 d3 fe ff ff    	je     80100b00 <consoleintr+0x20>
80100c2d:	e8 fe fd ff ff       	call   80100a30 <KeyDownPressed.part.0>
80100c32:	e9 c9 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c37:	89 f6                	mov    %esi,%esi
80100c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      KeyUpPressed();
80100c40:	e8 1b fe ff ff       	call   80100a60 <KeyUpPressed>
      break;
80100c45:	e9 b6 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100c50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c53:	5b                   	pop    %ebx
80100c54:	5e                   	pop    %esi
80100c55:	5f                   	pop    %edi
80100c56:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100c57:	e9 e4 36 00 00       	jmp    80104340 <procdump>
80100c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100c60:	c6 80 60 0f 11 80 0a 	movb   $0xa,-0x7feef0a0(%eax)
        consputc(c);
80100c67:	b8 0a 00 00 00       	mov    $0xa,%eax
80100c6c:	e8 9f f7 ff ff       	call   80100410 <consputc>
80100c71:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
          if ( (input.e - input.w) != 1) {
80100c76:	89 c2                	mov    %eax,%edx
80100c78:	2b 15 e4 0f 11 80    	sub    0x80110fe4,%edx
80100c7e:	83 fa 01             	cmp    $0x1,%edx
80100c81:	74 1b                	je     80100c9e <consoleintr+0x1be>
            InsertNewCmd();
80100c83:	e8 88 fb ff ff       	call   80100810 <InsertNewCmd>
            history.cmd_count++;
80100c88:	83 05 34 b5 10 80 01 	addl   $0x1,0x8010b534
80100c8f:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
            history.cursor = -1;
80100c94:	c7 05 38 b5 10 80 ff 	movl   $0xffffffff,0x8010b538
80100c9b:	ff ff ff 
          wakeup(&input.r);
80100c9e:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ca1:	a3 e4 0f 11 80       	mov    %eax,0x80110fe4
          wakeup(&input.r);
80100ca6:	68 e0 0f 11 80       	push   $0x80110fe0
80100cab:	e8 b0 35 00 00       	call   80104260 <wakeup>
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	e9 48 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100cb8:	90                   	nop
80100cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100cc0 <consoleinit>:

void
consoleinit(void)
{
80100cc0:	55                   	push   %ebp
80100cc1:	89 e5                	mov    %esp,%ebp
80100cc3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100cc6:	68 c8 7d 10 80       	push   $0x80107dc8
80100ccb:	68 60 b5 10 80       	push   $0x8010b560
80100cd0:	e8 bb 42 00 00       	call   80104f90 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100cd5:	58                   	pop    %eax
80100cd6:	5a                   	pop    %edx
80100cd7:	6a 00                	push   $0x0
80100cd9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100cdb:	c7 05 2c 1c 11 80 00 	movl   $0x80100600,0x80111c2c
80100ce2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100ce5:	c7 05 28 1c 11 80 70 	movl   $0x80100270,0x80111c28
80100cec:	02 10 80 
  cons.locking = 1;
80100cef:	c7 05 94 b5 10 80 01 	movl   $0x1,0x8010b594
80100cf6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100cf9:	e8 42 19 00 00       	call   80102640 <ioapicenable>
}
80100cfe:	83 c4 10             	add    $0x10,%esp
80100d01:	c9                   	leave  
80100d02:	c3                   	ret    
80100d03:	66 90                	xchg   %ax,%ax
80100d05:	66 90                	xchg   %ax,%ax
80100d07:	66 90                	xchg   %ax,%ax
80100d09:	66 90                	xchg   %ax,%ax
80100d0b:	66 90                	xchg   %ax,%ax
80100d0d:	66 90                	xchg   %ax,%ax
80100d0f:	90                   	nop

80100d10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100d10:	55                   	push   %ebp
80100d11:	89 e5                	mov    %esp,%ebp
80100d13:	57                   	push   %edi
80100d14:	56                   	push   %esi
80100d15:	53                   	push   %ebx
80100d16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100d1c:	e8 7f 2e 00 00       	call   80103ba0 <myproc>
80100d21:	89 c6                	mov    %eax,%esi

  begin_op();
80100d23:	e8 e8 21 00 00       	call   80102f10 <begin_op>
  //For testing priority

  find_and_set_sched_queue(LOTTERY, curproc->pid);
80100d28:	83 ec 08             	sub    $0x8,%esp
80100d2b:	ff 76 10             	pushl  0x10(%esi)
80100d2e:	6a 02                	push   $0x2
80100d30:	e8 fb 39 00 00       	call   80104730 <find_and_set_sched_queue>
  find_and_set_lottery_ticket(500, curproc->pid);
80100d35:	59                   	pop    %ecx
80100d36:	5b                   	pop    %ebx
80100d37:	ff 76 10             	pushl  0x10(%esi)
80100d3a:	68 f4 01 00 00       	push   $0x1f4
80100d3f:	e8 bc 39 00 00       	call   80104700 <find_and_set_lottery_ticket>
  find_and_set_burst_time(0, curproc->pid);
80100d44:	5f                   	pop    %edi
80100d45:	58                   	pop    %eax
80100d46:	ff 76 10             	pushl  0x10(%esi)
80100d49:	6a 00                	push   $0x0
80100d4b:	e8 10 3a 00 00       	call   80104760 <find_and_set_burst_time>

  if((ip = namei(path)) == 0){
80100d50:	58                   	pop    %eax
80100d51:	ff 75 08             	pushl  0x8(%ebp)
80100d54:	e8 f7 14 00 00       	call   80102250 <namei>
80100d59:	83 c4 10             	add    $0x10,%esp
80100d5c:	85 c0                	test   %eax,%eax
80100d5e:	0f 84 b8 01 00 00    	je     80100f1c <exec+0x20c>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100d64:	83 ec 0c             	sub    $0xc,%esp
80100d67:	89 c3                	mov    %eax,%ebx
80100d69:	50                   	push   %eax
80100d6a:	e8 81 0c 00 00       	call   801019f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100d6f:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100d75:	6a 34                	push   $0x34
80100d77:	6a 00                	push   $0x0
80100d79:	50                   	push   %eax
80100d7a:	53                   	push   %ebx
80100d7b:	e8 50 0f 00 00       	call   80101cd0 <readi>
80100d80:	83 c4 20             	add    $0x20,%esp
80100d83:	83 f8 34             	cmp    $0x34,%eax
80100d86:	74 28                	je     80100db0 <exec+0xa0>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100d88:	83 ec 0c             	sub    $0xc,%esp
80100d8b:	53                   	push   %ebx
80100d8c:	e8 ef 0e 00 00       	call   80101c80 <iunlockput>
    end_op();
80100d91:	e8 ea 21 00 00       	call   80102f80 <end_op>
80100d96:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100d99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100d9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100da1:	5b                   	pop    %ebx
80100da2:	5e                   	pop    %esi
80100da3:	5f                   	pop    %edi
80100da4:	5d                   	pop    %ebp
80100da5:	c3                   	ret    
80100da6:	8d 76 00             	lea    0x0(%esi),%esi
80100da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(elf.magic != ELF_MAGIC)
80100db0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100db7:	45 4c 46 
80100dba:	75 cc                	jne    80100d88 <exec+0x78>
  if((pgdir = setupkvm()) == 0)
80100dbc:	e8 ff 6c 00 00       	call   80107ac0 <setupkvm>
80100dc1:	85 c0                	test   %eax,%eax
80100dc3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100dc9:	74 bd                	je     80100d88 <exec+0x78>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dcb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100dd2:	00 
80100dd3:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100dd9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ddf:	0f 84 b6 02 00 00    	je     8010109b <exec+0x38b>
  sz = 0;
80100de5:	31 c0                	xor    %eax,%eax
80100de7:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ded:	31 ff                	xor    %edi,%edi
80100def:	89 c6                	mov    %eax,%esi
80100df1:	eb 7f                	jmp    80100e72 <exec+0x162>
80100df3:	90                   	nop
80100df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100df8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100dff:	75 63                	jne    80100e64 <exec+0x154>
    if(ph.memsz < ph.filesz)
80100e01:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100e07:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100e0d:	0f 82 86 00 00 00    	jb     80100e99 <exec+0x189>
80100e13:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100e19:	72 7e                	jb     80100e99 <exec+0x189>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100e1b:	83 ec 04             	sub    $0x4,%esp
80100e1e:	50                   	push   %eax
80100e1f:	56                   	push   %esi
80100e20:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e26:	e8 b5 6a 00 00       	call   801078e0 <allocuvm>
80100e2b:	83 c4 10             	add    $0x10,%esp
80100e2e:	85 c0                	test   %eax,%eax
80100e30:	89 c6                	mov    %eax,%esi
80100e32:	74 65                	je     80100e99 <exec+0x189>
    if(ph.vaddr % PGSIZE != 0)
80100e34:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100e3a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100e3f:	75 58                	jne    80100e99 <exec+0x189>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100e41:	83 ec 0c             	sub    $0xc,%esp
80100e44:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100e4a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100e50:	53                   	push   %ebx
80100e51:	50                   	push   %eax
80100e52:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e58:	e8 c3 69 00 00       	call   80107820 <loaduvm>
80100e5d:	83 c4 20             	add    $0x20,%esp
80100e60:	85 c0                	test   %eax,%eax
80100e62:	78 35                	js     80100e99 <exec+0x189>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e64:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100e6b:	83 c7 01             	add    $0x1,%edi
80100e6e:	39 f8                	cmp    %edi,%eax
80100e70:	7e 3d                	jle    80100eaf <exec+0x19f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100e72:	89 f8                	mov    %edi,%eax
80100e74:	6a 20                	push   $0x20
80100e76:	c1 e0 05             	shl    $0x5,%eax
80100e79:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100e7f:	50                   	push   %eax
80100e80:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100e86:	50                   	push   %eax
80100e87:	53                   	push   %ebx
80100e88:	e8 43 0e 00 00       	call   80101cd0 <readi>
80100e8d:	83 c4 10             	add    $0x10,%esp
80100e90:	83 f8 20             	cmp    $0x20,%eax
80100e93:	0f 84 5f ff ff ff    	je     80100df8 <exec+0xe8>
    freevm(pgdir);
80100e99:	83 ec 0c             	sub    $0xc,%esp
80100e9c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ea2:	e8 99 6b 00 00       	call   80107a40 <freevm>
80100ea7:	83 c4 10             	add    $0x10,%esp
80100eaa:	e9 d9 fe ff ff       	jmp    80100d88 <exec+0x78>
80100eaf:	89 f0                	mov    %esi,%eax
80100eb1:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100eb7:	05 ff 0f 00 00       	add    $0xfff,%eax
80100ebc:	89 c7                	mov    %eax,%edi
80100ebe:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100ec4:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
  iunlockput(ip);
80100eca:	83 ec 0c             	sub    $0xc,%esp
80100ecd:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ed3:	53                   	push   %ebx
80100ed4:	e8 a7 0d 00 00       	call   80101c80 <iunlockput>
  end_op();
80100ed9:	e8 a2 20 00 00       	call   80102f80 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ede:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ee4:	83 c4 0c             	add    $0xc,%esp
80100ee7:	50                   	push   %eax
80100ee8:	57                   	push   %edi
80100ee9:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100eef:	e8 ec 69 00 00       	call   801078e0 <allocuvm>
80100ef4:	83 c4 10             	add    $0x10,%esp
80100ef7:	85 c0                	test   %eax,%eax
80100ef9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100eff:	75 3a                	jne    80100f3b <exec+0x22b>
    freevm(pgdir);
80100f01:	83 ec 0c             	sub    $0xc,%esp
80100f04:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f0a:	e8 31 6b 00 00       	call   80107a40 <freevm>
80100f0f:	83 c4 10             	add    $0x10,%esp
  return -1;
80100f12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f17:	e9 82 fe ff ff       	jmp    80100d9e <exec+0x8e>
    end_op();
80100f1c:	e8 5f 20 00 00       	call   80102f80 <end_op>
    cprintf("exec: fail\n");
80100f21:	83 ec 0c             	sub    $0xc,%esp
80100f24:	68 e1 7d 10 80       	push   $0x80107de1
80100f29:	e8 32 f7 ff ff       	call   80100660 <cprintf>
    return -1;
80100f2e:	83 c4 10             	add    $0x10,%esp
80100f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f36:	e9 63 fe ff ff       	jmp    80100d9e <exec+0x8e>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f3b:	89 c3                	mov    %eax,%ebx
80100f3d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100f43:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100f46:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100f48:	50                   	push   %eax
80100f49:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f4f:	e8 0c 6c 00 00       	call   80107b60 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100f54:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f57:	83 c4 10             	add    $0x10,%esp
80100f5a:	8b 00                	mov    (%eax),%eax
80100f5c:	85 c0                	test   %eax,%eax
80100f5e:	0f 84 43 01 00 00    	je     801010a7 <exec+0x397>
80100f64:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100f6a:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100f70:	eb 0b                	jmp    80100f7d <exec+0x26d>
80100f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100f78:	83 ff 20             	cmp    $0x20,%edi
80100f7b:	74 84                	je     80100f01 <exec+0x1f1>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	50                   	push   %eax
80100f81:	e8 7a 44 00 00       	call   80105400 <strlen>
80100f86:	f7 d0                	not    %eax
80100f88:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f8d:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f8e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f91:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f94:	e8 67 44 00 00       	call   80105400 <strlen>
80100f99:	83 c0 01             	add    $0x1,%eax
80100f9c:	50                   	push   %eax
80100f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fa0:	ff 34 b8             	pushl  (%eax,%edi,4)
80100fa3:	53                   	push   %ebx
80100fa4:	56                   	push   %esi
80100fa5:	e8 16 6d 00 00       	call   80107cc0 <copyout>
80100faa:	83 c4 20             	add    $0x20,%esp
80100fad:	85 c0                	test   %eax,%eax
80100faf:	0f 88 4c ff ff ff    	js     80100f01 <exec+0x1f1>
  for(argc = 0; argv[argc]; argc++) {
80100fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100fb8:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100fbf:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100fc2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100fc8:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100fcb:	85 c0                	test   %eax,%eax
80100fcd:	75 a9                	jne    80100f78 <exec+0x268>
80100fcf:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100fd5:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100fdc:	89 da                	mov    %ebx,%edx
  ustack[3+argc] = 0;
80100fde:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100fe5:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100fe9:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ff0:	ff ff ff 
  ustack[1] = argc;
80100ff3:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ff9:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100ffb:	83 c0 0c             	add    $0xc,%eax
80100ffe:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101000:	50                   	push   %eax
80101001:	51                   	push   %ecx
80101002:	53                   	push   %ebx
80101003:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101009:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010100f:	e8 ac 6c 00 00       	call   80107cc0 <copyout>
80101014:	83 c4 10             	add    $0x10,%esp
80101017:	85 c0                	test   %eax,%eax
80101019:	0f 88 e2 fe ff ff    	js     80100f01 <exec+0x1f1>
  for(last=s=path; *s; s++)
8010101f:	8b 45 08             	mov    0x8(%ebp),%eax
80101022:	0f b6 00             	movzbl (%eax),%eax
80101025:	84 c0                	test   %al,%al
80101027:	74 17                	je     80101040 <exec+0x330>
80101029:	8b 55 08             	mov    0x8(%ebp),%edx
8010102c:	89 d1                	mov    %edx,%ecx
8010102e:	83 c1 01             	add    $0x1,%ecx
80101031:	3c 2f                	cmp    $0x2f,%al
80101033:	0f b6 01             	movzbl (%ecx),%eax
80101036:	0f 44 d1             	cmove  %ecx,%edx
80101039:	84 c0                	test   %al,%al
8010103b:	75 f1                	jne    8010102e <exec+0x31e>
8010103d:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101040:	50                   	push   %eax
80101041:	8d 46 6c             	lea    0x6c(%esi),%eax
80101044:	6a 10                	push   $0x10
80101046:	ff 75 08             	pushl  0x8(%ebp)
80101049:	50                   	push   %eax
8010104a:	e8 71 43 00 00       	call   801053c0 <safestrcpy>
  oldpgdir = curproc->pgdir;
8010104f:	8b 46 04             	mov    0x4(%esi),%eax
  curproc->tf->eip = elf.entry;  // main
80101052:	8b 56 18             	mov    0x18(%esi),%edx
  oldpgdir = curproc->pgdir;
80101055:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  curproc->pgdir = pgdir;
8010105b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80101061:	89 46 04             	mov    %eax,0x4(%esi)
  curproc->sz = sz;
80101064:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
8010106a:	89 06                	mov    %eax,(%esi)
  curproc->tf->eip = elf.entry;  // main
8010106c:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80101072:	89 4a 38             	mov    %ecx,0x38(%edx)
  curproc->tf->esp = sp;
80101075:	8b 56 18             	mov    0x18(%esi),%edx
80101078:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(curproc);
8010107b:	89 34 24             	mov    %esi,(%esp)
8010107e:	e8 0d 66 00 00       	call   80107690 <switchuvm>
  freevm(oldpgdir);
80101083:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80101089:	89 04 24             	mov    %eax,(%esp)
8010108c:	e8 af 69 00 00       	call   80107a40 <freevm>
  return 0;
80101091:	83 c4 10             	add    $0x10,%esp
80101094:	31 c0                	xor    %eax,%eax
80101096:	e9 03 fd ff ff       	jmp    80100d9e <exec+0x8e>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010109b:	31 ff                	xor    %edi,%edi
8010109d:	b8 00 20 00 00       	mov    $0x2000,%eax
801010a2:	e9 23 fe ff ff       	jmp    80100eca <exec+0x1ba>
  for(argc = 0; argv[argc]; argc++) {
801010a7:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
801010ad:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
801010b3:	e9 1d ff ff ff       	jmp    80100fd5 <exec+0x2c5>
801010b8:	66 90                	xchg   %ax,%ax
801010ba:	66 90                	xchg   %ax,%ax
801010bc:	66 90                	xchg   %ax,%ax
801010be:	66 90                	xchg   %ax,%ax

801010c0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801010c6:	68 ed 7d 10 80       	push   $0x80107ded
801010cb:	68 80 12 11 80       	push   $0x80111280
801010d0:	e8 bb 3e 00 00       	call   80104f90 <initlock>
}
801010d5:	83 c4 10             	add    $0x10,%esp
801010d8:	c9                   	leave  
801010d9:	c3                   	ret    
801010da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010e0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010e4:	bb b4 12 11 80       	mov    $0x801112b4,%ebx
{
801010e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801010ec:	68 80 12 11 80       	push   $0x80111280
801010f1:	e8 da 3f 00 00       	call   801050d0 <acquire>
801010f6:	83 c4 10             	add    $0x10,%esp
801010f9:	eb 10                	jmp    8010110b <filealloc+0x2b>
801010fb:	90                   	nop
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101100:	83 c3 18             	add    $0x18,%ebx
80101103:	81 fb 14 1c 11 80    	cmp    $0x80111c14,%ebx
80101109:	73 25                	jae    80101130 <filealloc+0x50>
    if(f->ref == 0){
8010110b:	8b 43 04             	mov    0x4(%ebx),%eax
8010110e:	85 c0                	test   %eax,%eax
80101110:	75 ee                	jne    80101100 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101112:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101115:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010111c:	68 80 12 11 80       	push   $0x80111280
80101121:	e8 6a 40 00 00       	call   80105190 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101126:	89 d8                	mov    %ebx,%eax
      return f;
80101128:	83 c4 10             	add    $0x10,%esp
}
8010112b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010112e:	c9                   	leave  
8010112f:	c3                   	ret    
  release(&ftable.lock);
80101130:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101133:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101135:	68 80 12 11 80       	push   $0x80111280
8010113a:	e8 51 40 00 00       	call   80105190 <release>
}
8010113f:	89 d8                	mov    %ebx,%eax
  return 0;
80101141:	83 c4 10             	add    $0x10,%esp
}
80101144:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101147:	c9                   	leave  
80101148:	c3                   	ret    
80101149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101150 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	53                   	push   %ebx
80101154:	83 ec 10             	sub    $0x10,%esp
80101157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010115a:	68 80 12 11 80       	push   $0x80111280
8010115f:	e8 6c 3f 00 00       	call   801050d0 <acquire>
  if(f->ref < 1)
80101164:	8b 43 04             	mov    0x4(%ebx),%eax
80101167:	83 c4 10             	add    $0x10,%esp
8010116a:	85 c0                	test   %eax,%eax
8010116c:	7e 1a                	jle    80101188 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010116e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101171:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101174:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101177:	68 80 12 11 80       	push   $0x80111280
8010117c:	e8 0f 40 00 00       	call   80105190 <release>
  return f;
}
80101181:	89 d8                	mov    %ebx,%eax
80101183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101186:	c9                   	leave  
80101187:	c3                   	ret    
    panic("filedup");
80101188:	83 ec 0c             	sub    $0xc,%esp
8010118b:	68 f4 7d 10 80       	push   $0x80107df4
80101190:	e8 fb f1 ff ff       	call   80100390 <panic>
80101195:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801011a0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 28             	sub    $0x28,%esp
801011a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801011ac:	68 80 12 11 80       	push   $0x80111280
801011b1:	e8 1a 3f 00 00       	call   801050d0 <acquire>
  if(f->ref < 1)
801011b6:	8b 43 04             	mov    0x4(%ebx),%eax
801011b9:	83 c4 10             	add    $0x10,%esp
801011bc:	85 c0                	test   %eax,%eax
801011be:	0f 8e 9b 00 00 00    	jle    8010125f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
801011c4:	83 e8 01             	sub    $0x1,%eax
801011c7:	85 c0                	test   %eax,%eax
801011c9:	89 43 04             	mov    %eax,0x4(%ebx)
801011cc:	74 1a                	je     801011e8 <fileclose+0x48>
    release(&ftable.lock);
801011ce:	c7 45 08 80 12 11 80 	movl   $0x80111280,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801011d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011d8:	5b                   	pop    %ebx
801011d9:	5e                   	pop    %esi
801011da:	5f                   	pop    %edi
801011db:	5d                   	pop    %ebp
    release(&ftable.lock);
801011dc:	e9 af 3f 00 00       	jmp    80105190 <release>
801011e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
801011e8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801011ec:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
801011ee:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801011f1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
801011f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801011fa:	88 45 e7             	mov    %al,-0x19(%ebp)
801011fd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101200:	68 80 12 11 80       	push   $0x80111280
  ff = *f;
80101205:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101208:	e8 83 3f 00 00       	call   80105190 <release>
  if(ff.type == FD_PIPE)
8010120d:	83 c4 10             	add    $0x10,%esp
80101210:	83 ff 01             	cmp    $0x1,%edi
80101213:	74 13                	je     80101228 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80101215:	83 ff 02             	cmp    $0x2,%edi
80101218:	74 26                	je     80101240 <fileclose+0xa0>
}
8010121a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010121d:	5b                   	pop    %ebx
8010121e:	5e                   	pop    %esi
8010121f:	5f                   	pop    %edi
80101220:	5d                   	pop    %ebp
80101221:	c3                   	ret    
80101222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101228:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010122c:	83 ec 08             	sub    $0x8,%esp
8010122f:	53                   	push   %ebx
80101230:	56                   	push   %esi
80101231:	e8 8a 24 00 00       	call   801036c0 <pipeclose>
80101236:	83 c4 10             	add    $0x10,%esp
80101239:	eb df                	jmp    8010121a <fileclose+0x7a>
8010123b:	90                   	nop
8010123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80101240:	e8 cb 1c 00 00       	call   80102f10 <begin_op>
    iput(ff.ip);
80101245:	83 ec 0c             	sub    $0xc,%esp
80101248:	ff 75 e0             	pushl  -0x20(%ebp)
8010124b:	e8 d0 08 00 00       	call   80101b20 <iput>
    end_op();
80101250:	83 c4 10             	add    $0x10,%esp
}
80101253:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101256:	5b                   	pop    %ebx
80101257:	5e                   	pop    %esi
80101258:	5f                   	pop    %edi
80101259:	5d                   	pop    %ebp
    end_op();
8010125a:	e9 21 1d 00 00       	jmp    80102f80 <end_op>
    panic("fileclose");
8010125f:	83 ec 0c             	sub    $0xc,%esp
80101262:	68 fc 7d 10 80       	push   $0x80107dfc
80101267:	e8 24 f1 ff ff       	call   80100390 <panic>
8010126c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101270 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	53                   	push   %ebx
80101274:	83 ec 04             	sub    $0x4,%esp
80101277:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010127a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010127d:	75 31                	jne    801012b0 <filestat+0x40>
    ilock(f->ip);
8010127f:	83 ec 0c             	sub    $0xc,%esp
80101282:	ff 73 10             	pushl  0x10(%ebx)
80101285:	e8 66 07 00 00       	call   801019f0 <ilock>
    stati(f->ip, st);
8010128a:	58                   	pop    %eax
8010128b:	5a                   	pop    %edx
8010128c:	ff 75 0c             	pushl  0xc(%ebp)
8010128f:	ff 73 10             	pushl  0x10(%ebx)
80101292:	e8 09 0a 00 00       	call   80101ca0 <stati>
    iunlock(f->ip);
80101297:	59                   	pop    %ecx
80101298:	ff 73 10             	pushl  0x10(%ebx)
8010129b:	e8 30 08 00 00       	call   80101ad0 <iunlock>
    return 0;
801012a0:	83 c4 10             	add    $0x10,%esp
801012a3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
801012a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801012a8:	c9                   	leave  
801012a9:	c3                   	ret    
801012aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
801012b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012b5:	eb ee                	jmp    801012a5 <filestat+0x35>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012c0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	83 ec 0c             	sub    $0xc,%esp
801012c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801012cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801012cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801012d2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801012d6:	74 60                	je     80101338 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801012d8:	8b 03                	mov    (%ebx),%eax
801012da:	83 f8 01             	cmp    $0x1,%eax
801012dd:	74 41                	je     80101320 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801012df:	83 f8 02             	cmp    $0x2,%eax
801012e2:	75 5b                	jne    8010133f <fileread+0x7f>
    ilock(f->ip);
801012e4:	83 ec 0c             	sub    $0xc,%esp
801012e7:	ff 73 10             	pushl  0x10(%ebx)
801012ea:	e8 01 07 00 00       	call   801019f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801012ef:	57                   	push   %edi
801012f0:	ff 73 14             	pushl  0x14(%ebx)
801012f3:	56                   	push   %esi
801012f4:	ff 73 10             	pushl  0x10(%ebx)
801012f7:	e8 d4 09 00 00       	call   80101cd0 <readi>
801012fc:	83 c4 20             	add    $0x20,%esp
801012ff:	85 c0                	test   %eax,%eax
80101301:	89 c6                	mov    %eax,%esi
80101303:	7e 03                	jle    80101308 <fileread+0x48>
      f->off += r;
80101305:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101308:	83 ec 0c             	sub    $0xc,%esp
8010130b:	ff 73 10             	pushl  0x10(%ebx)
8010130e:	e8 bd 07 00 00       	call   80101ad0 <iunlock>
    return r;
80101313:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101316:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101319:	89 f0                	mov    %esi,%eax
8010131b:	5b                   	pop    %ebx
8010131c:	5e                   	pop    %esi
8010131d:	5f                   	pop    %edi
8010131e:	5d                   	pop    %ebp
8010131f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101320:	8b 43 0c             	mov    0xc(%ebx),%eax
80101323:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101326:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101329:	5b                   	pop    %ebx
8010132a:	5e                   	pop    %esi
8010132b:	5f                   	pop    %edi
8010132c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010132d:	e9 3e 25 00 00       	jmp    80103870 <piperead>
80101332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101338:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010133d:	eb d7                	jmp    80101316 <fileread+0x56>
  panic("fileread");
8010133f:	83 ec 0c             	sub    $0xc,%esp
80101342:	68 06 7e 10 80       	push   $0x80107e06
80101347:	e8 44 f0 ff ff       	call   80100390 <panic>
8010134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101350 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	83 ec 1c             	sub    $0x1c,%esp
80101359:	8b 75 08             	mov    0x8(%ebp),%esi
8010135c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010135f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101363:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101366:	8b 45 10             	mov    0x10(%ebp),%eax
80101369:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010136c:	0f 84 aa 00 00 00    	je     8010141c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101372:	8b 06                	mov    (%esi),%eax
80101374:	83 f8 01             	cmp    $0x1,%eax
80101377:	0f 84 c3 00 00 00    	je     80101440 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010137d:	83 f8 02             	cmp    $0x2,%eax
80101380:	0f 85 d9 00 00 00    	jne    8010145f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101386:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101389:	31 ff                	xor    %edi,%edi
    while(i < n){
8010138b:	85 c0                	test   %eax,%eax
8010138d:	7f 34                	jg     801013c3 <filewrite+0x73>
8010138f:	e9 9c 00 00 00       	jmp    80101430 <filewrite+0xe0>
80101394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101398:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010139b:	83 ec 0c             	sub    $0xc,%esp
8010139e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801013a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801013a4:	e8 27 07 00 00       	call   80101ad0 <iunlock>
      end_op();
801013a9:	e8 d2 1b 00 00       	call   80102f80 <end_op>
801013ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013b1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801013b4:	39 c3                	cmp    %eax,%ebx
801013b6:	0f 85 96 00 00 00    	jne    80101452 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801013bc:	01 df                	add    %ebx,%edi
    while(i < n){
801013be:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801013c1:	7e 6d                	jle    80101430 <filewrite+0xe0>
      int n1 = n - i;
801013c3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801013c6:	b8 00 06 00 00       	mov    $0x600,%eax
801013cb:	29 fb                	sub    %edi,%ebx
801013cd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801013d3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801013d6:	e8 35 1b 00 00       	call   80102f10 <begin_op>
      ilock(f->ip);
801013db:	83 ec 0c             	sub    $0xc,%esp
801013de:	ff 76 10             	pushl  0x10(%esi)
801013e1:	e8 0a 06 00 00       	call   801019f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801013e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013e9:	53                   	push   %ebx
801013ea:	ff 76 14             	pushl  0x14(%esi)
801013ed:	01 f8                	add    %edi,%eax
801013ef:	50                   	push   %eax
801013f0:	ff 76 10             	pushl  0x10(%esi)
801013f3:	e8 d8 09 00 00       	call   80101dd0 <writei>
801013f8:	83 c4 20             	add    $0x20,%esp
801013fb:	85 c0                	test   %eax,%eax
801013fd:	7f 99                	jg     80101398 <filewrite+0x48>
      iunlock(f->ip);
801013ff:	83 ec 0c             	sub    $0xc,%esp
80101402:	ff 76 10             	pushl  0x10(%esi)
80101405:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101408:	e8 c3 06 00 00       	call   80101ad0 <iunlock>
      end_op();
8010140d:	e8 6e 1b 00 00       	call   80102f80 <end_op>
      if(r < 0)
80101412:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101415:	83 c4 10             	add    $0x10,%esp
80101418:	85 c0                	test   %eax,%eax
8010141a:	74 98                	je     801013b4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010141c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010141f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101424:	89 f8                	mov    %edi,%eax
80101426:	5b                   	pop    %ebx
80101427:	5e                   	pop    %esi
80101428:	5f                   	pop    %edi
80101429:	5d                   	pop    %ebp
8010142a:	c3                   	ret    
8010142b:	90                   	nop
8010142c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101430:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101433:	75 e7                	jne    8010141c <filewrite+0xcc>
}
80101435:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101438:	89 f8                	mov    %edi,%eax
8010143a:	5b                   	pop    %ebx
8010143b:	5e                   	pop    %esi
8010143c:	5f                   	pop    %edi
8010143d:	5d                   	pop    %ebp
8010143e:	c3                   	ret    
8010143f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101440:	8b 46 0c             	mov    0xc(%esi),%eax
80101443:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101446:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101449:	5b                   	pop    %ebx
8010144a:	5e                   	pop    %esi
8010144b:	5f                   	pop    %edi
8010144c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010144d:	e9 0e 23 00 00       	jmp    80103760 <pipewrite>
        panic("short filewrite");
80101452:	83 ec 0c             	sub    $0xc,%esp
80101455:	68 0f 7e 10 80       	push   $0x80107e0f
8010145a:	e8 31 ef ff ff       	call   80100390 <panic>
  panic("filewrite");
8010145f:	83 ec 0c             	sub    $0xc,%esp
80101462:	68 15 7e 10 80       	push   $0x80107e15
80101467:	e8 24 ef ff ff       	call   80100390 <panic>
8010146c:	66 90                	xchg   %ax,%ax
8010146e:	66 90                	xchg   %ax,%ax

80101470 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	57                   	push   %edi
80101474:	56                   	push   %esi
80101475:	53                   	push   %ebx
80101476:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101479:	8b 0d 80 1c 11 80    	mov    0x80111c80,%ecx
{
8010147f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101482:	85 c9                	test   %ecx,%ecx
80101484:	0f 84 87 00 00 00    	je     80101511 <balloc+0xa1>
8010148a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101491:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101494:	83 ec 08             	sub    $0x8,%esp
80101497:	89 f0                	mov    %esi,%eax
80101499:	c1 f8 0c             	sar    $0xc,%eax
8010149c:	03 05 98 1c 11 80    	add    0x80111c98,%eax
801014a2:	50                   	push   %eax
801014a3:	ff 75 d8             	pushl  -0x28(%ebp)
801014a6:	e8 25 ec ff ff       	call   801000d0 <bread>
801014ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014ae:	a1 80 1c 11 80       	mov    0x80111c80,%eax
801014b3:	83 c4 10             	add    $0x10,%esp
801014b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801014b9:	31 c0                	xor    %eax,%eax
801014bb:	eb 2f                	jmp    801014ec <balloc+0x7c>
801014bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801014c0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801014c5:	bb 01 00 00 00       	mov    $0x1,%ebx
801014ca:	83 e1 07             	and    $0x7,%ecx
801014cd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014cf:	89 c1                	mov    %eax,%ecx
801014d1:	c1 f9 03             	sar    $0x3,%ecx
801014d4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801014d9:	85 df                	test   %ebx,%edi
801014db:	89 fa                	mov    %edi,%edx
801014dd:	74 41                	je     80101520 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014df:	83 c0 01             	add    $0x1,%eax
801014e2:	83 c6 01             	add    $0x1,%esi
801014e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801014ea:	74 05                	je     801014f1 <balloc+0x81>
801014ec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801014ef:	77 cf                	ja     801014c0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014f1:	83 ec 0c             	sub    $0xc,%esp
801014f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801014f7:	e8 e4 ec ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801014fc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101503:	83 c4 10             	add    $0x10,%esp
80101506:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101509:	39 05 80 1c 11 80    	cmp    %eax,0x80111c80
8010150f:	77 80                	ja     80101491 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101511:	83 ec 0c             	sub    $0xc,%esp
80101514:	68 1f 7e 10 80       	push   $0x80107e1f
80101519:	e8 72 ee ff ff       	call   80100390 <panic>
8010151e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101520:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101523:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101526:	09 da                	or     %ebx,%edx
80101528:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010152c:	57                   	push   %edi
8010152d:	e8 ae 1b 00 00       	call   801030e0 <log_write>
        brelse(bp);
80101532:	89 3c 24             	mov    %edi,(%esp)
80101535:	e8 a6 ec ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010153a:	58                   	pop    %eax
8010153b:	5a                   	pop    %edx
8010153c:	56                   	push   %esi
8010153d:	ff 75 d8             	pushl  -0x28(%ebp)
80101540:	e8 8b eb ff ff       	call   801000d0 <bread>
80101545:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101547:	8d 40 5c             	lea    0x5c(%eax),%eax
8010154a:	83 c4 0c             	add    $0xc,%esp
8010154d:	68 00 02 00 00       	push   $0x200
80101552:	6a 00                	push   $0x0
80101554:	50                   	push   %eax
80101555:	e8 86 3c 00 00       	call   801051e0 <memset>
  log_write(bp);
8010155a:	89 1c 24             	mov    %ebx,(%esp)
8010155d:	e8 7e 1b 00 00       	call   801030e0 <log_write>
  brelse(bp);
80101562:	89 1c 24             	mov    %ebx,(%esp)
80101565:	e8 76 ec ff ff       	call   801001e0 <brelse>
}
8010156a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010156d:	89 f0                	mov    %esi,%eax
8010156f:	5b                   	pop    %ebx
80101570:	5e                   	pop    %esi
80101571:	5f                   	pop    %edi
80101572:	5d                   	pop    %ebp
80101573:	c3                   	ret    
80101574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010157a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101580 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101580:	55                   	push   %ebp
80101581:	89 e5                	mov    %esp,%ebp
80101583:	57                   	push   %edi
80101584:	56                   	push   %esi
80101585:	53                   	push   %ebx
80101586:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101588:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010158a:	bb d4 1c 11 80       	mov    $0x80111cd4,%ebx
{
8010158f:	83 ec 28             	sub    $0x28,%esp
80101592:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101595:	68 a0 1c 11 80       	push   $0x80111ca0
8010159a:	e8 31 3b 00 00       	call   801050d0 <acquire>
8010159f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801015a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015a5:	eb 17                	jmp    801015be <iget+0x3e>
801015a7:	89 f6                	mov    %esi,%esi
801015a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801015b0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015b6:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
801015bc:	73 22                	jae    801015e0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801015be:	8b 4b 08             	mov    0x8(%ebx),%ecx
801015c1:	85 c9                	test   %ecx,%ecx
801015c3:	7e 04                	jle    801015c9 <iget+0x49>
801015c5:	39 3b                	cmp    %edi,(%ebx)
801015c7:	74 4f                	je     80101618 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801015c9:	85 f6                	test   %esi,%esi
801015cb:	75 e3                	jne    801015b0 <iget+0x30>
801015cd:	85 c9                	test   %ecx,%ecx
801015cf:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801015d2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015d8:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
801015de:	72 de                	jb     801015be <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801015e0:	85 f6                	test   %esi,%esi
801015e2:	74 5b                	je     8010163f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801015e4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801015e7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801015e9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801015ec:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801015f3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801015fa:	68 a0 1c 11 80       	push   $0x80111ca0
801015ff:	e8 8c 3b 00 00       	call   80105190 <release>

  return ip;
80101604:	83 c4 10             	add    $0x10,%esp
}
80101607:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010160a:	89 f0                	mov    %esi,%eax
8010160c:	5b                   	pop    %ebx
8010160d:	5e                   	pop    %esi
8010160e:	5f                   	pop    %edi
8010160f:	5d                   	pop    %ebp
80101610:	c3                   	ret    
80101611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101618:	39 53 04             	cmp    %edx,0x4(%ebx)
8010161b:	75 ac                	jne    801015c9 <iget+0x49>
      release(&icache.lock);
8010161d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101620:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101623:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101625:	68 a0 1c 11 80       	push   $0x80111ca0
      ip->ref++;
8010162a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010162d:	e8 5e 3b 00 00       	call   80105190 <release>
      return ip;
80101632:	83 c4 10             	add    $0x10,%esp
}
80101635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101638:	89 f0                	mov    %esi,%eax
8010163a:	5b                   	pop    %ebx
8010163b:	5e                   	pop    %esi
8010163c:	5f                   	pop    %edi
8010163d:	5d                   	pop    %ebp
8010163e:	c3                   	ret    
    panic("iget: no inodes");
8010163f:	83 ec 0c             	sub    $0xc,%esp
80101642:	68 35 7e 10 80       	push   $0x80107e35
80101647:	e8 44 ed ff ff       	call   80100390 <panic>
8010164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101650 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	57                   	push   %edi
80101654:	56                   	push   %esi
80101655:	53                   	push   %ebx
80101656:	89 c6                	mov    %eax,%esi
80101658:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010165b:	83 fa 0b             	cmp    $0xb,%edx
8010165e:	77 18                	ja     80101678 <bmap+0x28>
80101660:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101663:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101666:	85 db                	test   %ebx,%ebx
80101668:	74 76                	je     801016e0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010166a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010166d:	89 d8                	mov    %ebx,%eax
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5f                   	pop    %edi
80101672:	5d                   	pop    %ebp
80101673:	c3                   	ret    
80101674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101678:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010167b:	83 fb 7f             	cmp    $0x7f,%ebx
8010167e:	0f 87 90 00 00 00    	ja     80101714 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101684:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010168a:	8b 00                	mov    (%eax),%eax
8010168c:	85 d2                	test   %edx,%edx
8010168e:	74 70                	je     80101700 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101690:	83 ec 08             	sub    $0x8,%esp
80101693:	52                   	push   %edx
80101694:	50                   	push   %eax
80101695:	e8 36 ea ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010169a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010169e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801016a1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801016a3:	8b 1a                	mov    (%edx),%ebx
801016a5:	85 db                	test   %ebx,%ebx
801016a7:	75 1d                	jne    801016c6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801016a9:	8b 06                	mov    (%esi),%eax
801016ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801016ae:	e8 bd fd ff ff       	call   80101470 <balloc>
801016b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801016b6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801016b9:	89 c3                	mov    %eax,%ebx
801016bb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801016bd:	57                   	push   %edi
801016be:	e8 1d 1a 00 00       	call   801030e0 <log_write>
801016c3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801016c6:	83 ec 0c             	sub    $0xc,%esp
801016c9:	57                   	push   %edi
801016ca:	e8 11 eb ff ff       	call   801001e0 <brelse>
801016cf:	83 c4 10             	add    $0x10,%esp
}
801016d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016d5:	89 d8                	mov    %ebx,%eax
801016d7:	5b                   	pop    %ebx
801016d8:	5e                   	pop    %esi
801016d9:	5f                   	pop    %edi
801016da:	5d                   	pop    %ebp
801016db:	c3                   	ret    
801016dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801016e0:	8b 00                	mov    (%eax),%eax
801016e2:	e8 89 fd ff ff       	call   80101470 <balloc>
801016e7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801016ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801016ed:	89 c3                	mov    %eax,%ebx
}
801016ef:	89 d8                	mov    %ebx,%eax
801016f1:	5b                   	pop    %ebx
801016f2:	5e                   	pop    %esi
801016f3:	5f                   	pop    %edi
801016f4:	5d                   	pop    %ebp
801016f5:	c3                   	ret    
801016f6:	8d 76 00             	lea    0x0(%esi),%esi
801016f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101700:	e8 6b fd ff ff       	call   80101470 <balloc>
80101705:	89 c2                	mov    %eax,%edx
80101707:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010170d:	8b 06                	mov    (%esi),%eax
8010170f:	e9 7c ff ff ff       	jmp    80101690 <bmap+0x40>
  panic("bmap: out of range");
80101714:	83 ec 0c             	sub    $0xc,%esp
80101717:	68 45 7e 10 80       	push   $0x80107e45
8010171c:	e8 6f ec ff ff       	call   80100390 <panic>
80101721:	eb 0d                	jmp    80101730 <readsb>
80101723:	90                   	nop
80101724:	90                   	nop
80101725:	90                   	nop
80101726:	90                   	nop
80101727:	90                   	nop
80101728:	90                   	nop
80101729:	90                   	nop
8010172a:	90                   	nop
8010172b:	90                   	nop
8010172c:	90                   	nop
8010172d:	90                   	nop
8010172e:	90                   	nop
8010172f:	90                   	nop

80101730 <readsb>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	56                   	push   %esi
80101734:	53                   	push   %ebx
80101735:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101738:	83 ec 08             	sub    $0x8,%esp
8010173b:	6a 01                	push   $0x1
8010173d:	ff 75 08             	pushl  0x8(%ebp)
80101740:	e8 8b e9 ff ff       	call   801000d0 <bread>
80101745:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101747:	8d 40 5c             	lea    0x5c(%eax),%eax
8010174a:	83 c4 0c             	add    $0xc,%esp
8010174d:	6a 1c                	push   $0x1c
8010174f:	50                   	push   %eax
80101750:	56                   	push   %esi
80101751:	e8 3a 3b 00 00       	call   80105290 <memmove>
  brelse(bp);
80101756:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101759:	83 c4 10             	add    $0x10,%esp
}
8010175c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010175f:	5b                   	pop    %ebx
80101760:	5e                   	pop    %esi
80101761:	5d                   	pop    %ebp
  brelse(bp);
80101762:	e9 79 ea ff ff       	jmp    801001e0 <brelse>
80101767:	89 f6                	mov    %esi,%esi
80101769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101770 <bfree>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	89 d3                	mov    %edx,%ebx
80101777:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101779:	83 ec 08             	sub    $0x8,%esp
8010177c:	68 80 1c 11 80       	push   $0x80111c80
80101781:	50                   	push   %eax
80101782:	e8 a9 ff ff ff       	call   80101730 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101787:	58                   	pop    %eax
80101788:	5a                   	pop    %edx
80101789:	89 da                	mov    %ebx,%edx
8010178b:	c1 ea 0c             	shr    $0xc,%edx
8010178e:	03 15 98 1c 11 80    	add    0x80111c98,%edx
80101794:	52                   	push   %edx
80101795:	56                   	push   %esi
80101796:	e8 35 e9 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010179b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010179d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801017a0:	ba 01 00 00 00       	mov    $0x1,%edx
801017a5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801017a8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801017ae:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801017b1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801017b3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801017b8:	85 d1                	test   %edx,%ecx
801017ba:	74 25                	je     801017e1 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801017bc:	f7 d2                	not    %edx
801017be:	89 c6                	mov    %eax,%esi
  log_write(bp);
801017c0:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801017c3:	21 ca                	and    %ecx,%edx
801017c5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801017c9:	56                   	push   %esi
801017ca:	e8 11 19 00 00       	call   801030e0 <log_write>
  brelse(bp);
801017cf:	89 34 24             	mov    %esi,(%esp)
801017d2:	e8 09 ea ff ff       	call   801001e0 <brelse>
}
801017d7:	83 c4 10             	add    $0x10,%esp
801017da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017dd:	5b                   	pop    %ebx
801017de:	5e                   	pop    %esi
801017df:	5d                   	pop    %ebp
801017e0:	c3                   	ret    
    panic("freeing free block");
801017e1:	83 ec 0c             	sub    $0xc,%esp
801017e4:	68 58 7e 10 80       	push   $0x80107e58
801017e9:	e8 a2 eb ff ff       	call   80100390 <panic>
801017ee:	66 90                	xchg   %ax,%ax

801017f0 <iinit>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	53                   	push   %ebx
801017f4:	bb e0 1c 11 80       	mov    $0x80111ce0,%ebx
801017f9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801017fc:	68 6b 7e 10 80       	push   $0x80107e6b
80101801:	68 a0 1c 11 80       	push   $0x80111ca0
80101806:	e8 85 37 00 00       	call   80104f90 <initlock>
8010180b:	83 c4 10             	add    $0x10,%esp
8010180e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101810:	83 ec 08             	sub    $0x8,%esp
80101813:	68 72 7e 10 80       	push   $0x80107e72
80101818:	53                   	push   %ebx
80101819:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010181f:	e8 3c 36 00 00       	call   80104e60 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	81 fb 00 39 11 80    	cmp    $0x80113900,%ebx
8010182d:	75 e1                	jne    80101810 <iinit+0x20>
  readsb(dev, &sb);
8010182f:	83 ec 08             	sub    $0x8,%esp
80101832:	68 80 1c 11 80       	push   $0x80111c80
80101837:	ff 75 08             	pushl  0x8(%ebp)
8010183a:	e8 f1 fe ff ff       	call   80101730 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010183f:	ff 35 98 1c 11 80    	pushl  0x80111c98
80101845:	ff 35 94 1c 11 80    	pushl  0x80111c94
8010184b:	ff 35 90 1c 11 80    	pushl  0x80111c90
80101851:	ff 35 8c 1c 11 80    	pushl  0x80111c8c
80101857:	ff 35 88 1c 11 80    	pushl  0x80111c88
8010185d:	ff 35 84 1c 11 80    	pushl  0x80111c84
80101863:	ff 35 80 1c 11 80    	pushl  0x80111c80
80101869:	68 d8 7e 10 80       	push   $0x80107ed8
8010186e:	e8 ed ed ff ff       	call   80100660 <cprintf>
}
80101873:	83 c4 30             	add    $0x30,%esp
80101876:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101879:	c9                   	leave  
8010187a:	c3                   	ret    
8010187b:	90                   	nop
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101880 <ialloc>:
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	57                   	push   %edi
80101884:	56                   	push   %esi
80101885:	53                   	push   %ebx
80101886:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101889:	83 3d 88 1c 11 80 01 	cmpl   $0x1,0x80111c88
{
80101890:	8b 45 0c             	mov    0xc(%ebp),%eax
80101893:	8b 75 08             	mov    0x8(%ebp),%esi
80101896:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101899:	0f 86 91 00 00 00    	jbe    80101930 <ialloc+0xb0>
8010189f:	bb 01 00 00 00       	mov    $0x1,%ebx
801018a4:	eb 21                	jmp    801018c7 <ialloc+0x47>
801018a6:	8d 76 00             	lea    0x0(%esi),%esi
801018a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801018b0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801018b3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801018b6:	57                   	push   %edi
801018b7:	e8 24 e9 ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801018bc:	83 c4 10             	add    $0x10,%esp
801018bf:	39 1d 88 1c 11 80    	cmp    %ebx,0x80111c88
801018c5:	76 69                	jbe    80101930 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801018c7:	89 d8                	mov    %ebx,%eax
801018c9:	83 ec 08             	sub    $0x8,%esp
801018cc:	c1 e8 03             	shr    $0x3,%eax
801018cf:	03 05 94 1c 11 80    	add    0x80111c94,%eax
801018d5:	50                   	push   %eax
801018d6:	56                   	push   %esi
801018d7:	e8 f4 e7 ff ff       	call   801000d0 <bread>
801018dc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801018de:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801018e0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801018e3:	83 e0 07             	and    $0x7,%eax
801018e6:	c1 e0 06             	shl    $0x6,%eax
801018e9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801018ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801018f1:	75 bd                	jne    801018b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801018f3:	83 ec 04             	sub    $0x4,%esp
801018f6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801018f9:	6a 40                	push   $0x40
801018fb:	6a 00                	push   $0x0
801018fd:	51                   	push   %ecx
801018fe:	e8 dd 38 00 00       	call   801051e0 <memset>
      dip->type = type;
80101903:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101907:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010190a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010190d:	89 3c 24             	mov    %edi,(%esp)
80101910:	e8 cb 17 00 00       	call   801030e0 <log_write>
      brelse(bp);
80101915:	89 3c 24             	mov    %edi,(%esp)
80101918:	e8 c3 e8 ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010191d:	83 c4 10             	add    $0x10,%esp
}
80101920:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101923:	89 da                	mov    %ebx,%edx
80101925:	89 f0                	mov    %esi,%eax
}
80101927:	5b                   	pop    %ebx
80101928:	5e                   	pop    %esi
80101929:	5f                   	pop    %edi
8010192a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010192b:	e9 50 fc ff ff       	jmp    80101580 <iget>
  panic("ialloc: no inodes");
80101930:	83 ec 0c             	sub    $0xc,%esp
80101933:	68 78 7e 10 80       	push   $0x80107e78
80101938:	e8 53 ea ff ff       	call   80100390 <panic>
8010193d:	8d 76 00             	lea    0x0(%esi),%esi

80101940 <iupdate>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	56                   	push   %esi
80101944:	53                   	push   %ebx
80101945:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101948:	83 ec 08             	sub    $0x8,%esp
8010194b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010194e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101951:	c1 e8 03             	shr    $0x3,%eax
80101954:	03 05 94 1c 11 80    	add    0x80111c94,%eax
8010195a:	50                   	push   %eax
8010195b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010195e:	e8 6d e7 ff ff       	call   801000d0 <bread>
80101963:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101965:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101968:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010196c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010196f:	83 e0 07             	and    $0x7,%eax
80101972:	c1 e0 06             	shl    $0x6,%eax
80101975:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101979:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010197c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101980:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101983:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101987:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010198b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010198f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101993:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101997:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010199a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010199d:	6a 34                	push   $0x34
8010199f:	53                   	push   %ebx
801019a0:	50                   	push   %eax
801019a1:	e8 ea 38 00 00       	call   80105290 <memmove>
  log_write(bp);
801019a6:	89 34 24             	mov    %esi,(%esp)
801019a9:	e8 32 17 00 00       	call   801030e0 <log_write>
  brelse(bp);
801019ae:	89 75 08             	mov    %esi,0x8(%ebp)
801019b1:	83 c4 10             	add    $0x10,%esp
}
801019b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019b7:	5b                   	pop    %ebx
801019b8:	5e                   	pop    %esi
801019b9:	5d                   	pop    %ebp
  brelse(bp);
801019ba:	e9 21 e8 ff ff       	jmp    801001e0 <brelse>
801019bf:	90                   	nop

801019c0 <idup>:
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	53                   	push   %ebx
801019c4:	83 ec 10             	sub    $0x10,%esp
801019c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801019ca:	68 a0 1c 11 80       	push   $0x80111ca0
801019cf:	e8 fc 36 00 00       	call   801050d0 <acquire>
  ip->ref++;
801019d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019d8:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
801019df:	e8 ac 37 00 00       	call   80105190 <release>
}
801019e4:	89 d8                	mov    %ebx,%eax
801019e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019e9:	c9                   	leave  
801019ea:	c3                   	ret    
801019eb:	90                   	nop
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019f0 <ilock>:
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	56                   	push   %esi
801019f4:	53                   	push   %ebx
801019f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801019f8:	85 db                	test   %ebx,%ebx
801019fa:	0f 84 b7 00 00 00    	je     80101ab7 <ilock+0xc7>
80101a00:	8b 53 08             	mov    0x8(%ebx),%edx
80101a03:	85 d2                	test   %edx,%edx
80101a05:	0f 8e ac 00 00 00    	jle    80101ab7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101a0b:	8d 43 0c             	lea    0xc(%ebx),%eax
80101a0e:	83 ec 0c             	sub    $0xc,%esp
80101a11:	50                   	push   %eax
80101a12:	e8 89 34 00 00       	call   80104ea0 <acquiresleep>
  if(ip->valid == 0){
80101a17:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	85 c0                	test   %eax,%eax
80101a1f:	74 0f                	je     80101a30 <ilock+0x40>
}
80101a21:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a24:	5b                   	pop    %ebx
80101a25:	5e                   	pop    %esi
80101a26:	5d                   	pop    %ebp
80101a27:	c3                   	ret    
80101a28:	90                   	nop
80101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a30:	8b 43 04             	mov    0x4(%ebx),%eax
80101a33:	83 ec 08             	sub    $0x8,%esp
80101a36:	c1 e8 03             	shr    $0x3,%eax
80101a39:	03 05 94 1c 11 80    	add    0x80111c94,%eax
80101a3f:	50                   	push   %eax
80101a40:	ff 33                	pushl  (%ebx)
80101a42:	e8 89 e6 ff ff       	call   801000d0 <bread>
80101a47:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a49:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a4c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a4f:	83 e0 07             	and    $0x7,%eax
80101a52:	c1 e0 06             	shl    $0x6,%eax
80101a55:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101a59:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a5c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101a5f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101a63:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101a67:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101a6b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101a6f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a73:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a77:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a7b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a7e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a81:	6a 34                	push   $0x34
80101a83:	50                   	push   %eax
80101a84:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101a87:	50                   	push   %eax
80101a88:	e8 03 38 00 00       	call   80105290 <memmove>
    brelse(bp);
80101a8d:	89 34 24             	mov    %esi,(%esp)
80101a90:	e8 4b e7 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101a95:	83 c4 10             	add    $0x10,%esp
80101a98:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101a9d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101aa4:	0f 85 77 ff ff ff    	jne    80101a21 <ilock+0x31>
      panic("ilock: no type");
80101aaa:	83 ec 0c             	sub    $0xc,%esp
80101aad:	68 90 7e 10 80       	push   $0x80107e90
80101ab2:	e8 d9 e8 ff ff       	call   80100390 <panic>
    panic("ilock");
80101ab7:	83 ec 0c             	sub    $0xc,%esp
80101aba:	68 8a 7e 10 80       	push   $0x80107e8a
80101abf:	e8 cc e8 ff ff       	call   80100390 <panic>
80101ac4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101aca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101ad0 <iunlock>:
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	56                   	push   %esi
80101ad4:	53                   	push   %ebx
80101ad5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ad8:	85 db                	test   %ebx,%ebx
80101ada:	74 28                	je     80101b04 <iunlock+0x34>
80101adc:	8d 73 0c             	lea    0xc(%ebx),%esi
80101adf:	83 ec 0c             	sub    $0xc,%esp
80101ae2:	56                   	push   %esi
80101ae3:	e8 58 34 00 00       	call   80104f40 <holdingsleep>
80101ae8:	83 c4 10             	add    $0x10,%esp
80101aeb:	85 c0                	test   %eax,%eax
80101aed:	74 15                	je     80101b04 <iunlock+0x34>
80101aef:	8b 43 08             	mov    0x8(%ebx),%eax
80101af2:	85 c0                	test   %eax,%eax
80101af4:	7e 0e                	jle    80101b04 <iunlock+0x34>
  releasesleep(&ip->lock);
80101af6:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101af9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101afc:	5b                   	pop    %ebx
80101afd:	5e                   	pop    %esi
80101afe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101aff:	e9 fc 33 00 00       	jmp    80104f00 <releasesleep>
    panic("iunlock");
80101b04:	83 ec 0c             	sub    $0xc,%esp
80101b07:	68 9f 7e 10 80       	push   $0x80107e9f
80101b0c:	e8 7f e8 ff ff       	call   80100390 <panic>
80101b11:	eb 0d                	jmp    80101b20 <iput>
80101b13:	90                   	nop
80101b14:	90                   	nop
80101b15:	90                   	nop
80101b16:	90                   	nop
80101b17:	90                   	nop
80101b18:	90                   	nop
80101b19:	90                   	nop
80101b1a:	90                   	nop
80101b1b:	90                   	nop
80101b1c:	90                   	nop
80101b1d:	90                   	nop
80101b1e:	90                   	nop
80101b1f:	90                   	nop

80101b20 <iput>:
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	56                   	push   %esi
80101b25:	53                   	push   %ebx
80101b26:	83 ec 28             	sub    $0x28,%esp
80101b29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101b2c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101b2f:	57                   	push   %edi
80101b30:	e8 6b 33 00 00       	call   80104ea0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101b35:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101b38:	83 c4 10             	add    $0x10,%esp
80101b3b:	85 d2                	test   %edx,%edx
80101b3d:	74 07                	je     80101b46 <iput+0x26>
80101b3f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101b44:	74 32                	je     80101b78 <iput+0x58>
  releasesleep(&ip->lock);
80101b46:	83 ec 0c             	sub    $0xc,%esp
80101b49:	57                   	push   %edi
80101b4a:	e8 b1 33 00 00       	call   80104f00 <releasesleep>
  acquire(&icache.lock);
80101b4f:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b56:	e8 75 35 00 00       	call   801050d0 <acquire>
  ip->ref--;
80101b5b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101b5f:	83 c4 10             	add    $0x10,%esp
80101b62:	c7 45 08 a0 1c 11 80 	movl   $0x80111ca0,0x8(%ebp)
}
80101b69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6c:	5b                   	pop    %ebx
80101b6d:	5e                   	pop    %esi
80101b6e:	5f                   	pop    %edi
80101b6f:	5d                   	pop    %ebp
  release(&icache.lock);
80101b70:	e9 1b 36 00 00       	jmp    80105190 <release>
80101b75:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101b78:	83 ec 0c             	sub    $0xc,%esp
80101b7b:	68 a0 1c 11 80       	push   $0x80111ca0
80101b80:	e8 4b 35 00 00       	call   801050d0 <acquire>
    int r = ip->ref;
80101b85:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101b88:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b8f:	e8 fc 35 00 00       	call   80105190 <release>
    if(r == 1){
80101b94:	83 c4 10             	add    $0x10,%esp
80101b97:	83 fe 01             	cmp    $0x1,%esi
80101b9a:	75 aa                	jne    80101b46 <iput+0x26>
80101b9c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101ba2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ba5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101ba8:	89 cf                	mov    %ecx,%edi
80101baa:	eb 0b                	jmp    80101bb7 <iput+0x97>
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101bb3:	39 fe                	cmp    %edi,%esi
80101bb5:	74 19                	je     80101bd0 <iput+0xb0>
    if(ip->addrs[i]){
80101bb7:	8b 16                	mov    (%esi),%edx
80101bb9:	85 d2                	test   %edx,%edx
80101bbb:	74 f3                	je     80101bb0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101bbd:	8b 03                	mov    (%ebx),%eax
80101bbf:	e8 ac fb ff ff       	call   80101770 <bfree>
      ip->addrs[i] = 0;
80101bc4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101bca:	eb e4                	jmp    80101bb0 <iput+0x90>
80101bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101bd0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101bd6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101bd9:	85 c0                	test   %eax,%eax
80101bdb:	75 33                	jne    80101c10 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101bdd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101be0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101be7:	53                   	push   %ebx
80101be8:	e8 53 fd ff ff       	call   80101940 <iupdate>
      ip->type = 0;
80101bed:	31 c0                	xor    %eax,%eax
80101bef:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101bf3:	89 1c 24             	mov    %ebx,(%esp)
80101bf6:	e8 45 fd ff ff       	call   80101940 <iupdate>
      ip->valid = 0;
80101bfb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	e9 3c ff ff ff       	jmp    80101b46 <iput+0x26>
80101c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c10:	83 ec 08             	sub    $0x8,%esp
80101c13:	50                   	push   %eax
80101c14:	ff 33                	pushl  (%ebx)
80101c16:	e8 b5 e4 ff ff       	call   801000d0 <bread>
80101c1b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101c21:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101c24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101c27:	8d 70 5c             	lea    0x5c(%eax),%esi
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	89 cf                	mov    %ecx,%edi
80101c2f:	eb 0e                	jmp    80101c3f <iput+0x11f>
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c38:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101c3b:	39 fe                	cmp    %edi,%esi
80101c3d:	74 0f                	je     80101c4e <iput+0x12e>
      if(a[j])
80101c3f:	8b 16                	mov    (%esi),%edx
80101c41:	85 d2                	test   %edx,%edx
80101c43:	74 f3                	je     80101c38 <iput+0x118>
        bfree(ip->dev, a[j]);
80101c45:	8b 03                	mov    (%ebx),%eax
80101c47:	e8 24 fb ff ff       	call   80101770 <bfree>
80101c4c:	eb ea                	jmp    80101c38 <iput+0x118>
    brelse(bp);
80101c4e:	83 ec 0c             	sub    $0xc,%esp
80101c51:	ff 75 e4             	pushl  -0x1c(%ebp)
80101c54:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c57:	e8 84 e5 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101c5c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101c62:	8b 03                	mov    (%ebx),%eax
80101c64:	e8 07 fb ff ff       	call   80101770 <bfree>
    ip->addrs[NDIRECT] = 0;
80101c69:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101c70:	00 00 00 
80101c73:	83 c4 10             	add    $0x10,%esp
80101c76:	e9 62 ff ff ff       	jmp    80101bdd <iput+0xbd>
80101c7b:	90                   	nop
80101c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c80 <iunlockput>:
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	53                   	push   %ebx
80101c84:	83 ec 10             	sub    $0x10,%esp
80101c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101c8a:	53                   	push   %ebx
80101c8b:	e8 40 fe ff ff       	call   80101ad0 <iunlock>
  iput(ip);
80101c90:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101c93:	83 c4 10             	add    $0x10,%esp
}
80101c96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c99:	c9                   	leave  
  iput(ip);
80101c9a:	e9 81 fe ff ff       	jmp    80101b20 <iput>
80101c9f:	90                   	nop

80101ca0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ca9:	8b 0a                	mov    (%edx),%ecx
80101cab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101cae:	8b 4a 04             	mov    0x4(%edx),%ecx
80101cb1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101cb4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101cb8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101cbb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101cbf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101cc3:	8b 52 58             	mov    0x58(%edx),%edx
80101cc6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101cc9:	5d                   	pop    %ebp
80101cca:	c3                   	ret    
80101ccb:	90                   	nop
80101ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cd0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	57                   	push   %edi
80101cd4:	56                   	push   %esi
80101cd5:	53                   	push   %ebx
80101cd6:	83 ec 1c             	sub    $0x1c,%esp
80101cd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101cdf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ce2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ce7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101cea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ced:	8b 75 10             	mov    0x10(%ebp),%esi
80101cf0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101cf3:	0f 84 a7 00 00 00    	je     80101da0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101cf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cfc:	8b 40 58             	mov    0x58(%eax),%eax
80101cff:	39 c6                	cmp    %eax,%esi
80101d01:	0f 87 ba 00 00 00    	ja     80101dc1 <readi+0xf1>
80101d07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d0a:	89 f9                	mov    %edi,%ecx
80101d0c:	01 f1                	add    %esi,%ecx
80101d0e:	0f 82 ad 00 00 00    	jb     80101dc1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101d14:	89 c2                	mov    %eax,%edx
80101d16:	29 f2                	sub    %esi,%edx
80101d18:	39 c8                	cmp    %ecx,%eax
80101d1a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d1d:	31 ff                	xor    %edi,%edi
80101d1f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101d21:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d24:	74 6c                	je     80101d92 <readi+0xc2>
80101d26:	8d 76 00             	lea    0x0(%esi),%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d30:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101d33:	89 f2                	mov    %esi,%edx
80101d35:	c1 ea 09             	shr    $0x9,%edx
80101d38:	89 d8                	mov    %ebx,%eax
80101d3a:	e8 11 f9 ff ff       	call   80101650 <bmap>
80101d3f:	83 ec 08             	sub    $0x8,%esp
80101d42:	50                   	push   %eax
80101d43:	ff 33                	pushl  (%ebx)
80101d45:	e8 86 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d4a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d4d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d4f:	89 f0                	mov    %esi,%eax
80101d51:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d56:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d5b:	83 c4 0c             	add    $0xc,%esp
80101d5e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101d60:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101d64:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101d67:	29 fb                	sub    %edi,%ebx
80101d69:	39 d9                	cmp    %ebx,%ecx
80101d6b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101d6e:	53                   	push   %ebx
80101d6f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d70:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101d72:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d75:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101d77:	e8 14 35 00 00       	call   80105290 <memmove>
    brelse(bp);
80101d7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d7f:	89 14 24             	mov    %edx,(%esp)
80101d82:	e8 59 e4 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d87:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d8a:	83 c4 10             	add    $0x10,%esp
80101d8d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101d90:	77 9e                	ja     80101d30 <readi+0x60>
  }
  return n;
80101d92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101d95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d98:	5b                   	pop    %ebx
80101d99:	5e                   	pop    %esi
80101d9a:	5f                   	pop    %edi
80101d9b:	5d                   	pop    %ebp
80101d9c:	c3                   	ret    
80101d9d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101da0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101da4:	66 83 f8 09          	cmp    $0x9,%ax
80101da8:	77 17                	ja     80101dc1 <readi+0xf1>
80101daa:	8b 04 c5 20 1c 11 80 	mov    -0x7feee3e0(,%eax,8),%eax
80101db1:	85 c0                	test   %eax,%eax
80101db3:	74 0c                	je     80101dc1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101db5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101db8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dbb:	5b                   	pop    %ebx
80101dbc:	5e                   	pop    %esi
80101dbd:	5f                   	pop    %edi
80101dbe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101dbf:	ff e0                	jmp    *%eax
      return -1;
80101dc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dc6:	eb cd                	jmp    80101d95 <readi+0xc5>
80101dc8:	90                   	nop
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 1c             	sub    $0x1c,%esp
80101dd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ddc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101ddf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101de2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101de7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101dea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ded:	8b 75 10             	mov    0x10(%ebp),%esi
80101df0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101df3:	0f 84 b7 00 00 00    	je     80101eb0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101df9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101dfc:	39 70 58             	cmp    %esi,0x58(%eax)
80101dff:	0f 82 eb 00 00 00    	jb     80101ef0 <writei+0x120>
80101e05:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101e08:	31 d2                	xor    %edx,%edx
80101e0a:	89 f8                	mov    %edi,%eax
80101e0c:	01 f0                	add    %esi,%eax
80101e0e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101e11:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101e16:	0f 87 d4 00 00 00    	ja     80101ef0 <writei+0x120>
80101e1c:	85 d2                	test   %edx,%edx
80101e1e:	0f 85 cc 00 00 00    	jne    80101ef0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e24:	85 ff                	test   %edi,%edi
80101e26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101e2d:	74 72                	je     80101ea1 <writei+0xd1>
80101e2f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e30:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101e33:	89 f2                	mov    %esi,%edx
80101e35:	c1 ea 09             	shr    $0x9,%edx
80101e38:	89 f8                	mov    %edi,%eax
80101e3a:	e8 11 f8 ff ff       	call   80101650 <bmap>
80101e3f:	83 ec 08             	sub    $0x8,%esp
80101e42:	50                   	push   %eax
80101e43:	ff 37                	pushl  (%edi)
80101e45:	e8 86 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e4a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101e4d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e50:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101e52:	89 f0                	mov    %esi,%eax
80101e54:	b9 00 02 00 00       	mov    $0x200,%ecx
80101e59:	83 c4 0c             	add    $0xc,%esp
80101e5c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e61:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101e63:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101e67:	39 d9                	cmp    %ebx,%ecx
80101e69:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101e6c:	53                   	push   %ebx
80101e6d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e70:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101e72:	50                   	push   %eax
80101e73:	e8 18 34 00 00       	call   80105290 <memmove>
    log_write(bp);
80101e78:	89 3c 24             	mov    %edi,(%esp)
80101e7b:	e8 60 12 00 00       	call   801030e0 <log_write>
    brelse(bp);
80101e80:	89 3c 24             	mov    %edi,(%esp)
80101e83:	e8 58 e3 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e88:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101e8b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e94:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101e97:	77 97                	ja     80101e30 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101e99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e9c:	3b 70 58             	cmp    0x58(%eax),%esi
80101e9f:	77 37                	ja     80101ed8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ea1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ea4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea7:	5b                   	pop    %ebx
80101ea8:	5e                   	pop    %esi
80101ea9:	5f                   	pop    %edi
80101eaa:	5d                   	pop    %ebp
80101eab:	c3                   	ret    
80101eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101eb0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101eb4:	66 83 f8 09          	cmp    $0x9,%ax
80101eb8:	77 36                	ja     80101ef0 <writei+0x120>
80101eba:	8b 04 c5 24 1c 11 80 	mov    -0x7feee3dc(,%eax,8),%eax
80101ec1:	85 c0                	test   %eax,%eax
80101ec3:	74 2b                	je     80101ef0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101ec5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ecb:	5b                   	pop    %ebx
80101ecc:	5e                   	pop    %esi
80101ecd:	5f                   	pop    %edi
80101ece:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101ecf:	ff e0                	jmp    *%eax
80101ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ed8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101edb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101ede:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ee1:	50                   	push   %eax
80101ee2:	e8 59 fa ff ff       	call   80101940 <iupdate>
80101ee7:	83 c4 10             	add    $0x10,%esp
80101eea:	eb b5                	jmp    80101ea1 <writei+0xd1>
80101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ef5:	eb ad                	jmp    80101ea4 <writei+0xd4>
80101ef7:	89 f6                	mov    %esi,%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101f06:	6a 0e                	push   $0xe
80101f08:	ff 75 0c             	pushl  0xc(%ebp)
80101f0b:	ff 75 08             	pushl  0x8(%ebp)
80101f0e:	e8 ed 33 00 00       	call   80105300 <strncmp>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	57                   	push   %edi
80101f24:	56                   	push   %esi
80101f25:	53                   	push   %ebx
80101f26:	83 ec 1c             	sub    $0x1c,%esp
80101f29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101f2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101f31:	0f 85 85 00 00 00    	jne    80101fbc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101f37:	8b 53 58             	mov    0x58(%ebx),%edx
80101f3a:	31 ff                	xor    %edi,%edi
80101f3c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f3f:	85 d2                	test   %edx,%edx
80101f41:	74 3e                	je     80101f81 <dirlookup+0x61>
80101f43:	90                   	nop
80101f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f48:	6a 10                	push   $0x10
80101f4a:	57                   	push   %edi
80101f4b:	56                   	push   %esi
80101f4c:	53                   	push   %ebx
80101f4d:	e8 7e fd ff ff       	call   80101cd0 <readi>
80101f52:	83 c4 10             	add    $0x10,%esp
80101f55:	83 f8 10             	cmp    $0x10,%eax
80101f58:	75 55                	jne    80101faf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101f5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f5f:	74 18                	je     80101f79 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101f61:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f64:	83 ec 04             	sub    $0x4,%esp
80101f67:	6a 0e                	push   $0xe
80101f69:	50                   	push   %eax
80101f6a:	ff 75 0c             	pushl  0xc(%ebp)
80101f6d:	e8 8e 33 00 00       	call   80105300 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	85 c0                	test   %eax,%eax
80101f77:	74 17                	je     80101f90 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f79:	83 c7 10             	add    $0x10,%edi
80101f7c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f7f:	72 c7                	jb     80101f48 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101f81:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101f84:	31 c0                	xor    %eax,%eax
}
80101f86:	5b                   	pop    %ebx
80101f87:	5e                   	pop    %esi
80101f88:	5f                   	pop    %edi
80101f89:	5d                   	pop    %ebp
80101f8a:	c3                   	ret    
80101f8b:	90                   	nop
80101f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101f90:	8b 45 10             	mov    0x10(%ebp),%eax
80101f93:	85 c0                	test   %eax,%eax
80101f95:	74 05                	je     80101f9c <dirlookup+0x7c>
        *poff = off;
80101f97:	8b 45 10             	mov    0x10(%ebp),%eax
80101f9a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101f9c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101fa0:	8b 03                	mov    (%ebx),%eax
80101fa2:	e8 d9 f5 ff ff       	call   80101580 <iget>
}
80101fa7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101faa:	5b                   	pop    %ebx
80101fab:	5e                   	pop    %esi
80101fac:	5f                   	pop    %edi
80101fad:	5d                   	pop    %ebp
80101fae:	c3                   	ret    
      panic("dirlookup read");
80101faf:	83 ec 0c             	sub    $0xc,%esp
80101fb2:	68 b9 7e 10 80       	push   $0x80107eb9
80101fb7:	e8 d4 e3 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101fbc:	83 ec 0c             	sub    $0xc,%esp
80101fbf:	68 a7 7e 10 80       	push   $0x80107ea7
80101fc4:	e8 c7 e3 ff ff       	call   80100390 <panic>
80101fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fd0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	57                   	push   %edi
80101fd4:	56                   	push   %esi
80101fd5:	53                   	push   %ebx
80101fd6:	89 cf                	mov    %ecx,%edi
80101fd8:	89 c3                	mov    %eax,%ebx
80101fda:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101fdd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101fe0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101fe3:	0f 84 67 01 00 00    	je     80102150 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101fe9:	e8 b2 1b 00 00       	call   80103ba0 <myproc>
  acquire(&icache.lock);
80101fee:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ff1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ff4:	68 a0 1c 11 80       	push   $0x80111ca0
80101ff9:	e8 d2 30 00 00       	call   801050d0 <acquire>
  ip->ref++;
80101ffe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102002:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80102009:	e8 82 31 00 00       	call   80105190 <release>
8010200e:	83 c4 10             	add    $0x10,%esp
80102011:	eb 08                	jmp    8010201b <namex+0x4b>
80102013:	90                   	nop
80102014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102018:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010201b:	0f b6 03             	movzbl (%ebx),%eax
8010201e:	3c 2f                	cmp    $0x2f,%al
80102020:	74 f6                	je     80102018 <namex+0x48>
  if(*path == 0)
80102022:	84 c0                	test   %al,%al
80102024:	0f 84 ee 00 00 00    	je     80102118 <namex+0x148>
  while(*path != '/' && *path != 0)
8010202a:	0f b6 03             	movzbl (%ebx),%eax
8010202d:	3c 2f                	cmp    $0x2f,%al
8010202f:	0f 84 b3 00 00 00    	je     801020e8 <namex+0x118>
80102035:	84 c0                	test   %al,%al
80102037:	89 da                	mov    %ebx,%edx
80102039:	75 09                	jne    80102044 <namex+0x74>
8010203b:	e9 a8 00 00 00       	jmp    801020e8 <namex+0x118>
80102040:	84 c0                	test   %al,%al
80102042:	74 0a                	je     8010204e <namex+0x7e>
    path++;
80102044:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80102047:	0f b6 02             	movzbl (%edx),%eax
8010204a:	3c 2f                	cmp    $0x2f,%al
8010204c:	75 f2                	jne    80102040 <namex+0x70>
8010204e:	89 d1                	mov    %edx,%ecx
80102050:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80102052:	83 f9 0d             	cmp    $0xd,%ecx
80102055:	0f 8e 91 00 00 00    	jle    801020ec <namex+0x11c>
    memmove(name, s, DIRSIZ);
8010205b:	83 ec 04             	sub    $0x4,%esp
8010205e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102061:	6a 0e                	push   $0xe
80102063:	53                   	push   %ebx
80102064:	57                   	push   %edi
80102065:	e8 26 32 00 00       	call   80105290 <memmove>
    path++;
8010206a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
8010206d:	83 c4 10             	add    $0x10,%esp
    path++;
80102070:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80102072:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102075:	75 11                	jne    80102088 <namex+0xb8>
80102077:	89 f6                	mov    %esi,%esi
80102079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80102080:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102083:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102086:	74 f8                	je     80102080 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102088:	83 ec 0c             	sub    $0xc,%esp
8010208b:	56                   	push   %esi
8010208c:	e8 5f f9 ff ff       	call   801019f0 <ilock>
    if(ip->type != T_DIR){
80102091:	83 c4 10             	add    $0x10,%esp
80102094:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102099:	0f 85 91 00 00 00    	jne    80102130 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
8010209f:	8b 55 e0             	mov    -0x20(%ebp),%edx
801020a2:	85 d2                	test   %edx,%edx
801020a4:	74 09                	je     801020af <namex+0xdf>
801020a6:	80 3b 00             	cmpb   $0x0,(%ebx)
801020a9:	0f 84 b7 00 00 00    	je     80102166 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801020af:	83 ec 04             	sub    $0x4,%esp
801020b2:	6a 00                	push   $0x0
801020b4:	57                   	push   %edi
801020b5:	56                   	push   %esi
801020b6:	e8 65 fe ff ff       	call   80101f20 <dirlookup>
801020bb:	83 c4 10             	add    $0x10,%esp
801020be:	85 c0                	test   %eax,%eax
801020c0:	74 6e                	je     80102130 <namex+0x160>
  iunlock(ip);
801020c2:	83 ec 0c             	sub    $0xc,%esp
801020c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801020c8:	56                   	push   %esi
801020c9:	e8 02 fa ff ff       	call   80101ad0 <iunlock>
  iput(ip);
801020ce:	89 34 24             	mov    %esi,(%esp)
801020d1:	e8 4a fa ff ff       	call   80101b20 <iput>
801020d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020d9:	83 c4 10             	add    $0x10,%esp
801020dc:	89 c6                	mov    %eax,%esi
801020de:	e9 38 ff ff ff       	jmp    8010201b <namex+0x4b>
801020e3:	90                   	nop
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
801020e8:	89 da                	mov    %ebx,%edx
801020ea:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
801020ec:	83 ec 04             	sub    $0x4,%esp
801020ef:	89 55 dc             	mov    %edx,-0x24(%ebp)
801020f2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801020f5:	51                   	push   %ecx
801020f6:	53                   	push   %ebx
801020f7:	57                   	push   %edi
801020f8:	e8 93 31 00 00       	call   80105290 <memmove>
    name[len] = 0;
801020fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102100:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102103:	83 c4 10             	add    $0x10,%esp
80102106:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
8010210a:	89 d3                	mov    %edx,%ebx
8010210c:	e9 61 ff ff ff       	jmp    80102072 <namex+0xa2>
80102111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102118:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010211b:	85 c0                	test   %eax,%eax
8010211d:	75 5d                	jne    8010217c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
8010211f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102122:	89 f0                	mov    %esi,%eax
80102124:	5b                   	pop    %ebx
80102125:	5e                   	pop    %esi
80102126:	5f                   	pop    %edi
80102127:	5d                   	pop    %ebp
80102128:	c3                   	ret    
80102129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	56                   	push   %esi
80102134:	e8 97 f9 ff ff       	call   80101ad0 <iunlock>
  iput(ip);
80102139:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010213c:	31 f6                	xor    %esi,%esi
  iput(ip);
8010213e:	e8 dd f9 ff ff       	call   80101b20 <iput>
      return 0;
80102143:	83 c4 10             	add    $0x10,%esp
}
80102146:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102149:	89 f0                	mov    %esi,%eax
8010214b:	5b                   	pop    %ebx
8010214c:	5e                   	pop    %esi
8010214d:	5f                   	pop    %edi
8010214e:	5d                   	pop    %ebp
8010214f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80102150:	ba 01 00 00 00       	mov    $0x1,%edx
80102155:	b8 01 00 00 00       	mov    $0x1,%eax
8010215a:	e8 21 f4 ff ff       	call   80101580 <iget>
8010215f:	89 c6                	mov    %eax,%esi
80102161:	e9 b5 fe ff ff       	jmp    8010201b <namex+0x4b>
      iunlock(ip);
80102166:	83 ec 0c             	sub    $0xc,%esp
80102169:	56                   	push   %esi
8010216a:	e8 61 f9 ff ff       	call   80101ad0 <iunlock>
      return ip;
8010216f:	83 c4 10             	add    $0x10,%esp
}
80102172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102175:	89 f0                	mov    %esi,%eax
80102177:	5b                   	pop    %ebx
80102178:	5e                   	pop    %esi
80102179:	5f                   	pop    %edi
8010217a:	5d                   	pop    %ebp
8010217b:	c3                   	ret    
    iput(ip);
8010217c:	83 ec 0c             	sub    $0xc,%esp
8010217f:	56                   	push   %esi
    return 0;
80102180:	31 f6                	xor    %esi,%esi
    iput(ip);
80102182:	e8 99 f9 ff ff       	call   80101b20 <iput>
    return 0;
80102187:	83 c4 10             	add    $0x10,%esp
8010218a:	eb 93                	jmp    8010211f <namex+0x14f>
8010218c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102190 <dirlink>:
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	57                   	push   %edi
80102194:	56                   	push   %esi
80102195:	53                   	push   %ebx
80102196:	83 ec 20             	sub    $0x20,%esp
80102199:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010219c:	6a 00                	push   $0x0
8010219e:	ff 75 0c             	pushl  0xc(%ebp)
801021a1:	53                   	push   %ebx
801021a2:	e8 79 fd ff ff       	call   80101f20 <dirlookup>
801021a7:	83 c4 10             	add    $0x10,%esp
801021aa:	85 c0                	test   %eax,%eax
801021ac:	75 67                	jne    80102215 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021ae:	8b 7b 58             	mov    0x58(%ebx),%edi
801021b1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021b4:	85 ff                	test   %edi,%edi
801021b6:	74 29                	je     801021e1 <dirlink+0x51>
801021b8:	31 ff                	xor    %edi,%edi
801021ba:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021bd:	eb 09                	jmp    801021c8 <dirlink+0x38>
801021bf:	90                   	nop
801021c0:	83 c7 10             	add    $0x10,%edi
801021c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021c6:	73 19                	jae    801021e1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021c8:	6a 10                	push   $0x10
801021ca:	57                   	push   %edi
801021cb:	56                   	push   %esi
801021cc:	53                   	push   %ebx
801021cd:	e8 fe fa ff ff       	call   80101cd0 <readi>
801021d2:	83 c4 10             	add    $0x10,%esp
801021d5:	83 f8 10             	cmp    $0x10,%eax
801021d8:	75 4e                	jne    80102228 <dirlink+0x98>
    if(de.inum == 0)
801021da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021df:	75 df                	jne    801021c0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801021e1:	8d 45 da             	lea    -0x26(%ebp),%eax
801021e4:	83 ec 04             	sub    $0x4,%esp
801021e7:	6a 0e                	push   $0xe
801021e9:	ff 75 0c             	pushl  0xc(%ebp)
801021ec:	50                   	push   %eax
801021ed:	e8 6e 31 00 00       	call   80105360 <strncpy>
  de.inum = inum;
801021f2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021f5:	6a 10                	push   $0x10
801021f7:	57                   	push   %edi
801021f8:	56                   	push   %esi
801021f9:	53                   	push   %ebx
  de.inum = inum;
801021fa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021fe:	e8 cd fb ff ff       	call   80101dd0 <writei>
80102203:	83 c4 20             	add    $0x20,%esp
80102206:	83 f8 10             	cmp    $0x10,%eax
80102209:	75 2a                	jne    80102235 <dirlink+0xa5>
  return 0;
8010220b:	31 c0                	xor    %eax,%eax
}
8010220d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102210:	5b                   	pop    %ebx
80102211:	5e                   	pop    %esi
80102212:	5f                   	pop    %edi
80102213:	5d                   	pop    %ebp
80102214:	c3                   	ret    
    iput(ip);
80102215:	83 ec 0c             	sub    $0xc,%esp
80102218:	50                   	push   %eax
80102219:	e8 02 f9 ff ff       	call   80101b20 <iput>
    return -1;
8010221e:	83 c4 10             	add    $0x10,%esp
80102221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102226:	eb e5                	jmp    8010220d <dirlink+0x7d>
      panic("dirlink read");
80102228:	83 ec 0c             	sub    $0xc,%esp
8010222b:	68 c8 7e 10 80       	push   $0x80107ec8
80102230:	e8 5b e1 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102235:	83 ec 0c             	sub    $0xc,%esp
80102238:	68 5a 86 10 80       	push   $0x8010865a
8010223d:	e8 4e e1 ff ff       	call   80100390 <panic>
80102242:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102250 <namei>:

struct inode*
namei(char *path)
{
80102250:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102251:	31 d2                	xor    %edx,%edx
{
80102253:	89 e5                	mov    %esp,%ebp
80102255:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102258:	8b 45 08             	mov    0x8(%ebp),%eax
8010225b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010225e:	e8 6d fd ff ff       	call   80101fd0 <namex>
}
80102263:	c9                   	leave  
80102264:	c3                   	ret    
80102265:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102270 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102270:	55                   	push   %ebp
  return namex(path, 1, name);
80102271:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102276:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102278:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010227b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010227e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010227f:	e9 4c fd ff ff       	jmp    80101fd0 <namex>
80102284:	66 90                	xchg   %ax,%ax
80102286:	66 90                	xchg   %ax,%ax
80102288:	66 90                	xchg   %ax,%ax
8010228a:	66 90                	xchg   %ax,%ax
8010228c:	66 90                	xchg   %ax,%ax
8010228e:	66 90                	xchg   %ax,%ax

80102290 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	57                   	push   %edi
80102294:	56                   	push   %esi
80102295:	53                   	push   %ebx
80102296:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102299:	85 c0                	test   %eax,%eax
8010229b:	0f 84 b4 00 00 00    	je     80102355 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801022a1:	8b 58 08             	mov    0x8(%eax),%ebx
801022a4:	89 c6                	mov    %eax,%esi
801022a6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801022ac:	0f 87 96 00 00 00    	ja     80102348 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801022c0:	89 ca                	mov    %ecx,%edx
801022c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022c3:	83 e0 c0             	and    $0xffffffc0,%eax
801022c6:	3c 40                	cmp    $0x40,%al
801022c8:	75 f6                	jne    801022c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022ca:	31 ff                	xor    %edi,%edi
801022cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801022d1:	89 f8                	mov    %edi,%eax
801022d3:	ee                   	out    %al,(%dx)
801022d4:	b8 01 00 00 00       	mov    $0x1,%eax
801022d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801022de:	ee                   	out    %al,(%dx)
801022df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801022e4:	89 d8                	mov    %ebx,%eax
801022e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801022e7:	89 d8                	mov    %ebx,%eax
801022e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801022ee:	c1 f8 08             	sar    $0x8,%eax
801022f1:	ee                   	out    %al,(%dx)
801022f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801022f7:	89 f8                	mov    %edi,%eax
801022f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801022fa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801022fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102303:	c1 e0 04             	shl    $0x4,%eax
80102306:	83 e0 10             	and    $0x10,%eax
80102309:	83 c8 e0             	or     $0xffffffe0,%eax
8010230c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010230d:	f6 06 04             	testb  $0x4,(%esi)
80102310:	75 16                	jne    80102328 <idestart+0x98>
80102312:	b8 20 00 00 00       	mov    $0x20,%eax
80102317:	89 ca                	mov    %ecx,%edx
80102319:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010231a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010231d:	5b                   	pop    %ebx
8010231e:	5e                   	pop    %esi
8010231f:	5f                   	pop    %edi
80102320:	5d                   	pop    %ebp
80102321:	c3                   	ret    
80102322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102328:	b8 30 00 00 00       	mov    $0x30,%eax
8010232d:	89 ca                	mov    %ecx,%edx
8010232f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102330:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102335:	83 c6 5c             	add    $0x5c,%esi
80102338:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010233d:	fc                   	cld    
8010233e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102340:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102343:	5b                   	pop    %ebx
80102344:	5e                   	pop    %esi
80102345:	5f                   	pop    %edi
80102346:	5d                   	pop    %ebp
80102347:	c3                   	ret    
    panic("incorrect blockno");
80102348:	83 ec 0c             	sub    $0xc,%esp
8010234b:	68 34 7f 10 80       	push   $0x80107f34
80102350:	e8 3b e0 ff ff       	call   80100390 <panic>
    panic("idestart");
80102355:	83 ec 0c             	sub    $0xc,%esp
80102358:	68 2b 7f 10 80       	push   $0x80107f2b
8010235d:	e8 2e e0 ff ff       	call   80100390 <panic>
80102362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102370 <ideinit>:
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102376:	68 46 7f 10 80       	push   $0x80107f46
8010237b:	68 c0 b5 10 80       	push   $0x8010b5c0
80102380:	e8 0b 2c 00 00       	call   80104f90 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102385:	58                   	pop    %eax
80102386:	a1 c0 3f 11 80       	mov    0x80113fc0,%eax
8010238b:	5a                   	pop    %edx
8010238c:	83 e8 01             	sub    $0x1,%eax
8010238f:	50                   	push   %eax
80102390:	6a 0e                	push   $0xe
80102392:	e8 a9 02 00 00       	call   80102640 <ioapicenable>
80102397:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010239a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010239f:	90                   	nop
801023a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023a1:	83 e0 c0             	and    $0xffffffc0,%eax
801023a4:	3c 40                	cmp    $0x40,%al
801023a6:	75 f8                	jne    801023a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023a8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801023ad:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023b2:	ee                   	out    %al,(%dx)
801023b3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023bd:	eb 06                	jmp    801023c5 <ideinit+0x55>
801023bf:	90                   	nop
  for(i=0; i<1000; i++){
801023c0:	83 e9 01             	sub    $0x1,%ecx
801023c3:	74 0f                	je     801023d4 <ideinit+0x64>
801023c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801023c6:	84 c0                	test   %al,%al
801023c8:	74 f6                	je     801023c0 <ideinit+0x50>
      havedisk1 = 1;
801023ca:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801023d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801023d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023de:	ee                   	out    %al,(%dx)
}
801023df:	c9                   	leave  
801023e0:	c3                   	ret    
801023e1:	eb 0d                	jmp    801023f0 <ideintr>
801023e3:	90                   	nop
801023e4:	90                   	nop
801023e5:	90                   	nop
801023e6:	90                   	nop
801023e7:	90                   	nop
801023e8:	90                   	nop
801023e9:	90                   	nop
801023ea:	90                   	nop
801023eb:	90                   	nop
801023ec:	90                   	nop
801023ed:	90                   	nop
801023ee:	90                   	nop
801023ef:	90                   	nop

801023f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	57                   	push   %edi
801023f4:	56                   	push   %esi
801023f5:	53                   	push   %ebx
801023f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801023f9:	68 c0 b5 10 80       	push   $0x8010b5c0
801023fe:	e8 cd 2c 00 00       	call   801050d0 <acquire>

  if((b = idequeue) == 0){
80102403:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
80102409:	83 c4 10             	add    $0x10,%esp
8010240c:	85 db                	test   %ebx,%ebx
8010240e:	74 67                	je     80102477 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102410:	8b 43 58             	mov    0x58(%ebx),%eax
80102413:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102418:	8b 3b                	mov    (%ebx),%edi
8010241a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102420:	75 31                	jne    80102453 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102422:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102427:	89 f6                	mov    %esi,%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102430:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102431:	89 c6                	mov    %eax,%esi
80102433:	83 e6 c0             	and    $0xffffffc0,%esi
80102436:	89 f1                	mov    %esi,%ecx
80102438:	80 f9 40             	cmp    $0x40,%cl
8010243b:	75 f3                	jne    80102430 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010243d:	a8 21                	test   $0x21,%al
8010243f:	75 12                	jne    80102453 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102441:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102444:	b9 80 00 00 00       	mov    $0x80,%ecx
80102449:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010244e:	fc                   	cld    
8010244f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102451:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102453:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102456:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102459:	89 f9                	mov    %edi,%ecx
8010245b:	83 c9 02             	or     $0x2,%ecx
8010245e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102460:	53                   	push   %ebx
80102461:	e8 fa 1d 00 00       	call   80104260 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102466:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
8010246b:	83 c4 10             	add    $0x10,%esp
8010246e:	85 c0                	test   %eax,%eax
80102470:	74 05                	je     80102477 <ideintr+0x87>
    idestart(idequeue);
80102472:	e8 19 fe ff ff       	call   80102290 <idestart>
    release(&idelock);
80102477:	83 ec 0c             	sub    $0xc,%esp
8010247a:	68 c0 b5 10 80       	push   $0x8010b5c0
8010247f:	e8 0c 2d 00 00       	call   80105190 <release>

  release(&idelock);
}
80102484:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102487:	5b                   	pop    %ebx
80102488:	5e                   	pop    %esi
80102489:	5f                   	pop    %edi
8010248a:	5d                   	pop    %ebp
8010248b:	c3                   	ret    
8010248c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102490 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 10             	sub    $0x10,%esp
80102497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010249a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010249d:	50                   	push   %eax
8010249e:	e8 9d 2a 00 00       	call   80104f40 <holdingsleep>
801024a3:	83 c4 10             	add    $0x10,%esp
801024a6:	85 c0                	test   %eax,%eax
801024a8:	0f 84 c6 00 00 00    	je     80102574 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801024ae:	8b 03                	mov    (%ebx),%eax
801024b0:	83 e0 06             	and    $0x6,%eax
801024b3:	83 f8 02             	cmp    $0x2,%eax
801024b6:	0f 84 ab 00 00 00    	je     80102567 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801024bc:	8b 53 04             	mov    0x4(%ebx),%edx
801024bf:	85 d2                	test   %edx,%edx
801024c1:	74 0d                	je     801024d0 <iderw+0x40>
801024c3:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
801024c8:	85 c0                	test   %eax,%eax
801024ca:	0f 84 b1 00 00 00    	je     80102581 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 c0 b5 10 80       	push   $0x8010b5c0
801024d8:	e8 f3 2b 00 00       	call   801050d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024dd:	8b 15 a4 b5 10 80    	mov    0x8010b5a4,%edx
801024e3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801024e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024ed:	85 d2                	test   %edx,%edx
801024ef:	75 09                	jne    801024fa <iderw+0x6a>
801024f1:	eb 6d                	jmp    80102560 <iderw+0xd0>
801024f3:	90                   	nop
801024f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024f8:	89 c2                	mov    %eax,%edx
801024fa:	8b 42 58             	mov    0x58(%edx),%eax
801024fd:	85 c0                	test   %eax,%eax
801024ff:	75 f7                	jne    801024f8 <iderw+0x68>
80102501:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102504:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102506:	39 1d a4 b5 10 80    	cmp    %ebx,0x8010b5a4
8010250c:	74 42                	je     80102550 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010250e:	8b 03                	mov    (%ebx),%eax
80102510:	83 e0 06             	and    $0x6,%eax
80102513:	83 f8 02             	cmp    $0x2,%eax
80102516:	74 23                	je     8010253b <iderw+0xab>
80102518:	90                   	nop
80102519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102520:	83 ec 08             	sub    $0x8,%esp
80102523:	68 c0 b5 10 80       	push   $0x8010b5c0
80102528:	53                   	push   %ebx
80102529:	e8 72 1b 00 00       	call   801040a0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010252e:	8b 03                	mov    (%ebx),%eax
80102530:	83 c4 10             	add    $0x10,%esp
80102533:	83 e0 06             	and    $0x6,%eax
80102536:	83 f8 02             	cmp    $0x2,%eax
80102539:	75 e5                	jne    80102520 <iderw+0x90>
  }


  release(&idelock);
8010253b:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80102542:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102545:	c9                   	leave  
  release(&idelock);
80102546:	e9 45 2c 00 00       	jmp    80105190 <release>
8010254b:	90                   	nop
8010254c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102550:	89 d8                	mov    %ebx,%eax
80102552:	e8 39 fd ff ff       	call   80102290 <idestart>
80102557:	eb b5                	jmp    8010250e <iderw+0x7e>
80102559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102560:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
80102565:	eb 9d                	jmp    80102504 <iderw+0x74>
    panic("iderw: nothing to do");
80102567:	83 ec 0c             	sub    $0xc,%esp
8010256a:	68 60 7f 10 80       	push   $0x80107f60
8010256f:	e8 1c de ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102574:	83 ec 0c             	sub    $0xc,%esp
80102577:	68 4a 7f 10 80       	push   $0x80107f4a
8010257c:	e8 0f de ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102581:	83 ec 0c             	sub    $0xc,%esp
80102584:	68 75 7f 10 80       	push   $0x80107f75
80102589:	e8 02 de ff ff       	call   80100390 <panic>
8010258e:	66 90                	xchg   %ax,%ax

80102590 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102590:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102591:	c7 05 f4 38 11 80 00 	movl   $0xfec00000,0x801138f4
80102598:	00 c0 fe 
{
8010259b:	89 e5                	mov    %esp,%ebp
8010259d:	56                   	push   %esi
8010259e:	53                   	push   %ebx
  ioapic->reg = reg;
8010259f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801025a6:	00 00 00 
  return ioapic->data;
801025a9:	a1 f4 38 11 80       	mov    0x801138f4,%eax
801025ae:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801025b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801025b7:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801025bd:	0f b6 15 20 3a 11 80 	movzbl 0x80113a20,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025c4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801025c7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025ca:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801025cd:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801025d0:	39 c2                	cmp    %eax,%edx
801025d2:	74 16                	je     801025ea <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801025d4:	83 ec 0c             	sub    $0xc,%esp
801025d7:	68 94 7f 10 80       	push   $0x80107f94
801025dc:	e8 7f e0 ff ff       	call   80100660 <cprintf>
801025e1:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
801025e7:	83 c4 10             	add    $0x10,%esp
801025ea:	83 c3 21             	add    $0x21,%ebx
{
801025ed:	ba 10 00 00 00       	mov    $0x10,%edx
801025f2:	b8 20 00 00 00       	mov    $0x20,%eax
801025f7:	89 f6                	mov    %esi,%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102600:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102602:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102608:	89 c6                	mov    %eax,%esi
8010260a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102610:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102613:	89 71 10             	mov    %esi,0x10(%ecx)
80102616:	8d 72 01             	lea    0x1(%edx),%esi
80102619:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010261c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010261e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102620:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
80102626:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010262d:	75 d1                	jne    80102600 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010262f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102632:	5b                   	pop    %ebx
80102633:	5e                   	pop    %esi
80102634:	5d                   	pop    %ebp
80102635:	c3                   	ret    
80102636:	8d 76 00             	lea    0x0(%esi),%esi
80102639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102640 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102640:	55                   	push   %ebp
  ioapic->reg = reg;
80102641:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
{
80102647:	89 e5                	mov    %esp,%ebp
80102649:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010264c:	8d 50 20             	lea    0x20(%eax),%edx
8010264f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102653:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102655:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010265b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010265e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102661:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102664:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102666:	a1 f4 38 11 80       	mov    0x801138f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010266b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010266e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	66 90                	xchg   %ax,%ax
80102675:	66 90                	xchg   %ax,%ax
80102677:	66 90                	xchg   %ax,%ax
80102679:	66 90                	xchg   %ax,%ax
8010267b:	66 90                	xchg   %ax,%ax
8010267d:	66 90                	xchg   %ax,%ax
8010267f:	90                   	nop

80102680 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	53                   	push   %ebx
80102684:	83 ec 04             	sub    $0x4,%esp
80102687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010268a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102690:	75 70                	jne    80102702 <kfree+0x82>
80102692:	81 fb 88 6d 11 80    	cmp    $0x80116d88,%ebx
80102698:	72 68                	jb     80102702 <kfree+0x82>
8010269a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801026a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801026a5:	77 5b                	ja     80102702 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801026a7:	83 ec 04             	sub    $0x4,%esp
801026aa:	68 00 10 00 00       	push   $0x1000
801026af:	6a 01                	push   $0x1
801026b1:	53                   	push   %ebx
801026b2:	e8 29 2b 00 00       	call   801051e0 <memset>

  if(kmem.use_lock)
801026b7:	8b 15 34 39 11 80    	mov    0x80113934,%edx
801026bd:	83 c4 10             	add    $0x10,%esp
801026c0:	85 d2                	test   %edx,%edx
801026c2:	75 2c                	jne    801026f0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801026c4:	a1 38 39 11 80       	mov    0x80113938,%eax
801026c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801026cb:	a1 34 39 11 80       	mov    0x80113934,%eax
  kmem.freelist = r;
801026d0:	89 1d 38 39 11 80    	mov    %ebx,0x80113938
  if(kmem.use_lock)
801026d6:	85 c0                	test   %eax,%eax
801026d8:	75 06                	jne    801026e0 <kfree+0x60>
    release(&kmem.lock);
}
801026da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026dd:	c9                   	leave  
801026de:	c3                   	ret    
801026df:	90                   	nop
    release(&kmem.lock);
801026e0:	c7 45 08 00 39 11 80 	movl   $0x80113900,0x8(%ebp)
}
801026e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026ea:	c9                   	leave  
    release(&kmem.lock);
801026eb:	e9 a0 2a 00 00       	jmp    80105190 <release>
    acquire(&kmem.lock);
801026f0:	83 ec 0c             	sub    $0xc,%esp
801026f3:	68 00 39 11 80       	push   $0x80113900
801026f8:	e8 d3 29 00 00       	call   801050d0 <acquire>
801026fd:	83 c4 10             	add    $0x10,%esp
80102700:	eb c2                	jmp    801026c4 <kfree+0x44>
    panic("kfree");
80102702:	83 ec 0c             	sub    $0xc,%esp
80102705:	68 c6 7f 10 80       	push   $0x80107fc6
8010270a:	e8 81 dc ff ff       	call   80100390 <panic>
8010270f:	90                   	nop

80102710 <freerange>:
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	56                   	push   %esi
80102714:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102715:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102718:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010271b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102721:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102727:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010272d:	39 de                	cmp    %ebx,%esi
8010272f:	72 23                	jb     80102754 <freerange+0x44>
80102731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102738:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010273e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102741:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102747:	50                   	push   %eax
80102748:	e8 33 ff ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010274d:	83 c4 10             	add    $0x10,%esp
80102750:	39 f3                	cmp    %esi,%ebx
80102752:	76 e4                	jbe    80102738 <freerange+0x28>
}
80102754:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102757:	5b                   	pop    %ebx
80102758:	5e                   	pop    %esi
80102759:	5d                   	pop    %ebp
8010275a:	c3                   	ret    
8010275b:	90                   	nop
8010275c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102760 <kinit1>:
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	56                   	push   %esi
80102764:	53                   	push   %ebx
80102765:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102768:	83 ec 08             	sub    $0x8,%esp
8010276b:	68 cc 7f 10 80       	push   $0x80107fcc
80102770:	68 00 39 11 80       	push   $0x80113900
80102775:	e8 16 28 00 00       	call   80104f90 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010277a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010277d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102780:	c7 05 34 39 11 80 00 	movl   $0x0,0x80113934
80102787:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010278a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102790:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102796:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010279c:	39 de                	cmp    %ebx,%esi
8010279e:	72 1c                	jb     801027bc <kinit1+0x5c>
    kfree(p);
801027a0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801027a6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027af:	50                   	push   %eax
801027b0:	e8 cb fe ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027b5:	83 c4 10             	add    $0x10,%esp
801027b8:	39 de                	cmp    %ebx,%esi
801027ba:	73 e4                	jae    801027a0 <kinit1+0x40>
}
801027bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027bf:	5b                   	pop    %ebx
801027c0:	5e                   	pop    %esi
801027c1:	5d                   	pop    %ebp
801027c2:	c3                   	ret    
801027c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027d0 <kinit2>:
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	56                   	push   %esi
801027d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801027d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801027d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801027db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027ed:	39 de                	cmp    %ebx,%esi
801027ef:	72 23                	jb     80102814 <kinit2+0x44>
801027f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801027f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801027fe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102801:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102807:	50                   	push   %eax
80102808:	e8 73 fe ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010280d:	83 c4 10             	add    $0x10,%esp
80102810:	39 de                	cmp    %ebx,%esi
80102812:	73 e4                	jae    801027f8 <kinit2+0x28>
  kmem.use_lock = 1;
80102814:	c7 05 34 39 11 80 01 	movl   $0x1,0x80113934
8010281b:	00 00 00 
}
8010281e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102821:	5b                   	pop    %ebx
80102822:	5e                   	pop    %esi
80102823:	5d                   	pop    %ebp
80102824:	c3                   	ret    
80102825:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102830:	a1 34 39 11 80       	mov    0x80113934,%eax
80102835:	85 c0                	test   %eax,%eax
80102837:	75 1f                	jne    80102858 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102839:	a1 38 39 11 80       	mov    0x80113938,%eax
  if(r)
8010283e:	85 c0                	test   %eax,%eax
80102840:	74 0e                	je     80102850 <kalloc+0x20>
    kmem.freelist = r->next;
80102842:	8b 10                	mov    (%eax),%edx
80102844:	89 15 38 39 11 80    	mov    %edx,0x80113938
8010284a:	c3                   	ret    
8010284b:	90                   	nop
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102850:	f3 c3                	repz ret 
80102852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102858:	55                   	push   %ebp
80102859:	89 e5                	mov    %esp,%ebp
8010285b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010285e:	68 00 39 11 80       	push   $0x80113900
80102863:	e8 68 28 00 00       	call   801050d0 <acquire>
  r = kmem.freelist;
80102868:	a1 38 39 11 80       	mov    0x80113938,%eax
  if(r)
8010286d:	83 c4 10             	add    $0x10,%esp
80102870:	8b 15 34 39 11 80    	mov    0x80113934,%edx
80102876:	85 c0                	test   %eax,%eax
80102878:	74 08                	je     80102882 <kalloc+0x52>
    kmem.freelist = r->next;
8010287a:	8b 08                	mov    (%eax),%ecx
8010287c:	89 0d 38 39 11 80    	mov    %ecx,0x80113938
  if(kmem.use_lock)
80102882:	85 d2                	test   %edx,%edx
80102884:	74 16                	je     8010289c <kalloc+0x6c>
    release(&kmem.lock);
80102886:	83 ec 0c             	sub    $0xc,%esp
80102889:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010288c:	68 00 39 11 80       	push   $0x80113900
80102891:	e8 fa 28 00 00       	call   80105190 <release>
  return (char*)r;
80102896:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102899:	83 c4 10             	add    $0x10,%esp
}
8010289c:	c9                   	leave  
8010289d:	c3                   	ret    
8010289e:	66 90                	xchg   %ax,%ax

801028a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a0:	ba 64 00 00 00       	mov    $0x64,%edx
801028a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801028a6:	a8 01                	test   $0x1,%al
801028a8:	0f 84 c2 00 00 00    	je     80102970 <kbdgetc+0xd0>
801028ae:	ba 60 00 00 00       	mov    $0x60,%edx
801028b3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801028b4:	0f b6 d0             	movzbl %al,%edx
801028b7:	8b 0d f4 b5 10 80    	mov    0x8010b5f4,%ecx

  if(data == 0xE0){
801028bd:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801028c3:	0f 84 7f 00 00 00    	je     80102948 <kbdgetc+0xa8>
{
801028c9:	55                   	push   %ebp
801028ca:	89 e5                	mov    %esp,%ebp
801028cc:	53                   	push   %ebx
801028cd:	89 cb                	mov    %ecx,%ebx
801028cf:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801028d2:	84 c0                	test   %al,%al
801028d4:	78 4a                	js     80102920 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801028d6:	85 db                	test   %ebx,%ebx
801028d8:	74 09                	je     801028e3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801028da:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801028dd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801028e0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801028e3:	0f b6 82 00 81 10 80 	movzbl -0x7fef7f00(%edx),%eax
801028ea:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801028ec:	0f b6 82 00 80 10 80 	movzbl -0x7fef8000(%edx),%eax
801028f3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801028f5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801028f7:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
801028fd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102900:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102903:	8b 04 85 e0 7f 10 80 	mov    -0x7fef8020(,%eax,4),%eax
8010290a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010290e:	74 31                	je     80102941 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102910:	8d 50 9f             	lea    -0x61(%eax),%edx
80102913:	83 fa 19             	cmp    $0x19,%edx
80102916:	77 40                	ja     80102958 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102918:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010291b:	5b                   	pop    %ebx
8010291c:	5d                   	pop    %ebp
8010291d:	c3                   	ret    
8010291e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102920:	83 e0 7f             	and    $0x7f,%eax
80102923:	85 db                	test   %ebx,%ebx
80102925:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102928:	0f b6 82 00 81 10 80 	movzbl -0x7fef7f00(%edx),%eax
8010292f:	83 c8 40             	or     $0x40,%eax
80102932:	0f b6 c0             	movzbl %al,%eax
80102935:	f7 d0                	not    %eax
80102937:	21 c1                	and    %eax,%ecx
    return 0;
80102939:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010293b:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
}
80102941:	5b                   	pop    %ebx
80102942:	5d                   	pop    %ebp
80102943:	c3                   	ret    
80102944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102948:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010294b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010294d:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
    return 0;
80102953:	c3                   	ret    
80102954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102958:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010295b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010295e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010295f:	83 f9 1a             	cmp    $0x1a,%ecx
80102962:	0f 42 c2             	cmovb  %edx,%eax
}
80102965:	5d                   	pop    %ebp
80102966:	c3                   	ret    
80102967:	89 f6                	mov    %esi,%esi
80102969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102975:	c3                   	ret    
80102976:	8d 76 00             	lea    0x0(%esi),%esi
80102979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102980 <kbdintr>:

void
kbdintr(void)
{
80102980:	55                   	push   %ebp
80102981:	89 e5                	mov    %esp,%ebp
80102983:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102986:	68 a0 28 10 80       	push   $0x801028a0
8010298b:	e8 50 e1 ff ff       	call   80100ae0 <consoleintr>
}
80102990:	83 c4 10             	add    $0x10,%esp
80102993:	c9                   	leave  
80102994:	c3                   	ret    
80102995:	66 90                	xchg   %ax,%ax
80102997:	66 90                	xchg   %ax,%ax
80102999:	66 90                	xchg   %ax,%ax
8010299b:	66 90                	xchg   %ax,%ax
8010299d:	66 90                	xchg   %ax,%ax
8010299f:	90                   	nop

801029a0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801029a0:	a1 3c 39 11 80       	mov    0x8011393c,%eax
{
801029a5:	55                   	push   %ebp
801029a6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801029a8:	85 c0                	test   %eax,%eax
801029aa:	0f 84 c8 00 00 00    	je     80102a78 <lapicinit+0xd8>
  lapic[index] = value;
801029b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801029b7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801029c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801029d1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801029d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801029de:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801029e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801029eb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801029f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801029fe:	8b 50 30             	mov    0x30(%eax),%edx
80102a01:	c1 ea 10             	shr    $0x10,%edx
80102a04:	80 fa 03             	cmp    $0x3,%dl
80102a07:	77 77                	ja     80102a80 <lapicinit+0xe0>
  lapic[index] = value;
80102a09:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a10:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a13:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a16:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a1d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a20:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a23:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a2a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a2d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a30:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a37:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a3d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a44:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a47:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a4a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a51:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a54:	8b 50 20             	mov    0x20(%eax),%edx
80102a57:	89 f6                	mov    %esi,%esi
80102a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a60:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a66:	80 e6 10             	and    $0x10,%dh
80102a69:	75 f5                	jne    80102a60 <lapicinit+0xc0>
  lapic[index] = value;
80102a6b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a72:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a75:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a78:	5d                   	pop    %ebp
80102a79:	c3                   	ret    
80102a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102a80:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a87:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a8a:	8b 50 20             	mov    0x20(%eax),%edx
80102a8d:	e9 77 ff ff ff       	jmp    80102a09 <lapicinit+0x69>
80102a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102aa0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102aa0:	8b 15 3c 39 11 80    	mov    0x8011393c,%edx
{
80102aa6:	55                   	push   %ebp
80102aa7:	31 c0                	xor    %eax,%eax
80102aa9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102aab:	85 d2                	test   %edx,%edx
80102aad:	74 06                	je     80102ab5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102aaf:	8b 42 20             	mov    0x20(%edx),%eax
80102ab2:	c1 e8 18             	shr    $0x18,%eax
}
80102ab5:	5d                   	pop    %ebp
80102ab6:	c3                   	ret    
80102ab7:	89 f6                	mov    %esi,%esi
80102ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ac0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102ac0:	a1 3c 39 11 80       	mov    0x8011393c,%eax
{
80102ac5:	55                   	push   %ebp
80102ac6:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102ac8:	85 c0                	test   %eax,%eax
80102aca:	74 0d                	je     80102ad9 <lapiceoi+0x19>
  lapic[index] = value;
80102acc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ad3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ad6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102ad9:	5d                   	pop    %ebp
80102ada:	c3                   	ret    
80102adb:	90                   	nop
80102adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ae0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
}
80102ae3:	5d                   	pop    %ebp
80102ae4:	c3                   	ret    
80102ae5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102af0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102af0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102af1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102af6:	ba 70 00 00 00       	mov    $0x70,%edx
80102afb:	89 e5                	mov    %esp,%ebp
80102afd:	53                   	push   %ebx
80102afe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b01:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b04:	ee                   	out    %al,(%dx)
80102b05:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b0a:	ba 71 00 00 00       	mov    $0x71,%edx
80102b0f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b10:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102b12:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b15:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b1b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b1d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102b20:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102b23:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b25:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b28:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b2e:	a1 3c 39 11 80       	mov    0x8011393c,%eax
80102b33:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b39:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b3c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b43:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b46:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b49:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b50:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b53:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b56:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b5c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b5f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b65:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b68:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b6e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b71:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b77:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102b7a:	5b                   	pop    %ebx
80102b7b:	5d                   	pop    %ebp
80102b7c:	c3                   	ret    
80102b7d:	8d 76 00             	lea    0x0(%esi),%esi

80102b80 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b80:	55                   	push   %ebp
80102b81:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b86:	ba 70 00 00 00       	mov    $0x70,%edx
80102b8b:	89 e5                	mov    %esp,%ebp
80102b8d:	57                   	push   %edi
80102b8e:	56                   	push   %esi
80102b8f:	53                   	push   %ebx
80102b90:	83 ec 4c             	sub    $0x4c,%esp
80102b93:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b94:	ba 71 00 00 00       	mov    $0x71,%edx
80102b99:	ec                   	in     (%dx),%al
80102b9a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b9d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ba2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ba5:	8d 76 00             	lea    0x0(%esi),%esi
80102ba8:	31 c0                	xor    %eax,%eax
80102baa:	89 da                	mov    %ebx,%edx
80102bac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bad:	b9 71 00 00 00       	mov    $0x71,%ecx
80102bb2:	89 ca                	mov    %ecx,%edx
80102bb4:	ec                   	in     (%dx),%al
80102bb5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb8:	89 da                	mov    %ebx,%edx
80102bba:	b8 02 00 00 00       	mov    $0x2,%eax
80102bbf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bc0:	89 ca                	mov    %ecx,%edx
80102bc2:	ec                   	in     (%dx),%al
80102bc3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc6:	89 da                	mov    %ebx,%edx
80102bc8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bcd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bce:	89 ca                	mov    %ecx,%edx
80102bd0:	ec                   	in     (%dx),%al
80102bd1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd4:	89 da                	mov    %ebx,%edx
80102bd6:	b8 07 00 00 00       	mov    $0x7,%eax
80102bdb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdc:	89 ca                	mov    %ecx,%edx
80102bde:	ec                   	in     (%dx),%al
80102bdf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be2:	89 da                	mov    %ebx,%edx
80102be4:	b8 08 00 00 00       	mov    $0x8,%eax
80102be9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bea:	89 ca                	mov    %ecx,%edx
80102bec:	ec                   	in     (%dx),%al
80102bed:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bef:	89 da                	mov    %ebx,%edx
80102bf1:	b8 09 00 00 00       	mov    $0x9,%eax
80102bf6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf7:	89 ca                	mov    %ecx,%edx
80102bf9:	ec                   	in     (%dx),%al
80102bfa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bfc:	89 da                	mov    %ebx,%edx
80102bfe:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c04:	89 ca                	mov    %ecx,%edx
80102c06:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c07:	84 c0                	test   %al,%al
80102c09:	78 9d                	js     80102ba8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102c0b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c0f:	89 fa                	mov    %edi,%edx
80102c11:	0f b6 fa             	movzbl %dl,%edi
80102c14:	89 f2                	mov    %esi,%edx
80102c16:	0f b6 f2             	movzbl %dl,%esi
80102c19:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c1c:	89 da                	mov    %ebx,%edx
80102c1e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102c21:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c24:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102c28:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c2b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102c2f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102c32:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102c36:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c39:	31 c0                	xor    %eax,%eax
80102c3b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3c:	89 ca                	mov    %ecx,%edx
80102c3e:	ec                   	in     (%dx),%al
80102c3f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c42:	89 da                	mov    %ebx,%edx
80102c44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c47:	b8 02 00 00 00       	mov    $0x2,%eax
80102c4c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4d:	89 ca                	mov    %ecx,%edx
80102c4f:	ec                   	in     (%dx),%al
80102c50:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c53:	89 da                	mov    %ebx,%edx
80102c55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c58:	b8 04 00 00 00       	mov    $0x4,%eax
80102c5d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5e:	89 ca                	mov    %ecx,%edx
80102c60:	ec                   	in     (%dx),%al
80102c61:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c64:	89 da                	mov    %ebx,%edx
80102c66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c69:	b8 07 00 00 00       	mov    $0x7,%eax
80102c6e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6f:	89 ca                	mov    %ecx,%edx
80102c71:	ec                   	in     (%dx),%al
80102c72:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c75:	89 da                	mov    %ebx,%edx
80102c77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102c7f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c80:	89 ca                	mov    %ecx,%edx
80102c82:	ec                   	in     (%dx),%al
80102c83:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c86:	89 da                	mov    %ebx,%edx
80102c88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102c90:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c91:	89 ca                	mov    %ecx,%edx
80102c93:	ec                   	in     (%dx),%al
80102c94:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c97:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102c9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c9d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ca0:	6a 18                	push   $0x18
80102ca2:	50                   	push   %eax
80102ca3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ca6:	50                   	push   %eax
80102ca7:	e8 84 25 00 00       	call   80105230 <memcmp>
80102cac:	83 c4 10             	add    $0x10,%esp
80102caf:	85 c0                	test   %eax,%eax
80102cb1:	0f 85 f1 fe ff ff    	jne    80102ba8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102cb7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102cbb:	75 78                	jne    80102d35 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102cbd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cc0:	89 c2                	mov    %eax,%edx
80102cc2:	83 e0 0f             	and    $0xf,%eax
80102cc5:	c1 ea 04             	shr    $0x4,%edx
80102cc8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ccb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cce:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102cd1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102cd4:	89 c2                	mov    %eax,%edx
80102cd6:	83 e0 0f             	and    $0xf,%eax
80102cd9:	c1 ea 04             	shr    $0x4,%edx
80102cdc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cdf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ce2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102ce5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ce8:	89 c2                	mov    %eax,%edx
80102cea:	83 e0 0f             	and    $0xf,%eax
80102ced:	c1 ea 04             	shr    $0x4,%edx
80102cf0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cf3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cf6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102cf9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cfc:	89 c2                	mov    %eax,%edx
80102cfe:	83 e0 0f             	and    $0xf,%eax
80102d01:	c1 ea 04             	shr    $0x4,%edx
80102d04:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d07:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d0a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d0d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d10:	89 c2                	mov    %eax,%edx
80102d12:	83 e0 0f             	and    $0xf,%eax
80102d15:	c1 ea 04             	shr    $0x4,%edx
80102d18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d1e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d21:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d24:	89 c2                	mov    %eax,%edx
80102d26:	83 e0 0f             	and    $0xf,%eax
80102d29:	c1 ea 04             	shr    $0x4,%edx
80102d2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d32:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d35:	8b 75 08             	mov    0x8(%ebp),%esi
80102d38:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d3b:	89 06                	mov    %eax,(%esi)
80102d3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d40:	89 46 04             	mov    %eax,0x4(%esi)
80102d43:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d46:	89 46 08             	mov    %eax,0x8(%esi)
80102d49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d4c:	89 46 0c             	mov    %eax,0xc(%esi)
80102d4f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d52:	89 46 10             	mov    %eax,0x10(%esi)
80102d55:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d58:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102d5b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d65:	5b                   	pop    %ebx
80102d66:	5e                   	pop    %esi
80102d67:	5f                   	pop    %edi
80102d68:	5d                   	pop    %ebp
80102d69:	c3                   	ret    
80102d6a:	66 90                	xchg   %ax,%ax
80102d6c:	66 90                	xchg   %ax,%ax
80102d6e:	66 90                	xchg   %ax,%ax

80102d70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d70:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102d76:	85 c9                	test   %ecx,%ecx
80102d78:	0f 8e 8a 00 00 00    	jle    80102e08 <install_trans+0x98>
{
80102d7e:	55                   	push   %ebp
80102d7f:	89 e5                	mov    %esp,%ebp
80102d81:	57                   	push   %edi
80102d82:	56                   	push   %esi
80102d83:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102d84:	31 db                	xor    %ebx,%ebx
{
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d90:	a1 74 39 11 80       	mov    0x80113974,%eax
80102d95:	83 ec 08             	sub    $0x8,%esp
80102d98:	01 d8                	add    %ebx,%eax
80102d9a:	83 c0 01             	add    $0x1,%eax
80102d9d:	50                   	push   %eax
80102d9e:	ff 35 84 39 11 80    	pushl  0x80113984
80102da4:	e8 27 d3 ff ff       	call   801000d0 <bread>
80102da9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dab:	58                   	pop    %eax
80102dac:	5a                   	pop    %edx
80102dad:	ff 34 9d 8c 39 11 80 	pushl  -0x7feec674(,%ebx,4)
80102db4:	ff 35 84 39 11 80    	pushl  0x80113984
  for (tail = 0; tail < log.lh.n; tail++) {
80102dba:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dbd:	e8 0e d3 ff ff       	call   801000d0 <bread>
80102dc2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dc4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102dc7:	83 c4 0c             	add    $0xc,%esp
80102dca:	68 00 02 00 00       	push   $0x200
80102dcf:	50                   	push   %eax
80102dd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dd3:	50                   	push   %eax
80102dd4:	e8 b7 24 00 00       	call   80105290 <memmove>
    bwrite(dbuf);  // write dst to disk
80102dd9:	89 34 24             	mov    %esi,(%esp)
80102ddc:	e8 bf d3 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102de1:	89 3c 24             	mov    %edi,(%esp)
80102de4:	e8 f7 d3 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102de9:	89 34 24             	mov    %esi,(%esp)
80102dec:	e8 ef d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102df1:	83 c4 10             	add    $0x10,%esp
80102df4:	39 1d 88 39 11 80    	cmp    %ebx,0x80113988
80102dfa:	7f 94                	jg     80102d90 <install_trans+0x20>
  }
}
80102dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dff:	5b                   	pop    %ebx
80102e00:	5e                   	pop    %esi
80102e01:	5f                   	pop    %edi
80102e02:	5d                   	pop    %ebp
80102e03:	c3                   	ret    
80102e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e08:	f3 c3                	repz ret 
80102e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	56                   	push   %esi
80102e14:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102e15:	83 ec 08             	sub    $0x8,%esp
80102e18:	ff 35 74 39 11 80    	pushl  0x80113974
80102e1e:	ff 35 84 39 11 80    	pushl  0x80113984
80102e24:	e8 a7 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102e29:	8b 1d 88 39 11 80    	mov    0x80113988,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102e2f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e32:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102e34:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102e36:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102e39:	7e 16                	jle    80102e51 <write_head+0x41>
80102e3b:	c1 e3 02             	shl    $0x2,%ebx
80102e3e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102e40:	8b 8a 8c 39 11 80    	mov    -0x7feec674(%edx),%ecx
80102e46:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102e4a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102e4d:	39 da                	cmp    %ebx,%edx
80102e4f:	75 ef                	jne    80102e40 <write_head+0x30>
  }
  bwrite(buf);
80102e51:	83 ec 0c             	sub    $0xc,%esp
80102e54:	56                   	push   %esi
80102e55:	e8 46 d3 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102e5a:	89 34 24             	mov    %esi,(%esp)
80102e5d:	e8 7e d3 ff ff       	call   801001e0 <brelse>
}
80102e62:	83 c4 10             	add    $0x10,%esp
80102e65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e68:	5b                   	pop    %ebx
80102e69:	5e                   	pop    %esi
80102e6a:	5d                   	pop    %ebp
80102e6b:	c3                   	ret    
80102e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e70 <initlog>:
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	53                   	push   %ebx
80102e74:	83 ec 2c             	sub    $0x2c,%esp
80102e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e7a:	68 00 82 10 80       	push   $0x80108200
80102e7f:	68 40 39 11 80       	push   $0x80113940
80102e84:	e8 07 21 00 00       	call   80104f90 <initlock>
  readsb(dev, &sb);
80102e89:	58                   	pop    %eax
80102e8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e8d:	5a                   	pop    %edx
80102e8e:	50                   	push   %eax
80102e8f:	53                   	push   %ebx
80102e90:	e8 9b e8 ff ff       	call   80101730 <readsb>
  log.size = sb.nlog;
80102e95:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102e98:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102e9b:	59                   	pop    %ecx
  log.dev = dev;
80102e9c:	89 1d 84 39 11 80    	mov    %ebx,0x80113984
  log.size = sb.nlog;
80102ea2:	89 15 78 39 11 80    	mov    %edx,0x80113978
  log.start = sb.logstart;
80102ea8:	a3 74 39 11 80       	mov    %eax,0x80113974
  struct buf *buf = bread(log.dev, log.start);
80102ead:	5a                   	pop    %edx
80102eae:	50                   	push   %eax
80102eaf:	53                   	push   %ebx
80102eb0:	e8 1b d2 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102eb5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102eb8:	83 c4 10             	add    $0x10,%esp
80102ebb:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102ebd:	89 1d 88 39 11 80    	mov    %ebx,0x80113988
  for (i = 0; i < log.lh.n; i++) {
80102ec3:	7e 1c                	jle    80102ee1 <initlog+0x71>
80102ec5:	c1 e3 02             	shl    $0x2,%ebx
80102ec8:	31 d2                	xor    %edx,%edx
80102eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102ed0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102ed4:	83 c2 04             	add    $0x4,%edx
80102ed7:	89 8a 88 39 11 80    	mov    %ecx,-0x7feec678(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102edd:	39 d3                	cmp    %edx,%ebx
80102edf:	75 ef                	jne    80102ed0 <initlog+0x60>
  brelse(buf);
80102ee1:	83 ec 0c             	sub    $0xc,%esp
80102ee4:	50                   	push   %eax
80102ee5:	e8 f6 d2 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102eea:	e8 81 fe ff ff       	call   80102d70 <install_trans>
  log.lh.n = 0;
80102eef:	c7 05 88 39 11 80 00 	movl   $0x0,0x80113988
80102ef6:	00 00 00 
  write_head(); // clear the log
80102ef9:	e8 12 ff ff ff       	call   80102e10 <write_head>
}
80102efe:	83 c4 10             	add    $0x10,%esp
80102f01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f04:	c9                   	leave  
80102f05:	c3                   	ret    
80102f06:	8d 76 00             	lea    0x0(%esi),%esi
80102f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f16:	68 40 39 11 80       	push   $0x80113940
80102f1b:	e8 b0 21 00 00       	call   801050d0 <acquire>
80102f20:	83 c4 10             	add    $0x10,%esp
80102f23:	eb 18                	jmp    80102f3d <begin_op+0x2d>
80102f25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f28:	83 ec 08             	sub    $0x8,%esp
80102f2b:	68 40 39 11 80       	push   $0x80113940
80102f30:	68 40 39 11 80       	push   $0x80113940
80102f35:	e8 66 11 00 00       	call   801040a0 <sleep>
80102f3a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102f3d:	a1 80 39 11 80       	mov    0x80113980,%eax
80102f42:	85 c0                	test   %eax,%eax
80102f44:	75 e2                	jne    80102f28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f46:	a1 7c 39 11 80       	mov    0x8011397c,%eax
80102f4b:	8b 15 88 39 11 80    	mov    0x80113988,%edx
80102f51:	83 c0 01             	add    $0x1,%eax
80102f54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f5a:	83 fa 1e             	cmp    $0x1e,%edx
80102f5d:	7f c9                	jg     80102f28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f5f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f62:	a3 7c 39 11 80       	mov    %eax,0x8011397c
      release(&log.lock);
80102f67:	68 40 39 11 80       	push   $0x80113940
80102f6c:	e8 1f 22 00 00       	call   80105190 <release>
      break;
    }
  }
}
80102f71:	83 c4 10             	add    $0x10,%esp
80102f74:	c9                   	leave  
80102f75:	c3                   	ret    
80102f76:	8d 76 00             	lea    0x0(%esi),%esi
80102f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f80:	55                   	push   %ebp
80102f81:	89 e5                	mov    %esp,%ebp
80102f83:	57                   	push   %edi
80102f84:	56                   	push   %esi
80102f85:	53                   	push   %ebx
80102f86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f89:	68 40 39 11 80       	push   $0x80113940
80102f8e:	e8 3d 21 00 00       	call   801050d0 <acquire>
  log.outstanding -= 1;
80102f93:	a1 7c 39 11 80       	mov    0x8011397c,%eax
  if(log.committing)
80102f98:	8b 35 80 39 11 80    	mov    0x80113980,%esi
80102f9e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102fa1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102fa4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102fa6:	89 1d 7c 39 11 80    	mov    %ebx,0x8011397c
  if(log.committing)
80102fac:	0f 85 1a 01 00 00    	jne    801030cc <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102fb2:	85 db                	test   %ebx,%ebx
80102fb4:	0f 85 ee 00 00 00    	jne    801030a8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102fba:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102fbd:	c7 05 80 39 11 80 01 	movl   $0x1,0x80113980
80102fc4:	00 00 00 
  release(&log.lock);
80102fc7:	68 40 39 11 80       	push   $0x80113940
80102fcc:	e8 bf 21 00 00       	call   80105190 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fd1:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102fd7:	83 c4 10             	add    $0x10,%esp
80102fda:	85 c9                	test   %ecx,%ecx
80102fdc:	0f 8e 85 00 00 00    	jle    80103067 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102fe2:	a1 74 39 11 80       	mov    0x80113974,%eax
80102fe7:	83 ec 08             	sub    $0x8,%esp
80102fea:	01 d8                	add    %ebx,%eax
80102fec:	83 c0 01             	add    $0x1,%eax
80102fef:	50                   	push   %eax
80102ff0:	ff 35 84 39 11 80    	pushl  0x80113984
80102ff6:	e8 d5 d0 ff ff       	call   801000d0 <bread>
80102ffb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ffd:	58                   	pop    %eax
80102ffe:	5a                   	pop    %edx
80102fff:	ff 34 9d 8c 39 11 80 	pushl  -0x7feec674(,%ebx,4)
80103006:	ff 35 84 39 11 80    	pushl  0x80113984
  for (tail = 0; tail < log.lh.n; tail++) {
8010300c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010300f:	e8 bc d0 ff ff       	call   801000d0 <bread>
80103014:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103016:	8d 40 5c             	lea    0x5c(%eax),%eax
80103019:	83 c4 0c             	add    $0xc,%esp
8010301c:	68 00 02 00 00       	push   $0x200
80103021:	50                   	push   %eax
80103022:	8d 46 5c             	lea    0x5c(%esi),%eax
80103025:	50                   	push   %eax
80103026:	e8 65 22 00 00       	call   80105290 <memmove>
    bwrite(to);  // write the log
8010302b:	89 34 24             	mov    %esi,(%esp)
8010302e:	e8 6d d1 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103033:	89 3c 24             	mov    %edi,(%esp)
80103036:	e8 a5 d1 ff ff       	call   801001e0 <brelse>
    brelse(to);
8010303b:	89 34 24             	mov    %esi,(%esp)
8010303e:	e8 9d d1 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103043:	83 c4 10             	add    $0x10,%esp
80103046:	3b 1d 88 39 11 80    	cmp    0x80113988,%ebx
8010304c:	7c 94                	jl     80102fe2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010304e:	e8 bd fd ff ff       	call   80102e10 <write_head>
    install_trans(); // Now install writes to home locations
80103053:	e8 18 fd ff ff       	call   80102d70 <install_trans>
    log.lh.n = 0;
80103058:	c7 05 88 39 11 80 00 	movl   $0x0,0x80113988
8010305f:	00 00 00 
    write_head();    // Erase the transaction from the log
80103062:	e8 a9 fd ff ff       	call   80102e10 <write_head>
    acquire(&log.lock);
80103067:	83 ec 0c             	sub    $0xc,%esp
8010306a:	68 40 39 11 80       	push   $0x80113940
8010306f:	e8 5c 20 00 00       	call   801050d0 <acquire>
    wakeup(&log);
80103074:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
    log.committing = 0;
8010307b:	c7 05 80 39 11 80 00 	movl   $0x0,0x80113980
80103082:	00 00 00 
    wakeup(&log);
80103085:	e8 d6 11 00 00       	call   80104260 <wakeup>
    release(&log.lock);
8010308a:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103091:	e8 fa 20 00 00       	call   80105190 <release>
80103096:	83 c4 10             	add    $0x10,%esp
}
80103099:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010309c:	5b                   	pop    %ebx
8010309d:	5e                   	pop    %esi
8010309e:	5f                   	pop    %edi
8010309f:	5d                   	pop    %ebp
801030a0:	c3                   	ret    
801030a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
801030a8:	83 ec 0c             	sub    $0xc,%esp
801030ab:	68 40 39 11 80       	push   $0x80113940
801030b0:	e8 ab 11 00 00       	call   80104260 <wakeup>
  release(&log.lock);
801030b5:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
801030bc:	e8 cf 20 00 00       	call   80105190 <release>
801030c1:	83 c4 10             	add    $0x10,%esp
}
801030c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030c7:	5b                   	pop    %ebx
801030c8:	5e                   	pop    %esi
801030c9:	5f                   	pop    %edi
801030ca:	5d                   	pop    %ebp
801030cb:	c3                   	ret    
    panic("log.committing");
801030cc:	83 ec 0c             	sub    $0xc,%esp
801030cf:	68 04 82 10 80       	push   $0x80108204
801030d4:	e8 b7 d2 ff ff       	call   80100390 <panic>
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801030e0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	53                   	push   %ebx
801030e4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030e7:	8b 15 88 39 11 80    	mov    0x80113988,%edx
{
801030ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030f0:	83 fa 1d             	cmp    $0x1d,%edx
801030f3:	0f 8f 9d 00 00 00    	jg     80103196 <log_write+0xb6>
801030f9:	a1 78 39 11 80       	mov    0x80113978,%eax
801030fe:	83 e8 01             	sub    $0x1,%eax
80103101:	39 c2                	cmp    %eax,%edx
80103103:	0f 8d 8d 00 00 00    	jge    80103196 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103109:	a1 7c 39 11 80       	mov    0x8011397c,%eax
8010310e:	85 c0                	test   %eax,%eax
80103110:	0f 8e 8d 00 00 00    	jle    801031a3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103116:	83 ec 0c             	sub    $0xc,%esp
80103119:	68 40 39 11 80       	push   $0x80113940
8010311e:	e8 ad 1f 00 00       	call   801050d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103123:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80103129:	83 c4 10             	add    $0x10,%esp
8010312c:	83 f9 00             	cmp    $0x0,%ecx
8010312f:	7e 57                	jle    80103188 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103131:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80103134:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103136:	3b 15 8c 39 11 80    	cmp    0x8011398c,%edx
8010313c:	75 0b                	jne    80103149 <log_write+0x69>
8010313e:	eb 38                	jmp    80103178 <log_write+0x98>
80103140:	39 14 85 8c 39 11 80 	cmp    %edx,-0x7feec674(,%eax,4)
80103147:	74 2f                	je     80103178 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80103149:	83 c0 01             	add    $0x1,%eax
8010314c:	39 c1                	cmp    %eax,%ecx
8010314e:	75 f0                	jne    80103140 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103150:	89 14 85 8c 39 11 80 	mov    %edx,-0x7feec674(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80103157:	83 c0 01             	add    $0x1,%eax
8010315a:	a3 88 39 11 80       	mov    %eax,0x80113988
  b->flags |= B_DIRTY; // prevent eviction
8010315f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103162:	c7 45 08 40 39 11 80 	movl   $0x80113940,0x8(%ebp)
}
80103169:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010316c:	c9                   	leave  
  release(&log.lock);
8010316d:	e9 1e 20 00 00       	jmp    80105190 <release>
80103172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103178:	89 14 85 8c 39 11 80 	mov    %edx,-0x7feec674(,%eax,4)
8010317f:	eb de                	jmp    8010315f <log_write+0x7f>
80103181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103188:	8b 43 08             	mov    0x8(%ebx),%eax
8010318b:	a3 8c 39 11 80       	mov    %eax,0x8011398c
  if (i == log.lh.n)
80103190:	75 cd                	jne    8010315f <log_write+0x7f>
80103192:	31 c0                	xor    %eax,%eax
80103194:	eb c1                	jmp    80103157 <log_write+0x77>
    panic("too big a transaction");
80103196:	83 ec 0c             	sub    $0xc,%esp
80103199:	68 13 82 10 80       	push   $0x80108213
8010319e:	e8 ed d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801031a3:	83 ec 0c             	sub    $0xc,%esp
801031a6:	68 29 82 10 80       	push   $0x80108229
801031ab:	e8 e0 d1 ff ff       	call   80100390 <panic>

801031b0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	53                   	push   %ebx
801031b4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801031b7:	e8 c4 09 00 00       	call   80103b80 <cpuid>
801031bc:	89 c3                	mov    %eax,%ebx
801031be:	e8 bd 09 00 00       	call   80103b80 <cpuid>
801031c3:	83 ec 04             	sub    $0x4,%esp
801031c6:	53                   	push   %ebx
801031c7:	50                   	push   %eax
801031c8:	68 44 82 10 80       	push   $0x80108244
801031cd:	e8 8e d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
801031d2:	e8 a9 33 00 00       	call   80106580 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031d7:	e8 24 09 00 00       	call   80103b00 <mycpu>
801031dc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031de:	b8 01 00 00 00       	mov    $0x1,%eax
801031e3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801031ea:	e8 d1 1b 00 00       	call   80104dc0 <scheduler>
801031ef:	90                   	nop

801031f0 <mpenter>:
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801031f6:	e8 75 44 00 00       	call   80107670 <switchkvm>
  seginit();
801031fb:	e8 e0 43 00 00       	call   801075e0 <seginit>
  lapicinit();
80103200:	e8 9b f7 ff ff       	call   801029a0 <lapicinit>
  mpmain();
80103205:	e8 a6 ff ff ff       	call   801031b0 <mpmain>
8010320a:	66 90                	xchg   %ax,%ax
8010320c:	66 90                	xchg   %ax,%ax
8010320e:	66 90                	xchg   %ax,%ax

80103210 <main>:
{
80103210:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103214:	83 e4 f0             	and    $0xfffffff0,%esp
80103217:	ff 71 fc             	pushl  -0x4(%ecx)
8010321a:	55                   	push   %ebp
8010321b:	89 e5                	mov    %esp,%ebp
8010321d:	53                   	push   %ebx
8010321e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010321f:	83 ec 08             	sub    $0x8,%esp
80103222:	68 00 00 40 80       	push   $0x80400000
80103227:	68 88 6d 11 80       	push   $0x80116d88
8010322c:	e8 2f f5 ff ff       	call   80102760 <kinit1>
  kvmalloc();      // kernel page table
80103231:	e8 0a 49 00 00       	call   80107b40 <kvmalloc>
  mpinit();        // detect other processors
80103236:	e8 75 01 00 00       	call   801033b0 <mpinit>
  lapicinit();     // interrupt controller
8010323b:	e8 60 f7 ff ff       	call   801029a0 <lapicinit>
  seginit();       // segment descriptors
80103240:	e8 9b 43 00 00       	call   801075e0 <seginit>
  picinit();       // disable pic
80103245:	e8 46 03 00 00       	call   80103590 <picinit>
  ioapicinit();    // another interrupt controller
8010324a:	e8 41 f3 ff ff       	call   80102590 <ioapicinit>
  consoleinit();   // console hardware
8010324f:	e8 6c da ff ff       	call   80100cc0 <consoleinit>
  uartinit();      // serial port
80103254:	e8 57 36 00 00       	call   801068b0 <uartinit>
  pinit();         // process table
80103259:	e8 82 08 00 00       	call   80103ae0 <pinit>
  tvinit();        // trap vectors
8010325e:	e8 9d 32 00 00       	call   80106500 <tvinit>
  binit();         // buffer cache
80103263:	e8 d8 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103268:	e8 53 de ff ff       	call   801010c0 <fileinit>
  ideinit();       // disk 
8010326d:	e8 fe f0 ff ff       	call   80102370 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103272:	83 c4 0c             	add    $0xc,%esp
80103275:	68 8a 00 00 00       	push   $0x8a
8010327a:	68 8c b4 10 80       	push   $0x8010b48c
8010327f:	68 00 70 00 80       	push   $0x80007000
80103284:	e8 07 20 00 00       	call   80105290 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103289:	69 05 c0 3f 11 80 b0 	imul   $0xb0,0x80113fc0,%eax
80103290:	00 00 00 
80103293:	83 c4 10             	add    $0x10,%esp
80103296:	05 40 3a 11 80       	add    $0x80113a40,%eax
8010329b:	3d 40 3a 11 80       	cmp    $0x80113a40,%eax
801032a0:	76 71                	jbe    80103313 <main+0x103>
801032a2:	bb 40 3a 11 80       	mov    $0x80113a40,%ebx
801032a7:	89 f6                	mov    %esi,%esi
801032a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
801032b0:	e8 4b 08 00 00       	call   80103b00 <mycpu>
801032b5:	39 d8                	cmp    %ebx,%eax
801032b7:	74 41                	je     801032fa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032b9:	e8 72 f5 ff ff       	call   80102830 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801032be:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801032c3:	c7 05 f8 6f 00 80 f0 	movl   $0x801031f0,0x80006ff8
801032ca:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801032cd:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801032d4:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801032d7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801032dc:	0f b6 03             	movzbl (%ebx),%eax
801032df:	83 ec 08             	sub    $0x8,%esp
801032e2:	68 00 70 00 00       	push   $0x7000
801032e7:	50                   	push   %eax
801032e8:	e8 03 f8 ff ff       	call   80102af0 <lapicstartap>
801032ed:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801032f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801032f6:	85 c0                	test   %eax,%eax
801032f8:	74 f6                	je     801032f0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
801032fa:	69 05 c0 3f 11 80 b0 	imul   $0xb0,0x80113fc0,%eax
80103301:	00 00 00 
80103304:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010330a:	05 40 3a 11 80       	add    $0x80113a40,%eax
8010330f:	39 c3                	cmp    %eax,%ebx
80103311:	72 9d                	jb     801032b0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103313:	83 ec 08             	sub    $0x8,%esp
80103316:	68 00 00 00 8e       	push   $0x8e000000
8010331b:	68 00 00 40 80       	push   $0x80400000
80103320:	e8 ab f4 ff ff       	call   801027d0 <kinit2>
  userinit();      // first user process
80103325:	e8 a6 08 00 00       	call   80103bd0 <userinit>
  mpmain();        // finish this processor's setup
8010332a:	e8 81 fe ff ff       	call   801031b0 <mpmain>
8010332f:	90                   	nop

80103330 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	57                   	push   %edi
80103334:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103335:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010333b:	53                   	push   %ebx
  e = addr+len;
8010333c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010333f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103342:	39 de                	cmp    %ebx,%esi
80103344:	72 10                	jb     80103356 <mpsearch1+0x26>
80103346:	eb 50                	jmp    80103398 <mpsearch1+0x68>
80103348:	90                   	nop
80103349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103350:	39 fb                	cmp    %edi,%ebx
80103352:	89 fe                	mov    %edi,%esi
80103354:	76 42                	jbe    80103398 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103356:	83 ec 04             	sub    $0x4,%esp
80103359:	8d 7e 10             	lea    0x10(%esi),%edi
8010335c:	6a 04                	push   $0x4
8010335e:	68 58 82 10 80       	push   $0x80108258
80103363:	56                   	push   %esi
80103364:	e8 c7 1e 00 00       	call   80105230 <memcmp>
80103369:	83 c4 10             	add    $0x10,%esp
8010336c:	85 c0                	test   %eax,%eax
8010336e:	75 e0                	jne    80103350 <mpsearch1+0x20>
80103370:	89 f1                	mov    %esi,%ecx
80103372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103378:	0f b6 11             	movzbl (%ecx),%edx
8010337b:	83 c1 01             	add    $0x1,%ecx
8010337e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103380:	39 f9                	cmp    %edi,%ecx
80103382:	75 f4                	jne    80103378 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103384:	84 c0                	test   %al,%al
80103386:	75 c8                	jne    80103350 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103388:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010338b:	89 f0                	mov    %esi,%eax
8010338d:	5b                   	pop    %ebx
8010338e:	5e                   	pop    %esi
8010338f:	5f                   	pop    %edi
80103390:	5d                   	pop    %ebp
80103391:	c3                   	ret    
80103392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103398:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010339b:	31 f6                	xor    %esi,%esi
}
8010339d:	89 f0                	mov    %esi,%eax
8010339f:	5b                   	pop    %ebx
801033a0:	5e                   	pop    %esi
801033a1:	5f                   	pop    %edi
801033a2:	5d                   	pop    %ebp
801033a3:	c3                   	ret    
801033a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801033b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033b9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033c0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033c7:	c1 e0 08             	shl    $0x8,%eax
801033ca:	09 d0                	or     %edx,%eax
801033cc:	c1 e0 04             	shl    $0x4,%eax
801033cf:	85 c0                	test   %eax,%eax
801033d1:	75 1b                	jne    801033ee <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801033d3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801033da:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801033e1:	c1 e0 08             	shl    $0x8,%eax
801033e4:	09 d0                	or     %edx,%eax
801033e6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801033e9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801033ee:	ba 00 04 00 00       	mov    $0x400,%edx
801033f3:	e8 38 ff ff ff       	call   80103330 <mpsearch1>
801033f8:	85 c0                	test   %eax,%eax
801033fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801033fd:	0f 84 3d 01 00 00    	je     80103540 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103403:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103406:	8b 58 04             	mov    0x4(%eax),%ebx
80103409:	85 db                	test   %ebx,%ebx
8010340b:	0f 84 4f 01 00 00    	je     80103560 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103411:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103417:	83 ec 04             	sub    $0x4,%esp
8010341a:	6a 04                	push   $0x4
8010341c:	68 75 82 10 80       	push   $0x80108275
80103421:	56                   	push   %esi
80103422:	e8 09 1e 00 00       	call   80105230 <memcmp>
80103427:	83 c4 10             	add    $0x10,%esp
8010342a:	85 c0                	test   %eax,%eax
8010342c:	0f 85 2e 01 00 00    	jne    80103560 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103432:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103439:	3c 01                	cmp    $0x1,%al
8010343b:	0f 95 c2             	setne  %dl
8010343e:	3c 04                	cmp    $0x4,%al
80103440:	0f 95 c0             	setne  %al
80103443:	20 c2                	and    %al,%dl
80103445:	0f 85 15 01 00 00    	jne    80103560 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010344b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103452:	66 85 ff             	test   %di,%di
80103455:	74 1a                	je     80103471 <mpinit+0xc1>
80103457:	89 f0                	mov    %esi,%eax
80103459:	01 f7                	add    %esi,%edi
  sum = 0;
8010345b:	31 d2                	xor    %edx,%edx
8010345d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103460:	0f b6 08             	movzbl (%eax),%ecx
80103463:	83 c0 01             	add    $0x1,%eax
80103466:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103468:	39 c7                	cmp    %eax,%edi
8010346a:	75 f4                	jne    80103460 <mpinit+0xb0>
8010346c:	84 d2                	test   %dl,%dl
8010346e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103471:	85 f6                	test   %esi,%esi
80103473:	0f 84 e7 00 00 00    	je     80103560 <mpinit+0x1b0>
80103479:	84 d2                	test   %dl,%dl
8010347b:	0f 85 df 00 00 00    	jne    80103560 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103481:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103487:	a3 3c 39 11 80       	mov    %eax,0x8011393c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010348c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103493:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103499:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010349e:	01 d6                	add    %edx,%esi
801034a0:	39 c6                	cmp    %eax,%esi
801034a2:	76 23                	jbe    801034c7 <mpinit+0x117>
    switch(*p){
801034a4:	0f b6 10             	movzbl (%eax),%edx
801034a7:	80 fa 04             	cmp    $0x4,%dl
801034aa:	0f 87 ca 00 00 00    	ja     8010357a <mpinit+0x1ca>
801034b0:	ff 24 95 9c 82 10 80 	jmp    *-0x7fef7d64(,%edx,4)
801034b7:	89 f6                	mov    %esi,%esi
801034b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801034c0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034c3:	39 c6                	cmp    %eax,%esi
801034c5:	77 dd                	ja     801034a4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801034c7:	85 db                	test   %ebx,%ebx
801034c9:	0f 84 9e 00 00 00    	je     8010356d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801034cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801034d2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801034d6:	74 15                	je     801034ed <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034d8:	b8 70 00 00 00       	mov    $0x70,%eax
801034dd:	ba 22 00 00 00       	mov    $0x22,%edx
801034e2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034e3:	ba 23 00 00 00       	mov    $0x23,%edx
801034e8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801034e9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034ec:	ee                   	out    %al,(%dx)
  }
}
801034ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034f0:	5b                   	pop    %ebx
801034f1:	5e                   	pop    %esi
801034f2:	5f                   	pop    %edi
801034f3:	5d                   	pop    %ebp
801034f4:	c3                   	ret    
801034f5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801034f8:	8b 0d c0 3f 11 80    	mov    0x80113fc0,%ecx
801034fe:	83 f9 07             	cmp    $0x7,%ecx
80103501:	7f 19                	jg     8010351c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103503:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103507:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010350d:	83 c1 01             	add    $0x1,%ecx
80103510:	89 0d c0 3f 11 80    	mov    %ecx,0x80113fc0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103516:	88 97 40 3a 11 80    	mov    %dl,-0x7feec5c0(%edi)
      p += sizeof(struct mpproc);
8010351c:	83 c0 14             	add    $0x14,%eax
      continue;
8010351f:	e9 7c ff ff ff       	jmp    801034a0 <mpinit+0xf0>
80103524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103528:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010352c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010352f:	88 15 20 3a 11 80    	mov    %dl,0x80113a20
      continue;
80103535:	e9 66 ff ff ff       	jmp    801034a0 <mpinit+0xf0>
8010353a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103540:	ba 00 00 01 00       	mov    $0x10000,%edx
80103545:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010354a:	e8 e1 fd ff ff       	call   80103330 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010354f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103551:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103554:	0f 85 a9 fe ff ff    	jne    80103403 <mpinit+0x53>
8010355a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	68 5d 82 10 80       	push   $0x8010825d
80103568:	e8 23 ce ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010356d:	83 ec 0c             	sub    $0xc,%esp
80103570:	68 7c 82 10 80       	push   $0x8010827c
80103575:	e8 16 ce ff ff       	call   80100390 <panic>
      ismp = 0;
8010357a:	31 db                	xor    %ebx,%ebx
8010357c:	e9 26 ff ff ff       	jmp    801034a7 <mpinit+0xf7>
80103581:	66 90                	xchg   %ax,%ax
80103583:	66 90                	xchg   %ax,%ax
80103585:	66 90                	xchg   %ax,%ax
80103587:	66 90                	xchg   %ax,%ax
80103589:	66 90                	xchg   %ax,%ax
8010358b:	66 90                	xchg   %ax,%ax
8010358d:	66 90                	xchg   %ax,%ax
8010358f:	90                   	nop

80103590 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103590:	55                   	push   %ebp
80103591:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103596:	ba 21 00 00 00       	mov    $0x21,%edx
8010359b:	89 e5                	mov    %esp,%ebp
8010359d:	ee                   	out    %al,(%dx)
8010359e:	ba a1 00 00 00       	mov    $0xa1,%edx
801035a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801035a4:	5d                   	pop    %ebp
801035a5:	c3                   	ret    
801035a6:	66 90                	xchg   %ax,%ax
801035a8:	66 90                	xchg   %ax,%ax
801035aa:	66 90                	xchg   %ax,%ax
801035ac:	66 90                	xchg   %ax,%ax
801035ae:	66 90                	xchg   %ax,%ax

801035b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	57                   	push   %edi
801035b4:	56                   	push   %esi
801035b5:	53                   	push   %ebx
801035b6:	83 ec 0c             	sub    $0xc,%esp
801035b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801035bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801035c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801035cb:	e8 10 db ff ff       	call   801010e0 <filealloc>
801035d0:	85 c0                	test   %eax,%eax
801035d2:	89 03                	mov    %eax,(%ebx)
801035d4:	74 22                	je     801035f8 <pipealloc+0x48>
801035d6:	e8 05 db ff ff       	call   801010e0 <filealloc>
801035db:	85 c0                	test   %eax,%eax
801035dd:	89 06                	mov    %eax,(%esi)
801035df:	74 3f                	je     80103620 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801035e1:	e8 4a f2 ff ff       	call   80102830 <kalloc>
801035e6:	85 c0                	test   %eax,%eax
801035e8:	89 c7                	mov    %eax,%edi
801035ea:	75 54                	jne    80103640 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801035ec:	8b 03                	mov    (%ebx),%eax
801035ee:	85 c0                	test   %eax,%eax
801035f0:	75 34                	jne    80103626 <pipealloc+0x76>
801035f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801035f8:	8b 06                	mov    (%esi),%eax
801035fa:	85 c0                	test   %eax,%eax
801035fc:	74 0c                	je     8010360a <pipealloc+0x5a>
    fileclose(*f1);
801035fe:	83 ec 0c             	sub    $0xc,%esp
80103601:	50                   	push   %eax
80103602:	e8 99 db ff ff       	call   801011a0 <fileclose>
80103607:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010360a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010360d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103612:	5b                   	pop    %ebx
80103613:	5e                   	pop    %esi
80103614:	5f                   	pop    %edi
80103615:	5d                   	pop    %ebp
80103616:	c3                   	ret    
80103617:	89 f6                	mov    %esi,%esi
80103619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103620:	8b 03                	mov    (%ebx),%eax
80103622:	85 c0                	test   %eax,%eax
80103624:	74 e4                	je     8010360a <pipealloc+0x5a>
    fileclose(*f0);
80103626:	83 ec 0c             	sub    $0xc,%esp
80103629:	50                   	push   %eax
8010362a:	e8 71 db ff ff       	call   801011a0 <fileclose>
  if(*f1)
8010362f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103631:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103634:	85 c0                	test   %eax,%eax
80103636:	75 c6                	jne    801035fe <pipealloc+0x4e>
80103638:	eb d0                	jmp    8010360a <pipealloc+0x5a>
8010363a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103640:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103643:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010364a:	00 00 00 
  p->writeopen = 1;
8010364d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103654:	00 00 00 
  p->nwrite = 0;
80103657:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010365e:	00 00 00 
  p->nread = 0;
80103661:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103668:	00 00 00 
  initlock(&p->lock, "pipe");
8010366b:	68 b0 82 10 80       	push   $0x801082b0
80103670:	50                   	push   %eax
80103671:	e8 1a 19 00 00       	call   80104f90 <initlock>
  (*f0)->type = FD_PIPE;
80103676:	8b 03                	mov    (%ebx),%eax
  return 0;
80103678:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010367b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103681:	8b 03                	mov    (%ebx),%eax
80103683:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103687:	8b 03                	mov    (%ebx),%eax
80103689:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010368d:	8b 03                	mov    (%ebx),%eax
8010368f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103692:	8b 06                	mov    (%esi),%eax
80103694:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010369a:	8b 06                	mov    (%esi),%eax
8010369c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801036a0:	8b 06                	mov    (%esi),%eax
801036a2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801036a6:	8b 06                	mov    (%esi),%eax
801036a8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801036ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801036ae:	31 c0                	xor    %eax,%eax
}
801036b0:	5b                   	pop    %ebx
801036b1:	5e                   	pop    %esi
801036b2:	5f                   	pop    %edi
801036b3:	5d                   	pop    %ebp
801036b4:	c3                   	ret    
801036b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	56                   	push   %esi
801036c4:	53                   	push   %ebx
801036c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801036cb:	83 ec 0c             	sub    $0xc,%esp
801036ce:	53                   	push   %ebx
801036cf:	e8 fc 19 00 00       	call   801050d0 <acquire>
  if(writable){
801036d4:	83 c4 10             	add    $0x10,%esp
801036d7:	85 f6                	test   %esi,%esi
801036d9:	74 45                	je     80103720 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801036db:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036e1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801036e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801036eb:	00 00 00 
    wakeup(&p->nread);
801036ee:	50                   	push   %eax
801036ef:	e8 6c 0b 00 00       	call   80104260 <wakeup>
801036f4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801036f7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801036fd:	85 d2                	test   %edx,%edx
801036ff:	75 0a                	jne    8010370b <pipeclose+0x4b>
80103701:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103707:	85 c0                	test   %eax,%eax
80103709:	74 35                	je     80103740 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010370b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010370e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103711:	5b                   	pop    %ebx
80103712:	5e                   	pop    %esi
80103713:	5d                   	pop    %ebp
    release(&p->lock);
80103714:	e9 77 1a 00 00       	jmp    80105190 <release>
80103719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103720:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103726:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103729:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103730:	00 00 00 
    wakeup(&p->nwrite);
80103733:	50                   	push   %eax
80103734:	e8 27 0b 00 00       	call   80104260 <wakeup>
80103739:	83 c4 10             	add    $0x10,%esp
8010373c:	eb b9                	jmp    801036f7 <pipeclose+0x37>
8010373e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103740:	83 ec 0c             	sub    $0xc,%esp
80103743:	53                   	push   %ebx
80103744:	e8 47 1a 00 00       	call   80105190 <release>
    kfree((char*)p);
80103749:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010374c:	83 c4 10             	add    $0x10,%esp
}
8010374f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103752:	5b                   	pop    %ebx
80103753:	5e                   	pop    %esi
80103754:	5d                   	pop    %ebp
    kfree((char*)p);
80103755:	e9 26 ef ff ff       	jmp    80102680 <kfree>
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103760 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	57                   	push   %edi
80103764:	56                   	push   %esi
80103765:	53                   	push   %ebx
80103766:	83 ec 28             	sub    $0x28,%esp
80103769:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010376c:	53                   	push   %ebx
8010376d:	e8 5e 19 00 00       	call   801050d0 <acquire>
  for(i = 0; i < n; i++){
80103772:	8b 45 10             	mov    0x10(%ebp),%eax
80103775:	83 c4 10             	add    $0x10,%esp
80103778:	85 c0                	test   %eax,%eax
8010377a:	0f 8e c9 00 00 00    	jle    80103849 <pipewrite+0xe9>
80103780:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103783:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103789:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010378f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103792:	03 4d 10             	add    0x10(%ebp),%ecx
80103795:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103798:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010379e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801037a4:	39 d0                	cmp    %edx,%eax
801037a6:	75 71                	jne    80103819 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801037a8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801037ae:	85 c0                	test   %eax,%eax
801037b0:	74 4e                	je     80103800 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037b2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801037b8:	eb 3a                	jmp    801037f4 <pipewrite+0x94>
801037ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801037c0:	83 ec 0c             	sub    $0xc,%esp
801037c3:	57                   	push   %edi
801037c4:	e8 97 0a 00 00       	call   80104260 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037c9:	5a                   	pop    %edx
801037ca:	59                   	pop    %ecx
801037cb:	53                   	push   %ebx
801037cc:	56                   	push   %esi
801037cd:	e8 ce 08 00 00       	call   801040a0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037d2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801037d8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801037de:	83 c4 10             	add    $0x10,%esp
801037e1:	05 00 02 00 00       	add    $0x200,%eax
801037e6:	39 c2                	cmp    %eax,%edx
801037e8:	75 36                	jne    80103820 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801037ea:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801037f0:	85 c0                	test   %eax,%eax
801037f2:	74 0c                	je     80103800 <pipewrite+0xa0>
801037f4:	e8 a7 03 00 00       	call   80103ba0 <myproc>
801037f9:	8b 40 24             	mov    0x24(%eax),%eax
801037fc:	85 c0                	test   %eax,%eax
801037fe:	74 c0                	je     801037c0 <pipewrite+0x60>
        release(&p->lock);
80103800:	83 ec 0c             	sub    $0xc,%esp
80103803:	53                   	push   %ebx
80103804:	e8 87 19 00 00       	call   80105190 <release>
        return -1;
80103809:	83 c4 10             	add    $0x10,%esp
8010380c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103811:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103814:	5b                   	pop    %ebx
80103815:	5e                   	pop    %esi
80103816:	5f                   	pop    %edi
80103817:	5d                   	pop    %ebp
80103818:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103819:	89 c2                	mov    %eax,%edx
8010381b:	90                   	nop
8010381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103820:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103823:	8d 42 01             	lea    0x1(%edx),%eax
80103826:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010382c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103832:	83 c6 01             	add    $0x1,%esi
80103835:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103839:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010383c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010383f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103843:	0f 85 4f ff ff ff    	jne    80103798 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103849:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010384f:	83 ec 0c             	sub    $0xc,%esp
80103852:	50                   	push   %eax
80103853:	e8 08 0a 00 00       	call   80104260 <wakeup>
  release(&p->lock);
80103858:	89 1c 24             	mov    %ebx,(%esp)
8010385b:	e8 30 19 00 00       	call   80105190 <release>
  return n;
80103860:	83 c4 10             	add    $0x10,%esp
80103863:	8b 45 10             	mov    0x10(%ebp),%eax
80103866:	eb a9                	jmp    80103811 <pipewrite+0xb1>
80103868:	90                   	nop
80103869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103870 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	57                   	push   %edi
80103874:	56                   	push   %esi
80103875:	53                   	push   %ebx
80103876:	83 ec 18             	sub    $0x18,%esp
80103879:	8b 75 08             	mov    0x8(%ebp),%esi
8010387c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010387f:	56                   	push   %esi
80103880:	e8 4b 18 00 00       	call   801050d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103885:	83 c4 10             	add    $0x10,%esp
80103888:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010388e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103894:	75 6a                	jne    80103900 <piperead+0x90>
80103896:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010389c:	85 db                	test   %ebx,%ebx
8010389e:	0f 84 c4 00 00 00    	je     80103968 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801038a4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801038aa:	eb 2d                	jmp    801038d9 <piperead+0x69>
801038ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038b0:	83 ec 08             	sub    $0x8,%esp
801038b3:	56                   	push   %esi
801038b4:	53                   	push   %ebx
801038b5:	e8 e6 07 00 00       	call   801040a0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038ba:	83 c4 10             	add    $0x10,%esp
801038bd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801038c3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801038c9:	75 35                	jne    80103900 <piperead+0x90>
801038cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801038d1:	85 d2                	test   %edx,%edx
801038d3:	0f 84 8f 00 00 00    	je     80103968 <piperead+0xf8>
    if(myproc()->killed){
801038d9:	e8 c2 02 00 00       	call   80103ba0 <myproc>
801038de:	8b 48 24             	mov    0x24(%eax),%ecx
801038e1:	85 c9                	test   %ecx,%ecx
801038e3:	74 cb                	je     801038b0 <piperead+0x40>
      release(&p->lock);
801038e5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038ed:	56                   	push   %esi
801038ee:	e8 9d 18 00 00       	call   80105190 <release>
      return -1;
801038f3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801038f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038f9:	89 d8                	mov    %ebx,%eax
801038fb:	5b                   	pop    %ebx
801038fc:	5e                   	pop    %esi
801038fd:	5f                   	pop    %edi
801038fe:	5d                   	pop    %ebp
801038ff:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103900:	8b 45 10             	mov    0x10(%ebp),%eax
80103903:	85 c0                	test   %eax,%eax
80103905:	7e 61                	jle    80103968 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103907:	31 db                	xor    %ebx,%ebx
80103909:	eb 13                	jmp    8010391e <piperead+0xae>
8010390b:	90                   	nop
8010390c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103910:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103916:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010391c:	74 1f                	je     8010393d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010391e:	8d 41 01             	lea    0x1(%ecx),%eax
80103921:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103927:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010392d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103932:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103935:	83 c3 01             	add    $0x1,%ebx
80103938:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010393b:	75 d3                	jne    80103910 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010393d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103943:	83 ec 0c             	sub    $0xc,%esp
80103946:	50                   	push   %eax
80103947:	e8 14 09 00 00       	call   80104260 <wakeup>
  release(&p->lock);
8010394c:	89 34 24             	mov    %esi,(%esp)
8010394f:	e8 3c 18 00 00       	call   80105190 <release>
  return i;
80103954:	83 c4 10             	add    $0x10,%esp
}
80103957:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010395a:	89 d8                	mov    %ebx,%eax
8010395c:	5b                   	pop    %ebx
8010395d:	5e                   	pop    %esi
8010395e:	5f                   	pop    %edi
8010395f:	5d                   	pop    %ebp
80103960:	c3                   	ret    
80103961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103968:	31 db                	xor    %ebx,%ebx
8010396a:	eb d1                	jmp    8010393d <piperead+0xcd>
8010396c:	66 90                	xchg   %ax,%ax
8010396e:	66 90                	xchg   %ax,%ax

80103970 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103974:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
80103979:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010397c:	68 00 40 11 80       	push   $0x80114000
80103981:	e8 4a 17 00 00       	call   801050d0 <acquire>
80103986:	83 c4 10             	add    $0x10,%esp
80103989:	eb 17                	jmp    801039a2 <allocproc+0x32>
8010398b:	90                   	nop
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103990:	81 c3 94 00 00 00    	add    $0x94,%ebx
80103996:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
8010399c:	0f 83 be 00 00 00    	jae    80103a60 <allocproc+0xf0>
    if(p->state == UNUSED)
801039a2:	8b 43 0c             	mov    0xc(%ebx),%eax
801039a5:	85 c0                	test   %eax,%eax
801039a7:	75 e7                	jne    80103990 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801039a9:	a1 08 b0 10 80       	mov    0x8010b008,%eax

  release(&ptable.lock);
801039ae:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801039b1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801039b8:	8d 50 01             	lea    0x1(%eax),%edx
801039bb:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
801039be:	68 00 40 11 80       	push   $0x80114000
  p->pid = nextpid++;
801039c3:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&ptable.lock);
801039c9:	e8 c2 17 00 00       	call   80105190 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801039ce:	e8 5d ee ff ff       	call   80102830 <kalloc>
801039d3:	83 c4 10             	add    $0x10,%esp
801039d6:	85 c0                	test   %eax,%eax
801039d8:	89 43 08             	mov    %eax,0x8(%ebx)
801039db:	0f 84 98 00 00 00    	je     80103a79 <allocproc+0x109>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801039e1:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801039e7:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801039ea:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801039ef:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801039f2:	c7 40 14 f1 64 10 80 	movl   $0x801064f1,0x14(%eax)
  p->context = (struct context*)sp;
801039f9:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801039fc:	6a 14                	push   $0x14
801039fe:	6a 00                	push   $0x0
80103a00:	50                   	push   %eax
80103a01:	e8 da 17 00 00       	call   801051e0 <memset>
  p->context->eip = (uint)forkret;
80103a06:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->creation_time = ticks + createdProcess++;
  p->process_count = process_number;
  process_number++;
  p->lottery_ticket = 50;
  p->schedQueue = LOTTERY;
  return p;
80103a09:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a0c:	c7 40 10 90 3a 10 80 	movl   $0x80103a90,0x10(%eax)
  p->creation_time = ticks + createdProcess++;
80103a13:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->lottery_ticket = 50;
80103a18:	c7 43 7c 32 00 00 00 	movl   $0x32,0x7c(%ebx)
  p->schedQueue = LOTTERY;
80103a1f:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103a26:	00 00 00 
  p->creation_time = ticks + createdProcess++;
80103a29:	8d 50 01             	lea    0x1(%eax),%edx
80103a2c:	03 05 80 6d 11 80    	add    0x80116d80,%eax
80103a32:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80103a38:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  p->process_count = process_number;
80103a3e:	a1 e0 3f 11 80       	mov    0x80113fe0,%eax
80103a43:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  process_number++;
80103a49:	83 c0 01             	add    $0x1,%eax
80103a4c:	a3 e0 3f 11 80       	mov    %eax,0x80113fe0
}
80103a51:	89 d8                	mov    %ebx,%eax
80103a53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a56:	c9                   	leave  
80103a57:	c3                   	ret    
80103a58:	90                   	nop
80103a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103a60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103a63:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103a65:	68 00 40 11 80       	push   $0x80114000
80103a6a:	e8 21 17 00 00       	call   80105190 <release>
}
80103a6f:	89 d8                	mov    %ebx,%eax
  return 0;
80103a71:	83 c4 10             	add    $0x10,%esp
}
80103a74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a77:	c9                   	leave  
80103a78:	c3                   	ret    
    p->state = UNUSED;
80103a79:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103a80:	31 db                	xor    %ebx,%ebx
80103a82:	eb cd                	jmp    80103a51 <allocproc+0xe1>
80103a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103a90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a96:	68 00 40 11 80       	push   $0x80114000
80103a9b:	e8 f0 16 00 00       	call   80105190 <release>

  if (first) {
80103aa0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	85 c0                	test   %eax,%eax
80103aaa:	75 04                	jne    80103ab0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103aac:	c9                   	leave  
80103aad:	c3                   	ret    
80103aae:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103ab0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103ab3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103aba:	00 00 00 
    iinit(ROOTDEV);
80103abd:	6a 01                	push   $0x1
80103abf:	e8 2c dd ff ff       	call   801017f0 <iinit>
    initlog(ROOTDEV);
80103ac4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103acb:	e8 a0 f3 ff ff       	call   80102e70 <initlog>
80103ad0:	83 c4 10             	add    $0x10,%esp
}
80103ad3:	c9                   	leave  
80103ad4:	c3                   	ret    
80103ad5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ae0 <pinit>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ae6:	68 b5 82 10 80       	push   $0x801082b5
80103aeb:	68 00 40 11 80       	push   $0x80114000
80103af0:	e8 9b 14 00 00       	call   80104f90 <initlock>
}
80103af5:	83 c4 10             	add    $0x10,%esp
80103af8:	c9                   	leave  
80103af9:	c3                   	ret    
80103afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b00 <mycpu>:
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	56                   	push   %esi
80103b04:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b05:	9c                   	pushf  
80103b06:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b07:	f6 c4 02             	test   $0x2,%ah
80103b0a:	75 5e                	jne    80103b6a <mycpu+0x6a>
  apicid = lapicid();
80103b0c:	e8 8f ef ff ff       	call   80102aa0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103b11:	8b 35 c0 3f 11 80    	mov    0x80113fc0,%esi
80103b17:	85 f6                	test   %esi,%esi
80103b19:	7e 42                	jle    80103b5d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103b1b:	0f b6 15 40 3a 11 80 	movzbl 0x80113a40,%edx
80103b22:	39 d0                	cmp    %edx,%eax
80103b24:	74 30                	je     80103b56 <mycpu+0x56>
80103b26:	b9 f0 3a 11 80       	mov    $0x80113af0,%ecx
  for (i = 0; i < ncpu; ++i) {
80103b2b:	31 d2                	xor    %edx,%edx
80103b2d:	8d 76 00             	lea    0x0(%esi),%esi
80103b30:	83 c2 01             	add    $0x1,%edx
80103b33:	39 f2                	cmp    %esi,%edx
80103b35:	74 26                	je     80103b5d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103b37:	0f b6 19             	movzbl (%ecx),%ebx
80103b3a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103b40:	39 c3                	cmp    %eax,%ebx
80103b42:	75 ec                	jne    80103b30 <mycpu+0x30>
80103b44:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103b4a:	05 40 3a 11 80       	add    $0x80113a40,%eax
}
80103b4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b52:	5b                   	pop    %ebx
80103b53:	5e                   	pop    %esi
80103b54:	5d                   	pop    %ebp
80103b55:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103b56:	b8 40 3a 11 80       	mov    $0x80113a40,%eax
      return &cpus[i];
80103b5b:	eb f2                	jmp    80103b4f <mycpu+0x4f>
  panic("unknown apicid\n");
80103b5d:	83 ec 0c             	sub    $0xc,%esp
80103b60:	68 bc 82 10 80       	push   $0x801082bc
80103b65:	e8 26 c8 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b6a:	83 ec 0c             	sub    $0xc,%esp
80103b6d:	68 a8 84 10 80       	push   $0x801084a8
80103b72:	e8 19 c8 ff ff       	call   80100390 <panic>
80103b77:	89 f6                	mov    %esi,%esi
80103b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b80 <cpuid>:
cpuid() {
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b86:	e8 75 ff ff ff       	call   80103b00 <mycpu>
80103b8b:	2d 40 3a 11 80       	sub    $0x80113a40,%eax
}
80103b90:	c9                   	leave  
  return mycpu()-cpus;
80103b91:	c1 f8 04             	sar    $0x4,%eax
80103b94:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b9a:	c3                   	ret    
80103b9b:	90                   	nop
80103b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ba0 <myproc>:
myproc(void) {
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	53                   	push   %ebx
80103ba4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ba7:	e8 54 14 00 00       	call   80105000 <pushcli>
  c = mycpu();
80103bac:	e8 4f ff ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103bb1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bb7:	e8 84 14 00 00       	call   80105040 <popcli>
}
80103bbc:	83 c4 04             	add    $0x4,%esp
80103bbf:	89 d8                	mov    %ebx,%eax
80103bc1:	5b                   	pop    %ebx
80103bc2:	5d                   	pop    %ebp
80103bc3:	c3                   	ret    
80103bc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103bd0 <userinit>:
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	53                   	push   %ebx
80103bd4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103bd7:	e8 94 fd ff ff       	call   80103970 <allocproc>
80103bdc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103bde:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if((p->pgdir = setupkvm()) == 0)
80103be3:	e8 d8 3e 00 00       	call   80107ac0 <setupkvm>
80103be8:	85 c0                	test   %eax,%eax
80103bea:	89 43 04             	mov    %eax,0x4(%ebx)
80103bed:	0f 84 bd 00 00 00    	je     80103cb0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bf3:	83 ec 04             	sub    $0x4,%esp
80103bf6:	68 2c 00 00 00       	push   $0x2c
80103bfb:	68 60 b4 10 80       	push   $0x8010b460
80103c00:	50                   	push   %eax
80103c01:	e8 9a 3b 00 00       	call   801077a0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103c06:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103c09:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103c0f:	6a 4c                	push   $0x4c
80103c11:	6a 00                	push   $0x0
80103c13:	ff 73 18             	pushl  0x18(%ebx)
80103c16:	e8 c5 15 00 00       	call   801051e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c1b:	8b 43 18             	mov    0x18(%ebx),%eax
80103c1e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c23:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c28:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c2b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c2f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c32:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c36:	8b 43 18             	mov    0x18(%ebx),%eax
80103c39:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c3d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c41:	8b 43 18             	mov    0x18(%ebx),%eax
80103c44:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c48:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c4c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c4f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c56:	8b 43 18             	mov    0x18(%ebx),%eax
80103c59:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c60:	8b 43 18             	mov    0x18(%ebx),%eax
80103c63:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c6a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c6d:	6a 10                	push   $0x10
80103c6f:	68 e5 82 10 80       	push   $0x801082e5
80103c74:	50                   	push   %eax
80103c75:	e8 46 17 00 00       	call   801053c0 <safestrcpy>
  p->cwd = namei("/");
80103c7a:	c7 04 24 ee 82 10 80 	movl   $0x801082ee,(%esp)
80103c81:	e8 ca e5 ff ff       	call   80102250 <namei>
80103c86:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c89:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103c90:	e8 3b 14 00 00       	call   801050d0 <acquire>
  p->state = RUNNABLE;
80103c95:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c9c:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103ca3:	e8 e8 14 00 00       	call   80105190 <release>
}
80103ca8:	83 c4 10             	add    $0x10,%esp
80103cab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103cae:	c9                   	leave  
80103caf:	c3                   	ret    
    panic("userinit: out of memory?");
80103cb0:	83 ec 0c             	sub    $0xc,%esp
80103cb3:	68 cc 82 10 80       	push   $0x801082cc
80103cb8:	e8 d3 c6 ff ff       	call   80100390 <panic>
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi

80103cc0 <growproc>:
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	56                   	push   %esi
80103cc4:	53                   	push   %ebx
80103cc5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103cc8:	e8 33 13 00 00       	call   80105000 <pushcli>
  c = mycpu();
80103ccd:	e8 2e fe ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103cd2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cd8:	e8 63 13 00 00       	call   80105040 <popcli>
  if(n > 0){
80103cdd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103ce0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ce2:	7f 1c                	jg     80103d00 <growproc+0x40>
  } else if(n < 0){
80103ce4:	75 3a                	jne    80103d20 <growproc+0x60>
  switchuvm(curproc);
80103ce6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ce9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103ceb:	53                   	push   %ebx
80103cec:	e8 9f 39 00 00       	call   80107690 <switchuvm>
  return 0;
80103cf1:	83 c4 10             	add    $0x10,%esp
80103cf4:	31 c0                	xor    %eax,%eax
}
80103cf6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cf9:	5b                   	pop    %ebx
80103cfa:	5e                   	pop    %esi
80103cfb:	5d                   	pop    %ebp
80103cfc:	c3                   	ret    
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d00:	83 ec 04             	sub    $0x4,%esp
80103d03:	01 c6                	add    %eax,%esi
80103d05:	56                   	push   %esi
80103d06:	50                   	push   %eax
80103d07:	ff 73 04             	pushl  0x4(%ebx)
80103d0a:	e8 d1 3b 00 00       	call   801078e0 <allocuvm>
80103d0f:	83 c4 10             	add    $0x10,%esp
80103d12:	85 c0                	test   %eax,%eax
80103d14:	75 d0                	jne    80103ce6 <growproc+0x26>
      return -1;
80103d16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d1b:	eb d9                	jmp    80103cf6 <growproc+0x36>
80103d1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d20:	83 ec 04             	sub    $0x4,%esp
80103d23:	01 c6                	add    %eax,%esi
80103d25:	56                   	push   %esi
80103d26:	50                   	push   %eax
80103d27:	ff 73 04             	pushl  0x4(%ebx)
80103d2a:	e8 e1 3c 00 00       	call   80107a10 <deallocuvm>
80103d2f:	83 c4 10             	add    $0x10,%esp
80103d32:	85 c0                	test   %eax,%eax
80103d34:	75 b0                	jne    80103ce6 <growproc+0x26>
80103d36:	eb de                	jmp    80103d16 <growproc+0x56>
80103d38:	90                   	nop
80103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d40 <fork>:
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	57                   	push   %edi
80103d44:	56                   	push   %esi
80103d45:	53                   	push   %ebx
80103d46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d49:	e8 b2 12 00 00       	call   80105000 <pushcli>
  c = mycpu();
80103d4e:	e8 ad fd ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103d53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d59:	e8 e2 12 00 00       	call   80105040 <popcli>
  if((np = allocproc()) == 0){
80103d5e:	e8 0d fc ff ff       	call   80103970 <allocproc>
80103d63:	85 c0                	test   %eax,%eax
80103d65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d68:	0f 84 b7 00 00 00    	je     80103e25 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d6e:	83 ec 08             	sub    $0x8,%esp
80103d71:	ff 33                	pushl  (%ebx)
80103d73:	ff 73 04             	pushl  0x4(%ebx)
80103d76:	89 c7                	mov    %eax,%edi
80103d78:	e8 13 3e 00 00       	call   80107b90 <copyuvm>
80103d7d:	83 c4 10             	add    $0x10,%esp
80103d80:	85 c0                	test   %eax,%eax
80103d82:	89 47 04             	mov    %eax,0x4(%edi)
80103d85:	0f 84 a1 00 00 00    	je     80103e2c <fork+0xec>
  np->sz = curproc->sz;
80103d8b:	8b 03                	mov    (%ebx),%eax
80103d8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d90:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103d92:	89 59 14             	mov    %ebx,0x14(%ecx)
80103d95:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103d97:	8b 79 18             	mov    0x18(%ecx),%edi
80103d9a:	8b 73 18             	mov    0x18(%ebx),%esi
80103d9d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103da2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103da4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103da6:	8b 40 18             	mov    0x18(%eax),%eax
80103da9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103db0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103db4:	85 c0                	test   %eax,%eax
80103db6:	74 13                	je     80103dcb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103db8:	83 ec 0c             	sub    $0xc,%esp
80103dbb:	50                   	push   %eax
80103dbc:	e8 8f d3 ff ff       	call   80101150 <filedup>
80103dc1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103dc4:	83 c4 10             	add    $0x10,%esp
80103dc7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103dcb:	83 c6 01             	add    $0x1,%esi
80103dce:	83 fe 10             	cmp    $0x10,%esi
80103dd1:	75 dd                	jne    80103db0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103dd3:	83 ec 0c             	sub    $0xc,%esp
80103dd6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dd9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103ddc:	e8 df db ff ff       	call   801019c0 <idup>
80103de1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103de4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103de7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dea:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ded:	6a 10                	push   $0x10
80103def:	53                   	push   %ebx
80103df0:	50                   	push   %eax
80103df1:	e8 ca 15 00 00       	call   801053c0 <safestrcpy>
  pid = np->pid;
80103df6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103df9:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103e00:	e8 cb 12 00 00       	call   801050d0 <acquire>
  np->state = RUNNABLE;
80103e05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103e0c:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103e13:	e8 78 13 00 00       	call   80105190 <release>
  return pid;
80103e18:	83 c4 10             	add    $0x10,%esp
}
80103e1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e1e:	89 d8                	mov    %ebx,%eax
80103e20:	5b                   	pop    %ebx
80103e21:	5e                   	pop    %esi
80103e22:	5f                   	pop    %edi
80103e23:	5d                   	pop    %ebp
80103e24:	c3                   	ret    
    return -1;
80103e25:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e2a:	eb ef                	jmp    80103e1b <fork+0xdb>
    kfree(np->kstack);
80103e2c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103e2f:	83 ec 0c             	sub    $0xc,%esp
80103e32:	ff 73 08             	pushl  0x8(%ebx)
80103e35:	e8 46 e8 ff ff       	call   80102680 <kfree>
    np->kstack = 0;
80103e3a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103e41:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103e48:	83 c4 10             	add    $0x10,%esp
80103e4b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e50:	eb c9                	jmp    80103e1b <fork+0xdb>
80103e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e60 <sched>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	56                   	push   %esi
80103e64:	53                   	push   %ebx
  pushcli();
80103e65:	e8 96 11 00 00       	call   80105000 <pushcli>
  c = mycpu();
80103e6a:	e8 91 fc ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103e6f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e75:	e8 c6 11 00 00       	call   80105040 <popcli>
  if(!holding(&ptable.lock))
80103e7a:	83 ec 0c             	sub    $0xc,%esp
80103e7d:	68 00 40 11 80       	push   $0x80114000
80103e82:	e8 19 12 00 00       	call   801050a0 <holding>
80103e87:	83 c4 10             	add    $0x10,%esp
80103e8a:	85 c0                	test   %eax,%eax
80103e8c:	74 4f                	je     80103edd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103e8e:	e8 6d fc ff ff       	call   80103b00 <mycpu>
80103e93:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e9a:	75 68                	jne    80103f04 <sched+0xa4>
  if(p->state == RUNNING)
80103e9c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ea0:	74 55                	je     80103ef7 <sched+0x97>
80103ea2:	9c                   	pushf  
80103ea3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ea4:	f6 c4 02             	test   $0x2,%ah
80103ea7:	75 41                	jne    80103eea <sched+0x8a>
  intena = mycpu()->intena;
80103ea9:	e8 52 fc ff ff       	call   80103b00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103eae:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103eb1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103eb7:	e8 44 fc ff ff       	call   80103b00 <mycpu>
80103ebc:	83 ec 08             	sub    $0x8,%esp
80103ebf:	ff 70 04             	pushl  0x4(%eax)
80103ec2:	53                   	push   %ebx
80103ec3:	e8 53 15 00 00       	call   8010541b <swtch>
  mycpu()->intena = intena;
80103ec8:	e8 33 fc ff ff       	call   80103b00 <mycpu>
}
80103ecd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103ed0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103ed6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ed9:	5b                   	pop    %ebx
80103eda:	5e                   	pop    %esi
80103edb:	5d                   	pop    %ebp
80103edc:	c3                   	ret    
    panic("sched ptable.lock");
80103edd:	83 ec 0c             	sub    $0xc,%esp
80103ee0:	68 f0 82 10 80       	push   $0x801082f0
80103ee5:	e8 a6 c4 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103eea:	83 ec 0c             	sub    $0xc,%esp
80103eed:	68 1c 83 10 80       	push   $0x8010831c
80103ef2:	e8 99 c4 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ef7:	83 ec 0c             	sub    $0xc,%esp
80103efa:	68 0e 83 10 80       	push   $0x8010830e
80103eff:	e8 8c c4 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103f04:	83 ec 0c             	sub    $0xc,%esp
80103f07:	68 02 83 10 80       	push   $0x80108302
80103f0c:	e8 7f c4 ff ff       	call   80100390 <panic>
80103f11:	eb 0d                	jmp    80103f20 <exit>
80103f13:	90                   	nop
80103f14:	90                   	nop
80103f15:	90                   	nop
80103f16:	90                   	nop
80103f17:	90                   	nop
80103f18:	90                   	nop
80103f19:	90                   	nop
80103f1a:	90                   	nop
80103f1b:	90                   	nop
80103f1c:	90                   	nop
80103f1d:	90                   	nop
80103f1e:	90                   	nop
80103f1f:	90                   	nop

80103f20 <exit>:
{
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	57                   	push   %edi
80103f24:	56                   	push   %esi
80103f25:	53                   	push   %ebx
80103f26:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103f29:	e8 d2 10 00 00       	call   80105000 <pushcli>
  c = mycpu();
80103f2e:	e8 cd fb ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103f33:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f39:	e8 02 11 00 00       	call   80105040 <popcli>
  if(curproc == initproc)
80103f3e:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80103f44:	8d 5e 28             	lea    0x28(%esi),%ebx
80103f47:	8d 7e 68             	lea    0x68(%esi),%edi
80103f4a:	0f 84 f1 00 00 00    	je     80104041 <exit+0x121>
    if(curproc->ofile[fd]){
80103f50:	8b 03                	mov    (%ebx),%eax
80103f52:	85 c0                	test   %eax,%eax
80103f54:	74 12                	je     80103f68 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103f56:	83 ec 0c             	sub    $0xc,%esp
80103f59:	50                   	push   %eax
80103f5a:	e8 41 d2 ff ff       	call   801011a0 <fileclose>
      curproc->ofile[fd] = 0;
80103f5f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103f65:	83 c4 10             	add    $0x10,%esp
80103f68:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103f6b:	39 fb                	cmp    %edi,%ebx
80103f6d:	75 e1                	jne    80103f50 <exit+0x30>
  begin_op();
80103f6f:	e8 9c ef ff ff       	call   80102f10 <begin_op>
  iput(curproc->cwd);
80103f74:	83 ec 0c             	sub    $0xc,%esp
80103f77:	ff 76 68             	pushl  0x68(%esi)
80103f7a:	e8 a1 db ff ff       	call   80101b20 <iput>
  end_op();
80103f7f:	e8 fc ef ff ff       	call   80102f80 <end_op>
  curproc->cwd = 0;
80103f84:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103f8b:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103f92:	e8 39 11 00 00       	call   801050d0 <acquire>
  wakeup1(curproc->parent);
80103f97:	8b 56 14             	mov    0x14(%esi),%edx
80103f9a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f9d:	b8 34 40 11 80       	mov    $0x80114034,%eax
80103fa2:	eb 10                	jmp    80103fb4 <exit+0x94>
80103fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fa8:	05 94 00 00 00       	add    $0x94,%eax
80103fad:	3d 34 65 11 80       	cmp    $0x80116534,%eax
80103fb2:	73 1e                	jae    80103fd2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103fb4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fb8:	75 ee                	jne    80103fa8 <exit+0x88>
80103fba:	3b 50 20             	cmp    0x20(%eax),%edx
80103fbd:	75 e9                	jne    80103fa8 <exit+0x88>
      p->state = RUNNABLE;
80103fbf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fc6:	05 94 00 00 00       	add    $0x94,%eax
80103fcb:	3d 34 65 11 80       	cmp    $0x80116534,%eax
80103fd0:	72 e2                	jb     80103fb4 <exit+0x94>
      p->parent = initproc;
80103fd2:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fd8:	ba 34 40 11 80       	mov    $0x80114034,%edx
80103fdd:	eb 0f                	jmp    80103fee <exit+0xce>
80103fdf:	90                   	nop
80103fe0:	81 c2 94 00 00 00    	add    $0x94,%edx
80103fe6:	81 fa 34 65 11 80    	cmp    $0x80116534,%edx
80103fec:	73 3a                	jae    80104028 <exit+0x108>
    if(p->parent == curproc){
80103fee:	39 72 14             	cmp    %esi,0x14(%edx)
80103ff1:	75 ed                	jne    80103fe0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103ff3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103ff7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103ffa:	75 e4                	jne    80103fe0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ffc:	b8 34 40 11 80       	mov    $0x80114034,%eax
80104001:	eb 11                	jmp    80104014 <exit+0xf4>
80104003:	90                   	nop
80104004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104008:	05 94 00 00 00       	add    $0x94,%eax
8010400d:	3d 34 65 11 80       	cmp    $0x80116534,%eax
80104012:	73 cc                	jae    80103fe0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104014:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104018:	75 ee                	jne    80104008 <exit+0xe8>
8010401a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010401d:	75 e9                	jne    80104008 <exit+0xe8>
      p->state = RUNNABLE;
8010401f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104026:	eb e0                	jmp    80104008 <exit+0xe8>
  curproc->state = ZOMBIE;
80104028:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010402f:	e8 2c fe ff ff       	call   80103e60 <sched>
  panic("zombie exit");
80104034:	83 ec 0c             	sub    $0xc,%esp
80104037:	68 3d 83 10 80       	push   $0x8010833d
8010403c:	e8 4f c3 ff ff       	call   80100390 <panic>
    panic("init exiting");
80104041:	83 ec 0c             	sub    $0xc,%esp
80104044:	68 30 83 10 80       	push   $0x80108330
80104049:	e8 42 c3 ff ff       	call   80100390 <panic>
8010404e:	66 90                	xchg   %ax,%ax

80104050 <yield>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104057:	68 00 40 11 80       	push   $0x80114000
8010405c:	e8 6f 10 00 00       	call   801050d0 <acquire>
  pushcli();
80104061:	e8 9a 0f 00 00       	call   80105000 <pushcli>
  c = mycpu();
80104066:	e8 95 fa ff ff       	call   80103b00 <mycpu>
  p = c->proc;
8010406b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104071:	e8 ca 0f 00 00       	call   80105040 <popcli>
  myproc()->state = RUNNABLE;
80104076:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010407d:	e8 de fd ff ff       	call   80103e60 <sched>
  release(&ptable.lock);
80104082:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80104089:	e8 02 11 00 00       	call   80105190 <release>
}
8010408e:	83 c4 10             	add    $0x10,%esp
80104091:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104094:	c9                   	leave  
80104095:	c3                   	ret    
80104096:	8d 76 00             	lea    0x0(%esi),%esi
80104099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040a0 <sleep>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	57                   	push   %edi
801040a4:	56                   	push   %esi
801040a5:	53                   	push   %ebx
801040a6:	83 ec 0c             	sub    $0xc,%esp
801040a9:	8b 7d 08             	mov    0x8(%ebp),%edi
801040ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801040af:	e8 4c 0f 00 00       	call   80105000 <pushcli>
  c = mycpu();
801040b4:	e8 47 fa ff ff       	call   80103b00 <mycpu>
  p = c->proc;
801040b9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040bf:	e8 7c 0f 00 00       	call   80105040 <popcli>
  if(p == 0)
801040c4:	85 db                	test   %ebx,%ebx
801040c6:	0f 84 87 00 00 00    	je     80104153 <sleep+0xb3>
  if(lk == 0)
801040cc:	85 f6                	test   %esi,%esi
801040ce:	74 76                	je     80104146 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801040d0:	81 fe 00 40 11 80    	cmp    $0x80114000,%esi
801040d6:	74 50                	je     80104128 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801040d8:	83 ec 0c             	sub    $0xc,%esp
801040db:	68 00 40 11 80       	push   $0x80114000
801040e0:	e8 eb 0f 00 00       	call   801050d0 <acquire>
    release(lk);
801040e5:	89 34 24             	mov    %esi,(%esp)
801040e8:	e8 a3 10 00 00       	call   80105190 <release>
  p->chan = chan;
801040ed:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040f0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040f7:	e8 64 fd ff ff       	call   80103e60 <sched>
  p->chan = 0;
801040fc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104103:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
8010410a:	e8 81 10 00 00       	call   80105190 <release>
    acquire(lk);
8010410f:	89 75 08             	mov    %esi,0x8(%ebp)
80104112:	83 c4 10             	add    $0x10,%esp
}
80104115:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104118:	5b                   	pop    %ebx
80104119:	5e                   	pop    %esi
8010411a:	5f                   	pop    %edi
8010411b:	5d                   	pop    %ebp
    acquire(lk);
8010411c:	e9 af 0f 00 00       	jmp    801050d0 <acquire>
80104121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104128:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010412b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104132:	e8 29 fd ff ff       	call   80103e60 <sched>
  p->chan = 0;
80104137:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010413e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104141:	5b                   	pop    %ebx
80104142:	5e                   	pop    %esi
80104143:	5f                   	pop    %edi
80104144:	5d                   	pop    %ebp
80104145:	c3                   	ret    
    panic("sleep without lk");
80104146:	83 ec 0c             	sub    $0xc,%esp
80104149:	68 4f 83 10 80       	push   $0x8010834f
8010414e:	e8 3d c2 ff ff       	call   80100390 <panic>
    panic("sleep");
80104153:	83 ec 0c             	sub    $0xc,%esp
80104156:	68 49 83 10 80       	push   $0x80108349
8010415b:	e8 30 c2 ff ff       	call   80100390 <panic>

80104160 <wait>:
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	56                   	push   %esi
80104164:	53                   	push   %ebx
  pushcli();
80104165:	e8 96 0e 00 00       	call   80105000 <pushcli>
  c = mycpu();
8010416a:	e8 91 f9 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
8010416f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104175:	e8 c6 0e 00 00       	call   80105040 <popcli>
  acquire(&ptable.lock);
8010417a:	83 ec 0c             	sub    $0xc,%esp
8010417d:	68 00 40 11 80       	push   $0x80114000
80104182:	e8 49 0f 00 00       	call   801050d0 <acquire>
80104187:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010418a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010418c:	bb 34 40 11 80       	mov    $0x80114034,%ebx
80104191:	eb 13                	jmp    801041a6 <wait+0x46>
80104193:	90                   	nop
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104198:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010419e:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
801041a4:	73 1e                	jae    801041c4 <wait+0x64>
      if(p->parent != curproc)
801041a6:	39 73 14             	cmp    %esi,0x14(%ebx)
801041a9:	75 ed                	jne    80104198 <wait+0x38>
      if(p->state == ZOMBIE){
801041ab:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801041af:	74 37                	je     801041e8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b1:	81 c3 94 00 00 00    	add    $0x94,%ebx
      havekids = 1;
801041b7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041bc:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
801041c2:	72 e2                	jb     801041a6 <wait+0x46>
    if(!havekids || curproc->killed){
801041c4:	85 c0                	test   %eax,%eax
801041c6:	74 76                	je     8010423e <wait+0xde>
801041c8:	8b 46 24             	mov    0x24(%esi),%eax
801041cb:	85 c0                	test   %eax,%eax
801041cd:	75 6f                	jne    8010423e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801041cf:	83 ec 08             	sub    $0x8,%esp
801041d2:	68 00 40 11 80       	push   $0x80114000
801041d7:	56                   	push   %esi
801041d8:	e8 c3 fe ff ff       	call   801040a0 <sleep>
    havekids = 0;
801041dd:	83 c4 10             	add    $0x10,%esp
801041e0:	eb a8                	jmp    8010418a <wait+0x2a>
801041e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
801041e8:	83 ec 0c             	sub    $0xc,%esp
801041eb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801041ee:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041f1:	e8 8a e4 ff ff       	call   80102680 <kfree>
        freevm(p->pgdir);
801041f6:	5a                   	pop    %edx
801041f7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801041fa:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104201:	e8 3a 38 00 00       	call   80107a40 <freevm>
        release(&ptable.lock);
80104206:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
        p->pid = 0;
8010420d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104214:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010421b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010421f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104226:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010422d:	e8 5e 0f 00 00       	call   80105190 <release>
        return pid;
80104232:	83 c4 10             	add    $0x10,%esp
}
80104235:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104238:	89 f0                	mov    %esi,%eax
8010423a:	5b                   	pop    %ebx
8010423b:	5e                   	pop    %esi
8010423c:	5d                   	pop    %ebp
8010423d:	c3                   	ret    
      release(&ptable.lock);
8010423e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104241:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104246:	68 00 40 11 80       	push   $0x80114000
8010424b:	e8 40 0f 00 00       	call   80105190 <release>
      return -1;
80104250:	83 c4 10             	add    $0x10,%esp
80104253:	eb e0                	jmp    80104235 <wait+0xd5>
80104255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104260 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 10             	sub    $0x10,%esp
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010426a:	68 00 40 11 80       	push   $0x80114000
8010426f:	e8 5c 0e 00 00       	call   801050d0 <acquire>
80104274:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104277:	b8 34 40 11 80       	mov    $0x80114034,%eax
8010427c:	eb 0e                	jmp    8010428c <wakeup+0x2c>
8010427e:	66 90                	xchg   %ax,%ax
80104280:	05 94 00 00 00       	add    $0x94,%eax
80104285:	3d 34 65 11 80       	cmp    $0x80116534,%eax
8010428a:	73 1e                	jae    801042aa <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010428c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104290:	75 ee                	jne    80104280 <wakeup+0x20>
80104292:	3b 58 20             	cmp    0x20(%eax),%ebx
80104295:	75 e9                	jne    80104280 <wakeup+0x20>
      p->state = RUNNABLE;
80104297:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010429e:	05 94 00 00 00       	add    $0x94,%eax
801042a3:	3d 34 65 11 80       	cmp    $0x80116534,%eax
801042a8:	72 e2                	jb     8010428c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801042aa:	c7 45 08 00 40 11 80 	movl   $0x80114000,0x8(%ebp)
}
801042b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042b4:	c9                   	leave  
  release(&ptable.lock);
801042b5:	e9 d6 0e 00 00       	jmp    80105190 <release>
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042c0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	53                   	push   %ebx
801042c4:	83 ec 10             	sub    $0x10,%esp
801042c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801042ca:	68 00 40 11 80       	push   $0x80114000
801042cf:	e8 fc 0d 00 00       	call   801050d0 <acquire>
801042d4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042d7:	b8 34 40 11 80       	mov    $0x80114034,%eax
801042dc:	eb 0e                	jmp    801042ec <kill+0x2c>
801042de:	66 90                	xchg   %ax,%ax
801042e0:	05 94 00 00 00       	add    $0x94,%eax
801042e5:	3d 34 65 11 80       	cmp    $0x80116534,%eax
801042ea:	73 34                	jae    80104320 <kill+0x60>
    if(p->pid == pid){
801042ec:	39 58 10             	cmp    %ebx,0x10(%eax)
801042ef:	75 ef                	jne    801042e0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801042f1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801042f5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801042fc:	75 07                	jne    80104305 <kill+0x45>
        p->state = RUNNABLE;
801042fe:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104305:	83 ec 0c             	sub    $0xc,%esp
80104308:	68 00 40 11 80       	push   $0x80114000
8010430d:	e8 7e 0e 00 00       	call   80105190 <release>
      return 0;
80104312:	83 c4 10             	add    $0x10,%esp
80104315:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104317:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010431a:	c9                   	leave  
8010431b:	c3                   	ret    
8010431c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104320:	83 ec 0c             	sub    $0xc,%esp
80104323:	68 00 40 11 80       	push   $0x80114000
80104328:	e8 63 0e 00 00       	call   80105190 <release>
  return -1;
8010432d:	83 c4 10             	add    $0x10,%esp
80104330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104335:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104338:	c9                   	leave  
80104339:	c3                   	ret    
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104340 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	57                   	push   %edi
80104344:	56                   	push   %esi
80104345:	53                   	push   %ebx
80104346:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104349:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
8010434e:	83 ec 3c             	sub    $0x3c,%esp
80104351:	eb 27                	jmp    8010437a <procdump+0x3a>
80104353:	90                   	nop
80104354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104358:	83 ec 0c             	sub    $0xc,%esp
8010435b:	68 9f 88 10 80       	push   $0x8010889f
80104360:	e8 fb c2 ff ff       	call   80100660 <cprintf>
80104365:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104368:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010436e:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
80104374:	0f 83 86 00 00 00    	jae    80104400 <procdump+0xc0>
    if(p->state == UNUSED)
8010437a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010437d:	85 c0                	test   %eax,%eax
8010437f:	74 e7                	je     80104368 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104381:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104384:	ba 60 83 10 80       	mov    $0x80108360,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104389:	77 11                	ja     8010439c <procdump+0x5c>
8010438b:	8b 14 85 5c 85 10 80 	mov    -0x7fef7aa4(,%eax,4),%edx
      state = "???";
80104392:	b8 60 83 10 80       	mov    $0x80108360,%eax
80104397:	85 d2                	test   %edx,%edx
80104399:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010439c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010439f:	50                   	push   %eax
801043a0:	52                   	push   %edx
801043a1:	ff 73 10             	pushl  0x10(%ebx)
801043a4:	68 64 83 10 80       	push   $0x80108364
801043a9:	e8 b2 c2 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801043ae:	83 c4 10             	add    $0x10,%esp
801043b1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801043b5:	75 a1                	jne    80104358 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801043b7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801043ba:	83 ec 08             	sub    $0x8,%esp
801043bd:	8d 7d c0             	lea    -0x40(%ebp),%edi
801043c0:	50                   	push   %eax
801043c1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801043c4:	8b 40 0c             	mov    0xc(%eax),%eax
801043c7:	83 c0 08             	add    $0x8,%eax
801043ca:	50                   	push   %eax
801043cb:	e8 e0 0b 00 00       	call   80104fb0 <getcallerpcs>
801043d0:	83 c4 10             	add    $0x10,%esp
801043d3:	90                   	nop
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801043d8:	8b 17                	mov    (%edi),%edx
801043da:	85 d2                	test   %edx,%edx
801043dc:	0f 84 76 ff ff ff    	je     80104358 <procdump+0x18>
        cprintf(" %p", pc[i]);
801043e2:	83 ec 08             	sub    $0x8,%esp
801043e5:	83 c7 04             	add    $0x4,%edi
801043e8:	52                   	push   %edx
801043e9:	68 a1 7d 10 80       	push   $0x80107da1
801043ee:	e8 6d c2 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801043f3:	83 c4 10             	add    $0x10,%esp
801043f6:	39 fe                	cmp    %edi,%esi
801043f8:	75 de                	jne    801043d8 <procdump+0x98>
801043fa:	e9 59 ff ff ff       	jmp    80104358 <procdump+0x18>
801043ff:	90                   	nop
  }
}
80104400:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104403:	5b                   	pop    %ebx
80104404:	5e                   	pop    %esi
80104405:	5f                   	pop    %edi
80104406:	5d                   	pop    %ebp
80104407:	c3                   	ret    
80104408:	90                   	nop
80104409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104410 <printProcess>:

void
printProcess(struct proc* p)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	53                   	push   %ebx
80104414:	83 ec 0c             	sub    $0xc,%esp
80104417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cprintf("name : %s\n", p->name);
8010441a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010441d:	50                   	push   %eax
8010441e:	68 6d 83 10 80       	push   $0x8010836d
80104423:	e8 38 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PID : %d\n",p->pid);
80104428:	58                   	pop    %eax
80104429:	5a                   	pop    %edx
8010442a:	ff 73 10             	pushl  0x10(%ebx)
8010442d:	68 79 83 10 80       	push   $0x80108379
80104432:	e8 29 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PPID : %d\n",p->parent->pid);
80104437:	59                   	pop    %ecx
80104438:	58                   	pop    %eax
80104439:	8b 43 14             	mov    0x14(%ebx),%eax
8010443c:	ff 70 10             	pushl  0x10(%eax)
8010443f:	68 78 83 10 80       	push   $0x80108378
80104444:	e8 17 c2 ff ff       	call   80100660 <cprintf>
  switch (p->state)
80104449:	83 c4 10             	add    $0x10,%esp
8010444c:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104450:	77 6e                	ja     801044c0 <printProcess+0xb0>
80104452:	8b 43 0c             	mov    0xc(%ebx),%eax
80104455:	ff 24 85 44 85 10 80 	jmp    *-0x7fef7abc(,%eax,4)
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    case 3:
      cprintf("state : RUNNABLE\n");
      break;
    case 4:
      cprintf("state : RUNNING\n");
80104460:	c7 45 08 c7 83 10 80 	movl   $0x801083c7,0x8(%ebp)
      break;
    case 5:
      cprintf("state : ZOMBIE\n");
      break;
  }
}
80104467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010446a:	c9                   	leave  
      cprintf("state : RUNNING\n");
8010446b:	e9 f0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : ZOMBIE\n");
80104470:	c7 45 08 d8 83 10 80 	movl   $0x801083d8,0x8(%ebp)
}
80104477:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010447a:	c9                   	leave  
      cprintf("state : ZOMBIE\n");
8010447b:	e9 e0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : UNUSED\n");
80104480:	c7 45 08 83 83 10 80 	movl   $0x80108383,0x8(%ebp)
}
80104487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010448a:	c9                   	leave  
      cprintf("state : UNUSED\n");
8010448b:	e9 d0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : EMBRYO\n");
80104490:	c7 45 08 93 83 10 80 	movl   $0x80108393,0x8(%ebp)
}
80104497:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010449a:	c9                   	leave  
      cprintf("state : EMBRYO\n");
8010449b:	e9 c0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : SLEEPING\n");
801044a0:	c7 45 08 a3 83 10 80 	movl   $0x801083a3,0x8(%ebp)
}
801044a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044aa:	c9                   	leave  
      cprintf("state : SLEEPING\n");
801044ab:	e9 b0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : RUNNABLE\n");
801044b0:	c7 45 08 b5 83 10 80 	movl   $0x801083b5,0x8(%ebp)
}
801044b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044ba:	c9                   	leave  
      cprintf("state : RUNNABLE\n");
801044bb:	e9 a0 c1 ff ff       	jmp    80100660 <cprintf>
}
801044c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044c3:	c9                   	leave  
801044c4:	c3                   	ret    
801044c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <getprocs>:

int
getprocs(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
  struct proc* p;
  cprintf("\n-----------------------------\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044d4:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
801044d9:	83 ec 10             	sub    $0x10,%esp
  cprintf("\n-----------------------------\n");
801044dc:	68 d0 84 10 80       	push   $0x801084d0
801044e1:	e8 7a c1 ff ff       	call   80100660 <cprintf>
801044e6:	83 c4 10             	add    $0x10,%esp
801044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  { if (p->pid == 0)
801044f0:	8b 43 10             	mov    0x10(%ebx),%eax
801044f3:	85 c0                	test   %eax,%eax
801044f5:	74 18                	je     8010450f <getprocs+0x3f>
        continue;    
    printProcess(p);
801044f7:	83 ec 0c             	sub    $0xc,%esp
801044fa:	53                   	push   %ebx
801044fb:	e8 10 ff ff ff       	call   80104410 <printProcess>
    cprintf("\n-----------------------------\n");
80104500:	c7 04 24 d0 84 10 80 	movl   $0x801084d0,(%esp)
80104507:	e8 54 c1 ff ff       	call   80100660 <cprintf>
8010450c:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010450f:	81 c3 94 00 00 00    	add    $0x94,%ebx
80104515:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
8010451b:	72 d3                	jb     801044f0 <getprocs+0x20>
  }
  return 23;
}
8010451d:	b8 17 00 00 00       	mov    $0x17,%eax
80104522:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104525:	c9                   	leave  
80104526:	c3                   	ret    
80104527:	89 f6                	mov    %esi,%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104530 <generate_random>:

int generate_random(int toMod)
{
  int random;
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
80104530:	a1 80 6d 11 80       	mov    0x80116d80,%eax
{
80104535:	55                   	push   %ebp
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
80104536:	31 d2                	xor    %edx,%edx
{
80104538:	89 e5                	mov    %esp,%ebp
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010453a:	0f af c0             	imul   %eax,%eax
8010453d:	0f af c0             	imul   %eax,%eax
80104540:	05 4e 61 bc 00       	add    $0xbc614e,%eax
80104545:	f7 75 08             	divl   0x8(%ebp)
  return random;
}
80104548:	5d                   	pop    %ebp
80104549:	89 d0                	mov    %edx,%eax
8010454b:	c3                   	ret    
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104550 <lotterySched>:

struct proc*
lotterySched(void){
80104550:	55                   	push   %ebp
  int sum_lotteries = 1;
  int random_ticket = 0;
  int isLotterySelected = 0;
  struct proc *highLottery_ticket = 0; //process with highest lottery ticket
  
  sum_lotteries = 1;
80104551:	b9 01 00 00 00       	mov    $0x1,%ecx
  isLotterySelected = 0;
  // Loop over process table looking for process to run.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104556:	b8 34 40 11 80       	mov    $0x80114034,%eax
lotterySched(void){
8010455b:	89 e5                	mov    %esp,%ebp
8010455d:	57                   	push   %edi
8010455e:	56                   	push   %esi
8010455f:	53                   	push   %ebx
    if(p->state != RUNNABLE || p->schedQueue != LOTTERY)
80104560:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104564:	75 0c                	jne    80104572 <lotterySched+0x22>
80104566:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
8010456d:	75 03                	jne    80104572 <lotterySched+0x22>
      continue;
    sum_lotteries += p->lottery_ticket;
8010456f:	03 48 7c             	add    0x7c(%eax),%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104572:	05 94 00 00 00       	add    $0x94,%eax
80104577:	3d 34 65 11 80       	cmp    $0x80116534,%eax
8010457c:	72 e2                	jb     80104560 <lotterySched+0x10>
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010457e:	a1 80 6d 11 80       	mov    0x80116d80,%eax
80104583:	31 d2                	xor    %edx,%edx
  struct proc *highLottery_ticket = 0; //process with highest lottery ticket
80104585:	31 f6                	xor    %esi,%esi
  isLotterySelected = 0;
80104587:	31 db                	xor    %ebx,%ebx
80104589:	bf 02 00 00 00       	mov    $0x2,%edi
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010458e:	0f af c0             	imul   %eax,%eax
80104591:	0f af c0             	imul   %eax,%eax
80104594:	05 4e 61 bc 00       	add    $0xbc614e,%eax
80104599:	f7 f1                	div    %ecx
  }

  random_ticket = generate_random(sum_lotteries);
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010459b:	b9 34 40 11 80       	mov    $0x80114034,%ecx
801045a0:	eb 2c                	jmp    801045ce <lotterySched+0x7e>
801045a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045a8:	83 fb 01             	cmp    $0x1,%ebx
801045ab:	0f 94 c0             	sete   %al
      highLottery_ticket = p;
      isLotterySelected = 1;
      
    }

    if(random_ticket <= 0 && isLotterySelected == 1)
801045ae:	85 d2                	test   %edx,%edx
801045b0:	7f 0e                	jg     801045c0 <lotterySched+0x70>
801045b2:	84 c0                	test   %al,%al
801045b4:	0f 45 f1             	cmovne %ecx,%esi
801045b7:	0f 45 df             	cmovne %edi,%ebx
801045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c0:	81 c1 94 00 00 00    	add    $0x94,%ecx
801045c6:	81 f9 34 65 11 80    	cmp    $0x80116534,%ecx
801045cc:	73 2a                	jae    801045f8 <lotterySched+0xa8>
    if(p->state != RUNNABLE || p->schedQueue != LOTTERY)
801045ce:	83 79 0c 03          	cmpl   $0x3,0xc(%ecx)
801045d2:	75 ec                	jne    801045c0 <lotterySched+0x70>
801045d4:	83 b9 80 00 00 00 02 	cmpl   $0x2,0x80(%ecx)
801045db:	75 e3                	jne    801045c0 <lotterySched+0x70>
    random_ticket -= p->lottery_ticket;
801045dd:	2b 51 7c             	sub    0x7c(%ecx),%edx
    if(!isLotterySelected) {
801045e0:	85 db                	test   %ebx,%ebx
801045e2:	75 c4                	jne    801045a8 <lotterySched+0x58>
801045e4:	89 ce                	mov    %ecx,%esi
801045e6:	b8 01 00 00 00       	mov    $0x1,%eax
      isLotterySelected = 1;
801045eb:	bb 01 00 00 00       	mov    $0x1,%ebx
801045f0:	eb bc                	jmp    801045ae <lotterySched+0x5e>
801045f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
    if(isLotterySelected != 0) {
      return highLottery_ticket;
    }
    return 0;  
801045f8:	85 db                	test   %ebx,%ebx
801045fa:	b8 00 00 00 00       	mov    $0x0,%eax
801045ff:	0f 44 f0             	cmove  %eax,%esi
}
80104602:	5b                   	pop    %ebx
80104603:	89 f0                	mov    %esi,%eax
80104605:	5e                   	pop    %esi
80104606:	5f                   	pop    %edi
80104607:	5d                   	pop    %ebp
80104608:	c3                   	ret    
80104609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104610 <prioritySched>:


struct proc*
prioritySched(void)
{
80104610:	55                   	push   %ebp
  struct proc *p;
  
 
  int priorityProcessSelected = 0;
  struct proc *highPriority = 0; //process with highest priority
80104611:	31 c0                	xor    %eax,%eax
  // Enable interrupts on this processor.
  priorityProcessSelected = 0;
80104613:	31 c9                	xor    %ecx,%ecx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104615:	ba 34 40 11 80       	mov    $0x80114034,%edx
{
8010461a:	89 e5                	mov    %esp,%ebp
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state != RUNNABLE || p->schedQueue != PRIORITY)
80104620:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80104624:	75 22                	jne    80104648 <prioritySched+0x38>
80104626:	83 ba 80 00 00 00 00 	cmpl   $0x0,0x80(%edx)
8010462d:	75 19                	jne    80104648 <prioritySched+0x38>
      continue;

    if(!priorityProcessSelected)
8010462f:	85 c9                	test   %ecx,%ecx
    {
      highPriority = p;
      priorityProcessSelected = 1;
    }
    if(highPriority->priority > p->priority )
80104631:	8b 8a 84 00 00 00    	mov    0x84(%edx),%ecx
    if(!priorityProcessSelected)
80104637:	0f 44 c2             	cmove  %edx,%eax
    if(highPriority->priority > p->priority )
8010463a:	39 88 84 00 00 00    	cmp    %ecx,0x84(%eax)
80104640:	b9 01 00 00 00       	mov    $0x1,%ecx
80104645:	0f 4f c2             	cmovg  %edx,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104648:	81 c2 94 00 00 00    	add    $0x94,%edx
8010464e:	81 fa 34 65 11 80    	cmp    $0x80116534,%edx
80104654:	72 ca                	jb     80104620 <prioritySched+0x10>
  {
    
    return highPriority;
  }
  
  return 0;
80104656:	85 c9                	test   %ecx,%ecx
80104658:	ba 00 00 00 00       	mov    $0x0,%edx
8010465d:	0f 44 c2             	cmove  %edx,%eax

}
80104660:	5d                   	pop    %ebp
80104661:	c3                   	ret    
80104662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104670 <SJFSched>:

// scheduling algorithm
struct proc*
SJFSched(void)
{
80104670:	55                   	push   %ebp
  struct proc *p;
 
  int shortestProcessSelected = 0;
  struct proc *shortestTime = 0; //process that come earlier
80104671:	31 c0                	xor    %eax,%eax
  
  
    shortestProcessSelected = 0;
80104673:	31 c9                	xor    %ecx,%ecx

      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104675:	ba 34 40 11 80       	mov    $0x80114034,%edx
{
8010467a:	89 e5                	mov    %esp,%ebp
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->state != RUNNABLE || p->schedQueue != SJF)
80104680:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80104684:	75 22                	jne    801046a8 <SJFSched+0x38>
80104686:	83 ba 80 00 00 00 01 	cmpl   $0x1,0x80(%edx)
8010468d:	75 19                	jne    801046a8 <SJFSched+0x38>
          continue;
        if(!shortestProcessSelected){
8010468f:	85 c9                	test   %ecx,%ecx
          shortestTime = p;
          shortestProcessSelected = 1;
        }
        if(shortestTime->burst_time > p->burst_time)
80104691:	8b 8a 88 00 00 00    	mov    0x88(%edx),%ecx
        if(!shortestProcessSelected){
80104697:	0f 44 c2             	cmove  %edx,%eax
        if(shortestTime->burst_time > p->burst_time)
8010469a:	39 88 88 00 00 00    	cmp    %ecx,0x88(%eax)
801046a0:	b9 01 00 00 00       	mov    $0x1,%ecx
801046a5:	0f 4f c2             	cmovg  %edx,%eax
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046a8:	81 c2 94 00 00 00    	add    $0x94,%edx
801046ae:	81 fa 34 65 11 80    	cmp    $0x80116534,%edx
801046b4:	72 ca                	jb     80104680 <SJFSched+0x10>
    }
    if(shortestProcessSelected)
    {
      return shortestTime;
    }
  return 0;
801046b6:	85 c9                	test   %ecx,%ecx
801046b8:	ba 00 00 00 00       	mov    $0x0,%edx
801046bd:	0f 44 c2             	cmove  %edx,%eax
}
801046c0:	5d                   	pop    %ebp
801046c1:	c3                   	ret    
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <find_and_set_priority>:

void find_and_set_priority(int priority , int pid)
{
801046d0:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046d1:	b8 34 40 11 80       	mov    $0x80114034,%eax
{
801046d6:	89 e5                	mov    %esp,%ebp
801046d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801046db:	eb 0f                	jmp    801046ec <find_and_set_priority+0x1c>
801046dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e0:	05 94 00 00 00       	add    $0x94,%eax
801046e5:	3d 34 65 11 80       	cmp    $0x80116534,%eax
801046ea:	73 0e                	jae    801046fa <find_and_set_priority+0x2a>
    if(pid == p->pid)
801046ec:	39 50 10             	cmp    %edx,0x10(%eax)
801046ef:	75 ef                	jne    801046e0 <find_and_set_priority+0x10>
    {
      p -> priority = priority;
801046f1:	8b 55 08             	mov    0x8(%ebp),%edx
801046f4:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
      break;
    }
  }
}
801046fa:	5d                   	pop    %ebp
801046fb:	c3                   	ret    
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104700 <find_and_set_lottery_ticket>:

void find_and_set_lottery_ticket(int lottery_ticket , int pid){
80104700:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104701:	b8 34 40 11 80       	mov    $0x80114034,%eax
void find_and_set_lottery_ticket(int lottery_ticket , int pid){
80104706:	89 e5                	mov    %esp,%ebp
80104708:	8b 55 0c             	mov    0xc(%ebp),%edx
8010470b:	eb 0f                	jmp    8010471c <find_and_set_lottery_ticket+0x1c>
8010470d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104710:	05 94 00 00 00       	add    $0x94,%eax
80104715:	3d 34 65 11 80       	cmp    $0x80116534,%eax
8010471a:	73 0b                	jae    80104727 <find_and_set_lottery_ticket+0x27>
    if(pid == p->pid)
8010471c:	39 50 10             	cmp    %edx,0x10(%eax)
8010471f:	75 ef                	jne    80104710 <find_and_set_lottery_ticket+0x10>
    {
      p -> lottery_ticket = lottery_ticket;
80104721:	8b 55 08             	mov    0x8(%ebp),%edx
80104724:	89 50 7c             	mov    %edx,0x7c(%eax)
      break;
    }
  }
}
80104727:	5d                   	pop    %ebp
80104728:	c3                   	ret    
80104729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104730 <find_and_set_sched_queue>:

void 
find_and_set_sched_queue(int qeue_number, int pid)
{
80104730:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104731:	b8 34 40 11 80       	mov    $0x80114034,%eax
{
80104736:	89 e5                	mov    %esp,%ebp
80104738:	8b 55 0c             	mov    0xc(%ebp),%edx
8010473b:	eb 0f                	jmp    8010474c <find_and_set_sched_queue+0x1c>
8010473d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104740:	05 94 00 00 00       	add    $0x94,%eax
80104745:	3d 34 65 11 80       	cmp    $0x80116534,%eax
8010474a:	73 0e                	jae    8010475a <find_and_set_sched_queue+0x2a>
    if(pid == p->pid)
8010474c:	39 50 10             	cmp    %edx,0x10(%eax)
8010474f:	75 ef                	jne    80104740 <find_and_set_sched_queue+0x10>
    {
      p -> schedQueue = qeue_number;
80104751:	8b 55 08             	mov    0x8(%ebp),%edx
80104754:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      break;
    }
  }
}
8010475a:	5d                   	pop    %ebp
8010475b:	c3                   	ret    
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <find_and_set_burst_time>:

void 
find_and_set_burst_time(int burst_time, int pid)
{
80104760:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104761:	b8 34 40 11 80       	mov    $0x80114034,%eax
{
80104766:	89 e5                	mov    %esp,%ebp
80104768:	8b 55 0c             	mov    0xc(%ebp),%edx
8010476b:	eb 0f                	jmp    8010477c <find_and_set_burst_time+0x1c>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104770:	05 94 00 00 00       	add    $0x94,%eax
80104775:	3d 34 65 11 80       	cmp    $0x80116534,%eax
8010477a:	73 0e                	jae    8010478a <find_and_set_burst_time+0x2a>
    if(pid == p->pid)
8010477c:	39 50 10             	cmp    %edx,0x10(%eax)
8010477f:	75 ef                	jne    80104770 <find_and_set_burst_time+0x10>
    {
      p -> burst_time = burst_time;
80104781:	8b 55 08             	mov    0x8(%ebp),%edx
80104784:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      break;
    }
  }
}
8010478a:	5d                   	pop    %ebp
8010478b:	c3                   	ret    
8010478c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104790 <print_state>:

char* print_state(int state){
80104790:	55                   	push   %ebp
  if(state == 0){
    return "UNUSED";
80104791:	b8 e8 83 10 80       	mov    $0x801083e8,%eax
char* print_state(int state){
80104796:	89 e5                	mov    %esp,%ebp
80104798:	8b 55 08             	mov    0x8(%ebp),%edx
  if(state == 0){
8010479b:	85 d2                	test   %edx,%edx
8010479d:	74 38                	je     801047d7 <print_state+0x47>
  }else if(state == 1){
8010479f:	83 fa 01             	cmp    $0x1,%edx
    return "EMBRYO";
801047a2:	b8 ef 83 10 80       	mov    $0x801083ef,%eax
  }else if(state == 1){
801047a7:	74 2e                	je     801047d7 <print_state+0x47>
  }else if(state == 2){
801047a9:	83 fa 02             	cmp    $0x2,%edx
    return "SLEEPING";
801047ac:	b8 f6 83 10 80       	mov    $0x801083f6,%eax
  }else if(state == 2){
801047b1:	74 24                	je     801047d7 <print_state+0x47>
  }else if(state == 3){
801047b3:	83 fa 03             	cmp    $0x3,%edx
    return "RUNNABLE";
801047b6:	b8 ff 83 10 80       	mov    $0x801083ff,%eax
  }else if(state == 3){
801047bb:	74 1a                	je     801047d7 <print_state+0x47>
  }else if(state == 4){
801047bd:	83 fa 04             	cmp    $0x4,%edx
    return "RUNNING";
801047c0:	b8 0f 84 10 80       	mov    $0x8010840f,%eax
  }else if(state == 4){
801047c5:	74 10                	je     801047d7 <print_state+0x47>
  }else if(state == 5){
    return "ZOMBIE";
  }else{
    return "";
801047c7:	83 fa 05             	cmp    $0x5,%edx
801047ca:	b8 08 84 10 80       	mov    $0x80108408,%eax
801047cf:	ba a0 88 10 80       	mov    $0x801088a0,%edx
801047d4:	0f 45 c2             	cmovne %edx,%eax
  }
}
801047d7:	5d                   	pop    %ebp
801047d8:	c3                   	ret    
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047e0 <int_size>:

int int_size(int i){
801047e0:	55                   	push   %ebp
    if( i >= 1000000000) return 10;
801047e1:	b8 0a 00 00 00       	mov    $0xa,%eax
int int_size(int i){
801047e6:	89 e5                	mov    %esp,%ebp
801047e8:	8b 55 08             	mov    0x8(%ebp),%edx
    if( i >= 1000000000) return 10;
801047eb:	81 fa ff c9 9a 3b    	cmp    $0x3b9ac9ff,%edx
801047f1:	7f 63                	jg     80104856 <int_size+0x76>
    if( i >= 100000000)  return 9;
801047f3:	81 fa ff e0 f5 05    	cmp    $0x5f5e0ff,%edx
801047f9:	b8 09 00 00 00       	mov    $0x9,%eax
801047fe:	7f 56                	jg     80104856 <int_size+0x76>
    if( i >= 10000000)   return 8;
80104800:	81 fa 7f 96 98 00    	cmp    $0x98967f,%edx
80104806:	b8 08 00 00 00       	mov    $0x8,%eax
8010480b:	7f 49                	jg     80104856 <int_size+0x76>
    if( i >= 1000000)    return 7;
8010480d:	81 fa 3f 42 0f 00    	cmp    $0xf423f,%edx
80104813:	b8 07 00 00 00       	mov    $0x7,%eax
80104818:	7f 3c                	jg     80104856 <int_size+0x76>
    if( i >= 100000)     return 6;
8010481a:	81 fa 9f 86 01 00    	cmp    $0x1869f,%edx
80104820:	b8 06 00 00 00       	mov    $0x6,%eax
80104825:	7f 2f                	jg     80104856 <int_size+0x76>
    if( i >= 10000)      return 5;
80104827:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
8010482d:	b8 05 00 00 00       	mov    $0x5,%eax
80104832:	7f 22                	jg     80104856 <int_size+0x76>
    if( i >= 1000)       return 4;
80104834:	81 fa e7 03 00 00    	cmp    $0x3e7,%edx
8010483a:	b8 04 00 00 00       	mov    $0x4,%eax
8010483f:	7f 15                	jg     80104856 <int_size+0x76>
    if( i >= 100)        return 3;
80104841:	83 fa 63             	cmp    $0x63,%edx
80104844:	b8 03 00 00 00       	mov    $0x3,%eax
80104849:	7f 0b                	jg     80104856 <int_size+0x76>
    if( i >= 10)         return 2;
                        return 1;
8010484b:	31 c0                	xor    %eax,%eax
8010484d:	83 fa 09             	cmp    $0x9,%edx
80104850:	0f 9f c0             	setg   %al
80104853:	83 c0 01             	add    $0x1,%eax
}
80104856:	5d                   	pop    %ebp
80104857:	c3                   	ret    
80104858:	90                   	nop
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104860 <find_queue_name>:

char* find_queue_name(int queue){
80104860:	55                   	push   %ebp
  if(queue == 3){
    return "PRIORITY";
80104861:	b8 17 84 10 80       	mov    $0x80108417,%eax
char* find_queue_name(int queue){
80104866:	89 e5                	mov    %esp,%ebp
80104868:	8b 55 08             	mov    0x8(%ebp),%edx
  if(queue == 3){
8010486b:	83 fa 03             	cmp    $0x3,%edx
8010486e:	74 1a                	je     8010488a <find_queue_name+0x2a>
  }else if(queue == 2){
80104870:	83 fa 02             	cmp    $0x2,%edx
    return "SJF";
80104873:	b8 28 84 10 80       	mov    $0x80108428,%eax
  }else if(queue == 2){
80104878:	74 10                	je     8010488a <find_queue_name+0x2a>
  }else if(queue == 1){
    return "LOTTERY";
  }else{
    return "";
8010487a:	83 fa 01             	cmp    $0x1,%edx
8010487d:	b8 20 84 10 80       	mov    $0x80108420,%eax
80104882:	ba a0 88 10 80       	mov    $0x801088a0,%edx
80104887:	0f 45 c2             	cmovne %edx,%eax
  }
}
8010488a:	5d                   	pop    %ebp
8010488b:	c3                   	ret    
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104890 <show_all_processes_scheduling>:

void
show_all_processes_scheduling()
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	57                   	push   %edi
80104894:	56                   	push   %esi
80104895:	53                   	push   %ebx
  struct proc *p;
  int name_spaces = 0;
80104896:	31 ff                	xor    %edi,%edi
  int i = 0 ;
  char* state;
  char* queue_name;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104898:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
8010489d:	83 ec 1c             	sub    $0x1c,%esp
801048a0:	eb 14                	jmp    801048b6 <show_all_processes_scheduling+0x26>
801048a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048a8:	81 c3 94 00 00 00    	add    $0x94,%ebx
801048ae:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
801048b4:	73 36                	jae    801048ec <show_all_processes_scheduling+0x5c>
    if(p->pid == 0)
801048b6:	8b 73 10             	mov    0x10(%ebx),%esi
801048b9:	85 f6                	test   %esi,%esi
801048bb:	74 eb                	je     801048a8 <show_all_processes_scheduling+0x18>
801048bd:	8d 73 6c             	lea    0x6c(%ebx),%esi
      continue;
    if( name_spaces < strlen(p->name))
801048c0:	83 ec 0c             	sub    $0xc,%esp
801048c3:	56                   	push   %esi
801048c4:	e8 37 0b 00 00       	call   80105400 <strlen>
801048c9:	83 c4 10             	add    $0x10,%esp
801048cc:	39 f8                	cmp    %edi,%eax
801048ce:	7e d8                	jle    801048a8 <show_all_processes_scheduling+0x18>
      name_spaces = strlen(p->name);
801048d0:	83 ec 0c             	sub    $0xc,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048d3:	81 c3 94 00 00 00    	add    $0x94,%ebx
      name_spaces = strlen(p->name);
801048d9:	56                   	push   %esi
801048da:	e8 21 0b 00 00       	call   80105400 <strlen>
801048df:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048e2:	81 fb 34 65 11 80    	cmp    $0x80116534,%ebx
      name_spaces = strlen(p->name);
801048e8:	89 c7                	mov    %eax,%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048ea:	72 ca                	jb     801048b6 <show_all_processes_scheduling+0x26>
  }

  cprintf("name");
801048ec:	83 ec 0c             	sub    $0xc,%esp
801048ef:	89 7d e0             	mov    %edi,-0x20(%ebp)
801048f2:	89 fe                	mov    %edi,%esi
801048f4:	68 2c 84 10 80       	push   $0x8010842c
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
801048f9:	31 db                	xor    %ebx,%ebx
  cprintf("name");
801048fb:	e8 60 bd ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
80104900:	83 c4 10             	add    $0x10,%esp
80104903:	eb 16                	jmp    8010491b <show_all_processes_scheduling+0x8b>
80104905:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf(" ");
80104908:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
8010490b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" ");
8010490e:	68 9c 84 10 80       	push   $0x8010849c
80104913:	e8 48 bd ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
80104918:	83 c4 10             	add    $0x10,%esp
8010491b:	83 ec 0c             	sub    $0xc,%esp
8010491e:	68 2c 84 10 80       	push   $0x8010842c
80104923:	e8 d8 0a 00 00       	call   80105400 <strlen>
80104928:	89 f2                	mov    %esi,%edx
8010492a:	83 c4 10             	add    $0x10,%esp
8010492d:	29 c2                	sub    %eax,%edx
8010492f:	89 d0                	mov    %edx,%eax
80104931:	83 c0 02             	add    $0x2,%eax
80104934:	39 d8                	cmp    %ebx,%eax
80104936:	7d d0                	jge    80104908 <show_all_processes_scheduling+0x78>
  
  cprintf("pid");
80104938:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0 ; i < 4; i++)
    cprintf(" ");
  cprintf("state");
8010493b:	bb 06 00 00 00       	mov    $0x6,%ebx
  cprintf("pid");
80104940:	68 31 84 10 80       	push   $0x80108431
80104945:	e8 16 bd ff ff       	call   80100660 <cprintf>
    cprintf(" ");
8010494a:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104951:	e8 0a bd ff ff       	call   80100660 <cprintf>
80104956:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
8010495d:	e8 fe bc ff ff       	call   80100660 <cprintf>
80104962:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104969:	e8 f2 bc ff ff       	call   80100660 <cprintf>
8010496e:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104975:	e8 e6 bc ff ff       	call   80100660 <cprintf>
  cprintf("state");
8010497a:	c7 04 24 35 84 10 80 	movl   $0x80108435,(%esp)
80104981:	e8 da bc ff ff       	call   80100660 <cprintf>
80104986:	83 c4 10             	add    $0x10,%esp
80104989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0 ; i < 6; i++)
    cprintf(" ");
80104990:	83 ec 0c             	sub    $0xc,%esp
80104993:	68 9c 84 10 80       	push   $0x8010849c
80104998:	e8 c3 bc ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < 6; i++)
8010499d:	83 c4 10             	add    $0x10,%esp
801049a0:	83 eb 01             	sub    $0x1,%ebx
801049a3:	75 eb                	jne    80104990 <show_all_processes_scheduling+0x100>
  cprintf("queue");
801049a5:	83 ec 0c             	sub    $0xc,%esp
  cprintf("createTime");
  for(i = 0 ; i < 2; i++)
    cprintf(" ");
  cprintf("number\n");
  cprintf("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049a8:	bf 34 40 11 80       	mov    $0x80114034,%edi
  cprintf("queue");
801049ad:	68 3b 84 10 80       	push   $0x8010843b
801049b2:	e8 a9 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
801049b7:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
801049be:	e8 9d bc ff ff       	call   80100660 <cprintf>
801049c3:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
801049ca:	e8 91 bc ff ff       	call   80100660 <cprintf>
801049cf:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
801049d6:	e8 85 bc ff ff       	call   80100660 <cprintf>
801049db:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
801049e2:	e8 79 bc ff ff       	call   80100660 <cprintf>
801049e7:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
801049ee:	e8 6d bc ff ff       	call   80100660 <cprintf>
  cprintf("priority");
801049f3:	c7 04 24 41 84 10 80 	movl   $0x80108441,(%esp)
801049fa:	e8 61 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
801049ff:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a06:	e8 55 bc ff ff       	call   80100660 <cprintf>
80104a0b:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a12:	e8 49 bc ff ff       	call   80100660 <cprintf>
80104a17:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a1e:	e8 3d bc ff ff       	call   80100660 <cprintf>
  cprintf("lottery");
80104a23:	c7 04 24 4a 84 10 80 	movl   $0x8010844a,(%esp)
80104a2a:	e8 31 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a2f:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a36:	e8 25 bc ff ff       	call   80100660 <cprintf>
80104a3b:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a42:	e8 19 bc ff ff       	call   80100660 <cprintf>
80104a47:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a4e:	e8 0d bc ff ff       	call   80100660 <cprintf>
  cprintf("burstTime");
80104a53:	c7 04 24 52 84 10 80 	movl   $0x80108452,(%esp)
80104a5a:	e8 01 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a5f:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a66:	e8 f5 bb ff ff       	call   80100660 <cprintf>
80104a6b:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a72:	e8 e9 bb ff ff       	call   80100660 <cprintf>
80104a77:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a7e:	e8 dd bb ff ff       	call   80100660 <cprintf>
  cprintf("createTime");
80104a83:	c7 04 24 5c 84 10 80 	movl   $0x8010845c,(%esp)
80104a8a:	e8 d1 bb ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a8f:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104a96:	e8 c5 bb ff ff       	call   80100660 <cprintf>
80104a9b:	c7 04 24 9c 84 10 80 	movl   $0x8010849c,(%esp)
80104aa2:	e8 b9 bb ff ff       	call   80100660 <cprintf>
  cprintf("number\n");
80104aa7:	c7 04 24 67 84 10 80 	movl   $0x80108467,(%esp)
80104aae:	e8 ad bb ff ff       	call   80100660 <cprintf>
  cprintf("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n");
80104ab3:	c7 04 24 f0 84 10 80 	movl   $0x801084f0,(%esp)
80104aba:	e8 a1 bb ff ff       	call   80100660 <cprintf>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	eb 16                	jmp    80104ada <show_all_processes_scheduling+0x24a>
80104ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ac8:	81 c7 94 00 00 00    	add    $0x94,%edi
80104ace:	81 ff 34 65 11 80    	cmp    $0x80116534,%edi
80104ad4:	0f 83 d6 02 00 00    	jae    80104db0 <show_all_processes_scheduling+0x520>
    if(p->pid == 0)
80104ada:	8b 5f 10             	mov    0x10(%edi),%ebx
80104add:	85 db                	test   %ebx,%ebx
80104adf:	74 e7                	je     80104ac8 <show_all_processes_scheduling+0x238>
80104ae1:	8d 77 6c             	lea    0x6c(%edi),%esi
      continue;
    cprintf("%s", p->name);
80104ae4:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104ae7:	31 db                	xor    %ebx,%ebx
    cprintf("%s", p->name);
80104ae9:	56                   	push   %esi
80104aea:	68 6a 83 10 80       	push   $0x8010836a
80104aef:	e8 6c bb ff ff       	call   80100660 <cprintf>
80104af4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104af7:	83 c4 10             	add    $0x10,%esp
80104afa:	8b 7d e0             	mov    -0x20(%ebp),%edi
80104afd:	eb 14                	jmp    80104b13 <show_all_processes_scheduling+0x283>
80104aff:	90                   	nop
      cprintf(" ");
80104b00:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104b03:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104b06:	68 9c 84 10 80       	push   $0x8010849c
80104b0b:	e8 50 bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104b10:	83 c4 10             	add    $0x10,%esp
80104b13:	83 ec 0c             	sub    $0xc,%esp
80104b16:	56                   	push   %esi
80104b17:	e8 e4 08 00 00       	call   80105400 <strlen>
80104b1c:	89 fa                	mov    %edi,%edx
80104b1e:	83 c4 10             	add    $0x10,%esp
80104b21:	29 c2                	sub    %eax,%edx
80104b23:	89 d0                	mov    %edx,%eax
80104b25:	83 c0 03             	add    $0x3,%eax
80104b28:	39 d8                	cmp    %ebx,%eax
80104b2a:	7d d4                	jge    80104b00 <show_all_processes_scheduling+0x270>
80104b2c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    cprintf("%d", p->pid);
80104b2f:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b32:	31 db                	xor    %ebx,%ebx
    cprintf("%d", p->pid);
80104b34:	ff 77 10             	pushl  0x10(%edi)
80104b37:	68 6f 84 10 80       	push   $0x8010846f
80104b3c:	e8 1f bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b41:	83 c4 10             	add    $0x10,%esp
80104b44:	eb 1d                	jmp    80104b63 <show_all_processes_scheduling+0x2d3>
80104b46:	8d 76 00             	lea    0x0(%esi),%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      cprintf(" ");
80104b50:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b53:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104b56:	68 9c 84 10 80       	push   $0x8010849c
80104b5b:	e8 00 bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b60:	83 c4 10             	add    $0x10,%esp
80104b63:	83 ec 0c             	sub    $0xc,%esp
80104b66:	ff 77 10             	pushl  0x10(%edi)
80104b69:	e8 72 fc ff ff       	call   801047e0 <int_size>
80104b6e:	b9 06 00 00 00       	mov    $0x6,%ecx
80104b73:	83 c4 10             	add    $0x10,%esp
80104b76:	29 c1                	sub    %eax,%ecx
80104b78:	39 d9                	cmp    %ebx,%ecx
80104b7a:	7f d4                	jg     80104b50 <show_all_processes_scheduling+0x2c0>
    state = print_state(p->state);
80104b7c:	83 ec 0c             	sub    $0xc,%esp
80104b7f:	ff 77 0c             	pushl  0xc(%edi)
    cprintf("%s" , state);
    for(i = 0 ; i < 11 - strlen(state); i++)
80104b82:	31 db                	xor    %ebx,%ebx
    state = print_state(p->state);
80104b84:	e8 07 fc ff ff       	call   80104790 <print_state>
80104b89:	5a                   	pop    %edx
80104b8a:	59                   	pop    %ecx
    cprintf("%s" , state);
80104b8b:	50                   	push   %eax
80104b8c:	68 6a 83 10 80       	push   $0x8010836a
    state = print_state(p->state);
80104b91:	89 c6                	mov    %eax,%esi
    cprintf("%s" , state);
80104b93:	e8 c8 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 11 - strlen(state); i++)
80104b98:	83 c4 10             	add    $0x10,%esp
80104b9b:	eb 16                	jmp    80104bb3 <show_all_processes_scheduling+0x323>
80104b9d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf(" ");
80104ba0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 11 - strlen(state); i++)
80104ba3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104ba6:	68 9c 84 10 80       	push   $0x8010849c
80104bab:	e8 b0 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 11 - strlen(state); i++)
80104bb0:	83 c4 10             	add    $0x10,%esp
80104bb3:	83 ec 0c             	sub    $0xc,%esp
80104bb6:	56                   	push   %esi
80104bb7:	e8 44 08 00 00       	call   80105400 <strlen>
80104bbc:	ba 0b 00 00 00       	mov    $0xb,%edx
80104bc1:	83 c4 10             	add    $0x10,%esp
80104bc4:	29 c2                	sub    %eax,%edx
80104bc6:	39 da                	cmp    %ebx,%edx
80104bc8:	7f d6                	jg     80104ba0 <show_all_processes_scheduling+0x310>
    queue_name =  find_queue_name(p->schedQueue);
80104bca:	8b 87 80 00 00 00    	mov    0x80(%edi),%eax
    return "PRIORITY";
80104bd0:	be 17 84 10 80       	mov    $0x80108417,%esi
  if(queue == 3){
80104bd5:	83 f8 03             	cmp    $0x3,%eax
80104bd8:	74 1a                	je     80104bf4 <show_all_processes_scheduling+0x364>
  }else if(queue == 2){
80104bda:	83 f8 02             	cmp    $0x2,%eax
    return "SJF";
80104bdd:	be 28 84 10 80       	mov    $0x80108428,%esi
  }else if(queue == 2){
80104be2:	74 10                	je     80104bf4 <show_all_processes_scheduling+0x364>
    return "";
80104be4:	83 f8 01             	cmp    $0x1,%eax
80104be7:	be 20 84 10 80       	mov    $0x80108420,%esi
80104bec:	b8 a0 88 10 80       	mov    $0x801088a0,%eax
80104bf1:	0f 45 f0             	cmovne %eax,%esi
    cprintf("%s ", queue_name);
80104bf4:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104bf7:	31 db                	xor    %ebx,%ebx
    cprintf("%s ", queue_name);
80104bf9:	56                   	push   %esi
80104bfa:	68 72 84 10 80       	push   $0x80108472
80104bff:	e8 5c ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104c04:	83 c4 10             	add    $0x10,%esp
80104c07:	eb 1a                	jmp    80104c23 <show_all_processes_scheduling+0x393>
80104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104c10:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104c13:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104c16:	68 9c 84 10 80       	push   $0x8010849c
80104c1b:	e8 40 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104c20:	83 c4 10             	add    $0x10,%esp
80104c23:	83 ec 0c             	sub    $0xc,%esp
80104c26:	56                   	push   %esi
80104c27:	e8 d4 07 00 00       	call   80105400 <strlen>
80104c2c:	b9 0c 00 00 00       	mov    $0xc,%ecx
80104c31:	83 c4 10             	add    $0x10,%esp
80104c34:	29 c1                	sub    %eax,%ecx
80104c36:	39 d9                	cmp    %ebx,%ecx
80104c38:	7f d6                	jg     80104c10 <show_all_processes_scheduling+0x380>
    cprintf("%d  ", p->priority);
80104c3a:	83 ec 08             	sub    $0x8,%esp
80104c3d:	ff b7 84 00 00 00    	pushl  0x84(%edi)
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c43:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->priority);
80104c45:	68 76 84 10 80       	push   $0x80108476
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c4a:	be 08 00 00 00       	mov    $0x8,%esi
    cprintf("%d  ", p->priority);
80104c4f:	e8 0c ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c54:	83 c4 10             	add    $0x10,%esp
80104c57:	eb 1a                	jmp    80104c73 <show_all_processes_scheduling+0x3e3>
80104c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104c60:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c63:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104c66:	68 9c 84 10 80       	push   $0x8010849c
80104c6b:	e8 f0 b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c70:	83 c4 10             	add    $0x10,%esp
80104c73:	83 ec 0c             	sub    $0xc,%esp
80104c76:	ff b7 84 00 00 00    	pushl  0x84(%edi)
80104c7c:	e8 5f fb ff ff       	call   801047e0 <int_size>
80104c81:	89 f2                	mov    %esi,%edx
80104c83:	83 c4 10             	add    $0x10,%esp
80104c86:	29 c2                	sub    %eax,%edx
80104c88:	39 da                	cmp    %ebx,%edx
80104c8a:	7f d4                	jg     80104c60 <show_all_processes_scheduling+0x3d0>
    cprintf("%d  ", p->lottery_ticket);
80104c8c:	83 ec 08             	sub    $0x8,%esp
80104c8f:	ff 77 7c             	pushl  0x7c(%edi)
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c92:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->lottery_ticket);
80104c94:	68 76 84 10 80       	push   $0x80108476
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c99:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->lottery_ticket);
80104c9e:	e8 bd b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104ca3:	83 c4 10             	add    $0x10,%esp
80104ca6:	eb 1b                	jmp    80104cc3 <show_all_processes_scheduling+0x433>
80104ca8:	90                   	nop
80104ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104cb0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104cb3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104cb6:	68 9c 84 10 80       	push   $0x8010849c
80104cbb:	e8 a0 b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104cc0:	83 c4 10             	add    $0x10,%esp
80104cc3:	83 ec 0c             	sub    $0xc,%esp
80104cc6:	ff 77 7c             	pushl  0x7c(%edi)
80104cc9:	e8 12 fb ff ff       	call   801047e0 <int_size>
80104cce:	89 f1                	mov    %esi,%ecx
80104cd0:	83 c4 10             	add    $0x10,%esp
80104cd3:	29 c1                	sub    %eax,%ecx
80104cd5:	39 d9                	cmp    %ebx,%ecx
80104cd7:	7f d7                	jg     80104cb0 <show_all_processes_scheduling+0x420>
    cprintf("%d  ", p->burst_time);
80104cd9:	83 ec 08             	sub    $0x8,%esp
80104cdc:	ff b7 88 00 00 00    	pushl  0x88(%edi)
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104ce2:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->burst_time);
80104ce4:	68 76 84 10 80       	push   $0x80108476
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104ce9:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->burst_time);
80104cee:	e8 6d b9 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104cf3:	83 c4 10             	add    $0x10,%esp
80104cf6:	eb 1b                	jmp    80104d13 <show_all_processes_scheduling+0x483>
80104cf8:	90                   	nop
80104cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104d00:	83 ec 0c             	sub    $0xc,%esp
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d03:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104d06:	68 9c 84 10 80       	push   $0x8010849c
80104d0b:	e8 50 b9 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104d10:	83 c4 10             	add    $0x10,%esp
80104d13:	83 ec 0c             	sub    $0xc,%esp
80104d16:	ff b7 88 00 00 00    	pushl  0x88(%edi)
80104d1c:	e8 bf fa ff ff       	call   801047e0 <int_size>
80104d21:	89 f2                	mov    %esi,%edx
80104d23:	83 c4 10             	add    $0x10,%esp
80104d26:	29 c2                	sub    %eax,%edx
80104d28:	39 da                	cmp    %ebx,%edx
80104d2a:	7f d4                	jg     80104d00 <show_all_processes_scheduling+0x470>
    cprintf("%d  ", p->creation_time);
80104d2c:	83 ec 08             	sub    $0x8,%esp
80104d2f:	ff b7 8c 00 00 00    	pushl  0x8c(%edi)
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104d35:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->creation_time);
80104d37:	68 76 84 10 80       	push   $0x80108476
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104d3c:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->creation_time);
80104d41:	e8 1a b9 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104d46:	83 c4 10             	add    $0x10,%esp
80104d49:	eb 18                	jmp    80104d63 <show_all_processes_scheduling+0x4d3>
80104d4b:	90                   	nop
80104d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104d50:	83 ec 0c             	sub    $0xc,%esp
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104d53:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104d56:	68 9c 84 10 80       	push   $0x8010849c
80104d5b:	e8 00 b9 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->creation_time); i++)
80104d60:	83 c4 10             	add    $0x10,%esp
80104d63:	83 ec 0c             	sub    $0xc,%esp
80104d66:	ff b7 8c 00 00 00    	pushl  0x8c(%edi)
80104d6c:	e8 6f fa ff ff       	call   801047e0 <int_size>
80104d71:	89 f1                	mov    %esi,%ecx
80104d73:	83 c4 10             	add    $0x10,%esp
80104d76:	29 c1                	sub    %eax,%ecx
80104d78:	39 d9                	cmp    %ebx,%ecx
80104d7a:	7f d4                	jg     80104d50 <show_all_processes_scheduling+0x4c0>
    cprintf("%d  " , p->process_count);
80104d7c:	83 ec 08             	sub    $0x8,%esp
80104d7f:	ff b7 90 00 00 00    	pushl  0x90(%edi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d85:	81 c7 94 00 00 00    	add    $0x94,%edi
    cprintf("%d  " , p->process_count);
80104d8b:	68 76 84 10 80       	push   $0x80108476
80104d90:	e8 cb b8 ff ff       	call   80100660 <cprintf>
    cprintf("\n");
80104d95:	c7 04 24 9f 88 10 80 	movl   $0x8010889f,(%esp)
80104d9c:	e8 bf b8 ff ff       	call   80100660 <cprintf>
80104da1:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104da4:	81 ff 34 65 11 80    	cmp    $0x80116534,%edi
80104daa:	0f 82 2a fd ff ff    	jb     80104ada <show_all_processes_scheduling+0x24a>
  }
}
80104db0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104db3:	5b                   	pop    %ebx
80104db4:	5e                   	pop    %esi
80104db5:	5f                   	pop    %edi
80104db6:	5d                   	pop    %ebp
80104db7:	c3                   	ret    
80104db8:	90                   	nop
80104db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104dc0 <scheduler>:

void
scheduler(void)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	56                   	push   %esi
80104dc4:	53                   	push   %ebx
80104dc5:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;  
  struct cpu *c = mycpu();
80104dc8:	e8 33 ed ff ff       	call   80103b00 <mycpu>
80104dcd:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104dcf:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104dd6:	00 00 00 
80104dd9:	8d 70 04             	lea    0x4(%eax),%esi
80104ddc:	eb 4b                	jmp    80104e29 <scheduler+0x69>
80104dde:	66 90                	xchg   %ax,%ax
    if(p !=0 ) {
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80104de0:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104de3:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
      switchuvm(p);
80104de9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104dec:	50                   	push   %eax
80104ded:	e8 9e 28 00 00       	call   80107690 <switchuvm>
      p->state = RUNNING;
80104df2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104df5:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

      swtch(&(c->scheduler), p->context);
80104dfc:	5a                   	pop    %edx
80104dfd:	59                   	pop    %ecx
80104dfe:	ff 70 1c             	pushl  0x1c(%eax)
80104e01:	56                   	push   %esi
80104e02:	e8 14 06 00 00       	call   8010541b <swtch>
      switchkvm();
80104e07:	e8 64 28 00 00       	call   80107670 <switchkvm>
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80104e0c:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104e13:	00 00 00 
80104e16:	83 c4 10             	add    $0x10,%esp
    }

    release(&ptable.lock);
80104e19:	83 ec 0c             	sub    $0xc,%esp
80104e1c:	68 00 40 11 80       	push   $0x80114000
80104e21:	e8 6a 03 00 00       	call   80105190 <release>
    sti();
80104e26:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
80104e29:	fb                   	sti    
    acquire(&ptable.lock);
80104e2a:	83 ec 0c             	sub    $0xc,%esp
80104e2d:	68 00 40 11 80       	push   $0x80114000
80104e32:	e8 99 02 00 00       	call   801050d0 <acquire>
    p = lotterySched();
80104e37:	e8 14 f7 ff ff       	call   80104550 <lotterySched>
    if(p == 0)
80104e3c:	83 c4 10             	add    $0x10,%esp
80104e3f:	85 c0                	test   %eax,%eax
80104e41:	75 9d                	jne    80104de0 <scheduler+0x20>
      p = SJFSched();
80104e43:	e8 28 f8 ff ff       	call   80104670 <SJFSched>
    if(p == 0)
80104e48:	85 c0                	test   %eax,%eax
80104e4a:	75 94                	jne    80104de0 <scheduler+0x20>
      p = prioritySched();
80104e4c:	e8 bf f7 ff ff       	call   80104610 <prioritySched>
    if(p !=0 ) {
80104e51:	85 c0                	test   %eax,%eax
80104e53:	74 c4                	je     80104e19 <scheduler+0x59>
80104e55:	eb 89                	jmp    80104de0 <scheduler+0x20>
80104e57:	66 90                	xchg   %ax,%ax
80104e59:	66 90                	xchg   %ax,%ax
80104e5b:	66 90                	xchg   %ax,%ax
80104e5d:	66 90                	xchg   %ax,%ax
80104e5f:	90                   	nop

80104e60 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	53                   	push   %ebx
80104e64:	83 ec 0c             	sub    $0xc,%esp
80104e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104e6a:	68 74 85 10 80       	push   $0x80108574
80104e6f:	8d 43 04             	lea    0x4(%ebx),%eax
80104e72:	50                   	push   %eax
80104e73:	e8 18 01 00 00       	call   80104f90 <initlock>
  lk->name = name;
80104e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104e7b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e81:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e84:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e8b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e91:	c9                   	leave  
80104e92:	c3                   	ret    
80104e93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	56                   	push   %esi
80104ea4:	53                   	push   %ebx
80104ea5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ea8:	83 ec 0c             	sub    $0xc,%esp
80104eab:	8d 73 04             	lea    0x4(%ebx),%esi
80104eae:	56                   	push   %esi
80104eaf:	e8 1c 02 00 00       	call   801050d0 <acquire>
  while (lk->locked) {
80104eb4:	8b 13                	mov    (%ebx),%edx
80104eb6:	83 c4 10             	add    $0x10,%esp
80104eb9:	85 d2                	test   %edx,%edx
80104ebb:	74 16                	je     80104ed3 <acquiresleep+0x33>
80104ebd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104ec0:	83 ec 08             	sub    $0x8,%esp
80104ec3:	56                   	push   %esi
80104ec4:	53                   	push   %ebx
80104ec5:	e8 d6 f1 ff ff       	call   801040a0 <sleep>
  while (lk->locked) {
80104eca:	8b 03                	mov    (%ebx),%eax
80104ecc:	83 c4 10             	add    $0x10,%esp
80104ecf:	85 c0                	test   %eax,%eax
80104ed1:	75 ed                	jne    80104ec0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104ed3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104ed9:	e8 c2 ec ff ff       	call   80103ba0 <myproc>
80104ede:	8b 40 10             	mov    0x10(%eax),%eax
80104ee1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104ee4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ee7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eea:	5b                   	pop    %ebx
80104eeb:	5e                   	pop    %esi
80104eec:	5d                   	pop    %ebp
  release(&lk->lk);
80104eed:	e9 9e 02 00 00       	jmp    80105190 <release>
80104ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f00 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
80104f05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104f08:	83 ec 0c             	sub    $0xc,%esp
80104f0b:	8d 73 04             	lea    0x4(%ebx),%esi
80104f0e:	56                   	push   %esi
80104f0f:	e8 bc 01 00 00       	call   801050d0 <acquire>
  lk->locked = 0;
80104f14:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f1a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104f21:	89 1c 24             	mov    %ebx,(%esp)
80104f24:	e8 37 f3 ff ff       	call   80104260 <wakeup>
  release(&lk->lk);
80104f29:	89 75 08             	mov    %esi,0x8(%ebp)
80104f2c:	83 c4 10             	add    $0x10,%esp
}
80104f2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f32:	5b                   	pop    %ebx
80104f33:	5e                   	pop    %esi
80104f34:	5d                   	pop    %ebp
  release(&lk->lk);
80104f35:	e9 56 02 00 00       	jmp    80105190 <release>
80104f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f40 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
80104f46:	31 ff                	xor    %edi,%edi
80104f48:	83 ec 18             	sub    $0x18,%esp
80104f4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104f4e:	8d 73 04             	lea    0x4(%ebx),%esi
80104f51:	56                   	push   %esi
80104f52:	e8 79 01 00 00       	call   801050d0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104f57:	8b 03                	mov    (%ebx),%eax
80104f59:	83 c4 10             	add    $0x10,%esp
80104f5c:	85 c0                	test   %eax,%eax
80104f5e:	74 13                	je     80104f73 <holdingsleep+0x33>
80104f60:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f63:	e8 38 ec ff ff       	call   80103ba0 <myproc>
80104f68:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f6b:	0f 94 c0             	sete   %al
80104f6e:	0f b6 c0             	movzbl %al,%eax
80104f71:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104f73:	83 ec 0c             	sub    $0xc,%esp
80104f76:	56                   	push   %esi
80104f77:	e8 14 02 00 00       	call   80105190 <release>
  return r;
}
80104f7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f7f:	89 f8                	mov    %edi,%eax
80104f81:	5b                   	pop    %ebx
80104f82:	5e                   	pop    %esi
80104f83:	5f                   	pop    %edi
80104f84:	5d                   	pop    %ebp
80104f85:	c3                   	ret    
80104f86:	66 90                	xchg   %ax,%ax
80104f88:	66 90                	xchg   %ax,%ax
80104f8a:	66 90                	xchg   %ax,%ax
80104f8c:	66 90                	xchg   %ax,%ax
80104f8e:	66 90                	xchg   %ax,%ax

80104f90 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f96:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f9f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104fa2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104fa9:	5d                   	pop    %ebp
80104faa:	c3                   	ret    
80104fab:	90                   	nop
80104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104fb0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104fb1:	31 d2                	xor    %edx,%edx
{
80104fb3:	89 e5                	mov    %esp,%ebp
80104fb5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104fb6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104fb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104fbc:	83 e8 08             	sub    $0x8,%eax
80104fbf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104fc0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104fc6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104fcc:	77 1a                	ja     80104fe8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104fce:	8b 58 04             	mov    0x4(%eax),%ebx
80104fd1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104fd4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104fd7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104fd9:	83 fa 0a             	cmp    $0xa,%edx
80104fdc:	75 e2                	jne    80104fc0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104fde:	5b                   	pop    %ebx
80104fdf:	5d                   	pop    %ebp
80104fe0:	c3                   	ret    
80104fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fe8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104feb:	83 c1 28             	add    $0x28,%ecx
80104fee:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ff0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ff6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104ff9:	39 c1                	cmp    %eax,%ecx
80104ffb:	75 f3                	jne    80104ff0 <getcallerpcs+0x40>
}
80104ffd:	5b                   	pop    %ebx
80104ffe:	5d                   	pop    %ebp
80104fff:	c3                   	ret    

80105000 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	53                   	push   %ebx
80105004:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105007:	9c                   	pushf  
80105008:	5b                   	pop    %ebx
  asm volatile("cli");
80105009:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010500a:	e8 f1 ea ff ff       	call   80103b00 <mycpu>
8010500f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105015:	85 c0                	test   %eax,%eax
80105017:	75 11                	jne    8010502a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105019:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010501f:	e8 dc ea ff ff       	call   80103b00 <mycpu>
80105024:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010502a:	e8 d1 ea ff ff       	call   80103b00 <mycpu>
8010502f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105036:	83 c4 04             	add    $0x4,%esp
80105039:	5b                   	pop    %ebx
8010503a:	5d                   	pop    %ebp
8010503b:	c3                   	ret    
8010503c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105040 <popcli>:

void
popcli(void)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105046:	9c                   	pushf  
80105047:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105048:	f6 c4 02             	test   $0x2,%ah
8010504b:	75 35                	jne    80105082 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010504d:	e8 ae ea ff ff       	call   80103b00 <mycpu>
80105052:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105059:	78 34                	js     8010508f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010505b:	e8 a0 ea ff ff       	call   80103b00 <mycpu>
80105060:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105066:	85 d2                	test   %edx,%edx
80105068:	74 06                	je     80105070 <popcli+0x30>
    sti();
}
8010506a:	c9                   	leave  
8010506b:	c3                   	ret    
8010506c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105070:	e8 8b ea ff ff       	call   80103b00 <mycpu>
80105075:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010507b:	85 c0                	test   %eax,%eax
8010507d:	74 eb                	je     8010506a <popcli+0x2a>
  asm volatile("sti");
8010507f:	fb                   	sti    
}
80105080:	c9                   	leave  
80105081:	c3                   	ret    
    panic("popcli - interruptible");
80105082:	83 ec 0c             	sub    $0xc,%esp
80105085:	68 7f 85 10 80       	push   $0x8010857f
8010508a:	e8 01 b3 ff ff       	call   80100390 <panic>
    panic("popcli");
8010508f:	83 ec 0c             	sub    $0xc,%esp
80105092:	68 96 85 10 80       	push   $0x80108596
80105097:	e8 f4 b2 ff ff       	call   80100390 <panic>
8010509c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050a0 <holding>:
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	56                   	push   %esi
801050a4:	53                   	push   %ebx
801050a5:	8b 75 08             	mov    0x8(%ebp),%esi
801050a8:	31 db                	xor    %ebx,%ebx
  pushcli();
801050aa:	e8 51 ff ff ff       	call   80105000 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801050af:	8b 06                	mov    (%esi),%eax
801050b1:	85 c0                	test   %eax,%eax
801050b3:	74 10                	je     801050c5 <holding+0x25>
801050b5:	8b 5e 08             	mov    0x8(%esi),%ebx
801050b8:	e8 43 ea ff ff       	call   80103b00 <mycpu>
801050bd:	39 c3                	cmp    %eax,%ebx
801050bf:	0f 94 c3             	sete   %bl
801050c2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801050c5:	e8 76 ff ff ff       	call   80105040 <popcli>
}
801050ca:	89 d8                	mov    %ebx,%eax
801050cc:	5b                   	pop    %ebx
801050cd:	5e                   	pop    %esi
801050ce:	5d                   	pop    %ebp
801050cf:	c3                   	ret    

801050d0 <acquire>:
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	56                   	push   %esi
801050d4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801050d5:	e8 26 ff ff ff       	call   80105000 <pushcli>
  if(holding(lk))
801050da:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050dd:	83 ec 0c             	sub    $0xc,%esp
801050e0:	53                   	push   %ebx
801050e1:	e8 ba ff ff ff       	call   801050a0 <holding>
801050e6:	83 c4 10             	add    $0x10,%esp
801050e9:	85 c0                	test   %eax,%eax
801050eb:	0f 85 83 00 00 00    	jne    80105174 <acquire+0xa4>
801050f1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801050f3:	ba 01 00 00 00       	mov    $0x1,%edx
801050f8:	eb 09                	jmp    80105103 <acquire+0x33>
801050fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105100:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105103:	89 d0                	mov    %edx,%eax
80105105:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105108:	85 c0                	test   %eax,%eax
8010510a:	75 f4                	jne    80105100 <acquire+0x30>
  __sync_synchronize();
8010510c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105111:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105114:	e8 e7 e9 ff ff       	call   80103b00 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105119:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010511c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010511f:	89 e8                	mov    %ebp,%eax
80105121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105128:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010512e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105134:	77 1a                	ja     80105150 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80105136:	8b 48 04             	mov    0x4(%eax),%ecx
80105139:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010513c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010513f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105141:	83 fe 0a             	cmp    $0xa,%esi
80105144:	75 e2                	jne    80105128 <acquire+0x58>
}
80105146:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105149:	5b                   	pop    %ebx
8010514a:	5e                   	pop    %esi
8010514b:	5d                   	pop    %ebp
8010514c:	c3                   	ret    
8010514d:	8d 76 00             	lea    0x0(%esi),%esi
80105150:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105153:	83 c2 28             	add    $0x28,%edx
80105156:	8d 76 00             	lea    0x0(%esi),%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105160:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105166:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105169:	39 d0                	cmp    %edx,%eax
8010516b:	75 f3                	jne    80105160 <acquire+0x90>
}
8010516d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105170:	5b                   	pop    %ebx
80105171:	5e                   	pop    %esi
80105172:	5d                   	pop    %ebp
80105173:	c3                   	ret    
    panic("acquire");
80105174:	83 ec 0c             	sub    $0xc,%esp
80105177:	68 9d 85 10 80       	push   $0x8010859d
8010517c:	e8 0f b2 ff ff       	call   80100390 <panic>
80105181:	eb 0d                	jmp    80105190 <release>
80105183:	90                   	nop
80105184:	90                   	nop
80105185:	90                   	nop
80105186:	90                   	nop
80105187:	90                   	nop
80105188:	90                   	nop
80105189:	90                   	nop
8010518a:	90                   	nop
8010518b:	90                   	nop
8010518c:	90                   	nop
8010518d:	90                   	nop
8010518e:	90                   	nop
8010518f:	90                   	nop

80105190 <release>:
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	53                   	push   %ebx
80105194:	83 ec 10             	sub    $0x10,%esp
80105197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010519a:	53                   	push   %ebx
8010519b:	e8 00 ff ff ff       	call   801050a0 <holding>
801051a0:	83 c4 10             	add    $0x10,%esp
801051a3:	85 c0                	test   %eax,%eax
801051a5:	74 22                	je     801051c9 <release+0x39>
  lk->pcs[0] = 0;
801051a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801051ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801051b5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801051ba:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801051c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051c3:	c9                   	leave  
  popcli();
801051c4:	e9 77 fe ff ff       	jmp    80105040 <popcli>
    panic("release");
801051c9:	83 ec 0c             	sub    $0xc,%esp
801051cc:	68 a5 85 10 80       	push   $0x801085a5
801051d1:	e8 ba b1 ff ff       	call   80100390 <panic>
801051d6:	66 90                	xchg   %ax,%ax
801051d8:	66 90                	xchg   %ax,%ax
801051da:	66 90                	xchg   %ax,%ax
801051dc:	66 90                	xchg   %ax,%ax
801051de:	66 90                	xchg   %ax,%ax

801051e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	53                   	push   %ebx
801051e5:	8b 55 08             	mov    0x8(%ebp),%edx
801051e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801051eb:	f6 c2 03             	test   $0x3,%dl
801051ee:	75 05                	jne    801051f5 <memset+0x15>
801051f0:	f6 c1 03             	test   $0x3,%cl
801051f3:	74 13                	je     80105208 <memset+0x28>
  asm volatile("cld; rep stosb" :
801051f5:	89 d7                	mov    %edx,%edi
801051f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051fa:	fc                   	cld    
801051fb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801051fd:	5b                   	pop    %ebx
801051fe:	89 d0                	mov    %edx,%eax
80105200:	5f                   	pop    %edi
80105201:	5d                   	pop    %ebp
80105202:	c3                   	ret    
80105203:	90                   	nop
80105204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80105208:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010520c:	c1 e9 02             	shr    $0x2,%ecx
8010520f:	89 f8                	mov    %edi,%eax
80105211:	89 fb                	mov    %edi,%ebx
80105213:	c1 e0 18             	shl    $0x18,%eax
80105216:	c1 e3 10             	shl    $0x10,%ebx
80105219:	09 d8                	or     %ebx,%eax
8010521b:	09 f8                	or     %edi,%eax
8010521d:	c1 e7 08             	shl    $0x8,%edi
80105220:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105222:	89 d7                	mov    %edx,%edi
80105224:	fc                   	cld    
80105225:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105227:	5b                   	pop    %ebx
80105228:	89 d0                	mov    %edx,%eax
8010522a:	5f                   	pop    %edi
8010522b:	5d                   	pop    %ebp
8010522c:	c3                   	ret    
8010522d:	8d 76 00             	lea    0x0(%esi),%esi

80105230 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	57                   	push   %edi
80105234:	56                   	push   %esi
80105235:	53                   	push   %ebx
80105236:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105239:	8b 75 08             	mov    0x8(%ebp),%esi
8010523c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010523f:	85 db                	test   %ebx,%ebx
80105241:	74 29                	je     8010526c <memcmp+0x3c>
    if(*s1 != *s2)
80105243:	0f b6 16             	movzbl (%esi),%edx
80105246:	0f b6 0f             	movzbl (%edi),%ecx
80105249:	38 d1                	cmp    %dl,%cl
8010524b:	75 2b                	jne    80105278 <memcmp+0x48>
8010524d:	b8 01 00 00 00       	mov    $0x1,%eax
80105252:	eb 14                	jmp    80105268 <memcmp+0x38>
80105254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105258:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010525c:	83 c0 01             	add    $0x1,%eax
8010525f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105264:	38 ca                	cmp    %cl,%dl
80105266:	75 10                	jne    80105278 <memcmp+0x48>
  while(n-- > 0){
80105268:	39 d8                	cmp    %ebx,%eax
8010526a:	75 ec                	jne    80105258 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010526c:	5b                   	pop    %ebx
  return 0;
8010526d:	31 c0                	xor    %eax,%eax
}
8010526f:	5e                   	pop    %esi
80105270:	5f                   	pop    %edi
80105271:	5d                   	pop    %ebp
80105272:	c3                   	ret    
80105273:	90                   	nop
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80105278:	0f b6 c2             	movzbl %dl,%eax
}
8010527b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010527c:	29 c8                	sub    %ecx,%eax
}
8010527e:	5e                   	pop    %esi
8010527f:	5f                   	pop    %edi
80105280:	5d                   	pop    %ebp
80105281:	c3                   	ret    
80105282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105290 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	56                   	push   %esi
80105294:	53                   	push   %ebx
80105295:	8b 45 08             	mov    0x8(%ebp),%eax
80105298:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010529b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010529e:	39 c3                	cmp    %eax,%ebx
801052a0:	73 26                	jae    801052c8 <memmove+0x38>
801052a2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801052a5:	39 c8                	cmp    %ecx,%eax
801052a7:	73 1f                	jae    801052c8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801052a9:	85 f6                	test   %esi,%esi
801052ab:	8d 56 ff             	lea    -0x1(%esi),%edx
801052ae:	74 0f                	je     801052bf <memmove+0x2f>
      *--d = *--s;
801052b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801052b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801052b7:	83 ea 01             	sub    $0x1,%edx
801052ba:	83 fa ff             	cmp    $0xffffffff,%edx
801052bd:	75 f1                	jne    801052b0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801052bf:	5b                   	pop    %ebx
801052c0:	5e                   	pop    %esi
801052c1:	5d                   	pop    %ebp
801052c2:	c3                   	ret    
801052c3:	90                   	nop
801052c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
801052c8:	31 d2                	xor    %edx,%edx
801052ca:	85 f6                	test   %esi,%esi
801052cc:	74 f1                	je     801052bf <memmove+0x2f>
801052ce:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801052d0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801052d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801052d7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801052da:	39 d6                	cmp    %edx,%esi
801052dc:	75 f2                	jne    801052d0 <memmove+0x40>
}
801052de:	5b                   	pop    %ebx
801052df:	5e                   	pop    %esi
801052e0:	5d                   	pop    %ebp
801052e1:	c3                   	ret    
801052e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801052f3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801052f4:	eb 9a                	jmp    80105290 <memmove>
801052f6:	8d 76 00             	lea    0x0(%esi),%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105300 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	56                   	push   %esi
80105305:	8b 7d 10             	mov    0x10(%ebp),%edi
80105308:	53                   	push   %ebx
80105309:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010530c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010530f:	85 ff                	test   %edi,%edi
80105311:	74 2f                	je     80105342 <strncmp+0x42>
80105313:	0f b6 01             	movzbl (%ecx),%eax
80105316:	0f b6 1e             	movzbl (%esi),%ebx
80105319:	84 c0                	test   %al,%al
8010531b:	74 37                	je     80105354 <strncmp+0x54>
8010531d:	38 c3                	cmp    %al,%bl
8010531f:	75 33                	jne    80105354 <strncmp+0x54>
80105321:	01 f7                	add    %esi,%edi
80105323:	eb 13                	jmp    80105338 <strncmp+0x38>
80105325:	8d 76 00             	lea    0x0(%esi),%esi
80105328:	0f b6 01             	movzbl (%ecx),%eax
8010532b:	84 c0                	test   %al,%al
8010532d:	74 21                	je     80105350 <strncmp+0x50>
8010532f:	0f b6 1a             	movzbl (%edx),%ebx
80105332:	89 d6                	mov    %edx,%esi
80105334:	38 d8                	cmp    %bl,%al
80105336:	75 1c                	jne    80105354 <strncmp+0x54>
    n--, p++, q++;
80105338:	8d 56 01             	lea    0x1(%esi),%edx
8010533b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010533e:	39 fa                	cmp    %edi,%edx
80105340:	75 e6                	jne    80105328 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105342:	5b                   	pop    %ebx
    return 0;
80105343:	31 c0                	xor    %eax,%eax
}
80105345:	5e                   	pop    %esi
80105346:	5f                   	pop    %edi
80105347:	5d                   	pop    %ebp
80105348:	c3                   	ret    
80105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105350:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80105354:	29 d8                	sub    %ebx,%eax
}
80105356:	5b                   	pop    %ebx
80105357:	5e                   	pop    %esi
80105358:	5f                   	pop    %edi
80105359:	5d                   	pop    %ebp
8010535a:	c3                   	ret    
8010535b:	90                   	nop
8010535c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105360 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	56                   	push   %esi
80105364:	53                   	push   %ebx
80105365:	8b 45 08             	mov    0x8(%ebp),%eax
80105368:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010536b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010536e:	89 c2                	mov    %eax,%edx
80105370:	eb 19                	jmp    8010538b <strncpy+0x2b>
80105372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105378:	83 c3 01             	add    $0x1,%ebx
8010537b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010537f:	83 c2 01             	add    $0x1,%edx
80105382:	84 c9                	test   %cl,%cl
80105384:	88 4a ff             	mov    %cl,-0x1(%edx)
80105387:	74 09                	je     80105392 <strncpy+0x32>
80105389:	89 f1                	mov    %esi,%ecx
8010538b:	85 c9                	test   %ecx,%ecx
8010538d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105390:	7f e6                	jg     80105378 <strncpy+0x18>
    ;
  while(n-- > 0)
80105392:	31 c9                	xor    %ecx,%ecx
80105394:	85 f6                	test   %esi,%esi
80105396:	7e 17                	jle    801053af <strncpy+0x4f>
80105398:	90                   	nop
80105399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801053a0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801053a4:	89 f3                	mov    %esi,%ebx
801053a6:	83 c1 01             	add    $0x1,%ecx
801053a9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801053ab:	85 db                	test   %ebx,%ebx
801053ad:	7f f1                	jg     801053a0 <strncpy+0x40>
  return os;
}
801053af:	5b                   	pop    %ebx
801053b0:	5e                   	pop    %esi
801053b1:	5d                   	pop    %ebp
801053b2:	c3                   	ret    
801053b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053c0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	56                   	push   %esi
801053c4:	53                   	push   %ebx
801053c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801053c8:	8b 45 08             	mov    0x8(%ebp),%eax
801053cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801053ce:	85 c9                	test   %ecx,%ecx
801053d0:	7e 26                	jle    801053f8 <safestrcpy+0x38>
801053d2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801053d6:	89 c1                	mov    %eax,%ecx
801053d8:	eb 17                	jmp    801053f1 <safestrcpy+0x31>
801053da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801053e0:	83 c2 01             	add    $0x1,%edx
801053e3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801053e7:	83 c1 01             	add    $0x1,%ecx
801053ea:	84 db                	test   %bl,%bl
801053ec:	88 59 ff             	mov    %bl,-0x1(%ecx)
801053ef:	74 04                	je     801053f5 <safestrcpy+0x35>
801053f1:	39 f2                	cmp    %esi,%edx
801053f3:	75 eb                	jne    801053e0 <safestrcpy+0x20>
    ;
  *s = 0;
801053f5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801053f8:	5b                   	pop    %ebx
801053f9:	5e                   	pop    %esi
801053fa:	5d                   	pop    %ebp
801053fb:	c3                   	ret    
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105400 <strlen>:

int
strlen(const char *s)
{
80105400:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105401:	31 c0                	xor    %eax,%eax
{
80105403:	89 e5                	mov    %esp,%ebp
80105405:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105408:	80 3a 00             	cmpb   $0x0,(%edx)
8010540b:	74 0c                	je     80105419 <strlen+0x19>
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
80105410:	83 c0 01             	add    $0x1,%eax
80105413:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105417:	75 f7                	jne    80105410 <strlen+0x10>
    ;
  return n;
}
80105419:	5d                   	pop    %ebp
8010541a:	c3                   	ret    

8010541b <swtch>:
8010541b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010541f:	8b 54 24 08          	mov    0x8(%esp),%edx
80105423:	55                   	push   %ebp
80105424:	53                   	push   %ebx
80105425:	56                   	push   %esi
80105426:	57                   	push   %edi
80105427:	89 20                	mov    %esp,(%eax)
80105429:	89 d4                	mov    %edx,%esp
8010542b:	5f                   	pop    %edi
8010542c:	5e                   	pop    %esi
8010542d:	5b                   	pop    %ebx
8010542e:	5d                   	pop    %ebp
8010542f:	c3                   	ret    

80105430 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	53                   	push   %ebx
80105434:	83 ec 04             	sub    $0x4,%esp
80105437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010543a:	e8 61 e7 ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010543f:	8b 00                	mov    (%eax),%eax
80105441:	39 d8                	cmp    %ebx,%eax
80105443:	76 1b                	jbe    80105460 <fetchint+0x30>
80105445:	8d 53 04             	lea    0x4(%ebx),%edx
80105448:	39 d0                	cmp    %edx,%eax
8010544a:	72 14                	jb     80105460 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010544c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010544f:	8b 13                	mov    (%ebx),%edx
80105451:	89 10                	mov    %edx,(%eax)
  return 0;
80105453:	31 c0                	xor    %eax,%eax
}
80105455:	83 c4 04             	add    $0x4,%esp
80105458:	5b                   	pop    %ebx
80105459:	5d                   	pop    %ebp
8010545a:	c3                   	ret    
8010545b:	90                   	nop
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105465:	eb ee                	jmp    80105455 <fetchint+0x25>
80105467:	89 f6                	mov    %esi,%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105470 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	53                   	push   %ebx
80105474:	83 ec 04             	sub    $0x4,%esp
80105477:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010547a:	e8 21 e7 ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz)
8010547f:	39 18                	cmp    %ebx,(%eax)
80105481:	76 29                	jbe    801054ac <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105483:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105486:	89 da                	mov    %ebx,%edx
80105488:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010548a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010548c:	39 c3                	cmp    %eax,%ebx
8010548e:	73 1c                	jae    801054ac <fetchstr+0x3c>
    if(*s == 0)
80105490:	80 3b 00             	cmpb   $0x0,(%ebx)
80105493:	75 10                	jne    801054a5 <fetchstr+0x35>
80105495:	eb 39                	jmp    801054d0 <fetchstr+0x60>
80105497:	89 f6                	mov    %esi,%esi
80105499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801054a0:	80 3a 00             	cmpb   $0x0,(%edx)
801054a3:	74 1b                	je     801054c0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801054a5:	83 c2 01             	add    $0x1,%edx
801054a8:	39 d0                	cmp    %edx,%eax
801054aa:	77 f4                	ja     801054a0 <fetchstr+0x30>
    return -1;
801054ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801054b1:	83 c4 04             	add    $0x4,%esp
801054b4:	5b                   	pop    %ebx
801054b5:	5d                   	pop    %ebp
801054b6:	c3                   	ret    
801054b7:	89 f6                	mov    %esi,%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801054c0:	83 c4 04             	add    $0x4,%esp
801054c3:	89 d0                	mov    %edx,%eax
801054c5:	29 d8                	sub    %ebx,%eax
801054c7:	5b                   	pop    %ebx
801054c8:	5d                   	pop    %ebp
801054c9:	c3                   	ret    
801054ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801054d0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801054d2:	eb dd                	jmp    801054b1 <fetchstr+0x41>
801054d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801054e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054e5:	e8 b6 e6 ff ff       	call   80103ba0 <myproc>
801054ea:	8b 40 18             	mov    0x18(%eax),%eax
801054ed:	8b 55 08             	mov    0x8(%ebp),%edx
801054f0:	8b 40 44             	mov    0x44(%eax),%eax
801054f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801054f6:	e8 a5 e6 ff ff       	call   80103ba0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054fb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054fd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105500:	39 c6                	cmp    %eax,%esi
80105502:	73 1c                	jae    80105520 <argint+0x40>
80105504:	8d 53 08             	lea    0x8(%ebx),%edx
80105507:	39 d0                	cmp    %edx,%eax
80105509:	72 15                	jb     80105520 <argint+0x40>
  *ip = *(int*)(addr);
8010550b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010550e:	8b 53 04             	mov    0x4(%ebx),%edx
80105511:	89 10                	mov    %edx,(%eax)
  return 0;
80105513:	31 c0                	xor    %eax,%eax
}
80105515:	5b                   	pop    %ebx
80105516:	5e                   	pop    %esi
80105517:	5d                   	pop    %ebp
80105518:	c3                   	ret    
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105525:	eb ee                	jmp    80105515 <argint+0x35>
80105527:	89 f6                	mov    %esi,%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105530 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	56                   	push   %esi
80105534:	53                   	push   %ebx
80105535:	83 ec 10             	sub    $0x10,%esp
80105538:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010553b:	e8 60 e6 ff ff       	call   80103ba0 <myproc>
80105540:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105542:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105545:	83 ec 08             	sub    $0x8,%esp
80105548:	50                   	push   %eax
80105549:	ff 75 08             	pushl  0x8(%ebp)
8010554c:	e8 8f ff ff ff       	call   801054e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105551:	83 c4 10             	add    $0x10,%esp
80105554:	85 c0                	test   %eax,%eax
80105556:	78 28                	js     80105580 <argptr+0x50>
80105558:	85 db                	test   %ebx,%ebx
8010555a:	78 24                	js     80105580 <argptr+0x50>
8010555c:	8b 16                	mov    (%esi),%edx
8010555e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105561:	39 c2                	cmp    %eax,%edx
80105563:	76 1b                	jbe    80105580 <argptr+0x50>
80105565:	01 c3                	add    %eax,%ebx
80105567:	39 da                	cmp    %ebx,%edx
80105569:	72 15                	jb     80105580 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010556b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010556e:	89 02                	mov    %eax,(%edx)
  return 0;
80105570:	31 c0                	xor    %eax,%eax
}
80105572:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105575:	5b                   	pop    %ebx
80105576:	5e                   	pop    %esi
80105577:	5d                   	pop    %ebp
80105578:	c3                   	ret    
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105585:	eb eb                	jmp    80105572 <argptr+0x42>
80105587:	89 f6                	mov    %esi,%esi
80105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105590 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105596:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105599:	50                   	push   %eax
8010559a:	ff 75 08             	pushl  0x8(%ebp)
8010559d:	e8 3e ff ff ff       	call   801054e0 <argint>
801055a2:	83 c4 10             	add    $0x10,%esp
801055a5:	85 c0                	test   %eax,%eax
801055a7:	78 17                	js     801055c0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801055a9:	83 ec 08             	sub    $0x8,%esp
801055ac:	ff 75 0c             	pushl  0xc(%ebp)
801055af:	ff 75 f4             	pushl  -0xc(%ebp)
801055b2:	e8 b9 fe ff ff       	call   80105470 <fetchstr>
801055b7:	83 c4 10             	add    $0x10,%esp
}
801055ba:	c9                   	leave  
801055bb:	c3                   	ret    
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801055c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055c5:	c9                   	leave  
801055c6:	c3                   	ret    
801055c7:	89 f6                	mov    %esi,%esi
801055c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055d0 <syscall>:
[SYS_show_processes_scheduling] sys_show_processes_scheduling,
};

void
syscall(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	53                   	push   %ebx
801055d4:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
801055d7:	e8 c4 e5 ff ff       	call   80103ba0 <myproc>
  num = curproc->tf->eax;
801055dc:	8b 50 18             	mov    0x18(%eax),%edx
  struct proc *curproc = myproc();
801055df:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
801055e1:	8b 42 1c             	mov    0x1c(%edx),%eax
  if (num == 22) {
801055e4:	83 f8 16             	cmp    $0x16,%eax
801055e7:	74 37                	je     80105620 <syscall+0x50>
    int arg = 0;
    argint(0 ,&arg);    
    curproc->tf->eax = sys_incNum(arg);    
  }
  else if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801055e9:	8d 48 ff             	lea    -0x1(%eax),%ecx
801055ec:	83 f9 1b             	cmp    $0x1b,%ecx
801055ef:	77 1f                	ja     80105610 <syscall+0x40>
801055f1:	8b 04 85 c0 85 10 80 	mov    -0x7fef7a40(,%eax,4),%eax
801055f8:	85 c0                	test   %eax,%eax
801055fa:	74 14                	je     80105610 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801055fc:	ff d0                	call   *%eax
801055fe:	8b 53 18             	mov    0x18(%ebx),%edx
80105601:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    curproc->tf->eax = -1;
  }
}
80105604:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105607:	c9                   	leave  
80105608:	c3                   	ret    
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curproc->tf->eax = -1;
80105610:	c7 42 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%edx)
}
80105617:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010561a:	c9                   	leave  
8010561b:	c3                   	ret    
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    argint(0 ,&arg);    
80105620:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105623:	83 ec 08             	sub    $0x8,%esp
    int arg = 0;
80105626:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    argint(0 ,&arg);    
8010562d:	50                   	push   %eax
8010562e:	6a 00                	push   $0x0
80105630:	e8 ab fe ff ff       	call   801054e0 <argint>
    curproc->tf->eax = sys_incNum(arg);    
80105635:	58                   	pop    %eax
80105636:	ff 75 f4             	pushl  -0xc(%ebp)
80105639:	e8 a2 0d 00 00       	call   801063e0 <sys_incNum>
8010563e:	8b 53 18             	mov    0x18(%ebx),%edx
80105641:	83 c4 10             	add    $0x10,%esp
80105644:	89 42 1c             	mov    %eax,0x1c(%edx)
}
80105647:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010564a:	c9                   	leave  
8010564b:	c3                   	ret    
8010564c:	66 90                	xchg   %ax,%ax
8010564e:	66 90                	xchg   %ax,%ax

80105650 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
80105655:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105656:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105659:	83 ec 44             	sub    $0x44,%esp
8010565c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010565f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105662:	56                   	push   %esi
80105663:	50                   	push   %eax
{
80105664:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105667:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010566a:	e8 01 cc ff ff       	call   80102270 <nameiparent>
8010566f:	83 c4 10             	add    $0x10,%esp
80105672:	85 c0                	test   %eax,%eax
80105674:	0f 84 46 01 00 00    	je     801057c0 <create+0x170>
    return 0;
  ilock(dp);
8010567a:	83 ec 0c             	sub    $0xc,%esp
8010567d:	89 c3                	mov    %eax,%ebx
8010567f:	50                   	push   %eax
80105680:	e8 6b c3 ff ff       	call   801019f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105685:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105688:	83 c4 0c             	add    $0xc,%esp
8010568b:	50                   	push   %eax
8010568c:	56                   	push   %esi
8010568d:	53                   	push   %ebx
8010568e:	e8 8d c8 ff ff       	call   80101f20 <dirlookup>
80105693:	83 c4 10             	add    $0x10,%esp
80105696:	85 c0                	test   %eax,%eax
80105698:	89 c7                	mov    %eax,%edi
8010569a:	74 34                	je     801056d0 <create+0x80>
    iunlockput(dp);
8010569c:	83 ec 0c             	sub    $0xc,%esp
8010569f:	53                   	push   %ebx
801056a0:	e8 db c5 ff ff       	call   80101c80 <iunlockput>
    ilock(ip);
801056a5:	89 3c 24             	mov    %edi,(%esp)
801056a8:	e8 43 c3 ff ff       	call   801019f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801056ad:	83 c4 10             	add    $0x10,%esp
801056b0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801056b5:	0f 85 95 00 00 00    	jne    80105750 <create+0x100>
801056bb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801056c0:	0f 85 8a 00 00 00    	jne    80105750 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801056c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056c9:	89 f8                	mov    %edi,%eax
801056cb:	5b                   	pop    %ebx
801056cc:	5e                   	pop    %esi
801056cd:	5f                   	pop    %edi
801056ce:	5d                   	pop    %ebp
801056cf:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801056d0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801056d4:	83 ec 08             	sub    $0x8,%esp
801056d7:	50                   	push   %eax
801056d8:	ff 33                	pushl  (%ebx)
801056da:	e8 a1 c1 ff ff       	call   80101880 <ialloc>
801056df:	83 c4 10             	add    $0x10,%esp
801056e2:	85 c0                	test   %eax,%eax
801056e4:	89 c7                	mov    %eax,%edi
801056e6:	0f 84 e8 00 00 00    	je     801057d4 <create+0x184>
  ilock(ip);
801056ec:	83 ec 0c             	sub    $0xc,%esp
801056ef:	50                   	push   %eax
801056f0:	e8 fb c2 ff ff       	call   801019f0 <ilock>
  ip->major = major;
801056f5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801056f9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801056fd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105701:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105705:	b8 01 00 00 00       	mov    $0x1,%eax
8010570a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010570e:	89 3c 24             	mov    %edi,(%esp)
80105711:	e8 2a c2 ff ff       	call   80101940 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105716:	83 c4 10             	add    $0x10,%esp
80105719:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010571e:	74 50                	je     80105770 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105720:	83 ec 04             	sub    $0x4,%esp
80105723:	ff 77 04             	pushl  0x4(%edi)
80105726:	56                   	push   %esi
80105727:	53                   	push   %ebx
80105728:	e8 63 ca ff ff       	call   80102190 <dirlink>
8010572d:	83 c4 10             	add    $0x10,%esp
80105730:	85 c0                	test   %eax,%eax
80105732:	0f 88 8f 00 00 00    	js     801057c7 <create+0x177>
  iunlockput(dp);
80105738:	83 ec 0c             	sub    $0xc,%esp
8010573b:	53                   	push   %ebx
8010573c:	e8 3f c5 ff ff       	call   80101c80 <iunlockput>
  return ip;
80105741:	83 c4 10             	add    $0x10,%esp
}
80105744:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105747:	89 f8                	mov    %edi,%eax
80105749:	5b                   	pop    %ebx
8010574a:	5e                   	pop    %esi
8010574b:	5f                   	pop    %edi
8010574c:	5d                   	pop    %ebp
8010574d:	c3                   	ret    
8010574e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105750:	83 ec 0c             	sub    $0xc,%esp
80105753:	57                   	push   %edi
    return 0;
80105754:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105756:	e8 25 c5 ff ff       	call   80101c80 <iunlockput>
    return 0;
8010575b:	83 c4 10             	add    $0x10,%esp
}
8010575e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105761:	89 f8                	mov    %edi,%eax
80105763:	5b                   	pop    %ebx
80105764:	5e                   	pop    %esi
80105765:	5f                   	pop    %edi
80105766:	5d                   	pop    %ebp
80105767:	c3                   	ret    
80105768:	90                   	nop
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105770:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105775:	83 ec 0c             	sub    $0xc,%esp
80105778:	53                   	push   %ebx
80105779:	e8 c2 c1 ff ff       	call   80101940 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010577e:	83 c4 0c             	add    $0xc,%esp
80105781:	ff 77 04             	pushl  0x4(%edi)
80105784:	68 50 86 10 80       	push   $0x80108650
80105789:	57                   	push   %edi
8010578a:	e8 01 ca ff ff       	call   80102190 <dirlink>
8010578f:	83 c4 10             	add    $0x10,%esp
80105792:	85 c0                	test   %eax,%eax
80105794:	78 1c                	js     801057b2 <create+0x162>
80105796:	83 ec 04             	sub    $0x4,%esp
80105799:	ff 73 04             	pushl  0x4(%ebx)
8010579c:	68 4f 86 10 80       	push   $0x8010864f
801057a1:	57                   	push   %edi
801057a2:	e8 e9 c9 ff ff       	call   80102190 <dirlink>
801057a7:	83 c4 10             	add    $0x10,%esp
801057aa:	85 c0                	test   %eax,%eax
801057ac:	0f 89 6e ff ff ff    	jns    80105720 <create+0xd0>
      panic("create dots");
801057b2:	83 ec 0c             	sub    $0xc,%esp
801057b5:	68 43 86 10 80       	push   $0x80108643
801057ba:	e8 d1 ab ff ff       	call   80100390 <panic>
801057bf:	90                   	nop
    return 0;
801057c0:	31 ff                	xor    %edi,%edi
801057c2:	e9 ff fe ff ff       	jmp    801056c6 <create+0x76>
    panic("create: dirlink");
801057c7:	83 ec 0c             	sub    $0xc,%esp
801057ca:	68 52 86 10 80       	push   $0x80108652
801057cf:	e8 bc ab ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801057d4:	83 ec 0c             	sub    $0xc,%esp
801057d7:	68 34 86 10 80       	push   $0x80108634
801057dc:	e8 af ab ff ff       	call   80100390 <panic>
801057e1:	eb 0d                	jmp    801057f0 <argfd.constprop.0>
801057e3:	90                   	nop
801057e4:	90                   	nop
801057e5:	90                   	nop
801057e6:	90                   	nop
801057e7:	90                   	nop
801057e8:	90                   	nop
801057e9:	90                   	nop
801057ea:	90                   	nop
801057eb:	90                   	nop
801057ec:	90                   	nop
801057ed:	90                   	nop
801057ee:	90                   	nop
801057ef:	90                   	nop

801057f0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	56                   	push   %esi
801057f4:	53                   	push   %ebx
801057f5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801057f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801057fa:	89 d6                	mov    %edx,%esi
801057fc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801057ff:	50                   	push   %eax
80105800:	6a 00                	push   $0x0
80105802:	e8 d9 fc ff ff       	call   801054e0 <argint>
80105807:	83 c4 10             	add    $0x10,%esp
8010580a:	85 c0                	test   %eax,%eax
8010580c:	78 2a                	js     80105838 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010580e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105812:	77 24                	ja     80105838 <argfd.constprop.0+0x48>
80105814:	e8 87 e3 ff ff       	call   80103ba0 <myproc>
80105819:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010581c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105820:	85 c0                	test   %eax,%eax
80105822:	74 14                	je     80105838 <argfd.constprop.0+0x48>
  if(pfd)
80105824:	85 db                	test   %ebx,%ebx
80105826:	74 02                	je     8010582a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105828:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010582a:	89 06                	mov    %eax,(%esi)
  return 0;
8010582c:	31 c0                	xor    %eax,%eax
}
8010582e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105831:	5b                   	pop    %ebx
80105832:	5e                   	pop    %esi
80105833:	5d                   	pop    %ebp
80105834:	c3                   	ret    
80105835:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105838:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010583d:	eb ef                	jmp    8010582e <argfd.constprop.0+0x3e>
8010583f:	90                   	nop

80105840 <sys_dup>:
{
80105840:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105841:	31 c0                	xor    %eax,%eax
{
80105843:	89 e5                	mov    %esp,%ebp
80105845:	56                   	push   %esi
80105846:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105847:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010584a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010584d:	e8 9e ff ff ff       	call   801057f0 <argfd.constprop.0>
80105852:	85 c0                	test   %eax,%eax
80105854:	78 42                	js     80105898 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80105856:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105859:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010585b:	e8 40 e3 ff ff       	call   80103ba0 <myproc>
80105860:	eb 0e                	jmp    80105870 <sys_dup+0x30>
80105862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105868:	83 c3 01             	add    $0x1,%ebx
8010586b:	83 fb 10             	cmp    $0x10,%ebx
8010586e:	74 28                	je     80105898 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105870:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105874:	85 d2                	test   %edx,%edx
80105876:	75 f0                	jne    80105868 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105878:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010587c:	83 ec 0c             	sub    $0xc,%esp
8010587f:	ff 75 f4             	pushl  -0xc(%ebp)
80105882:	e8 c9 b8 ff ff       	call   80101150 <filedup>
  return fd;
80105887:	83 c4 10             	add    $0x10,%esp
}
8010588a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010588d:	89 d8                	mov    %ebx,%eax
8010588f:	5b                   	pop    %ebx
80105890:	5e                   	pop    %esi
80105891:	5d                   	pop    %ebp
80105892:	c3                   	ret    
80105893:	90                   	nop
80105894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105898:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010589b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801058a0:	89 d8                	mov    %ebx,%eax
801058a2:	5b                   	pop    %ebx
801058a3:	5e                   	pop    %esi
801058a4:	5d                   	pop    %ebp
801058a5:	c3                   	ret    
801058a6:	8d 76 00             	lea    0x0(%esi),%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058b0 <sys_read>:
{
801058b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058b1:	31 c0                	xor    %eax,%eax
{
801058b3:	89 e5                	mov    %esp,%ebp
801058b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058b8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801058bb:	e8 30 ff ff ff       	call   801057f0 <argfd.constprop.0>
801058c0:	85 c0                	test   %eax,%eax
801058c2:	78 4c                	js     80105910 <sys_read+0x60>
801058c4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058c7:	83 ec 08             	sub    $0x8,%esp
801058ca:	50                   	push   %eax
801058cb:	6a 02                	push   $0x2
801058cd:	e8 0e fc ff ff       	call   801054e0 <argint>
801058d2:	83 c4 10             	add    $0x10,%esp
801058d5:	85 c0                	test   %eax,%eax
801058d7:	78 37                	js     80105910 <sys_read+0x60>
801058d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058dc:	83 ec 04             	sub    $0x4,%esp
801058df:	ff 75 f0             	pushl  -0x10(%ebp)
801058e2:	50                   	push   %eax
801058e3:	6a 01                	push   $0x1
801058e5:	e8 46 fc ff ff       	call   80105530 <argptr>
801058ea:	83 c4 10             	add    $0x10,%esp
801058ed:	85 c0                	test   %eax,%eax
801058ef:	78 1f                	js     80105910 <sys_read+0x60>
  return fileread(f, p, n);
801058f1:	83 ec 04             	sub    $0x4,%esp
801058f4:	ff 75 f0             	pushl  -0x10(%ebp)
801058f7:	ff 75 f4             	pushl  -0xc(%ebp)
801058fa:	ff 75 ec             	pushl  -0x14(%ebp)
801058fd:	e8 be b9 ff ff       	call   801012c0 <fileread>
80105902:	83 c4 10             	add    $0x10,%esp
}
80105905:	c9                   	leave  
80105906:	c3                   	ret    
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105915:	c9                   	leave  
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_write>:
{
80105920:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105921:	31 c0                	xor    %eax,%eax
{
80105923:	89 e5                	mov    %esp,%ebp
80105925:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105928:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010592b:	e8 c0 fe ff ff       	call   801057f0 <argfd.constprop.0>
80105930:	85 c0                	test   %eax,%eax
80105932:	78 4c                	js     80105980 <sys_write+0x60>
80105934:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105937:	83 ec 08             	sub    $0x8,%esp
8010593a:	50                   	push   %eax
8010593b:	6a 02                	push   $0x2
8010593d:	e8 9e fb ff ff       	call   801054e0 <argint>
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	85 c0                	test   %eax,%eax
80105947:	78 37                	js     80105980 <sys_write+0x60>
80105949:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010594c:	83 ec 04             	sub    $0x4,%esp
8010594f:	ff 75 f0             	pushl  -0x10(%ebp)
80105952:	50                   	push   %eax
80105953:	6a 01                	push   $0x1
80105955:	e8 d6 fb ff ff       	call   80105530 <argptr>
8010595a:	83 c4 10             	add    $0x10,%esp
8010595d:	85 c0                	test   %eax,%eax
8010595f:	78 1f                	js     80105980 <sys_write+0x60>
  return filewrite(f, p, n);
80105961:	83 ec 04             	sub    $0x4,%esp
80105964:	ff 75 f0             	pushl  -0x10(%ebp)
80105967:	ff 75 f4             	pushl  -0xc(%ebp)
8010596a:	ff 75 ec             	pushl  -0x14(%ebp)
8010596d:	e8 de b9 ff ff       	call   80101350 <filewrite>
80105972:	83 c4 10             	add    $0x10,%esp
}
80105975:	c9                   	leave  
80105976:	c3                   	ret    
80105977:	89 f6                	mov    %esi,%esi
80105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105985:	c9                   	leave  
80105986:	c3                   	ret    
80105987:	89 f6                	mov    %esi,%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105990 <sys_close>:
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105996:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105999:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010599c:	e8 4f fe ff ff       	call   801057f0 <argfd.constprop.0>
801059a1:	85 c0                	test   %eax,%eax
801059a3:	78 2b                	js     801059d0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801059a5:	e8 f6 e1 ff ff       	call   80103ba0 <myproc>
801059aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801059ad:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801059b0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801059b7:	00 
  fileclose(f);
801059b8:	ff 75 f4             	pushl  -0xc(%ebp)
801059bb:	e8 e0 b7 ff ff       	call   801011a0 <fileclose>
  return 0;
801059c0:	83 c4 10             	add    $0x10,%esp
801059c3:	31 c0                	xor    %eax,%eax
}
801059c5:	c9                   	leave  
801059c6:	c3                   	ret    
801059c7:	89 f6                	mov    %esi,%esi
801059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801059d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059d5:	c9                   	leave  
801059d6:	c3                   	ret    
801059d7:	89 f6                	mov    %esi,%esi
801059d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059e0 <sys_fstat>:
{
801059e0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801059e1:	31 c0                	xor    %eax,%eax
{
801059e3:	89 e5                	mov    %esp,%ebp
801059e5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801059e8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801059eb:	e8 00 fe ff ff       	call   801057f0 <argfd.constprop.0>
801059f0:	85 c0                	test   %eax,%eax
801059f2:	78 2c                	js     80105a20 <sys_fstat+0x40>
801059f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059f7:	83 ec 04             	sub    $0x4,%esp
801059fa:	6a 14                	push   $0x14
801059fc:	50                   	push   %eax
801059fd:	6a 01                	push   $0x1
801059ff:	e8 2c fb ff ff       	call   80105530 <argptr>
80105a04:	83 c4 10             	add    $0x10,%esp
80105a07:	85 c0                	test   %eax,%eax
80105a09:	78 15                	js     80105a20 <sys_fstat+0x40>
  return filestat(f, st);
80105a0b:	83 ec 08             	sub    $0x8,%esp
80105a0e:	ff 75 f4             	pushl  -0xc(%ebp)
80105a11:	ff 75 f0             	pushl  -0x10(%ebp)
80105a14:	e8 57 b8 ff ff       	call   80101270 <filestat>
80105a19:	83 c4 10             	add    $0x10,%esp
}
80105a1c:	c9                   	leave  
80105a1d:	c3                   	ret    
80105a1e:	66 90                	xchg   %ax,%ax
    return -1;
80105a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a25:	c9                   	leave  
80105a26:	c3                   	ret    
80105a27:	89 f6                	mov    %esi,%esi
80105a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a30 <sys_link>:
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	57                   	push   %edi
80105a34:	56                   	push   %esi
80105a35:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a36:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105a39:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a3c:	50                   	push   %eax
80105a3d:	6a 00                	push   $0x0
80105a3f:	e8 4c fb ff ff       	call   80105590 <argstr>
80105a44:	83 c4 10             	add    $0x10,%esp
80105a47:	85 c0                	test   %eax,%eax
80105a49:	0f 88 fb 00 00 00    	js     80105b4a <sys_link+0x11a>
80105a4f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105a52:	83 ec 08             	sub    $0x8,%esp
80105a55:	50                   	push   %eax
80105a56:	6a 01                	push   $0x1
80105a58:	e8 33 fb ff ff       	call   80105590 <argstr>
80105a5d:	83 c4 10             	add    $0x10,%esp
80105a60:	85 c0                	test   %eax,%eax
80105a62:	0f 88 e2 00 00 00    	js     80105b4a <sys_link+0x11a>
  begin_op();
80105a68:	e8 a3 d4 ff ff       	call   80102f10 <begin_op>
  if((ip = namei(old)) == 0){
80105a6d:	83 ec 0c             	sub    $0xc,%esp
80105a70:	ff 75 d4             	pushl  -0x2c(%ebp)
80105a73:	e8 d8 c7 ff ff       	call   80102250 <namei>
80105a78:	83 c4 10             	add    $0x10,%esp
80105a7b:	85 c0                	test   %eax,%eax
80105a7d:	89 c3                	mov    %eax,%ebx
80105a7f:	0f 84 ea 00 00 00    	je     80105b6f <sys_link+0x13f>
  ilock(ip);
80105a85:	83 ec 0c             	sub    $0xc,%esp
80105a88:	50                   	push   %eax
80105a89:	e8 62 bf ff ff       	call   801019f0 <ilock>
  if(ip->type == T_DIR){
80105a8e:	83 c4 10             	add    $0x10,%esp
80105a91:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a96:	0f 84 bb 00 00 00    	je     80105b57 <sys_link+0x127>
  ip->nlink++;
80105a9c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105aa1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105aa4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105aa7:	53                   	push   %ebx
80105aa8:	e8 93 be ff ff       	call   80101940 <iupdate>
  iunlock(ip);
80105aad:	89 1c 24             	mov    %ebx,(%esp)
80105ab0:	e8 1b c0 ff ff       	call   80101ad0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105ab5:	58                   	pop    %eax
80105ab6:	5a                   	pop    %edx
80105ab7:	57                   	push   %edi
80105ab8:	ff 75 d0             	pushl  -0x30(%ebp)
80105abb:	e8 b0 c7 ff ff       	call   80102270 <nameiparent>
80105ac0:	83 c4 10             	add    $0x10,%esp
80105ac3:	85 c0                	test   %eax,%eax
80105ac5:	89 c6                	mov    %eax,%esi
80105ac7:	74 5b                	je     80105b24 <sys_link+0xf4>
  ilock(dp);
80105ac9:	83 ec 0c             	sub    $0xc,%esp
80105acc:	50                   	push   %eax
80105acd:	e8 1e bf ff ff       	call   801019f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105ad2:	83 c4 10             	add    $0x10,%esp
80105ad5:	8b 03                	mov    (%ebx),%eax
80105ad7:	39 06                	cmp    %eax,(%esi)
80105ad9:	75 3d                	jne    80105b18 <sys_link+0xe8>
80105adb:	83 ec 04             	sub    $0x4,%esp
80105ade:	ff 73 04             	pushl  0x4(%ebx)
80105ae1:	57                   	push   %edi
80105ae2:	56                   	push   %esi
80105ae3:	e8 a8 c6 ff ff       	call   80102190 <dirlink>
80105ae8:	83 c4 10             	add    $0x10,%esp
80105aeb:	85 c0                	test   %eax,%eax
80105aed:	78 29                	js     80105b18 <sys_link+0xe8>
  iunlockput(dp);
80105aef:	83 ec 0c             	sub    $0xc,%esp
80105af2:	56                   	push   %esi
80105af3:	e8 88 c1 ff ff       	call   80101c80 <iunlockput>
  iput(ip);
80105af8:	89 1c 24             	mov    %ebx,(%esp)
80105afb:	e8 20 c0 ff ff       	call   80101b20 <iput>
  end_op();
80105b00:	e8 7b d4 ff ff       	call   80102f80 <end_op>
  return 0;
80105b05:	83 c4 10             	add    $0x10,%esp
80105b08:	31 c0                	xor    %eax,%eax
}
80105b0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b0d:	5b                   	pop    %ebx
80105b0e:	5e                   	pop    %esi
80105b0f:	5f                   	pop    %edi
80105b10:	5d                   	pop    %ebp
80105b11:	c3                   	ret    
80105b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105b18:	83 ec 0c             	sub    $0xc,%esp
80105b1b:	56                   	push   %esi
80105b1c:	e8 5f c1 ff ff       	call   80101c80 <iunlockput>
    goto bad;
80105b21:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105b24:	83 ec 0c             	sub    $0xc,%esp
80105b27:	53                   	push   %ebx
80105b28:	e8 c3 be ff ff       	call   801019f0 <ilock>
  ip->nlink--;
80105b2d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b32:	89 1c 24             	mov    %ebx,(%esp)
80105b35:	e8 06 be ff ff       	call   80101940 <iupdate>
  iunlockput(ip);
80105b3a:	89 1c 24             	mov    %ebx,(%esp)
80105b3d:	e8 3e c1 ff ff       	call   80101c80 <iunlockput>
  end_op();
80105b42:	e8 39 d4 ff ff       	call   80102f80 <end_op>
  return -1;
80105b47:	83 c4 10             	add    $0x10,%esp
}
80105b4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80105b4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b52:	5b                   	pop    %ebx
80105b53:	5e                   	pop    %esi
80105b54:	5f                   	pop    %edi
80105b55:	5d                   	pop    %ebp
80105b56:	c3                   	ret    
    iunlockput(ip);
80105b57:	83 ec 0c             	sub    $0xc,%esp
80105b5a:	53                   	push   %ebx
80105b5b:	e8 20 c1 ff ff       	call   80101c80 <iunlockput>
    end_op();
80105b60:	e8 1b d4 ff ff       	call   80102f80 <end_op>
    return -1;
80105b65:	83 c4 10             	add    $0x10,%esp
80105b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b6d:	eb 9b                	jmp    80105b0a <sys_link+0xda>
    end_op();
80105b6f:	e8 0c d4 ff ff       	call   80102f80 <end_op>
    return -1;
80105b74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b79:	eb 8f                	jmp    80105b0a <sys_link+0xda>
80105b7b:	90                   	nop
80105b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b80 <sys_unlink>:
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	57                   	push   %edi
80105b84:	56                   	push   %esi
80105b85:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105b86:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105b89:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80105b8c:	50                   	push   %eax
80105b8d:	6a 00                	push   $0x0
80105b8f:	e8 fc f9 ff ff       	call   80105590 <argstr>
80105b94:	83 c4 10             	add    $0x10,%esp
80105b97:	85 c0                	test   %eax,%eax
80105b99:	0f 88 77 01 00 00    	js     80105d16 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80105b9f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105ba2:	e8 69 d3 ff ff       	call   80102f10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105ba7:	83 ec 08             	sub    $0x8,%esp
80105baa:	53                   	push   %ebx
80105bab:	ff 75 c0             	pushl  -0x40(%ebp)
80105bae:	e8 bd c6 ff ff       	call   80102270 <nameiparent>
80105bb3:	83 c4 10             	add    $0x10,%esp
80105bb6:	85 c0                	test   %eax,%eax
80105bb8:	89 c6                	mov    %eax,%esi
80105bba:	0f 84 60 01 00 00    	je     80105d20 <sys_unlink+0x1a0>
  ilock(dp);
80105bc0:	83 ec 0c             	sub    $0xc,%esp
80105bc3:	50                   	push   %eax
80105bc4:	e8 27 be ff ff       	call   801019f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105bc9:	58                   	pop    %eax
80105bca:	5a                   	pop    %edx
80105bcb:	68 50 86 10 80       	push   $0x80108650
80105bd0:	53                   	push   %ebx
80105bd1:	e8 2a c3 ff ff       	call   80101f00 <namecmp>
80105bd6:	83 c4 10             	add    $0x10,%esp
80105bd9:	85 c0                	test   %eax,%eax
80105bdb:	0f 84 03 01 00 00    	je     80105ce4 <sys_unlink+0x164>
80105be1:	83 ec 08             	sub    $0x8,%esp
80105be4:	68 4f 86 10 80       	push   $0x8010864f
80105be9:	53                   	push   %ebx
80105bea:	e8 11 c3 ff ff       	call   80101f00 <namecmp>
80105bef:	83 c4 10             	add    $0x10,%esp
80105bf2:	85 c0                	test   %eax,%eax
80105bf4:	0f 84 ea 00 00 00    	je     80105ce4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105bfa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105bfd:	83 ec 04             	sub    $0x4,%esp
80105c00:	50                   	push   %eax
80105c01:	53                   	push   %ebx
80105c02:	56                   	push   %esi
80105c03:	e8 18 c3 ff ff       	call   80101f20 <dirlookup>
80105c08:	83 c4 10             	add    $0x10,%esp
80105c0b:	85 c0                	test   %eax,%eax
80105c0d:	89 c3                	mov    %eax,%ebx
80105c0f:	0f 84 cf 00 00 00    	je     80105ce4 <sys_unlink+0x164>
  ilock(ip);
80105c15:	83 ec 0c             	sub    $0xc,%esp
80105c18:	50                   	push   %eax
80105c19:	e8 d2 bd ff ff       	call   801019f0 <ilock>
  if(ip->nlink < 1)
80105c1e:	83 c4 10             	add    $0x10,%esp
80105c21:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105c26:	0f 8e 10 01 00 00    	jle    80105d3c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c31:	74 6d                	je     80105ca0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105c33:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105c36:	83 ec 04             	sub    $0x4,%esp
80105c39:	6a 10                	push   $0x10
80105c3b:	6a 00                	push   $0x0
80105c3d:	50                   	push   %eax
80105c3e:	e8 9d f5 ff ff       	call   801051e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c43:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105c46:	6a 10                	push   $0x10
80105c48:	ff 75 c4             	pushl  -0x3c(%ebp)
80105c4b:	50                   	push   %eax
80105c4c:	56                   	push   %esi
80105c4d:	e8 7e c1 ff ff       	call   80101dd0 <writei>
80105c52:	83 c4 20             	add    $0x20,%esp
80105c55:	83 f8 10             	cmp    $0x10,%eax
80105c58:	0f 85 eb 00 00 00    	jne    80105d49 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80105c5e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c63:	0f 84 97 00 00 00    	je     80105d00 <sys_unlink+0x180>
  iunlockput(dp);
80105c69:	83 ec 0c             	sub    $0xc,%esp
80105c6c:	56                   	push   %esi
80105c6d:	e8 0e c0 ff ff       	call   80101c80 <iunlockput>
  ip->nlink--;
80105c72:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105c77:	89 1c 24             	mov    %ebx,(%esp)
80105c7a:	e8 c1 bc ff ff       	call   80101940 <iupdate>
  iunlockput(ip);
80105c7f:	89 1c 24             	mov    %ebx,(%esp)
80105c82:	e8 f9 bf ff ff       	call   80101c80 <iunlockput>
  end_op();
80105c87:	e8 f4 d2 ff ff       	call   80102f80 <end_op>
  return 0;
80105c8c:	83 c4 10             	add    $0x10,%esp
80105c8f:	31 c0                	xor    %eax,%eax
}
80105c91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c94:	5b                   	pop    %ebx
80105c95:	5e                   	pop    %esi
80105c96:	5f                   	pop    %edi
80105c97:	5d                   	pop    %ebp
80105c98:	c3                   	ret    
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105ca0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105ca4:	76 8d                	jbe    80105c33 <sys_unlink+0xb3>
80105ca6:	bf 20 00 00 00       	mov    $0x20,%edi
80105cab:	eb 0f                	jmp    80105cbc <sys_unlink+0x13c>
80105cad:	8d 76 00             	lea    0x0(%esi),%esi
80105cb0:	83 c7 10             	add    $0x10,%edi
80105cb3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105cb6:	0f 83 77 ff ff ff    	jae    80105c33 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105cbc:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105cbf:	6a 10                	push   $0x10
80105cc1:	57                   	push   %edi
80105cc2:	50                   	push   %eax
80105cc3:	53                   	push   %ebx
80105cc4:	e8 07 c0 ff ff       	call   80101cd0 <readi>
80105cc9:	83 c4 10             	add    $0x10,%esp
80105ccc:	83 f8 10             	cmp    $0x10,%eax
80105ccf:	75 5e                	jne    80105d2f <sys_unlink+0x1af>
    if(de.inum != 0)
80105cd1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105cd6:	74 d8                	je     80105cb0 <sys_unlink+0x130>
    iunlockput(ip);
80105cd8:	83 ec 0c             	sub    $0xc,%esp
80105cdb:	53                   	push   %ebx
80105cdc:	e8 9f bf ff ff       	call   80101c80 <iunlockput>
    goto bad;
80105ce1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105ce4:	83 ec 0c             	sub    $0xc,%esp
80105ce7:	56                   	push   %esi
80105ce8:	e8 93 bf ff ff       	call   80101c80 <iunlockput>
  end_op();
80105ced:	e8 8e d2 ff ff       	call   80102f80 <end_op>
  return -1;
80105cf2:	83 c4 10             	add    $0x10,%esp
80105cf5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cfa:	eb 95                	jmp    80105c91 <sys_unlink+0x111>
80105cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105d00:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105d05:	83 ec 0c             	sub    $0xc,%esp
80105d08:	56                   	push   %esi
80105d09:	e8 32 bc ff ff       	call   80101940 <iupdate>
80105d0e:	83 c4 10             	add    $0x10,%esp
80105d11:	e9 53 ff ff ff       	jmp    80105c69 <sys_unlink+0xe9>
    return -1;
80105d16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d1b:	e9 71 ff ff ff       	jmp    80105c91 <sys_unlink+0x111>
    end_op();
80105d20:	e8 5b d2 ff ff       	call   80102f80 <end_op>
    return -1;
80105d25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d2a:	e9 62 ff ff ff       	jmp    80105c91 <sys_unlink+0x111>
      panic("isdirempty: readi");
80105d2f:	83 ec 0c             	sub    $0xc,%esp
80105d32:	68 74 86 10 80       	push   $0x80108674
80105d37:	e8 54 a6 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105d3c:	83 ec 0c             	sub    $0xc,%esp
80105d3f:	68 62 86 10 80       	push   $0x80108662
80105d44:	e8 47 a6 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105d49:	83 ec 0c             	sub    $0xc,%esp
80105d4c:	68 86 86 10 80       	push   $0x80108686
80105d51:	e8 3a a6 ff ff       	call   80100390 <panic>
80105d56:	8d 76 00             	lea    0x0(%esi),%esi
80105d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d60 <sys_open>:

int
sys_open(void)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	57                   	push   %edi
80105d64:	56                   	push   %esi
80105d65:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d66:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105d69:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d6c:	50                   	push   %eax
80105d6d:	6a 00                	push   $0x0
80105d6f:	e8 1c f8 ff ff       	call   80105590 <argstr>
80105d74:	83 c4 10             	add    $0x10,%esp
80105d77:	85 c0                	test   %eax,%eax
80105d79:	0f 88 1d 01 00 00    	js     80105e9c <sys_open+0x13c>
80105d7f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d82:	83 ec 08             	sub    $0x8,%esp
80105d85:	50                   	push   %eax
80105d86:	6a 01                	push   $0x1
80105d88:	e8 53 f7 ff ff       	call   801054e0 <argint>
80105d8d:	83 c4 10             	add    $0x10,%esp
80105d90:	85 c0                	test   %eax,%eax
80105d92:	0f 88 04 01 00 00    	js     80105e9c <sys_open+0x13c>
    return -1;

  begin_op();
80105d98:	e8 73 d1 ff ff       	call   80102f10 <begin_op>

  if(omode & O_CREATE){
80105d9d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105da1:	0f 85 a9 00 00 00    	jne    80105e50 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105da7:	83 ec 0c             	sub    $0xc,%esp
80105daa:	ff 75 e0             	pushl  -0x20(%ebp)
80105dad:	e8 9e c4 ff ff       	call   80102250 <namei>
80105db2:	83 c4 10             	add    $0x10,%esp
80105db5:	85 c0                	test   %eax,%eax
80105db7:	89 c6                	mov    %eax,%esi
80105db9:	0f 84 b2 00 00 00    	je     80105e71 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
80105dbf:	83 ec 0c             	sub    $0xc,%esp
80105dc2:	50                   	push   %eax
80105dc3:	e8 28 bc ff ff       	call   801019f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105dc8:	83 c4 10             	add    $0x10,%esp
80105dcb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105dd0:	0f 84 aa 00 00 00    	je     80105e80 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105dd6:	e8 05 b3 ff ff       	call   801010e0 <filealloc>
80105ddb:	85 c0                	test   %eax,%eax
80105ddd:	89 c7                	mov    %eax,%edi
80105ddf:	0f 84 a6 00 00 00    	je     80105e8b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105de5:	e8 b6 dd ff ff       	call   80103ba0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105dea:	31 db                	xor    %ebx,%ebx
80105dec:	eb 0e                	jmp    80105dfc <sys_open+0x9c>
80105dee:	66 90                	xchg   %ax,%ax
80105df0:	83 c3 01             	add    $0x1,%ebx
80105df3:	83 fb 10             	cmp    $0x10,%ebx
80105df6:	0f 84 ac 00 00 00    	je     80105ea8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105dfc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e00:	85 d2                	test   %edx,%edx
80105e02:	75 ec                	jne    80105df0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105e04:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105e07:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105e0b:	56                   	push   %esi
80105e0c:	e8 bf bc ff ff       	call   80101ad0 <iunlock>
  end_op();
80105e11:	e8 6a d1 ff ff       	call   80102f80 <end_op>

  f->type = FD_INODE;
80105e16:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e1c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e1f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105e22:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105e25:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105e2c:	89 d0                	mov    %edx,%eax
80105e2e:	f7 d0                	not    %eax
80105e30:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e33:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105e36:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e39:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105e3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e40:	89 d8                	mov    %ebx,%eax
80105e42:	5b                   	pop    %ebx
80105e43:	5e                   	pop    %esi
80105e44:	5f                   	pop    %edi
80105e45:	5d                   	pop    %ebp
80105e46:	c3                   	ret    
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105e50:	83 ec 0c             	sub    $0xc,%esp
80105e53:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e56:	31 c9                	xor    %ecx,%ecx
80105e58:	6a 00                	push   $0x0
80105e5a:	ba 02 00 00 00       	mov    $0x2,%edx
80105e5f:	e8 ec f7 ff ff       	call   80105650 <create>
    if(ip == 0){
80105e64:	83 c4 10             	add    $0x10,%esp
80105e67:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105e69:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105e6b:	0f 85 65 ff ff ff    	jne    80105dd6 <sys_open+0x76>
      end_op();
80105e71:	e8 0a d1 ff ff       	call   80102f80 <end_op>
      return -1;
80105e76:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e7b:	eb c0                	jmp    80105e3d <sys_open+0xdd>
80105e7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e80:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105e83:	85 c9                	test   %ecx,%ecx
80105e85:	0f 84 4b ff ff ff    	je     80105dd6 <sys_open+0x76>
    iunlockput(ip);
80105e8b:	83 ec 0c             	sub    $0xc,%esp
80105e8e:	56                   	push   %esi
80105e8f:	e8 ec bd ff ff       	call   80101c80 <iunlockput>
    end_op();
80105e94:	e8 e7 d0 ff ff       	call   80102f80 <end_op>
    return -1;
80105e99:	83 c4 10             	add    $0x10,%esp
80105e9c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ea1:	eb 9a                	jmp    80105e3d <sys_open+0xdd>
80105ea3:	90                   	nop
80105ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105ea8:	83 ec 0c             	sub    $0xc,%esp
80105eab:	57                   	push   %edi
80105eac:	e8 ef b2 ff ff       	call   801011a0 <fileclose>
80105eb1:	83 c4 10             	add    $0x10,%esp
80105eb4:	eb d5                	jmp    80105e8b <sys_open+0x12b>
80105eb6:	8d 76 00             	lea    0x0(%esi),%esi
80105eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ec0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105ec6:	e8 45 d0 ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105ecb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ece:	83 ec 08             	sub    $0x8,%esp
80105ed1:	50                   	push   %eax
80105ed2:	6a 00                	push   $0x0
80105ed4:	e8 b7 f6 ff ff       	call   80105590 <argstr>
80105ed9:	83 c4 10             	add    $0x10,%esp
80105edc:	85 c0                	test   %eax,%eax
80105ede:	78 30                	js     80105f10 <sys_mkdir+0x50>
80105ee0:	83 ec 0c             	sub    $0xc,%esp
80105ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ee6:	31 c9                	xor    %ecx,%ecx
80105ee8:	6a 00                	push   $0x0
80105eea:	ba 01 00 00 00       	mov    $0x1,%edx
80105eef:	e8 5c f7 ff ff       	call   80105650 <create>
80105ef4:	83 c4 10             	add    $0x10,%esp
80105ef7:	85 c0                	test   %eax,%eax
80105ef9:	74 15                	je     80105f10 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105efb:	83 ec 0c             	sub    $0xc,%esp
80105efe:	50                   	push   %eax
80105eff:	e8 7c bd ff ff       	call   80101c80 <iunlockput>
  end_op();
80105f04:	e8 77 d0 ff ff       	call   80102f80 <end_op>
  return 0;
80105f09:	83 c4 10             	add    $0x10,%esp
80105f0c:	31 c0                	xor    %eax,%eax
}
80105f0e:	c9                   	leave  
80105f0f:	c3                   	ret    
    end_op();
80105f10:	e8 6b d0 ff ff       	call   80102f80 <end_op>
    return -1;
80105f15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f1a:	c9                   	leave  
80105f1b:	c3                   	ret    
80105f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f20 <sys_mknod>:

int
sys_mknod(void)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105f26:	e8 e5 cf ff ff       	call   80102f10 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105f2b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f2e:	83 ec 08             	sub    $0x8,%esp
80105f31:	50                   	push   %eax
80105f32:	6a 00                	push   $0x0
80105f34:	e8 57 f6 ff ff       	call   80105590 <argstr>
80105f39:	83 c4 10             	add    $0x10,%esp
80105f3c:	85 c0                	test   %eax,%eax
80105f3e:	78 60                	js     80105fa0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105f40:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f43:	83 ec 08             	sub    $0x8,%esp
80105f46:	50                   	push   %eax
80105f47:	6a 01                	push   $0x1
80105f49:	e8 92 f5 ff ff       	call   801054e0 <argint>
  if((argstr(0, &path)) < 0 ||
80105f4e:	83 c4 10             	add    $0x10,%esp
80105f51:	85 c0                	test   %eax,%eax
80105f53:	78 4b                	js     80105fa0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105f55:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f58:	83 ec 08             	sub    $0x8,%esp
80105f5b:	50                   	push   %eax
80105f5c:	6a 02                	push   $0x2
80105f5e:	e8 7d f5 ff ff       	call   801054e0 <argint>
     argint(1, &major) < 0 ||
80105f63:	83 c4 10             	add    $0x10,%esp
80105f66:	85 c0                	test   %eax,%eax
80105f68:	78 36                	js     80105fa0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f6a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105f6e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f71:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105f75:	ba 03 00 00 00       	mov    $0x3,%edx
80105f7a:	50                   	push   %eax
80105f7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f7e:	e8 cd f6 ff ff       	call   80105650 <create>
80105f83:	83 c4 10             	add    $0x10,%esp
80105f86:	85 c0                	test   %eax,%eax
80105f88:	74 16                	je     80105fa0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f8a:	83 ec 0c             	sub    $0xc,%esp
80105f8d:	50                   	push   %eax
80105f8e:	e8 ed bc ff ff       	call   80101c80 <iunlockput>
  end_op();
80105f93:	e8 e8 cf ff ff       	call   80102f80 <end_op>
  return 0;
80105f98:	83 c4 10             	add    $0x10,%esp
80105f9b:	31 c0                	xor    %eax,%eax
}
80105f9d:	c9                   	leave  
80105f9e:	c3                   	ret    
80105f9f:	90                   	nop
    end_op();
80105fa0:	e8 db cf ff ff       	call   80102f80 <end_op>
    return -1;
80105fa5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105faa:	c9                   	leave  
80105fab:	c3                   	ret    
80105fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fb0 <sys_chdir>:

int
sys_chdir(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	56                   	push   %esi
80105fb4:	53                   	push   %ebx
80105fb5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105fb8:	e8 e3 db ff ff       	call   80103ba0 <myproc>
80105fbd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105fbf:	e8 4c cf ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105fc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fc7:	83 ec 08             	sub    $0x8,%esp
80105fca:	50                   	push   %eax
80105fcb:	6a 00                	push   $0x0
80105fcd:	e8 be f5 ff ff       	call   80105590 <argstr>
80105fd2:	83 c4 10             	add    $0x10,%esp
80105fd5:	85 c0                	test   %eax,%eax
80105fd7:	78 77                	js     80106050 <sys_chdir+0xa0>
80105fd9:	83 ec 0c             	sub    $0xc,%esp
80105fdc:	ff 75 f4             	pushl  -0xc(%ebp)
80105fdf:	e8 6c c2 ff ff       	call   80102250 <namei>
80105fe4:	83 c4 10             	add    $0x10,%esp
80105fe7:	85 c0                	test   %eax,%eax
80105fe9:	89 c3                	mov    %eax,%ebx
80105feb:	74 63                	je     80106050 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105fed:	83 ec 0c             	sub    $0xc,%esp
80105ff0:	50                   	push   %eax
80105ff1:	e8 fa b9 ff ff       	call   801019f0 <ilock>
  if(ip->type != T_DIR){
80105ff6:	83 c4 10             	add    $0x10,%esp
80105ff9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ffe:	75 30                	jne    80106030 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106000:	83 ec 0c             	sub    $0xc,%esp
80106003:	53                   	push   %ebx
80106004:	e8 c7 ba ff ff       	call   80101ad0 <iunlock>
  iput(curproc->cwd);
80106009:	58                   	pop    %eax
8010600a:	ff 76 68             	pushl  0x68(%esi)
8010600d:	e8 0e bb ff ff       	call   80101b20 <iput>
  end_op();
80106012:	e8 69 cf ff ff       	call   80102f80 <end_op>
  curproc->cwd = ip;
80106017:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010601a:	83 c4 10             	add    $0x10,%esp
8010601d:	31 c0                	xor    %eax,%eax
}
8010601f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106022:	5b                   	pop    %ebx
80106023:	5e                   	pop    %esi
80106024:	5d                   	pop    %ebp
80106025:	c3                   	ret    
80106026:	8d 76 00             	lea    0x0(%esi),%esi
80106029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106030:	83 ec 0c             	sub    $0xc,%esp
80106033:	53                   	push   %ebx
80106034:	e8 47 bc ff ff       	call   80101c80 <iunlockput>
    end_op();
80106039:	e8 42 cf ff ff       	call   80102f80 <end_op>
    return -1;
8010603e:	83 c4 10             	add    $0x10,%esp
80106041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106046:	eb d7                	jmp    8010601f <sys_chdir+0x6f>
80106048:	90                   	nop
80106049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80106050:	e8 2b cf ff ff       	call   80102f80 <end_op>
    return -1;
80106055:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010605a:	eb c3                	jmp    8010601f <sys_chdir+0x6f>
8010605c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106060 <sys_exec>:

int
sys_exec(void)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	57                   	push   %edi
80106064:	56                   	push   %esi
80106065:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106066:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010606c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106072:	50                   	push   %eax
80106073:	6a 00                	push   $0x0
80106075:	e8 16 f5 ff ff       	call   80105590 <argstr>
8010607a:	83 c4 10             	add    $0x10,%esp
8010607d:	85 c0                	test   %eax,%eax
8010607f:	0f 88 87 00 00 00    	js     8010610c <sys_exec+0xac>
80106085:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010608b:	83 ec 08             	sub    $0x8,%esp
8010608e:	50                   	push   %eax
8010608f:	6a 01                	push   $0x1
80106091:	e8 4a f4 ff ff       	call   801054e0 <argint>
80106096:	83 c4 10             	add    $0x10,%esp
80106099:	85 c0                	test   %eax,%eax
8010609b:	78 6f                	js     8010610c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010609d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801060a3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801060a6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801060a8:	68 80 00 00 00       	push   $0x80
801060ad:	6a 00                	push   $0x0
801060af:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801060b5:	50                   	push   %eax
801060b6:	e8 25 f1 ff ff       	call   801051e0 <memset>
801060bb:	83 c4 10             	add    $0x10,%esp
801060be:	eb 2c                	jmp    801060ec <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801060c0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801060c6:	85 c0                	test   %eax,%eax
801060c8:	74 56                	je     80106120 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801060ca:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801060d0:	83 ec 08             	sub    $0x8,%esp
801060d3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801060d6:	52                   	push   %edx
801060d7:	50                   	push   %eax
801060d8:	e8 93 f3 ff ff       	call   80105470 <fetchstr>
801060dd:	83 c4 10             	add    $0x10,%esp
801060e0:	85 c0                	test   %eax,%eax
801060e2:	78 28                	js     8010610c <sys_exec+0xac>
  for(i=0;; i++){
801060e4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801060e7:	83 fb 20             	cmp    $0x20,%ebx
801060ea:	74 20                	je     8010610c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060ec:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801060f2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801060f9:	83 ec 08             	sub    $0x8,%esp
801060fc:	57                   	push   %edi
801060fd:	01 f0                	add    %esi,%eax
801060ff:	50                   	push   %eax
80106100:	e8 2b f3 ff ff       	call   80105430 <fetchint>
80106105:	83 c4 10             	add    $0x10,%esp
80106108:	85 c0                	test   %eax,%eax
8010610a:	79 b4                	jns    801060c0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010610c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010610f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106114:	5b                   	pop    %ebx
80106115:	5e                   	pop    %esi
80106116:	5f                   	pop    %edi
80106117:	5d                   	pop    %ebp
80106118:	c3                   	ret    
80106119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106120:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106126:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80106129:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106130:	00 00 00 00 
  return exec(path, argv);
80106134:	50                   	push   %eax
80106135:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010613b:	e8 d0 ab ff ff       	call   80100d10 <exec>
80106140:	83 c4 10             	add    $0x10,%esp
}
80106143:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106146:	5b                   	pop    %ebx
80106147:	5e                   	pop    %esi
80106148:	5f                   	pop    %edi
80106149:	5d                   	pop    %ebp
8010614a:	c3                   	ret    
8010614b:	90                   	nop
8010614c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106150 <sys_pipe>:

int
sys_pipe(void)
{
80106150:	55                   	push   %ebp
80106151:	89 e5                	mov    %esp,%ebp
80106153:	57                   	push   %edi
80106154:	56                   	push   %esi
80106155:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106156:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106159:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010615c:	6a 08                	push   $0x8
8010615e:	50                   	push   %eax
8010615f:	6a 00                	push   $0x0
80106161:	e8 ca f3 ff ff       	call   80105530 <argptr>
80106166:	83 c4 10             	add    $0x10,%esp
80106169:	85 c0                	test   %eax,%eax
8010616b:	0f 88 ae 00 00 00    	js     8010621f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106171:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106174:	83 ec 08             	sub    $0x8,%esp
80106177:	50                   	push   %eax
80106178:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010617b:	50                   	push   %eax
8010617c:	e8 2f d4 ff ff       	call   801035b0 <pipealloc>
80106181:	83 c4 10             	add    $0x10,%esp
80106184:	85 c0                	test   %eax,%eax
80106186:	0f 88 93 00 00 00    	js     8010621f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010618c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010618f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106191:	e8 0a da ff ff       	call   80103ba0 <myproc>
80106196:	eb 10                	jmp    801061a8 <sys_pipe+0x58>
80106198:	90                   	nop
80106199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801061a0:	83 c3 01             	add    $0x1,%ebx
801061a3:	83 fb 10             	cmp    $0x10,%ebx
801061a6:	74 60                	je     80106208 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801061a8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061ac:	85 f6                	test   %esi,%esi
801061ae:	75 f0                	jne    801061a0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801061b0:	8d 73 08             	lea    0x8(%ebx),%esi
801061b3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801061ba:	e8 e1 d9 ff ff       	call   80103ba0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061bf:	31 d2                	xor    %edx,%edx
801061c1:	eb 0d                	jmp    801061d0 <sys_pipe+0x80>
801061c3:	90                   	nop
801061c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061c8:	83 c2 01             	add    $0x1,%edx
801061cb:	83 fa 10             	cmp    $0x10,%edx
801061ce:	74 28                	je     801061f8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801061d0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801061d4:	85 c9                	test   %ecx,%ecx
801061d6:	75 f0                	jne    801061c8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801061d8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801061dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061df:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801061e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061e4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801061e7:	31 c0                	xor    %eax,%eax
}
801061e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061ec:	5b                   	pop    %ebx
801061ed:	5e                   	pop    %esi
801061ee:	5f                   	pop    %edi
801061ef:	5d                   	pop    %ebp
801061f0:	c3                   	ret    
801061f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801061f8:	e8 a3 d9 ff ff       	call   80103ba0 <myproc>
801061fd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106204:	00 
80106205:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80106208:	83 ec 0c             	sub    $0xc,%esp
8010620b:	ff 75 e0             	pushl  -0x20(%ebp)
8010620e:	e8 8d af ff ff       	call   801011a0 <fileclose>
    fileclose(wf);
80106213:	58                   	pop    %eax
80106214:	ff 75 e4             	pushl  -0x1c(%ebp)
80106217:	e8 84 af ff ff       	call   801011a0 <fileclose>
    return -1;
8010621c:	83 c4 10             	add    $0x10,%esp
8010621f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106224:	eb c3                	jmp    801061e9 <sys_pipe+0x99>
80106226:	66 90                	xchg   %ax,%ax
80106228:	66 90                	xchg   %ax,%ax
8010622a:	66 90                	xchg   %ax,%ax
8010622c:	66 90                	xchg   %ax,%ax
8010622e:	66 90                	xchg   %ax,%ax

80106230 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106230:	55                   	push   %ebp
80106231:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106233:	5d                   	pop    %ebp
  return fork();
80106234:	e9 07 db ff ff       	jmp    80103d40 <fork>
80106239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106240 <sys_exit>:

int
sys_exit(void)
{
80106240:	55                   	push   %ebp
80106241:	89 e5                	mov    %esp,%ebp
80106243:	83 ec 08             	sub    $0x8,%esp
  exit();
80106246:	e8 d5 dc ff ff       	call   80103f20 <exit>
  return 0;  // not reached
}
8010624b:	31 c0                	xor    %eax,%eax
8010624d:	c9                   	leave  
8010624e:	c3                   	ret    
8010624f:	90                   	nop

80106250 <sys_wait>:

int
sys_wait(void)
{
80106250:	55                   	push   %ebp
80106251:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106253:	5d                   	pop    %ebp
  return wait();
80106254:	e9 07 df ff ff       	jmp    80104160 <wait>
80106259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106260 <sys_kill>:

int
sys_kill(void)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106266:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106269:	50                   	push   %eax
8010626a:	6a 00                	push   $0x0
8010626c:	e8 6f f2 ff ff       	call   801054e0 <argint>
80106271:	83 c4 10             	add    $0x10,%esp
80106274:	85 c0                	test   %eax,%eax
80106276:	78 18                	js     80106290 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106278:	83 ec 0c             	sub    $0xc,%esp
8010627b:	ff 75 f4             	pushl  -0xc(%ebp)
8010627e:	e8 3d e0 ff ff       	call   801042c0 <kill>
80106283:	83 c4 10             	add    $0x10,%esp
}
80106286:	c9                   	leave  
80106287:	c3                   	ret    
80106288:	90                   	nop
80106289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106290:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106295:	c9                   	leave  
80106296:	c3                   	ret    
80106297:	89 f6                	mov    %esi,%esi
80106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062a0 <sys_getpid>:

int
sys_getpid(void)
{
801062a0:	55                   	push   %ebp
801062a1:	89 e5                	mov    %esp,%ebp
801062a3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801062a6:	e8 f5 d8 ff ff       	call   80103ba0 <myproc>
801062ab:	8b 40 10             	mov    0x10(%eax),%eax
}
801062ae:	c9                   	leave  
801062af:	c3                   	ret    

801062b0 <sys_sbrk>:

int
sys_sbrk(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062ba:	50                   	push   %eax
801062bb:	6a 00                	push   $0x0
801062bd:	e8 1e f2 ff ff       	call   801054e0 <argint>
801062c2:	83 c4 10             	add    $0x10,%esp
801062c5:	85 c0                	test   %eax,%eax
801062c7:	78 27                	js     801062f0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801062c9:	e8 d2 d8 ff ff       	call   80103ba0 <myproc>
  if(growproc(n) < 0)
801062ce:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801062d1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801062d3:	ff 75 f4             	pushl  -0xc(%ebp)
801062d6:	e8 e5 d9 ff ff       	call   80103cc0 <growproc>
801062db:	83 c4 10             	add    $0x10,%esp
801062de:	85 c0                	test   %eax,%eax
801062e0:	78 0e                	js     801062f0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801062e2:	89 d8                	mov    %ebx,%eax
801062e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062e7:	c9                   	leave  
801062e8:	c3                   	ret    
801062e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801062f0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801062f5:	eb eb                	jmp    801062e2 <sys_sbrk+0x32>
801062f7:	89 f6                	mov    %esi,%esi
801062f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106300 <sys_sleep>:

int
sys_sleep(void)
{
80106300:	55                   	push   %ebp
80106301:	89 e5                	mov    %esp,%ebp
80106303:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106304:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106307:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010630a:	50                   	push   %eax
8010630b:	6a 00                	push   $0x0
8010630d:	e8 ce f1 ff ff       	call   801054e0 <argint>
80106312:	83 c4 10             	add    $0x10,%esp
80106315:	85 c0                	test   %eax,%eax
80106317:	0f 88 8a 00 00 00    	js     801063a7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010631d:	83 ec 0c             	sub    $0xc,%esp
80106320:	68 40 65 11 80       	push   $0x80116540
80106325:	e8 a6 ed ff ff       	call   801050d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010632a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010632d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106330:	8b 1d 80 6d 11 80    	mov    0x80116d80,%ebx
  while(ticks - ticks0 < n){
80106336:	85 d2                	test   %edx,%edx
80106338:	75 27                	jne    80106361 <sys_sleep+0x61>
8010633a:	eb 54                	jmp    80106390 <sys_sleep+0x90>
8010633c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106340:	83 ec 08             	sub    $0x8,%esp
80106343:	68 40 65 11 80       	push   $0x80116540
80106348:	68 80 6d 11 80       	push   $0x80116d80
8010634d:	e8 4e dd ff ff       	call   801040a0 <sleep>
  while(ticks - ticks0 < n){
80106352:	a1 80 6d 11 80       	mov    0x80116d80,%eax
80106357:	83 c4 10             	add    $0x10,%esp
8010635a:	29 d8                	sub    %ebx,%eax
8010635c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010635f:	73 2f                	jae    80106390 <sys_sleep+0x90>
    if(myproc()->killed){
80106361:	e8 3a d8 ff ff       	call   80103ba0 <myproc>
80106366:	8b 40 24             	mov    0x24(%eax),%eax
80106369:	85 c0                	test   %eax,%eax
8010636b:	74 d3                	je     80106340 <sys_sleep+0x40>
      release(&tickslock);
8010636d:	83 ec 0c             	sub    $0xc,%esp
80106370:	68 40 65 11 80       	push   $0x80116540
80106375:	e8 16 ee ff ff       	call   80105190 <release>
      return -1;
8010637a:	83 c4 10             	add    $0x10,%esp
8010637d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106385:	c9                   	leave  
80106386:	c3                   	ret    
80106387:	89 f6                	mov    %esi,%esi
80106389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106390:	83 ec 0c             	sub    $0xc,%esp
80106393:	68 40 65 11 80       	push   $0x80116540
80106398:	e8 f3 ed ff ff       	call   80105190 <release>
  return 0;
8010639d:	83 c4 10             	add    $0x10,%esp
801063a0:	31 c0                	xor    %eax,%eax
}
801063a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063a5:	c9                   	leave  
801063a6:	c3                   	ret    
    return -1;
801063a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063ac:	eb f4                	jmp    801063a2 <sys_sleep+0xa2>
801063ae:	66 90                	xchg   %ax,%ax

801063b0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063b0:	55                   	push   %ebp
801063b1:	89 e5                	mov    %esp,%ebp
801063b3:	53                   	push   %ebx
801063b4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801063b7:	68 40 65 11 80       	push   $0x80116540
801063bc:	e8 0f ed ff ff       	call   801050d0 <acquire>
  xticks = ticks;
801063c1:	8b 1d 80 6d 11 80    	mov    0x80116d80,%ebx
  release(&tickslock);
801063c7:	c7 04 24 40 65 11 80 	movl   $0x80116540,(%esp)
801063ce:	e8 bd ed ff ff       	call   80105190 <release>
  return xticks;
}
801063d3:	89 d8                	mov    %ebx,%eax
801063d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063d8:	c9                   	leave  
801063d9:	c3                   	ret    
801063da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801063e0 <sys_incNum>:

int
sys_incNum(int num)
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 10             	sub    $0x10,%esp
  num++;
801063e6:	8b 45 08             	mov    0x8(%ebp),%eax
801063e9:	83 c0 01             	add    $0x1,%eax
  cprintf("increased and print in kernel surface %d\n",num);
801063ec:	50                   	push   %eax
801063ed:	68 98 86 10 80       	push   $0x80108698
801063f2:	e8 69 a2 ff ff       	call   80100660 <cprintf>
  return 22;
}
801063f7:	b8 16 00 00 00       	mov    $0x16,%eax
801063fc:	c9                   	leave  
801063fd:	c3                   	ret    
801063fe:	66 90                	xchg   %ax,%ax

80106400 <sys_getprocs>:

int
sys_getprocs()
{
80106400:	55                   	push   %ebp
80106401:	89 e5                	mov    %esp,%ebp
  return getprocs();
}
80106403:	5d                   	pop    %ebp
  return getprocs();
80106404:	e9 c7 e0 ff ff       	jmp    801044d0 <getprocs>
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106410 <sys_set_burst_time>:

void sys_set_burst_time()
{
80106410:	55                   	push   %ebp
80106411:	89 e5                	mov    %esp,%ebp
80106413:	83 ec 20             	sub    $0x20,%esp
  int burst_time;
  argint(0, &burst_time);
80106416:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106419:	50                   	push   %eax
8010641a:	6a 00                	push   $0x0
8010641c:	e8 bf f0 ff ff       	call   801054e0 <argint>
  int pid;
  argint(1, &pid);
80106421:	58                   	pop    %eax
80106422:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106425:	5a                   	pop    %edx
80106426:	50                   	push   %eax
80106427:	6a 01                	push   $0x1
80106429:	e8 b2 f0 ff ff       	call   801054e0 <argint>
  find_and_set_burst_time(burst_time , pid);
8010642e:	59                   	pop    %ecx
8010642f:	58                   	pop    %eax
80106430:	ff 75 f4             	pushl  -0xc(%ebp)
80106433:	ff 75 f0             	pushl  -0x10(%ebp)
80106436:	e8 25 e3 ff ff       	call   80104760 <find_and_set_burst_time>
}
8010643b:	83 c4 10             	add    $0x10,%esp
8010643e:	c9                   	leave  
8010643f:	c3                   	ret    

80106440 <sys_set_priority>:
void sys_set_priority()
{
80106440:	55                   	push   %ebp
80106441:	89 e5                	mov    %esp,%ebp
80106443:	83 ec 20             	sub    $0x20,%esp
  int priority;
  argint(0, &priority);
80106446:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106449:	50                   	push   %eax
8010644a:	6a 00                	push   $0x0
8010644c:	e8 8f f0 ff ff       	call   801054e0 <argint>
  int pid;
  argint(1, &pid);
80106451:	58                   	pop    %eax
80106452:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106455:	5a                   	pop    %edx
80106456:	50                   	push   %eax
80106457:	6a 01                	push   $0x1
80106459:	e8 82 f0 ff ff       	call   801054e0 <argint>
  find_and_set_priority(priority, pid);
8010645e:	59                   	pop    %ecx
8010645f:	58                   	pop    %eax
80106460:	ff 75 f4             	pushl  -0xc(%ebp)
80106463:	ff 75 f0             	pushl  -0x10(%ebp)
80106466:	e8 65 e2 ff ff       	call   801046d0 <find_and_set_priority>
}
8010646b:	83 c4 10             	add    $0x10,%esp
8010646e:	c9                   	leave  
8010646f:	c3                   	ret    

80106470 <sys_set_lottery_ticket>:

void sys_set_lottery_ticket(){
80106470:	55                   	push   %ebp
80106471:	89 e5                	mov    %esp,%ebp
80106473:	83 ec 20             	sub    $0x20,%esp
  int lottery_ticket;
  argint(0, &lottery_ticket);
80106476:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106479:	50                   	push   %eax
8010647a:	6a 00                	push   $0x0
8010647c:	e8 5f f0 ff ff       	call   801054e0 <argint>
  int pid;
  argint(1, &pid);
80106481:	58                   	pop    %eax
80106482:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106485:	5a                   	pop    %edx
80106486:	50                   	push   %eax
80106487:	6a 01                	push   $0x1
80106489:	e8 52 f0 ff ff       	call   801054e0 <argint>
  find_and_set_lottery_ticket(lottery_ticket , pid);
8010648e:	59                   	pop    %ecx
8010648f:	58                   	pop    %eax
80106490:	ff 75 f4             	pushl  -0xc(%ebp)
80106493:	ff 75 f0             	pushl  -0x10(%ebp)
80106496:	e8 65 e2 ff ff       	call   80104700 <find_and_set_lottery_ticket>
}
8010649b:	83 c4 10             	add    $0x10,%esp
8010649e:	c9                   	leave  
8010649f:	c3                   	ret    

801064a0 <sys_set_sched_queue>:

void sys_set_sched_queue()
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	83 ec 20             	sub    $0x20,%esp
  int qeue_number;
  argint(0, &qeue_number);
801064a6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064a9:	50                   	push   %eax
801064aa:	6a 00                	push   $0x0
801064ac:	e8 2f f0 ff ff       	call   801054e0 <argint>
  int pid;
  argint(1, &pid);
801064b1:	58                   	pop    %eax
801064b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064b5:	5a                   	pop    %edx
801064b6:	50                   	push   %eax
801064b7:	6a 01                	push   $0x1
801064b9:	e8 22 f0 ff ff       	call   801054e0 <argint>
  find_and_set_sched_queue(qeue_number, pid);
801064be:	59                   	pop    %ecx
801064bf:	58                   	pop    %eax
801064c0:	ff 75 f4             	pushl  -0xc(%ebp)
801064c3:	ff 75 f0             	pushl  -0x10(%ebp)
801064c6:	e8 65 e2 ff ff       	call   80104730 <find_and_set_sched_queue>
}
801064cb:	83 c4 10             	add    $0x10,%esp
801064ce:	c9                   	leave  
801064cf:	c3                   	ret    

801064d0 <sys_show_processes_scheduling>:

void sys_show_processes_scheduling()
{
801064d0:	55                   	push   %ebp
801064d1:	89 e5                	mov    %esp,%ebp
  show_all_processes_scheduling();
801064d3:	5d                   	pop    %ebp
  show_all_processes_scheduling();
801064d4:	e9 b7 e3 ff ff       	jmp    80104890 <show_all_processes_scheduling>

801064d9 <alltraps>:
801064d9:	1e                   	push   %ds
801064da:	06                   	push   %es
801064db:	0f a0                	push   %fs
801064dd:	0f a8                	push   %gs
801064df:	60                   	pusha  
801064e0:	66 b8 10 00          	mov    $0x10,%ax
801064e4:	8e d8                	mov    %eax,%ds
801064e6:	8e c0                	mov    %eax,%es
801064e8:	54                   	push   %esp
801064e9:	e8 c2 00 00 00       	call   801065b0 <trap>
801064ee:	83 c4 04             	add    $0x4,%esp

801064f1 <trapret>:
801064f1:	61                   	popa   
801064f2:	0f a9                	pop    %gs
801064f4:	0f a1                	pop    %fs
801064f6:	07                   	pop    %es
801064f7:	1f                   	pop    %ds
801064f8:	83 c4 08             	add    $0x8,%esp
801064fb:	cf                   	iret   
801064fc:	66 90                	xchg   %ax,%ax
801064fe:	66 90                	xchg   %ax,%ax

80106500 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106500:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106501:	31 c0                	xor    %eax,%eax
{
80106503:	89 e5                	mov    %esp,%ebp
80106505:	83 ec 08             	sub    $0x8,%esp
80106508:	90                   	nop
80106509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106510:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106517:	c7 04 c5 82 65 11 80 	movl   $0x8e000008,-0x7fee9a7e(,%eax,8)
8010651e:	08 00 00 8e 
80106522:	66 89 14 c5 80 65 11 	mov    %dx,-0x7fee9a80(,%eax,8)
80106529:	80 
8010652a:	c1 ea 10             	shr    $0x10,%edx
8010652d:	66 89 14 c5 86 65 11 	mov    %dx,-0x7fee9a7a(,%eax,8)
80106534:	80 
  for(i = 0; i < 256; i++)
80106535:	83 c0 01             	add    $0x1,%eax
80106538:	3d 00 01 00 00       	cmp    $0x100,%eax
8010653d:	75 d1                	jne    80106510 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010653f:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
80106544:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106547:	c7 05 82 67 11 80 08 	movl   $0xef000008,0x80116782
8010654e:	00 00 ef 
  initlock(&tickslock, "time");
80106551:	68 c2 86 10 80       	push   $0x801086c2
80106556:	68 40 65 11 80       	push   $0x80116540
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010655b:	66 a3 80 67 11 80    	mov    %ax,0x80116780
80106561:	c1 e8 10             	shr    $0x10,%eax
80106564:	66 a3 86 67 11 80    	mov    %ax,0x80116786
  initlock(&tickslock, "time");
8010656a:	e8 21 ea ff ff       	call   80104f90 <initlock>
}
8010656f:	83 c4 10             	add    $0x10,%esp
80106572:	c9                   	leave  
80106573:	c3                   	ret    
80106574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010657a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106580 <idtinit>:

void
idtinit(void)
{
80106580:	55                   	push   %ebp
  pd[0] = size-1;
80106581:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106586:	89 e5                	mov    %esp,%ebp
80106588:	83 ec 10             	sub    $0x10,%esp
8010658b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010658f:	b8 80 65 11 80       	mov    $0x80116580,%eax
80106594:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106598:	c1 e8 10             	shr    $0x10,%eax
8010659b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010659f:	8d 45 fa             	lea    -0x6(%ebp),%eax
801065a2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801065a5:	c9                   	leave  
801065a6:	c3                   	ret    
801065a7:	89 f6                	mov    %esi,%esi
801065a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065b0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801065b0:	55                   	push   %ebp
801065b1:	89 e5                	mov    %esp,%ebp
801065b3:	57                   	push   %edi
801065b4:	56                   	push   %esi
801065b5:	53                   	push   %ebx
801065b6:	83 ec 1c             	sub    $0x1c,%esp
801065b9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801065bc:	8b 47 30             	mov    0x30(%edi),%eax
801065bf:	83 f8 40             	cmp    $0x40,%eax
801065c2:	0f 84 f0 00 00 00    	je     801066b8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801065c8:	83 e8 20             	sub    $0x20,%eax
801065cb:	83 f8 1f             	cmp    $0x1f,%eax
801065ce:	77 10                	ja     801065e0 <trap+0x30>
801065d0:	ff 24 85 68 87 10 80 	jmp    *-0x7fef7898(,%eax,4)
801065d7:	89 f6                	mov    %esi,%esi
801065d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801065e0:	e8 bb d5 ff ff       	call   80103ba0 <myproc>
801065e5:	85 c0                	test   %eax,%eax
801065e7:	8b 5f 38             	mov    0x38(%edi),%ebx
801065ea:	0f 84 14 02 00 00    	je     80106804 <trap+0x254>
801065f0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801065f4:	0f 84 0a 02 00 00    	je     80106804 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801065fa:	0f 20 d1             	mov    %cr2,%ecx
801065fd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106600:	e8 7b d5 ff ff       	call   80103b80 <cpuid>
80106605:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106608:	8b 47 34             	mov    0x34(%edi),%eax
8010660b:	8b 77 30             	mov    0x30(%edi),%esi
8010660e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106611:	e8 8a d5 ff ff       	call   80103ba0 <myproc>
80106616:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106619:	e8 82 d5 ff ff       	call   80103ba0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010661e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106621:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106624:	51                   	push   %ecx
80106625:	53                   	push   %ebx
80106626:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106627:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010662a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010662d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010662e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106631:	52                   	push   %edx
80106632:	ff 70 10             	pushl  0x10(%eax)
80106635:	68 24 87 10 80       	push   $0x80108724
8010663a:	e8 21 a0 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010663f:	83 c4 20             	add    $0x20,%esp
80106642:	e8 59 d5 ff ff       	call   80103ba0 <myproc>
80106647:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010664e:	e8 4d d5 ff ff       	call   80103ba0 <myproc>
80106653:	85 c0                	test   %eax,%eax
80106655:	74 1d                	je     80106674 <trap+0xc4>
80106657:	e8 44 d5 ff ff       	call   80103ba0 <myproc>
8010665c:	8b 50 24             	mov    0x24(%eax),%edx
8010665f:	85 d2                	test   %edx,%edx
80106661:	74 11                	je     80106674 <trap+0xc4>
80106663:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106667:	83 e0 03             	and    $0x3,%eax
8010666a:	66 83 f8 03          	cmp    $0x3,%ax
8010666e:	0f 84 4c 01 00 00    	je     801067c0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106674:	e8 27 d5 ff ff       	call   80103ba0 <myproc>
80106679:	85 c0                	test   %eax,%eax
8010667b:	74 0b                	je     80106688 <trap+0xd8>
8010667d:	e8 1e d5 ff ff       	call   80103ba0 <myproc>
80106682:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106686:	74 68                	je     801066f0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106688:	e8 13 d5 ff ff       	call   80103ba0 <myproc>
8010668d:	85 c0                	test   %eax,%eax
8010668f:	74 19                	je     801066aa <trap+0xfa>
80106691:	e8 0a d5 ff ff       	call   80103ba0 <myproc>
80106696:	8b 40 24             	mov    0x24(%eax),%eax
80106699:	85 c0                	test   %eax,%eax
8010669b:	74 0d                	je     801066aa <trap+0xfa>
8010669d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801066a1:	83 e0 03             	and    $0x3,%eax
801066a4:	66 83 f8 03          	cmp    $0x3,%ax
801066a8:	74 37                	je     801066e1 <trap+0x131>
    exit();
}
801066aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066ad:	5b                   	pop    %ebx
801066ae:	5e                   	pop    %esi
801066af:	5f                   	pop    %edi
801066b0:	5d                   	pop    %ebp
801066b1:	c3                   	ret    
801066b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801066b8:	e8 e3 d4 ff ff       	call   80103ba0 <myproc>
801066bd:	8b 58 24             	mov    0x24(%eax),%ebx
801066c0:	85 db                	test   %ebx,%ebx
801066c2:	0f 85 e8 00 00 00    	jne    801067b0 <trap+0x200>
    myproc()->tf = tf;
801066c8:	e8 d3 d4 ff ff       	call   80103ba0 <myproc>
801066cd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801066d0:	e8 fb ee ff ff       	call   801055d0 <syscall>
    if(myproc()->killed)
801066d5:	e8 c6 d4 ff ff       	call   80103ba0 <myproc>
801066da:	8b 48 24             	mov    0x24(%eax),%ecx
801066dd:	85 c9                	test   %ecx,%ecx
801066df:	74 c9                	je     801066aa <trap+0xfa>
}
801066e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066e4:	5b                   	pop    %ebx
801066e5:	5e                   	pop    %esi
801066e6:	5f                   	pop    %edi
801066e7:	5d                   	pop    %ebp
      exit();
801066e8:	e9 33 d8 ff ff       	jmp    80103f20 <exit>
801066ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801066f0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801066f4:	75 92                	jne    80106688 <trap+0xd8>
    yield();
801066f6:	e8 55 d9 ff ff       	call   80104050 <yield>
801066fb:	eb 8b                	jmp    80106688 <trap+0xd8>
801066fd:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106700:	e8 7b d4 ff ff       	call   80103b80 <cpuid>
80106705:	85 c0                	test   %eax,%eax
80106707:	0f 84 c3 00 00 00    	je     801067d0 <trap+0x220>
    lapiceoi();
8010670d:	e8 ae c3 ff ff       	call   80102ac0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106712:	e8 89 d4 ff ff       	call   80103ba0 <myproc>
80106717:	85 c0                	test   %eax,%eax
80106719:	0f 85 38 ff ff ff    	jne    80106657 <trap+0xa7>
8010671f:	e9 50 ff ff ff       	jmp    80106674 <trap+0xc4>
80106724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106728:	e8 53 c2 ff ff       	call   80102980 <kbdintr>
    lapiceoi();
8010672d:	e8 8e c3 ff ff       	call   80102ac0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106732:	e8 69 d4 ff ff       	call   80103ba0 <myproc>
80106737:	85 c0                	test   %eax,%eax
80106739:	0f 85 18 ff ff ff    	jne    80106657 <trap+0xa7>
8010673f:	e9 30 ff ff ff       	jmp    80106674 <trap+0xc4>
80106744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106748:	e8 53 02 00 00       	call   801069a0 <uartintr>
    lapiceoi();
8010674d:	e8 6e c3 ff ff       	call   80102ac0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106752:	e8 49 d4 ff ff       	call   80103ba0 <myproc>
80106757:	85 c0                	test   %eax,%eax
80106759:	0f 85 f8 fe ff ff    	jne    80106657 <trap+0xa7>
8010675f:	e9 10 ff ff ff       	jmp    80106674 <trap+0xc4>
80106764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106768:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010676c:	8b 77 38             	mov    0x38(%edi),%esi
8010676f:	e8 0c d4 ff ff       	call   80103b80 <cpuid>
80106774:	56                   	push   %esi
80106775:	53                   	push   %ebx
80106776:	50                   	push   %eax
80106777:	68 cc 86 10 80       	push   $0x801086cc
8010677c:	e8 df 9e ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106781:	e8 3a c3 ff ff       	call   80102ac0 <lapiceoi>
    break;
80106786:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106789:	e8 12 d4 ff ff       	call   80103ba0 <myproc>
8010678e:	85 c0                	test   %eax,%eax
80106790:	0f 85 c1 fe ff ff    	jne    80106657 <trap+0xa7>
80106796:	e9 d9 fe ff ff       	jmp    80106674 <trap+0xc4>
8010679b:	90                   	nop
8010679c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801067a0:	e8 4b bc ff ff       	call   801023f0 <ideintr>
801067a5:	e9 63 ff ff ff       	jmp    8010670d <trap+0x15d>
801067aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801067b0:	e8 6b d7 ff ff       	call   80103f20 <exit>
801067b5:	e9 0e ff ff ff       	jmp    801066c8 <trap+0x118>
801067ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801067c0:	e8 5b d7 ff ff       	call   80103f20 <exit>
801067c5:	e9 aa fe ff ff       	jmp    80106674 <trap+0xc4>
801067ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801067d0:	83 ec 0c             	sub    $0xc,%esp
801067d3:	68 40 65 11 80       	push   $0x80116540
801067d8:	e8 f3 e8 ff ff       	call   801050d0 <acquire>
      wakeup(&ticks);
801067dd:	c7 04 24 80 6d 11 80 	movl   $0x80116d80,(%esp)
      ticks++;
801067e4:	83 05 80 6d 11 80 01 	addl   $0x1,0x80116d80
      wakeup(&ticks);
801067eb:	e8 70 da ff ff       	call   80104260 <wakeup>
      release(&tickslock);
801067f0:	c7 04 24 40 65 11 80 	movl   $0x80116540,(%esp)
801067f7:	e8 94 e9 ff ff       	call   80105190 <release>
801067fc:	83 c4 10             	add    $0x10,%esp
801067ff:	e9 09 ff ff ff       	jmp    8010670d <trap+0x15d>
80106804:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106807:	e8 74 d3 ff ff       	call   80103b80 <cpuid>
8010680c:	83 ec 0c             	sub    $0xc,%esp
8010680f:	56                   	push   %esi
80106810:	53                   	push   %ebx
80106811:	50                   	push   %eax
80106812:	ff 77 30             	pushl  0x30(%edi)
80106815:	68 f0 86 10 80       	push   $0x801086f0
8010681a:	e8 41 9e ff ff       	call   80100660 <cprintf>
      panic("trap");
8010681f:	83 c4 14             	add    $0x14,%esp
80106822:	68 c7 86 10 80       	push   $0x801086c7
80106827:	e8 64 9b ff ff       	call   80100390 <panic>
8010682c:	66 90                	xchg   %ax,%ax
8010682e:	66 90                	xchg   %ax,%ax

80106830 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106830:	a1 fc b5 10 80       	mov    0x8010b5fc,%eax
{
80106835:	55                   	push   %ebp
80106836:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106838:	85 c0                	test   %eax,%eax
8010683a:	74 1c                	je     80106858 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010683c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106841:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106842:	a8 01                	test   $0x1,%al
80106844:	74 12                	je     80106858 <uartgetc+0x28>
80106846:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010684b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010684c:	0f b6 c0             	movzbl %al,%eax
}
8010684f:	5d                   	pop    %ebp
80106850:	c3                   	ret    
80106851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106858:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010685d:	5d                   	pop    %ebp
8010685e:	c3                   	ret    
8010685f:	90                   	nop

80106860 <uartputc.part.0>:
uartputc(int c)
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	57                   	push   %edi
80106864:	56                   	push   %esi
80106865:	53                   	push   %ebx
80106866:	89 c7                	mov    %eax,%edi
80106868:	bb 80 00 00 00       	mov    $0x80,%ebx
8010686d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106872:	83 ec 0c             	sub    $0xc,%esp
80106875:	eb 1b                	jmp    80106892 <uartputc.part.0+0x32>
80106877:	89 f6                	mov    %esi,%esi
80106879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106880:	83 ec 0c             	sub    $0xc,%esp
80106883:	6a 0a                	push   $0xa
80106885:	e8 56 c2 ff ff       	call   80102ae0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010688a:	83 c4 10             	add    $0x10,%esp
8010688d:	83 eb 01             	sub    $0x1,%ebx
80106890:	74 07                	je     80106899 <uartputc.part.0+0x39>
80106892:	89 f2                	mov    %esi,%edx
80106894:	ec                   	in     (%dx),%al
80106895:	a8 20                	test   $0x20,%al
80106897:	74 e7                	je     80106880 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106899:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010689e:	89 f8                	mov    %edi,%eax
801068a0:	ee                   	out    %al,(%dx)
}
801068a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068a4:	5b                   	pop    %ebx
801068a5:	5e                   	pop    %esi
801068a6:	5f                   	pop    %edi
801068a7:	5d                   	pop    %ebp
801068a8:	c3                   	ret    
801068a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801068b0 <uartinit>:
{
801068b0:	55                   	push   %ebp
801068b1:	31 c9                	xor    %ecx,%ecx
801068b3:	89 c8                	mov    %ecx,%eax
801068b5:	89 e5                	mov    %esp,%ebp
801068b7:	57                   	push   %edi
801068b8:	56                   	push   %esi
801068b9:	53                   	push   %ebx
801068ba:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801068bf:	89 da                	mov    %ebx,%edx
801068c1:	83 ec 0c             	sub    $0xc,%esp
801068c4:	ee                   	out    %al,(%dx)
801068c5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801068ca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801068cf:	89 fa                	mov    %edi,%edx
801068d1:	ee                   	out    %al,(%dx)
801068d2:	b8 0c 00 00 00       	mov    $0xc,%eax
801068d7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068dc:	ee                   	out    %al,(%dx)
801068dd:	be f9 03 00 00       	mov    $0x3f9,%esi
801068e2:	89 c8                	mov    %ecx,%eax
801068e4:	89 f2                	mov    %esi,%edx
801068e6:	ee                   	out    %al,(%dx)
801068e7:	b8 03 00 00 00       	mov    $0x3,%eax
801068ec:	89 fa                	mov    %edi,%edx
801068ee:	ee                   	out    %al,(%dx)
801068ef:	ba fc 03 00 00       	mov    $0x3fc,%edx
801068f4:	89 c8                	mov    %ecx,%eax
801068f6:	ee                   	out    %al,(%dx)
801068f7:	b8 01 00 00 00       	mov    $0x1,%eax
801068fc:	89 f2                	mov    %esi,%edx
801068fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068ff:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106904:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106905:	3c ff                	cmp    $0xff,%al
80106907:	74 5a                	je     80106963 <uartinit+0xb3>
  uart = 1;
80106909:	c7 05 fc b5 10 80 01 	movl   $0x1,0x8010b5fc
80106910:	00 00 00 
80106913:	89 da                	mov    %ebx,%edx
80106915:	ec                   	in     (%dx),%al
80106916:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010691b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010691c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010691f:	bb e8 87 10 80       	mov    $0x801087e8,%ebx
  ioapicenable(IRQ_COM1, 0);
80106924:	6a 00                	push   $0x0
80106926:	6a 04                	push   $0x4
80106928:	e8 13 bd ff ff       	call   80102640 <ioapicenable>
8010692d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106930:	b8 78 00 00 00       	mov    $0x78,%eax
80106935:	eb 13                	jmp    8010694a <uartinit+0x9a>
80106937:	89 f6                	mov    %esi,%esi
80106939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106940:	83 c3 01             	add    $0x1,%ebx
80106943:	0f be 03             	movsbl (%ebx),%eax
80106946:	84 c0                	test   %al,%al
80106948:	74 19                	je     80106963 <uartinit+0xb3>
  if(!uart)
8010694a:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
80106950:	85 d2                	test   %edx,%edx
80106952:	74 ec                	je     80106940 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106954:	83 c3 01             	add    $0x1,%ebx
80106957:	e8 04 ff ff ff       	call   80106860 <uartputc.part.0>
8010695c:	0f be 03             	movsbl (%ebx),%eax
8010695f:	84 c0                	test   %al,%al
80106961:	75 e7                	jne    8010694a <uartinit+0x9a>
}
80106963:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106966:	5b                   	pop    %ebx
80106967:	5e                   	pop    %esi
80106968:	5f                   	pop    %edi
80106969:	5d                   	pop    %ebp
8010696a:	c3                   	ret    
8010696b:	90                   	nop
8010696c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106970 <uartputc>:
  if(!uart)
80106970:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
{
80106976:	55                   	push   %ebp
80106977:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106979:	85 d2                	test   %edx,%edx
{
8010697b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010697e:	74 10                	je     80106990 <uartputc+0x20>
}
80106980:	5d                   	pop    %ebp
80106981:	e9 da fe ff ff       	jmp    80106860 <uartputc.part.0>
80106986:	8d 76 00             	lea    0x0(%esi),%esi
80106989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106990:	5d                   	pop    %ebp
80106991:	c3                   	ret    
80106992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069a0 <uartintr>:

void
uartintr(void)
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801069a6:	68 30 68 10 80       	push   $0x80106830
801069ab:	e8 30 a1 ff ff       	call   80100ae0 <consoleintr>
}
801069b0:	83 c4 10             	add    $0x10,%esp
801069b3:	c9                   	leave  
801069b4:	c3                   	ret    

801069b5 <vector0>:
801069b5:	6a 00                	push   $0x0
801069b7:	6a 00                	push   $0x0
801069b9:	e9 1b fb ff ff       	jmp    801064d9 <alltraps>

801069be <vector1>:
801069be:	6a 00                	push   $0x0
801069c0:	6a 01                	push   $0x1
801069c2:	e9 12 fb ff ff       	jmp    801064d9 <alltraps>

801069c7 <vector2>:
801069c7:	6a 00                	push   $0x0
801069c9:	6a 02                	push   $0x2
801069cb:	e9 09 fb ff ff       	jmp    801064d9 <alltraps>

801069d0 <vector3>:
801069d0:	6a 00                	push   $0x0
801069d2:	6a 03                	push   $0x3
801069d4:	e9 00 fb ff ff       	jmp    801064d9 <alltraps>

801069d9 <vector4>:
801069d9:	6a 00                	push   $0x0
801069db:	6a 04                	push   $0x4
801069dd:	e9 f7 fa ff ff       	jmp    801064d9 <alltraps>

801069e2 <vector5>:
801069e2:	6a 00                	push   $0x0
801069e4:	6a 05                	push   $0x5
801069e6:	e9 ee fa ff ff       	jmp    801064d9 <alltraps>

801069eb <vector6>:
801069eb:	6a 00                	push   $0x0
801069ed:	6a 06                	push   $0x6
801069ef:	e9 e5 fa ff ff       	jmp    801064d9 <alltraps>

801069f4 <vector7>:
801069f4:	6a 00                	push   $0x0
801069f6:	6a 07                	push   $0x7
801069f8:	e9 dc fa ff ff       	jmp    801064d9 <alltraps>

801069fd <vector8>:
801069fd:	6a 08                	push   $0x8
801069ff:	e9 d5 fa ff ff       	jmp    801064d9 <alltraps>

80106a04 <vector9>:
80106a04:	6a 00                	push   $0x0
80106a06:	6a 09                	push   $0x9
80106a08:	e9 cc fa ff ff       	jmp    801064d9 <alltraps>

80106a0d <vector10>:
80106a0d:	6a 0a                	push   $0xa
80106a0f:	e9 c5 fa ff ff       	jmp    801064d9 <alltraps>

80106a14 <vector11>:
80106a14:	6a 0b                	push   $0xb
80106a16:	e9 be fa ff ff       	jmp    801064d9 <alltraps>

80106a1b <vector12>:
80106a1b:	6a 0c                	push   $0xc
80106a1d:	e9 b7 fa ff ff       	jmp    801064d9 <alltraps>

80106a22 <vector13>:
80106a22:	6a 0d                	push   $0xd
80106a24:	e9 b0 fa ff ff       	jmp    801064d9 <alltraps>

80106a29 <vector14>:
80106a29:	6a 0e                	push   $0xe
80106a2b:	e9 a9 fa ff ff       	jmp    801064d9 <alltraps>

80106a30 <vector15>:
80106a30:	6a 00                	push   $0x0
80106a32:	6a 0f                	push   $0xf
80106a34:	e9 a0 fa ff ff       	jmp    801064d9 <alltraps>

80106a39 <vector16>:
80106a39:	6a 00                	push   $0x0
80106a3b:	6a 10                	push   $0x10
80106a3d:	e9 97 fa ff ff       	jmp    801064d9 <alltraps>

80106a42 <vector17>:
80106a42:	6a 11                	push   $0x11
80106a44:	e9 90 fa ff ff       	jmp    801064d9 <alltraps>

80106a49 <vector18>:
80106a49:	6a 00                	push   $0x0
80106a4b:	6a 12                	push   $0x12
80106a4d:	e9 87 fa ff ff       	jmp    801064d9 <alltraps>

80106a52 <vector19>:
80106a52:	6a 00                	push   $0x0
80106a54:	6a 13                	push   $0x13
80106a56:	e9 7e fa ff ff       	jmp    801064d9 <alltraps>

80106a5b <vector20>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	6a 14                	push   $0x14
80106a5f:	e9 75 fa ff ff       	jmp    801064d9 <alltraps>

80106a64 <vector21>:
80106a64:	6a 00                	push   $0x0
80106a66:	6a 15                	push   $0x15
80106a68:	e9 6c fa ff ff       	jmp    801064d9 <alltraps>

80106a6d <vector22>:
80106a6d:	6a 00                	push   $0x0
80106a6f:	6a 16                	push   $0x16
80106a71:	e9 63 fa ff ff       	jmp    801064d9 <alltraps>

80106a76 <vector23>:
80106a76:	6a 00                	push   $0x0
80106a78:	6a 17                	push   $0x17
80106a7a:	e9 5a fa ff ff       	jmp    801064d9 <alltraps>

80106a7f <vector24>:
80106a7f:	6a 00                	push   $0x0
80106a81:	6a 18                	push   $0x18
80106a83:	e9 51 fa ff ff       	jmp    801064d9 <alltraps>

80106a88 <vector25>:
80106a88:	6a 00                	push   $0x0
80106a8a:	6a 19                	push   $0x19
80106a8c:	e9 48 fa ff ff       	jmp    801064d9 <alltraps>

80106a91 <vector26>:
80106a91:	6a 00                	push   $0x0
80106a93:	6a 1a                	push   $0x1a
80106a95:	e9 3f fa ff ff       	jmp    801064d9 <alltraps>

80106a9a <vector27>:
80106a9a:	6a 00                	push   $0x0
80106a9c:	6a 1b                	push   $0x1b
80106a9e:	e9 36 fa ff ff       	jmp    801064d9 <alltraps>

80106aa3 <vector28>:
80106aa3:	6a 00                	push   $0x0
80106aa5:	6a 1c                	push   $0x1c
80106aa7:	e9 2d fa ff ff       	jmp    801064d9 <alltraps>

80106aac <vector29>:
80106aac:	6a 00                	push   $0x0
80106aae:	6a 1d                	push   $0x1d
80106ab0:	e9 24 fa ff ff       	jmp    801064d9 <alltraps>

80106ab5 <vector30>:
80106ab5:	6a 00                	push   $0x0
80106ab7:	6a 1e                	push   $0x1e
80106ab9:	e9 1b fa ff ff       	jmp    801064d9 <alltraps>

80106abe <vector31>:
80106abe:	6a 00                	push   $0x0
80106ac0:	6a 1f                	push   $0x1f
80106ac2:	e9 12 fa ff ff       	jmp    801064d9 <alltraps>

80106ac7 <vector32>:
80106ac7:	6a 00                	push   $0x0
80106ac9:	6a 20                	push   $0x20
80106acb:	e9 09 fa ff ff       	jmp    801064d9 <alltraps>

80106ad0 <vector33>:
80106ad0:	6a 00                	push   $0x0
80106ad2:	6a 21                	push   $0x21
80106ad4:	e9 00 fa ff ff       	jmp    801064d9 <alltraps>

80106ad9 <vector34>:
80106ad9:	6a 00                	push   $0x0
80106adb:	6a 22                	push   $0x22
80106add:	e9 f7 f9 ff ff       	jmp    801064d9 <alltraps>

80106ae2 <vector35>:
80106ae2:	6a 00                	push   $0x0
80106ae4:	6a 23                	push   $0x23
80106ae6:	e9 ee f9 ff ff       	jmp    801064d9 <alltraps>

80106aeb <vector36>:
80106aeb:	6a 00                	push   $0x0
80106aed:	6a 24                	push   $0x24
80106aef:	e9 e5 f9 ff ff       	jmp    801064d9 <alltraps>

80106af4 <vector37>:
80106af4:	6a 00                	push   $0x0
80106af6:	6a 25                	push   $0x25
80106af8:	e9 dc f9 ff ff       	jmp    801064d9 <alltraps>

80106afd <vector38>:
80106afd:	6a 00                	push   $0x0
80106aff:	6a 26                	push   $0x26
80106b01:	e9 d3 f9 ff ff       	jmp    801064d9 <alltraps>

80106b06 <vector39>:
80106b06:	6a 00                	push   $0x0
80106b08:	6a 27                	push   $0x27
80106b0a:	e9 ca f9 ff ff       	jmp    801064d9 <alltraps>

80106b0f <vector40>:
80106b0f:	6a 00                	push   $0x0
80106b11:	6a 28                	push   $0x28
80106b13:	e9 c1 f9 ff ff       	jmp    801064d9 <alltraps>

80106b18 <vector41>:
80106b18:	6a 00                	push   $0x0
80106b1a:	6a 29                	push   $0x29
80106b1c:	e9 b8 f9 ff ff       	jmp    801064d9 <alltraps>

80106b21 <vector42>:
80106b21:	6a 00                	push   $0x0
80106b23:	6a 2a                	push   $0x2a
80106b25:	e9 af f9 ff ff       	jmp    801064d9 <alltraps>

80106b2a <vector43>:
80106b2a:	6a 00                	push   $0x0
80106b2c:	6a 2b                	push   $0x2b
80106b2e:	e9 a6 f9 ff ff       	jmp    801064d9 <alltraps>

80106b33 <vector44>:
80106b33:	6a 00                	push   $0x0
80106b35:	6a 2c                	push   $0x2c
80106b37:	e9 9d f9 ff ff       	jmp    801064d9 <alltraps>

80106b3c <vector45>:
80106b3c:	6a 00                	push   $0x0
80106b3e:	6a 2d                	push   $0x2d
80106b40:	e9 94 f9 ff ff       	jmp    801064d9 <alltraps>

80106b45 <vector46>:
80106b45:	6a 00                	push   $0x0
80106b47:	6a 2e                	push   $0x2e
80106b49:	e9 8b f9 ff ff       	jmp    801064d9 <alltraps>

80106b4e <vector47>:
80106b4e:	6a 00                	push   $0x0
80106b50:	6a 2f                	push   $0x2f
80106b52:	e9 82 f9 ff ff       	jmp    801064d9 <alltraps>

80106b57 <vector48>:
80106b57:	6a 00                	push   $0x0
80106b59:	6a 30                	push   $0x30
80106b5b:	e9 79 f9 ff ff       	jmp    801064d9 <alltraps>

80106b60 <vector49>:
80106b60:	6a 00                	push   $0x0
80106b62:	6a 31                	push   $0x31
80106b64:	e9 70 f9 ff ff       	jmp    801064d9 <alltraps>

80106b69 <vector50>:
80106b69:	6a 00                	push   $0x0
80106b6b:	6a 32                	push   $0x32
80106b6d:	e9 67 f9 ff ff       	jmp    801064d9 <alltraps>

80106b72 <vector51>:
80106b72:	6a 00                	push   $0x0
80106b74:	6a 33                	push   $0x33
80106b76:	e9 5e f9 ff ff       	jmp    801064d9 <alltraps>

80106b7b <vector52>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	6a 34                	push   $0x34
80106b7f:	e9 55 f9 ff ff       	jmp    801064d9 <alltraps>

80106b84 <vector53>:
80106b84:	6a 00                	push   $0x0
80106b86:	6a 35                	push   $0x35
80106b88:	e9 4c f9 ff ff       	jmp    801064d9 <alltraps>

80106b8d <vector54>:
80106b8d:	6a 00                	push   $0x0
80106b8f:	6a 36                	push   $0x36
80106b91:	e9 43 f9 ff ff       	jmp    801064d9 <alltraps>

80106b96 <vector55>:
80106b96:	6a 00                	push   $0x0
80106b98:	6a 37                	push   $0x37
80106b9a:	e9 3a f9 ff ff       	jmp    801064d9 <alltraps>

80106b9f <vector56>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	6a 38                	push   $0x38
80106ba3:	e9 31 f9 ff ff       	jmp    801064d9 <alltraps>

80106ba8 <vector57>:
80106ba8:	6a 00                	push   $0x0
80106baa:	6a 39                	push   $0x39
80106bac:	e9 28 f9 ff ff       	jmp    801064d9 <alltraps>

80106bb1 <vector58>:
80106bb1:	6a 00                	push   $0x0
80106bb3:	6a 3a                	push   $0x3a
80106bb5:	e9 1f f9 ff ff       	jmp    801064d9 <alltraps>

80106bba <vector59>:
80106bba:	6a 00                	push   $0x0
80106bbc:	6a 3b                	push   $0x3b
80106bbe:	e9 16 f9 ff ff       	jmp    801064d9 <alltraps>

80106bc3 <vector60>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	6a 3c                	push   $0x3c
80106bc7:	e9 0d f9 ff ff       	jmp    801064d9 <alltraps>

80106bcc <vector61>:
80106bcc:	6a 00                	push   $0x0
80106bce:	6a 3d                	push   $0x3d
80106bd0:	e9 04 f9 ff ff       	jmp    801064d9 <alltraps>

80106bd5 <vector62>:
80106bd5:	6a 00                	push   $0x0
80106bd7:	6a 3e                	push   $0x3e
80106bd9:	e9 fb f8 ff ff       	jmp    801064d9 <alltraps>

80106bde <vector63>:
80106bde:	6a 00                	push   $0x0
80106be0:	6a 3f                	push   $0x3f
80106be2:	e9 f2 f8 ff ff       	jmp    801064d9 <alltraps>

80106be7 <vector64>:
80106be7:	6a 00                	push   $0x0
80106be9:	6a 40                	push   $0x40
80106beb:	e9 e9 f8 ff ff       	jmp    801064d9 <alltraps>

80106bf0 <vector65>:
80106bf0:	6a 00                	push   $0x0
80106bf2:	6a 41                	push   $0x41
80106bf4:	e9 e0 f8 ff ff       	jmp    801064d9 <alltraps>

80106bf9 <vector66>:
80106bf9:	6a 00                	push   $0x0
80106bfb:	6a 42                	push   $0x42
80106bfd:	e9 d7 f8 ff ff       	jmp    801064d9 <alltraps>

80106c02 <vector67>:
80106c02:	6a 00                	push   $0x0
80106c04:	6a 43                	push   $0x43
80106c06:	e9 ce f8 ff ff       	jmp    801064d9 <alltraps>

80106c0b <vector68>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	6a 44                	push   $0x44
80106c0f:	e9 c5 f8 ff ff       	jmp    801064d9 <alltraps>

80106c14 <vector69>:
80106c14:	6a 00                	push   $0x0
80106c16:	6a 45                	push   $0x45
80106c18:	e9 bc f8 ff ff       	jmp    801064d9 <alltraps>

80106c1d <vector70>:
80106c1d:	6a 00                	push   $0x0
80106c1f:	6a 46                	push   $0x46
80106c21:	e9 b3 f8 ff ff       	jmp    801064d9 <alltraps>

80106c26 <vector71>:
80106c26:	6a 00                	push   $0x0
80106c28:	6a 47                	push   $0x47
80106c2a:	e9 aa f8 ff ff       	jmp    801064d9 <alltraps>

80106c2f <vector72>:
80106c2f:	6a 00                	push   $0x0
80106c31:	6a 48                	push   $0x48
80106c33:	e9 a1 f8 ff ff       	jmp    801064d9 <alltraps>

80106c38 <vector73>:
80106c38:	6a 00                	push   $0x0
80106c3a:	6a 49                	push   $0x49
80106c3c:	e9 98 f8 ff ff       	jmp    801064d9 <alltraps>

80106c41 <vector74>:
80106c41:	6a 00                	push   $0x0
80106c43:	6a 4a                	push   $0x4a
80106c45:	e9 8f f8 ff ff       	jmp    801064d9 <alltraps>

80106c4a <vector75>:
80106c4a:	6a 00                	push   $0x0
80106c4c:	6a 4b                	push   $0x4b
80106c4e:	e9 86 f8 ff ff       	jmp    801064d9 <alltraps>

80106c53 <vector76>:
80106c53:	6a 00                	push   $0x0
80106c55:	6a 4c                	push   $0x4c
80106c57:	e9 7d f8 ff ff       	jmp    801064d9 <alltraps>

80106c5c <vector77>:
80106c5c:	6a 00                	push   $0x0
80106c5e:	6a 4d                	push   $0x4d
80106c60:	e9 74 f8 ff ff       	jmp    801064d9 <alltraps>

80106c65 <vector78>:
80106c65:	6a 00                	push   $0x0
80106c67:	6a 4e                	push   $0x4e
80106c69:	e9 6b f8 ff ff       	jmp    801064d9 <alltraps>

80106c6e <vector79>:
80106c6e:	6a 00                	push   $0x0
80106c70:	6a 4f                	push   $0x4f
80106c72:	e9 62 f8 ff ff       	jmp    801064d9 <alltraps>

80106c77 <vector80>:
80106c77:	6a 00                	push   $0x0
80106c79:	6a 50                	push   $0x50
80106c7b:	e9 59 f8 ff ff       	jmp    801064d9 <alltraps>

80106c80 <vector81>:
80106c80:	6a 00                	push   $0x0
80106c82:	6a 51                	push   $0x51
80106c84:	e9 50 f8 ff ff       	jmp    801064d9 <alltraps>

80106c89 <vector82>:
80106c89:	6a 00                	push   $0x0
80106c8b:	6a 52                	push   $0x52
80106c8d:	e9 47 f8 ff ff       	jmp    801064d9 <alltraps>

80106c92 <vector83>:
80106c92:	6a 00                	push   $0x0
80106c94:	6a 53                	push   $0x53
80106c96:	e9 3e f8 ff ff       	jmp    801064d9 <alltraps>

80106c9b <vector84>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	6a 54                	push   $0x54
80106c9f:	e9 35 f8 ff ff       	jmp    801064d9 <alltraps>

80106ca4 <vector85>:
80106ca4:	6a 00                	push   $0x0
80106ca6:	6a 55                	push   $0x55
80106ca8:	e9 2c f8 ff ff       	jmp    801064d9 <alltraps>

80106cad <vector86>:
80106cad:	6a 00                	push   $0x0
80106caf:	6a 56                	push   $0x56
80106cb1:	e9 23 f8 ff ff       	jmp    801064d9 <alltraps>

80106cb6 <vector87>:
80106cb6:	6a 00                	push   $0x0
80106cb8:	6a 57                	push   $0x57
80106cba:	e9 1a f8 ff ff       	jmp    801064d9 <alltraps>

80106cbf <vector88>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	6a 58                	push   $0x58
80106cc3:	e9 11 f8 ff ff       	jmp    801064d9 <alltraps>

80106cc8 <vector89>:
80106cc8:	6a 00                	push   $0x0
80106cca:	6a 59                	push   $0x59
80106ccc:	e9 08 f8 ff ff       	jmp    801064d9 <alltraps>

80106cd1 <vector90>:
80106cd1:	6a 00                	push   $0x0
80106cd3:	6a 5a                	push   $0x5a
80106cd5:	e9 ff f7 ff ff       	jmp    801064d9 <alltraps>

80106cda <vector91>:
80106cda:	6a 00                	push   $0x0
80106cdc:	6a 5b                	push   $0x5b
80106cde:	e9 f6 f7 ff ff       	jmp    801064d9 <alltraps>

80106ce3 <vector92>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	6a 5c                	push   $0x5c
80106ce7:	e9 ed f7 ff ff       	jmp    801064d9 <alltraps>

80106cec <vector93>:
80106cec:	6a 00                	push   $0x0
80106cee:	6a 5d                	push   $0x5d
80106cf0:	e9 e4 f7 ff ff       	jmp    801064d9 <alltraps>

80106cf5 <vector94>:
80106cf5:	6a 00                	push   $0x0
80106cf7:	6a 5e                	push   $0x5e
80106cf9:	e9 db f7 ff ff       	jmp    801064d9 <alltraps>

80106cfe <vector95>:
80106cfe:	6a 00                	push   $0x0
80106d00:	6a 5f                	push   $0x5f
80106d02:	e9 d2 f7 ff ff       	jmp    801064d9 <alltraps>

80106d07 <vector96>:
80106d07:	6a 00                	push   $0x0
80106d09:	6a 60                	push   $0x60
80106d0b:	e9 c9 f7 ff ff       	jmp    801064d9 <alltraps>

80106d10 <vector97>:
80106d10:	6a 00                	push   $0x0
80106d12:	6a 61                	push   $0x61
80106d14:	e9 c0 f7 ff ff       	jmp    801064d9 <alltraps>

80106d19 <vector98>:
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 62                	push   $0x62
80106d1d:	e9 b7 f7 ff ff       	jmp    801064d9 <alltraps>

80106d22 <vector99>:
80106d22:	6a 00                	push   $0x0
80106d24:	6a 63                	push   $0x63
80106d26:	e9 ae f7 ff ff       	jmp    801064d9 <alltraps>

80106d2b <vector100>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	6a 64                	push   $0x64
80106d2f:	e9 a5 f7 ff ff       	jmp    801064d9 <alltraps>

80106d34 <vector101>:
80106d34:	6a 00                	push   $0x0
80106d36:	6a 65                	push   $0x65
80106d38:	e9 9c f7 ff ff       	jmp    801064d9 <alltraps>

80106d3d <vector102>:
80106d3d:	6a 00                	push   $0x0
80106d3f:	6a 66                	push   $0x66
80106d41:	e9 93 f7 ff ff       	jmp    801064d9 <alltraps>

80106d46 <vector103>:
80106d46:	6a 00                	push   $0x0
80106d48:	6a 67                	push   $0x67
80106d4a:	e9 8a f7 ff ff       	jmp    801064d9 <alltraps>

80106d4f <vector104>:
80106d4f:	6a 00                	push   $0x0
80106d51:	6a 68                	push   $0x68
80106d53:	e9 81 f7 ff ff       	jmp    801064d9 <alltraps>

80106d58 <vector105>:
80106d58:	6a 00                	push   $0x0
80106d5a:	6a 69                	push   $0x69
80106d5c:	e9 78 f7 ff ff       	jmp    801064d9 <alltraps>

80106d61 <vector106>:
80106d61:	6a 00                	push   $0x0
80106d63:	6a 6a                	push   $0x6a
80106d65:	e9 6f f7 ff ff       	jmp    801064d9 <alltraps>

80106d6a <vector107>:
80106d6a:	6a 00                	push   $0x0
80106d6c:	6a 6b                	push   $0x6b
80106d6e:	e9 66 f7 ff ff       	jmp    801064d9 <alltraps>

80106d73 <vector108>:
80106d73:	6a 00                	push   $0x0
80106d75:	6a 6c                	push   $0x6c
80106d77:	e9 5d f7 ff ff       	jmp    801064d9 <alltraps>

80106d7c <vector109>:
80106d7c:	6a 00                	push   $0x0
80106d7e:	6a 6d                	push   $0x6d
80106d80:	e9 54 f7 ff ff       	jmp    801064d9 <alltraps>

80106d85 <vector110>:
80106d85:	6a 00                	push   $0x0
80106d87:	6a 6e                	push   $0x6e
80106d89:	e9 4b f7 ff ff       	jmp    801064d9 <alltraps>

80106d8e <vector111>:
80106d8e:	6a 00                	push   $0x0
80106d90:	6a 6f                	push   $0x6f
80106d92:	e9 42 f7 ff ff       	jmp    801064d9 <alltraps>

80106d97 <vector112>:
80106d97:	6a 00                	push   $0x0
80106d99:	6a 70                	push   $0x70
80106d9b:	e9 39 f7 ff ff       	jmp    801064d9 <alltraps>

80106da0 <vector113>:
80106da0:	6a 00                	push   $0x0
80106da2:	6a 71                	push   $0x71
80106da4:	e9 30 f7 ff ff       	jmp    801064d9 <alltraps>

80106da9 <vector114>:
80106da9:	6a 00                	push   $0x0
80106dab:	6a 72                	push   $0x72
80106dad:	e9 27 f7 ff ff       	jmp    801064d9 <alltraps>

80106db2 <vector115>:
80106db2:	6a 00                	push   $0x0
80106db4:	6a 73                	push   $0x73
80106db6:	e9 1e f7 ff ff       	jmp    801064d9 <alltraps>

80106dbb <vector116>:
80106dbb:	6a 00                	push   $0x0
80106dbd:	6a 74                	push   $0x74
80106dbf:	e9 15 f7 ff ff       	jmp    801064d9 <alltraps>

80106dc4 <vector117>:
80106dc4:	6a 00                	push   $0x0
80106dc6:	6a 75                	push   $0x75
80106dc8:	e9 0c f7 ff ff       	jmp    801064d9 <alltraps>

80106dcd <vector118>:
80106dcd:	6a 00                	push   $0x0
80106dcf:	6a 76                	push   $0x76
80106dd1:	e9 03 f7 ff ff       	jmp    801064d9 <alltraps>

80106dd6 <vector119>:
80106dd6:	6a 00                	push   $0x0
80106dd8:	6a 77                	push   $0x77
80106dda:	e9 fa f6 ff ff       	jmp    801064d9 <alltraps>

80106ddf <vector120>:
80106ddf:	6a 00                	push   $0x0
80106de1:	6a 78                	push   $0x78
80106de3:	e9 f1 f6 ff ff       	jmp    801064d9 <alltraps>

80106de8 <vector121>:
80106de8:	6a 00                	push   $0x0
80106dea:	6a 79                	push   $0x79
80106dec:	e9 e8 f6 ff ff       	jmp    801064d9 <alltraps>

80106df1 <vector122>:
80106df1:	6a 00                	push   $0x0
80106df3:	6a 7a                	push   $0x7a
80106df5:	e9 df f6 ff ff       	jmp    801064d9 <alltraps>

80106dfa <vector123>:
80106dfa:	6a 00                	push   $0x0
80106dfc:	6a 7b                	push   $0x7b
80106dfe:	e9 d6 f6 ff ff       	jmp    801064d9 <alltraps>

80106e03 <vector124>:
80106e03:	6a 00                	push   $0x0
80106e05:	6a 7c                	push   $0x7c
80106e07:	e9 cd f6 ff ff       	jmp    801064d9 <alltraps>

80106e0c <vector125>:
80106e0c:	6a 00                	push   $0x0
80106e0e:	6a 7d                	push   $0x7d
80106e10:	e9 c4 f6 ff ff       	jmp    801064d9 <alltraps>

80106e15 <vector126>:
80106e15:	6a 00                	push   $0x0
80106e17:	6a 7e                	push   $0x7e
80106e19:	e9 bb f6 ff ff       	jmp    801064d9 <alltraps>

80106e1e <vector127>:
80106e1e:	6a 00                	push   $0x0
80106e20:	6a 7f                	push   $0x7f
80106e22:	e9 b2 f6 ff ff       	jmp    801064d9 <alltraps>

80106e27 <vector128>:
80106e27:	6a 00                	push   $0x0
80106e29:	68 80 00 00 00       	push   $0x80
80106e2e:	e9 a6 f6 ff ff       	jmp    801064d9 <alltraps>

80106e33 <vector129>:
80106e33:	6a 00                	push   $0x0
80106e35:	68 81 00 00 00       	push   $0x81
80106e3a:	e9 9a f6 ff ff       	jmp    801064d9 <alltraps>

80106e3f <vector130>:
80106e3f:	6a 00                	push   $0x0
80106e41:	68 82 00 00 00       	push   $0x82
80106e46:	e9 8e f6 ff ff       	jmp    801064d9 <alltraps>

80106e4b <vector131>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	68 83 00 00 00       	push   $0x83
80106e52:	e9 82 f6 ff ff       	jmp    801064d9 <alltraps>

80106e57 <vector132>:
80106e57:	6a 00                	push   $0x0
80106e59:	68 84 00 00 00       	push   $0x84
80106e5e:	e9 76 f6 ff ff       	jmp    801064d9 <alltraps>

80106e63 <vector133>:
80106e63:	6a 00                	push   $0x0
80106e65:	68 85 00 00 00       	push   $0x85
80106e6a:	e9 6a f6 ff ff       	jmp    801064d9 <alltraps>

80106e6f <vector134>:
80106e6f:	6a 00                	push   $0x0
80106e71:	68 86 00 00 00       	push   $0x86
80106e76:	e9 5e f6 ff ff       	jmp    801064d9 <alltraps>

80106e7b <vector135>:
80106e7b:	6a 00                	push   $0x0
80106e7d:	68 87 00 00 00       	push   $0x87
80106e82:	e9 52 f6 ff ff       	jmp    801064d9 <alltraps>

80106e87 <vector136>:
80106e87:	6a 00                	push   $0x0
80106e89:	68 88 00 00 00       	push   $0x88
80106e8e:	e9 46 f6 ff ff       	jmp    801064d9 <alltraps>

80106e93 <vector137>:
80106e93:	6a 00                	push   $0x0
80106e95:	68 89 00 00 00       	push   $0x89
80106e9a:	e9 3a f6 ff ff       	jmp    801064d9 <alltraps>

80106e9f <vector138>:
80106e9f:	6a 00                	push   $0x0
80106ea1:	68 8a 00 00 00       	push   $0x8a
80106ea6:	e9 2e f6 ff ff       	jmp    801064d9 <alltraps>

80106eab <vector139>:
80106eab:	6a 00                	push   $0x0
80106ead:	68 8b 00 00 00       	push   $0x8b
80106eb2:	e9 22 f6 ff ff       	jmp    801064d9 <alltraps>

80106eb7 <vector140>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	68 8c 00 00 00       	push   $0x8c
80106ebe:	e9 16 f6 ff ff       	jmp    801064d9 <alltraps>

80106ec3 <vector141>:
80106ec3:	6a 00                	push   $0x0
80106ec5:	68 8d 00 00 00       	push   $0x8d
80106eca:	e9 0a f6 ff ff       	jmp    801064d9 <alltraps>

80106ecf <vector142>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	68 8e 00 00 00       	push   $0x8e
80106ed6:	e9 fe f5 ff ff       	jmp    801064d9 <alltraps>

80106edb <vector143>:
80106edb:	6a 00                	push   $0x0
80106edd:	68 8f 00 00 00       	push   $0x8f
80106ee2:	e9 f2 f5 ff ff       	jmp    801064d9 <alltraps>

80106ee7 <vector144>:
80106ee7:	6a 00                	push   $0x0
80106ee9:	68 90 00 00 00       	push   $0x90
80106eee:	e9 e6 f5 ff ff       	jmp    801064d9 <alltraps>

80106ef3 <vector145>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	68 91 00 00 00       	push   $0x91
80106efa:	e9 da f5 ff ff       	jmp    801064d9 <alltraps>

80106eff <vector146>:
80106eff:	6a 00                	push   $0x0
80106f01:	68 92 00 00 00       	push   $0x92
80106f06:	e9 ce f5 ff ff       	jmp    801064d9 <alltraps>

80106f0b <vector147>:
80106f0b:	6a 00                	push   $0x0
80106f0d:	68 93 00 00 00       	push   $0x93
80106f12:	e9 c2 f5 ff ff       	jmp    801064d9 <alltraps>

80106f17 <vector148>:
80106f17:	6a 00                	push   $0x0
80106f19:	68 94 00 00 00       	push   $0x94
80106f1e:	e9 b6 f5 ff ff       	jmp    801064d9 <alltraps>

80106f23 <vector149>:
80106f23:	6a 00                	push   $0x0
80106f25:	68 95 00 00 00       	push   $0x95
80106f2a:	e9 aa f5 ff ff       	jmp    801064d9 <alltraps>

80106f2f <vector150>:
80106f2f:	6a 00                	push   $0x0
80106f31:	68 96 00 00 00       	push   $0x96
80106f36:	e9 9e f5 ff ff       	jmp    801064d9 <alltraps>

80106f3b <vector151>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	68 97 00 00 00       	push   $0x97
80106f42:	e9 92 f5 ff ff       	jmp    801064d9 <alltraps>

80106f47 <vector152>:
80106f47:	6a 00                	push   $0x0
80106f49:	68 98 00 00 00       	push   $0x98
80106f4e:	e9 86 f5 ff ff       	jmp    801064d9 <alltraps>

80106f53 <vector153>:
80106f53:	6a 00                	push   $0x0
80106f55:	68 99 00 00 00       	push   $0x99
80106f5a:	e9 7a f5 ff ff       	jmp    801064d9 <alltraps>

80106f5f <vector154>:
80106f5f:	6a 00                	push   $0x0
80106f61:	68 9a 00 00 00       	push   $0x9a
80106f66:	e9 6e f5 ff ff       	jmp    801064d9 <alltraps>

80106f6b <vector155>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	68 9b 00 00 00       	push   $0x9b
80106f72:	e9 62 f5 ff ff       	jmp    801064d9 <alltraps>

80106f77 <vector156>:
80106f77:	6a 00                	push   $0x0
80106f79:	68 9c 00 00 00       	push   $0x9c
80106f7e:	e9 56 f5 ff ff       	jmp    801064d9 <alltraps>

80106f83 <vector157>:
80106f83:	6a 00                	push   $0x0
80106f85:	68 9d 00 00 00       	push   $0x9d
80106f8a:	e9 4a f5 ff ff       	jmp    801064d9 <alltraps>

80106f8f <vector158>:
80106f8f:	6a 00                	push   $0x0
80106f91:	68 9e 00 00 00       	push   $0x9e
80106f96:	e9 3e f5 ff ff       	jmp    801064d9 <alltraps>

80106f9b <vector159>:
80106f9b:	6a 00                	push   $0x0
80106f9d:	68 9f 00 00 00       	push   $0x9f
80106fa2:	e9 32 f5 ff ff       	jmp    801064d9 <alltraps>

80106fa7 <vector160>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	68 a0 00 00 00       	push   $0xa0
80106fae:	e9 26 f5 ff ff       	jmp    801064d9 <alltraps>

80106fb3 <vector161>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	68 a1 00 00 00       	push   $0xa1
80106fba:	e9 1a f5 ff ff       	jmp    801064d9 <alltraps>

80106fbf <vector162>:
80106fbf:	6a 00                	push   $0x0
80106fc1:	68 a2 00 00 00       	push   $0xa2
80106fc6:	e9 0e f5 ff ff       	jmp    801064d9 <alltraps>

80106fcb <vector163>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 a3 00 00 00       	push   $0xa3
80106fd2:	e9 02 f5 ff ff       	jmp    801064d9 <alltraps>

80106fd7 <vector164>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 a4 00 00 00       	push   $0xa4
80106fde:	e9 f6 f4 ff ff       	jmp    801064d9 <alltraps>

80106fe3 <vector165>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 a5 00 00 00       	push   $0xa5
80106fea:	e9 ea f4 ff ff       	jmp    801064d9 <alltraps>

80106fef <vector166>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 a6 00 00 00       	push   $0xa6
80106ff6:	e9 de f4 ff ff       	jmp    801064d9 <alltraps>

80106ffb <vector167>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 a7 00 00 00       	push   $0xa7
80107002:	e9 d2 f4 ff ff       	jmp    801064d9 <alltraps>

80107007 <vector168>:
80107007:	6a 00                	push   $0x0
80107009:	68 a8 00 00 00       	push   $0xa8
8010700e:	e9 c6 f4 ff ff       	jmp    801064d9 <alltraps>

80107013 <vector169>:
80107013:	6a 00                	push   $0x0
80107015:	68 a9 00 00 00       	push   $0xa9
8010701a:	e9 ba f4 ff ff       	jmp    801064d9 <alltraps>

8010701f <vector170>:
8010701f:	6a 00                	push   $0x0
80107021:	68 aa 00 00 00       	push   $0xaa
80107026:	e9 ae f4 ff ff       	jmp    801064d9 <alltraps>

8010702b <vector171>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 ab 00 00 00       	push   $0xab
80107032:	e9 a2 f4 ff ff       	jmp    801064d9 <alltraps>

80107037 <vector172>:
80107037:	6a 00                	push   $0x0
80107039:	68 ac 00 00 00       	push   $0xac
8010703e:	e9 96 f4 ff ff       	jmp    801064d9 <alltraps>

80107043 <vector173>:
80107043:	6a 00                	push   $0x0
80107045:	68 ad 00 00 00       	push   $0xad
8010704a:	e9 8a f4 ff ff       	jmp    801064d9 <alltraps>

8010704f <vector174>:
8010704f:	6a 00                	push   $0x0
80107051:	68 ae 00 00 00       	push   $0xae
80107056:	e9 7e f4 ff ff       	jmp    801064d9 <alltraps>

8010705b <vector175>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 af 00 00 00       	push   $0xaf
80107062:	e9 72 f4 ff ff       	jmp    801064d9 <alltraps>

80107067 <vector176>:
80107067:	6a 00                	push   $0x0
80107069:	68 b0 00 00 00       	push   $0xb0
8010706e:	e9 66 f4 ff ff       	jmp    801064d9 <alltraps>

80107073 <vector177>:
80107073:	6a 00                	push   $0x0
80107075:	68 b1 00 00 00       	push   $0xb1
8010707a:	e9 5a f4 ff ff       	jmp    801064d9 <alltraps>

8010707f <vector178>:
8010707f:	6a 00                	push   $0x0
80107081:	68 b2 00 00 00       	push   $0xb2
80107086:	e9 4e f4 ff ff       	jmp    801064d9 <alltraps>

8010708b <vector179>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 b3 00 00 00       	push   $0xb3
80107092:	e9 42 f4 ff ff       	jmp    801064d9 <alltraps>

80107097 <vector180>:
80107097:	6a 00                	push   $0x0
80107099:	68 b4 00 00 00       	push   $0xb4
8010709e:	e9 36 f4 ff ff       	jmp    801064d9 <alltraps>

801070a3 <vector181>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 b5 00 00 00       	push   $0xb5
801070aa:	e9 2a f4 ff ff       	jmp    801064d9 <alltraps>

801070af <vector182>:
801070af:	6a 00                	push   $0x0
801070b1:	68 b6 00 00 00       	push   $0xb6
801070b6:	e9 1e f4 ff ff       	jmp    801064d9 <alltraps>

801070bb <vector183>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 b7 00 00 00       	push   $0xb7
801070c2:	e9 12 f4 ff ff       	jmp    801064d9 <alltraps>

801070c7 <vector184>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 b8 00 00 00       	push   $0xb8
801070ce:	e9 06 f4 ff ff       	jmp    801064d9 <alltraps>

801070d3 <vector185>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 b9 00 00 00       	push   $0xb9
801070da:	e9 fa f3 ff ff       	jmp    801064d9 <alltraps>

801070df <vector186>:
801070df:	6a 00                	push   $0x0
801070e1:	68 ba 00 00 00       	push   $0xba
801070e6:	e9 ee f3 ff ff       	jmp    801064d9 <alltraps>

801070eb <vector187>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 bb 00 00 00       	push   $0xbb
801070f2:	e9 e2 f3 ff ff       	jmp    801064d9 <alltraps>

801070f7 <vector188>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 bc 00 00 00       	push   $0xbc
801070fe:	e9 d6 f3 ff ff       	jmp    801064d9 <alltraps>

80107103 <vector189>:
80107103:	6a 00                	push   $0x0
80107105:	68 bd 00 00 00       	push   $0xbd
8010710a:	e9 ca f3 ff ff       	jmp    801064d9 <alltraps>

8010710f <vector190>:
8010710f:	6a 00                	push   $0x0
80107111:	68 be 00 00 00       	push   $0xbe
80107116:	e9 be f3 ff ff       	jmp    801064d9 <alltraps>

8010711b <vector191>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 bf 00 00 00       	push   $0xbf
80107122:	e9 b2 f3 ff ff       	jmp    801064d9 <alltraps>

80107127 <vector192>:
80107127:	6a 00                	push   $0x0
80107129:	68 c0 00 00 00       	push   $0xc0
8010712e:	e9 a6 f3 ff ff       	jmp    801064d9 <alltraps>

80107133 <vector193>:
80107133:	6a 00                	push   $0x0
80107135:	68 c1 00 00 00       	push   $0xc1
8010713a:	e9 9a f3 ff ff       	jmp    801064d9 <alltraps>

8010713f <vector194>:
8010713f:	6a 00                	push   $0x0
80107141:	68 c2 00 00 00       	push   $0xc2
80107146:	e9 8e f3 ff ff       	jmp    801064d9 <alltraps>

8010714b <vector195>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 c3 00 00 00       	push   $0xc3
80107152:	e9 82 f3 ff ff       	jmp    801064d9 <alltraps>

80107157 <vector196>:
80107157:	6a 00                	push   $0x0
80107159:	68 c4 00 00 00       	push   $0xc4
8010715e:	e9 76 f3 ff ff       	jmp    801064d9 <alltraps>

80107163 <vector197>:
80107163:	6a 00                	push   $0x0
80107165:	68 c5 00 00 00       	push   $0xc5
8010716a:	e9 6a f3 ff ff       	jmp    801064d9 <alltraps>

8010716f <vector198>:
8010716f:	6a 00                	push   $0x0
80107171:	68 c6 00 00 00       	push   $0xc6
80107176:	e9 5e f3 ff ff       	jmp    801064d9 <alltraps>

8010717b <vector199>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 c7 00 00 00       	push   $0xc7
80107182:	e9 52 f3 ff ff       	jmp    801064d9 <alltraps>

80107187 <vector200>:
80107187:	6a 00                	push   $0x0
80107189:	68 c8 00 00 00       	push   $0xc8
8010718e:	e9 46 f3 ff ff       	jmp    801064d9 <alltraps>

80107193 <vector201>:
80107193:	6a 00                	push   $0x0
80107195:	68 c9 00 00 00       	push   $0xc9
8010719a:	e9 3a f3 ff ff       	jmp    801064d9 <alltraps>

8010719f <vector202>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 ca 00 00 00       	push   $0xca
801071a6:	e9 2e f3 ff ff       	jmp    801064d9 <alltraps>

801071ab <vector203>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 cb 00 00 00       	push   $0xcb
801071b2:	e9 22 f3 ff ff       	jmp    801064d9 <alltraps>

801071b7 <vector204>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 cc 00 00 00       	push   $0xcc
801071be:	e9 16 f3 ff ff       	jmp    801064d9 <alltraps>

801071c3 <vector205>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 cd 00 00 00       	push   $0xcd
801071ca:	e9 0a f3 ff ff       	jmp    801064d9 <alltraps>

801071cf <vector206>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 ce 00 00 00       	push   $0xce
801071d6:	e9 fe f2 ff ff       	jmp    801064d9 <alltraps>

801071db <vector207>:
801071db:	6a 00                	push   $0x0
801071dd:	68 cf 00 00 00       	push   $0xcf
801071e2:	e9 f2 f2 ff ff       	jmp    801064d9 <alltraps>

801071e7 <vector208>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 d0 00 00 00       	push   $0xd0
801071ee:	e9 e6 f2 ff ff       	jmp    801064d9 <alltraps>

801071f3 <vector209>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 d1 00 00 00       	push   $0xd1
801071fa:	e9 da f2 ff ff       	jmp    801064d9 <alltraps>

801071ff <vector210>:
801071ff:	6a 00                	push   $0x0
80107201:	68 d2 00 00 00       	push   $0xd2
80107206:	e9 ce f2 ff ff       	jmp    801064d9 <alltraps>

8010720b <vector211>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 d3 00 00 00       	push   $0xd3
80107212:	e9 c2 f2 ff ff       	jmp    801064d9 <alltraps>

80107217 <vector212>:
80107217:	6a 00                	push   $0x0
80107219:	68 d4 00 00 00       	push   $0xd4
8010721e:	e9 b6 f2 ff ff       	jmp    801064d9 <alltraps>

80107223 <vector213>:
80107223:	6a 00                	push   $0x0
80107225:	68 d5 00 00 00       	push   $0xd5
8010722a:	e9 aa f2 ff ff       	jmp    801064d9 <alltraps>

8010722f <vector214>:
8010722f:	6a 00                	push   $0x0
80107231:	68 d6 00 00 00       	push   $0xd6
80107236:	e9 9e f2 ff ff       	jmp    801064d9 <alltraps>

8010723b <vector215>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 d7 00 00 00       	push   $0xd7
80107242:	e9 92 f2 ff ff       	jmp    801064d9 <alltraps>

80107247 <vector216>:
80107247:	6a 00                	push   $0x0
80107249:	68 d8 00 00 00       	push   $0xd8
8010724e:	e9 86 f2 ff ff       	jmp    801064d9 <alltraps>

80107253 <vector217>:
80107253:	6a 00                	push   $0x0
80107255:	68 d9 00 00 00       	push   $0xd9
8010725a:	e9 7a f2 ff ff       	jmp    801064d9 <alltraps>

8010725f <vector218>:
8010725f:	6a 00                	push   $0x0
80107261:	68 da 00 00 00       	push   $0xda
80107266:	e9 6e f2 ff ff       	jmp    801064d9 <alltraps>

8010726b <vector219>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 db 00 00 00       	push   $0xdb
80107272:	e9 62 f2 ff ff       	jmp    801064d9 <alltraps>

80107277 <vector220>:
80107277:	6a 00                	push   $0x0
80107279:	68 dc 00 00 00       	push   $0xdc
8010727e:	e9 56 f2 ff ff       	jmp    801064d9 <alltraps>

80107283 <vector221>:
80107283:	6a 00                	push   $0x0
80107285:	68 dd 00 00 00       	push   $0xdd
8010728a:	e9 4a f2 ff ff       	jmp    801064d9 <alltraps>

8010728f <vector222>:
8010728f:	6a 00                	push   $0x0
80107291:	68 de 00 00 00       	push   $0xde
80107296:	e9 3e f2 ff ff       	jmp    801064d9 <alltraps>

8010729b <vector223>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 df 00 00 00       	push   $0xdf
801072a2:	e9 32 f2 ff ff       	jmp    801064d9 <alltraps>

801072a7 <vector224>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 e0 00 00 00       	push   $0xe0
801072ae:	e9 26 f2 ff ff       	jmp    801064d9 <alltraps>

801072b3 <vector225>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 e1 00 00 00       	push   $0xe1
801072ba:	e9 1a f2 ff ff       	jmp    801064d9 <alltraps>

801072bf <vector226>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 e2 00 00 00       	push   $0xe2
801072c6:	e9 0e f2 ff ff       	jmp    801064d9 <alltraps>

801072cb <vector227>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 e3 00 00 00       	push   $0xe3
801072d2:	e9 02 f2 ff ff       	jmp    801064d9 <alltraps>

801072d7 <vector228>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 e4 00 00 00       	push   $0xe4
801072de:	e9 f6 f1 ff ff       	jmp    801064d9 <alltraps>

801072e3 <vector229>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 e5 00 00 00       	push   $0xe5
801072ea:	e9 ea f1 ff ff       	jmp    801064d9 <alltraps>

801072ef <vector230>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 e6 00 00 00       	push   $0xe6
801072f6:	e9 de f1 ff ff       	jmp    801064d9 <alltraps>

801072fb <vector231>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 e7 00 00 00       	push   $0xe7
80107302:	e9 d2 f1 ff ff       	jmp    801064d9 <alltraps>

80107307 <vector232>:
80107307:	6a 00                	push   $0x0
80107309:	68 e8 00 00 00       	push   $0xe8
8010730e:	e9 c6 f1 ff ff       	jmp    801064d9 <alltraps>

80107313 <vector233>:
80107313:	6a 00                	push   $0x0
80107315:	68 e9 00 00 00       	push   $0xe9
8010731a:	e9 ba f1 ff ff       	jmp    801064d9 <alltraps>

8010731f <vector234>:
8010731f:	6a 00                	push   $0x0
80107321:	68 ea 00 00 00       	push   $0xea
80107326:	e9 ae f1 ff ff       	jmp    801064d9 <alltraps>

8010732b <vector235>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 eb 00 00 00       	push   $0xeb
80107332:	e9 a2 f1 ff ff       	jmp    801064d9 <alltraps>

80107337 <vector236>:
80107337:	6a 00                	push   $0x0
80107339:	68 ec 00 00 00       	push   $0xec
8010733e:	e9 96 f1 ff ff       	jmp    801064d9 <alltraps>

80107343 <vector237>:
80107343:	6a 00                	push   $0x0
80107345:	68 ed 00 00 00       	push   $0xed
8010734a:	e9 8a f1 ff ff       	jmp    801064d9 <alltraps>

8010734f <vector238>:
8010734f:	6a 00                	push   $0x0
80107351:	68 ee 00 00 00       	push   $0xee
80107356:	e9 7e f1 ff ff       	jmp    801064d9 <alltraps>

8010735b <vector239>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 ef 00 00 00       	push   $0xef
80107362:	e9 72 f1 ff ff       	jmp    801064d9 <alltraps>

80107367 <vector240>:
80107367:	6a 00                	push   $0x0
80107369:	68 f0 00 00 00       	push   $0xf0
8010736e:	e9 66 f1 ff ff       	jmp    801064d9 <alltraps>

80107373 <vector241>:
80107373:	6a 00                	push   $0x0
80107375:	68 f1 00 00 00       	push   $0xf1
8010737a:	e9 5a f1 ff ff       	jmp    801064d9 <alltraps>

8010737f <vector242>:
8010737f:	6a 00                	push   $0x0
80107381:	68 f2 00 00 00       	push   $0xf2
80107386:	e9 4e f1 ff ff       	jmp    801064d9 <alltraps>

8010738b <vector243>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 f3 00 00 00       	push   $0xf3
80107392:	e9 42 f1 ff ff       	jmp    801064d9 <alltraps>

80107397 <vector244>:
80107397:	6a 00                	push   $0x0
80107399:	68 f4 00 00 00       	push   $0xf4
8010739e:	e9 36 f1 ff ff       	jmp    801064d9 <alltraps>

801073a3 <vector245>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 f5 00 00 00       	push   $0xf5
801073aa:	e9 2a f1 ff ff       	jmp    801064d9 <alltraps>

801073af <vector246>:
801073af:	6a 00                	push   $0x0
801073b1:	68 f6 00 00 00       	push   $0xf6
801073b6:	e9 1e f1 ff ff       	jmp    801064d9 <alltraps>

801073bb <vector247>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 f7 00 00 00       	push   $0xf7
801073c2:	e9 12 f1 ff ff       	jmp    801064d9 <alltraps>

801073c7 <vector248>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 f8 00 00 00       	push   $0xf8
801073ce:	e9 06 f1 ff ff       	jmp    801064d9 <alltraps>

801073d3 <vector249>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 f9 00 00 00       	push   $0xf9
801073da:	e9 fa f0 ff ff       	jmp    801064d9 <alltraps>

801073df <vector250>:
801073df:	6a 00                	push   $0x0
801073e1:	68 fa 00 00 00       	push   $0xfa
801073e6:	e9 ee f0 ff ff       	jmp    801064d9 <alltraps>

801073eb <vector251>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 fb 00 00 00       	push   $0xfb
801073f2:	e9 e2 f0 ff ff       	jmp    801064d9 <alltraps>

801073f7 <vector252>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 fc 00 00 00       	push   $0xfc
801073fe:	e9 d6 f0 ff ff       	jmp    801064d9 <alltraps>

80107403 <vector253>:
80107403:	6a 00                	push   $0x0
80107405:	68 fd 00 00 00       	push   $0xfd
8010740a:	e9 ca f0 ff ff       	jmp    801064d9 <alltraps>

8010740f <vector254>:
8010740f:	6a 00                	push   $0x0
80107411:	68 fe 00 00 00       	push   $0xfe
80107416:	e9 be f0 ff ff       	jmp    801064d9 <alltraps>

8010741b <vector255>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 ff 00 00 00       	push   $0xff
80107422:	e9 b2 f0 ff ff       	jmp    801064d9 <alltraps>
80107427:	66 90                	xchg   %ax,%ax
80107429:	66 90                	xchg   %ax,%ax
8010742b:	66 90                	xchg   %ax,%ax
8010742d:	66 90                	xchg   %ax,%ax
8010742f:	90                   	nop

80107430 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107430:	55                   	push   %ebp
80107431:	89 e5                	mov    %esp,%ebp
80107433:	57                   	push   %edi
80107434:	56                   	push   %esi
80107435:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107436:	89 d3                	mov    %edx,%ebx
{
80107438:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010743a:	c1 eb 16             	shr    $0x16,%ebx
8010743d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107440:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107443:	8b 06                	mov    (%esi),%eax
80107445:	a8 01                	test   $0x1,%al
80107447:	74 27                	je     80107470 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107449:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010744e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107454:	c1 ef 0a             	shr    $0xa,%edi
}
80107457:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010745a:	89 fa                	mov    %edi,%edx
8010745c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107462:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107465:	5b                   	pop    %ebx
80107466:	5e                   	pop    %esi
80107467:	5f                   	pop    %edi
80107468:	5d                   	pop    %ebp
80107469:	c3                   	ret    
8010746a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107470:	85 c9                	test   %ecx,%ecx
80107472:	74 2c                	je     801074a0 <walkpgdir+0x70>
80107474:	e8 b7 b3 ff ff       	call   80102830 <kalloc>
80107479:	85 c0                	test   %eax,%eax
8010747b:	89 c3                	mov    %eax,%ebx
8010747d:	74 21                	je     801074a0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010747f:	83 ec 04             	sub    $0x4,%esp
80107482:	68 00 10 00 00       	push   $0x1000
80107487:	6a 00                	push   $0x0
80107489:	50                   	push   %eax
8010748a:	e8 51 dd ff ff       	call   801051e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010748f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107495:	83 c4 10             	add    $0x10,%esp
80107498:	83 c8 07             	or     $0x7,%eax
8010749b:	89 06                	mov    %eax,(%esi)
8010749d:	eb b5                	jmp    80107454 <walkpgdir+0x24>
8010749f:	90                   	nop
}
801074a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801074a3:	31 c0                	xor    %eax,%eax
}
801074a5:	5b                   	pop    %ebx
801074a6:	5e                   	pop    %esi
801074a7:	5f                   	pop    %edi
801074a8:	5d                   	pop    %ebp
801074a9:	c3                   	ret    
801074aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074b0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801074b6:	89 d3                	mov    %edx,%ebx
801074b8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801074be:	83 ec 1c             	sub    $0x1c,%esp
801074c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801074c4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801074c8:	8b 7d 08             	mov    0x8(%ebp),%edi
801074cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801074d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801074d6:	29 df                	sub    %ebx,%edi
801074d8:	83 c8 01             	or     $0x1,%eax
801074db:	89 45 dc             	mov    %eax,-0x24(%ebp)
801074de:	eb 15                	jmp    801074f5 <mappages+0x45>
    if(*pte & PTE_P)
801074e0:	f6 00 01             	testb  $0x1,(%eax)
801074e3:	75 45                	jne    8010752a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801074e5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801074e8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801074eb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801074ed:	74 31                	je     80107520 <mappages+0x70>
      break;
    a += PGSIZE;
801074ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801074f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074f8:	b9 01 00 00 00       	mov    $0x1,%ecx
801074fd:	89 da                	mov    %ebx,%edx
801074ff:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107502:	e8 29 ff ff ff       	call   80107430 <walkpgdir>
80107507:	85 c0                	test   %eax,%eax
80107509:	75 d5                	jne    801074e0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010750b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010750e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107513:	5b                   	pop    %ebx
80107514:	5e                   	pop    %esi
80107515:	5f                   	pop    %edi
80107516:	5d                   	pop    %ebp
80107517:	c3                   	ret    
80107518:	90                   	nop
80107519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107520:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107523:	31 c0                	xor    %eax,%eax
}
80107525:	5b                   	pop    %ebx
80107526:	5e                   	pop    %esi
80107527:	5f                   	pop    %edi
80107528:	5d                   	pop    %ebp
80107529:	c3                   	ret    
      panic("remap");
8010752a:	83 ec 0c             	sub    $0xc,%esp
8010752d:	68 f0 87 10 80       	push   $0x801087f0
80107532:	e8 59 8e ff ff       	call   80100390 <panic>
80107537:	89 f6                	mov    %esi,%esi
80107539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107540 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107540:	55                   	push   %ebp
80107541:	89 e5                	mov    %esp,%ebp
80107543:	57                   	push   %edi
80107544:	56                   	push   %esi
80107545:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107546:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010754c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010754e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107554:	83 ec 1c             	sub    $0x1c,%esp
80107557:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010755a:	39 d3                	cmp    %edx,%ebx
8010755c:	73 66                	jae    801075c4 <deallocuvm.part.0+0x84>
8010755e:	89 d6                	mov    %edx,%esi
80107560:	eb 3d                	jmp    8010759f <deallocuvm.part.0+0x5f>
80107562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107568:	8b 10                	mov    (%eax),%edx
8010756a:	f6 c2 01             	test   $0x1,%dl
8010756d:	74 26                	je     80107595 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010756f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107575:	74 58                	je     801075cf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107577:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010757a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107580:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107583:	52                   	push   %edx
80107584:	e8 f7 b0 ff ff       	call   80102680 <kfree>
      *pte = 0;
80107589:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010758c:	83 c4 10             	add    $0x10,%esp
8010758f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107595:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010759b:	39 f3                	cmp    %esi,%ebx
8010759d:	73 25                	jae    801075c4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010759f:	31 c9                	xor    %ecx,%ecx
801075a1:	89 da                	mov    %ebx,%edx
801075a3:	89 f8                	mov    %edi,%eax
801075a5:	e8 86 fe ff ff       	call   80107430 <walkpgdir>
    if(!pte)
801075aa:	85 c0                	test   %eax,%eax
801075ac:	75 ba                	jne    80107568 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801075ae:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801075b4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801075ba:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801075c0:	39 f3                	cmp    %esi,%ebx
801075c2:	72 db                	jb     8010759f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801075c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801075c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075ca:	5b                   	pop    %ebx
801075cb:	5e                   	pop    %esi
801075cc:	5f                   	pop    %edi
801075cd:	5d                   	pop    %ebp
801075ce:	c3                   	ret    
        panic("kfree");
801075cf:	83 ec 0c             	sub    $0xc,%esp
801075d2:	68 c6 7f 10 80       	push   $0x80107fc6
801075d7:	e8 b4 8d ff ff       	call   80100390 <panic>
801075dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801075e0 <seginit>:
{
801075e0:	55                   	push   %ebp
801075e1:	89 e5                	mov    %esp,%ebp
801075e3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801075e6:	e8 95 c5 ff ff       	call   80103b80 <cpuid>
801075eb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
801075f1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801075f6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801075fa:	c7 80 b8 3a 11 80 ff 	movl   $0xffff,-0x7feec548(%eax)
80107601:	ff 00 00 
80107604:	c7 80 bc 3a 11 80 00 	movl   $0xcf9a00,-0x7feec544(%eax)
8010760b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010760e:	c7 80 c0 3a 11 80 ff 	movl   $0xffff,-0x7feec540(%eax)
80107615:	ff 00 00 
80107618:	c7 80 c4 3a 11 80 00 	movl   $0xcf9200,-0x7feec53c(%eax)
8010761f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107622:	c7 80 c8 3a 11 80 ff 	movl   $0xffff,-0x7feec538(%eax)
80107629:	ff 00 00 
8010762c:	c7 80 cc 3a 11 80 00 	movl   $0xcffa00,-0x7feec534(%eax)
80107633:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107636:	c7 80 d0 3a 11 80 ff 	movl   $0xffff,-0x7feec530(%eax)
8010763d:	ff 00 00 
80107640:	c7 80 d4 3a 11 80 00 	movl   $0xcff200,-0x7feec52c(%eax)
80107647:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010764a:	05 b0 3a 11 80       	add    $0x80113ab0,%eax
  pd[1] = (uint)p;
8010764f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107653:	c1 e8 10             	shr    $0x10,%eax
80107656:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010765a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010765d:	0f 01 10             	lgdtl  (%eax)
}
80107660:	c9                   	leave  
80107661:	c3                   	ret    
80107662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107670 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107670:	a1 84 6d 11 80       	mov    0x80116d84,%eax
{
80107675:	55                   	push   %ebp
80107676:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107678:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010767d:	0f 22 d8             	mov    %eax,%cr3
}
80107680:	5d                   	pop    %ebp
80107681:	c3                   	ret    
80107682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107690 <switchuvm>:
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	57                   	push   %edi
80107694:	56                   	push   %esi
80107695:	53                   	push   %ebx
80107696:	83 ec 1c             	sub    $0x1c,%esp
80107699:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010769c:	85 db                	test   %ebx,%ebx
8010769e:	0f 84 cb 00 00 00    	je     8010776f <switchuvm+0xdf>
  if(p->kstack == 0)
801076a4:	8b 43 08             	mov    0x8(%ebx),%eax
801076a7:	85 c0                	test   %eax,%eax
801076a9:	0f 84 da 00 00 00    	je     80107789 <switchuvm+0xf9>
  if(p->pgdir == 0)
801076af:	8b 43 04             	mov    0x4(%ebx),%eax
801076b2:	85 c0                	test   %eax,%eax
801076b4:	0f 84 c2 00 00 00    	je     8010777c <switchuvm+0xec>
  pushcli();
801076ba:	e8 41 d9 ff ff       	call   80105000 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801076bf:	e8 3c c4 ff ff       	call   80103b00 <mycpu>
801076c4:	89 c6                	mov    %eax,%esi
801076c6:	e8 35 c4 ff ff       	call   80103b00 <mycpu>
801076cb:	89 c7                	mov    %eax,%edi
801076cd:	e8 2e c4 ff ff       	call   80103b00 <mycpu>
801076d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076d5:	83 c7 08             	add    $0x8,%edi
801076d8:	e8 23 c4 ff ff       	call   80103b00 <mycpu>
801076dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801076e0:	83 c0 08             	add    $0x8,%eax
801076e3:	ba 67 00 00 00       	mov    $0x67,%edx
801076e8:	c1 e8 18             	shr    $0x18,%eax
801076eb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801076f2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801076f9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801076ff:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107704:	83 c1 08             	add    $0x8,%ecx
80107707:	c1 e9 10             	shr    $0x10,%ecx
8010770a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107710:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107715:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010771c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107721:	e8 da c3 ff ff       	call   80103b00 <mycpu>
80107726:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010772d:	e8 ce c3 ff ff       	call   80103b00 <mycpu>
80107732:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107736:	8b 73 08             	mov    0x8(%ebx),%esi
80107739:	e8 c2 c3 ff ff       	call   80103b00 <mycpu>
8010773e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107744:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107747:	e8 b4 c3 ff ff       	call   80103b00 <mycpu>
8010774c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107750:	b8 28 00 00 00       	mov    $0x28,%eax
80107755:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107758:	8b 43 04             	mov    0x4(%ebx),%eax
8010775b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107760:	0f 22 d8             	mov    %eax,%cr3
}
80107763:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107766:	5b                   	pop    %ebx
80107767:	5e                   	pop    %esi
80107768:	5f                   	pop    %edi
80107769:	5d                   	pop    %ebp
  popcli();
8010776a:	e9 d1 d8 ff ff       	jmp    80105040 <popcli>
    panic("switchuvm: no process");
8010776f:	83 ec 0c             	sub    $0xc,%esp
80107772:	68 f6 87 10 80       	push   $0x801087f6
80107777:	e8 14 8c ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010777c:	83 ec 0c             	sub    $0xc,%esp
8010777f:	68 21 88 10 80       	push   $0x80108821
80107784:	e8 07 8c ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107789:	83 ec 0c             	sub    $0xc,%esp
8010778c:	68 0c 88 10 80       	push   $0x8010880c
80107791:	e8 fa 8b ff ff       	call   80100390 <panic>
80107796:	8d 76 00             	lea    0x0(%esi),%esi
80107799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077a0 <inituvm>:
{
801077a0:	55                   	push   %ebp
801077a1:	89 e5                	mov    %esp,%ebp
801077a3:	57                   	push   %edi
801077a4:	56                   	push   %esi
801077a5:	53                   	push   %ebx
801077a6:	83 ec 1c             	sub    $0x1c,%esp
801077a9:	8b 75 10             	mov    0x10(%ebp),%esi
801077ac:	8b 45 08             	mov    0x8(%ebp),%eax
801077af:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801077b2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801077b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801077bb:	77 49                	ja     80107806 <inituvm+0x66>
  mem = kalloc();
801077bd:	e8 6e b0 ff ff       	call   80102830 <kalloc>
  memset(mem, 0, PGSIZE);
801077c2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801077c5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801077c7:	68 00 10 00 00       	push   $0x1000
801077cc:	6a 00                	push   $0x0
801077ce:	50                   	push   %eax
801077cf:	e8 0c da ff ff       	call   801051e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801077d4:	58                   	pop    %eax
801077d5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801077db:	b9 00 10 00 00       	mov    $0x1000,%ecx
801077e0:	5a                   	pop    %edx
801077e1:	6a 06                	push   $0x6
801077e3:	50                   	push   %eax
801077e4:	31 d2                	xor    %edx,%edx
801077e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077e9:	e8 c2 fc ff ff       	call   801074b0 <mappages>
  memmove(mem, init, sz);
801077ee:	89 75 10             	mov    %esi,0x10(%ebp)
801077f1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801077f4:	83 c4 10             	add    $0x10,%esp
801077f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801077fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077fd:	5b                   	pop    %ebx
801077fe:	5e                   	pop    %esi
801077ff:	5f                   	pop    %edi
80107800:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107801:	e9 8a da ff ff       	jmp    80105290 <memmove>
    panic("inituvm: more than a page");
80107806:	83 ec 0c             	sub    $0xc,%esp
80107809:	68 35 88 10 80       	push   $0x80108835
8010780e:	e8 7d 8b ff ff       	call   80100390 <panic>
80107813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107820 <loaduvm>:
{
80107820:	55                   	push   %ebp
80107821:	89 e5                	mov    %esp,%ebp
80107823:	57                   	push   %edi
80107824:	56                   	push   %esi
80107825:	53                   	push   %ebx
80107826:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107829:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107830:	0f 85 91 00 00 00    	jne    801078c7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107836:	8b 75 18             	mov    0x18(%ebp),%esi
80107839:	31 db                	xor    %ebx,%ebx
8010783b:	85 f6                	test   %esi,%esi
8010783d:	75 1a                	jne    80107859 <loaduvm+0x39>
8010783f:	eb 6f                	jmp    801078b0 <loaduvm+0x90>
80107841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107848:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010784e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107854:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107857:	76 57                	jbe    801078b0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107859:	8b 55 0c             	mov    0xc(%ebp),%edx
8010785c:	8b 45 08             	mov    0x8(%ebp),%eax
8010785f:	31 c9                	xor    %ecx,%ecx
80107861:	01 da                	add    %ebx,%edx
80107863:	e8 c8 fb ff ff       	call   80107430 <walkpgdir>
80107868:	85 c0                	test   %eax,%eax
8010786a:	74 4e                	je     801078ba <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010786c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010786e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107871:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107876:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010787b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107881:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107884:	01 d9                	add    %ebx,%ecx
80107886:	05 00 00 00 80       	add    $0x80000000,%eax
8010788b:	57                   	push   %edi
8010788c:	51                   	push   %ecx
8010788d:	50                   	push   %eax
8010788e:	ff 75 10             	pushl  0x10(%ebp)
80107891:	e8 3a a4 ff ff       	call   80101cd0 <readi>
80107896:	83 c4 10             	add    $0x10,%esp
80107899:	39 f8                	cmp    %edi,%eax
8010789b:	74 ab                	je     80107848 <loaduvm+0x28>
}
8010789d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078a5:	5b                   	pop    %ebx
801078a6:	5e                   	pop    %esi
801078a7:	5f                   	pop    %edi
801078a8:	5d                   	pop    %ebp
801078a9:	c3                   	ret    
801078aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078b3:	31 c0                	xor    %eax,%eax
}
801078b5:	5b                   	pop    %ebx
801078b6:	5e                   	pop    %esi
801078b7:	5f                   	pop    %edi
801078b8:	5d                   	pop    %ebp
801078b9:	c3                   	ret    
      panic("loaduvm: address should exist");
801078ba:	83 ec 0c             	sub    $0xc,%esp
801078bd:	68 4f 88 10 80       	push   $0x8010884f
801078c2:	e8 c9 8a ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801078c7:	83 ec 0c             	sub    $0xc,%esp
801078ca:	68 f0 88 10 80       	push   $0x801088f0
801078cf:	e8 bc 8a ff ff       	call   80100390 <panic>
801078d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801078e0 <allocuvm>:
{
801078e0:	55                   	push   %ebp
801078e1:	89 e5                	mov    %esp,%ebp
801078e3:	57                   	push   %edi
801078e4:	56                   	push   %esi
801078e5:	53                   	push   %ebx
801078e6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801078e9:	8b 7d 10             	mov    0x10(%ebp),%edi
801078ec:	85 ff                	test   %edi,%edi
801078ee:	0f 88 8e 00 00 00    	js     80107982 <allocuvm+0xa2>
  if(newsz < oldsz)
801078f4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801078f7:	0f 82 93 00 00 00    	jb     80107990 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
801078fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80107900:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107906:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010790c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010790f:	0f 86 7e 00 00 00    	jbe    80107993 <allocuvm+0xb3>
80107915:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107918:	8b 7d 08             	mov    0x8(%ebp),%edi
8010791b:	eb 42                	jmp    8010795f <allocuvm+0x7f>
8010791d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107920:	83 ec 04             	sub    $0x4,%esp
80107923:	68 00 10 00 00       	push   $0x1000
80107928:	6a 00                	push   $0x0
8010792a:	50                   	push   %eax
8010792b:	e8 b0 d8 ff ff       	call   801051e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107930:	58                   	pop    %eax
80107931:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107937:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010793c:	5a                   	pop    %edx
8010793d:	6a 06                	push   $0x6
8010793f:	50                   	push   %eax
80107940:	89 da                	mov    %ebx,%edx
80107942:	89 f8                	mov    %edi,%eax
80107944:	e8 67 fb ff ff       	call   801074b0 <mappages>
80107949:	83 c4 10             	add    $0x10,%esp
8010794c:	85 c0                	test   %eax,%eax
8010794e:	78 50                	js     801079a0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107950:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107956:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107959:	0f 86 81 00 00 00    	jbe    801079e0 <allocuvm+0x100>
    mem = kalloc();
8010795f:	e8 cc ae ff ff       	call   80102830 <kalloc>
    if(mem == 0){
80107964:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107966:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107968:	75 b6                	jne    80107920 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010796a:	83 ec 0c             	sub    $0xc,%esp
8010796d:	68 6d 88 10 80       	push   $0x8010886d
80107972:	e8 e9 8c ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107977:	83 c4 10             	add    $0x10,%esp
8010797a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010797d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107980:	77 6e                	ja     801079f0 <allocuvm+0x110>
}
80107982:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107985:	31 ff                	xor    %edi,%edi
}
80107987:	89 f8                	mov    %edi,%eax
80107989:	5b                   	pop    %ebx
8010798a:	5e                   	pop    %esi
8010798b:	5f                   	pop    %edi
8010798c:	5d                   	pop    %ebp
8010798d:	c3                   	ret    
8010798e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107990:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107993:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107996:	89 f8                	mov    %edi,%eax
80107998:	5b                   	pop    %ebx
80107999:	5e                   	pop    %esi
8010799a:	5f                   	pop    %edi
8010799b:	5d                   	pop    %ebp
8010799c:	c3                   	ret    
8010799d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801079a0:	83 ec 0c             	sub    $0xc,%esp
801079a3:	68 85 88 10 80       	push   $0x80108885
801079a8:	e8 b3 8c ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801079ad:	83 c4 10             	add    $0x10,%esp
801079b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801079b3:	39 45 10             	cmp    %eax,0x10(%ebp)
801079b6:	76 0d                	jbe    801079c5 <allocuvm+0xe5>
801079b8:	89 c1                	mov    %eax,%ecx
801079ba:	8b 55 10             	mov    0x10(%ebp),%edx
801079bd:	8b 45 08             	mov    0x8(%ebp),%eax
801079c0:	e8 7b fb ff ff       	call   80107540 <deallocuvm.part.0>
      kfree(mem);
801079c5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801079c8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801079ca:	56                   	push   %esi
801079cb:	e8 b0 ac ff ff       	call   80102680 <kfree>
      return 0;
801079d0:	83 c4 10             	add    $0x10,%esp
}
801079d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d6:	89 f8                	mov    %edi,%eax
801079d8:	5b                   	pop    %ebx
801079d9:	5e                   	pop    %esi
801079da:	5f                   	pop    %edi
801079db:	5d                   	pop    %ebp
801079dc:	c3                   	ret    
801079dd:	8d 76 00             	lea    0x0(%esi),%esi
801079e0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801079e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079e6:	5b                   	pop    %ebx
801079e7:	89 f8                	mov    %edi,%eax
801079e9:	5e                   	pop    %esi
801079ea:	5f                   	pop    %edi
801079eb:	5d                   	pop    %ebp
801079ec:	c3                   	ret    
801079ed:	8d 76 00             	lea    0x0(%esi),%esi
801079f0:	89 c1                	mov    %eax,%ecx
801079f2:	8b 55 10             	mov    0x10(%ebp),%edx
801079f5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801079f8:	31 ff                	xor    %edi,%edi
801079fa:	e8 41 fb ff ff       	call   80107540 <deallocuvm.part.0>
801079ff:	eb 92                	jmp    80107993 <allocuvm+0xb3>
80107a01:	eb 0d                	jmp    80107a10 <deallocuvm>
80107a03:	90                   	nop
80107a04:	90                   	nop
80107a05:	90                   	nop
80107a06:	90                   	nop
80107a07:	90                   	nop
80107a08:	90                   	nop
80107a09:	90                   	nop
80107a0a:	90                   	nop
80107a0b:	90                   	nop
80107a0c:	90                   	nop
80107a0d:	90                   	nop
80107a0e:	90                   	nop
80107a0f:	90                   	nop

80107a10 <deallocuvm>:
{
80107a10:	55                   	push   %ebp
80107a11:	89 e5                	mov    %esp,%ebp
80107a13:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a16:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a19:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107a1c:	39 d1                	cmp    %edx,%ecx
80107a1e:	73 10                	jae    80107a30 <deallocuvm+0x20>
}
80107a20:	5d                   	pop    %ebp
80107a21:	e9 1a fb ff ff       	jmp    80107540 <deallocuvm.part.0>
80107a26:	8d 76 00             	lea    0x0(%esi),%esi
80107a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107a30:	89 d0                	mov    %edx,%eax
80107a32:	5d                   	pop    %ebp
80107a33:	c3                   	ret    
80107a34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107a40 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107a40:	55                   	push   %ebp
80107a41:	89 e5                	mov    %esp,%ebp
80107a43:	57                   	push   %edi
80107a44:	56                   	push   %esi
80107a45:	53                   	push   %ebx
80107a46:	83 ec 0c             	sub    $0xc,%esp
80107a49:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107a4c:	85 f6                	test   %esi,%esi
80107a4e:	74 59                	je     80107aa9 <freevm+0x69>
80107a50:	31 c9                	xor    %ecx,%ecx
80107a52:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107a57:	89 f0                	mov    %esi,%eax
80107a59:	e8 e2 fa ff ff       	call   80107540 <deallocuvm.part.0>
80107a5e:	89 f3                	mov    %esi,%ebx
80107a60:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107a66:	eb 0f                	jmp    80107a77 <freevm+0x37>
80107a68:	90                   	nop
80107a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a70:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107a73:	39 fb                	cmp    %edi,%ebx
80107a75:	74 23                	je     80107a9a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107a77:	8b 03                	mov    (%ebx),%eax
80107a79:	a8 01                	test   $0x1,%al
80107a7b:	74 f3                	je     80107a70 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107a7d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107a82:	83 ec 0c             	sub    $0xc,%esp
80107a85:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107a88:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107a8d:	50                   	push   %eax
80107a8e:	e8 ed ab ff ff       	call   80102680 <kfree>
80107a93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107a96:	39 fb                	cmp    %edi,%ebx
80107a98:	75 dd                	jne    80107a77 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107a9a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107a9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aa0:	5b                   	pop    %ebx
80107aa1:	5e                   	pop    %esi
80107aa2:	5f                   	pop    %edi
80107aa3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107aa4:	e9 d7 ab ff ff       	jmp    80102680 <kfree>
    panic("freevm: no pgdir");
80107aa9:	83 ec 0c             	sub    $0xc,%esp
80107aac:	68 a1 88 10 80       	push   $0x801088a1
80107ab1:	e8 da 88 ff ff       	call   80100390 <panic>
80107ab6:	8d 76 00             	lea    0x0(%esi),%esi
80107ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ac0 <setupkvm>:
{
80107ac0:	55                   	push   %ebp
80107ac1:	89 e5                	mov    %esp,%ebp
80107ac3:	56                   	push   %esi
80107ac4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107ac5:	e8 66 ad ff ff       	call   80102830 <kalloc>
80107aca:	85 c0                	test   %eax,%eax
80107acc:	89 c6                	mov    %eax,%esi
80107ace:	74 42                	je     80107b12 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107ad0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ad3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107ad8:	68 00 10 00 00       	push   $0x1000
80107add:	6a 00                	push   $0x0
80107adf:	50                   	push   %eax
80107ae0:	e8 fb d6 ff ff       	call   801051e0 <memset>
80107ae5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107ae8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107aeb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107aee:	83 ec 08             	sub    $0x8,%esp
80107af1:	8b 13                	mov    (%ebx),%edx
80107af3:	ff 73 0c             	pushl  0xc(%ebx)
80107af6:	50                   	push   %eax
80107af7:	29 c1                	sub    %eax,%ecx
80107af9:	89 f0                	mov    %esi,%eax
80107afb:	e8 b0 f9 ff ff       	call   801074b0 <mappages>
80107b00:	83 c4 10             	add    $0x10,%esp
80107b03:	85 c0                	test   %eax,%eax
80107b05:	78 19                	js     80107b20 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b07:	83 c3 10             	add    $0x10,%ebx
80107b0a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b10:	75 d6                	jne    80107ae8 <setupkvm+0x28>
}
80107b12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b15:	89 f0                	mov    %esi,%eax
80107b17:	5b                   	pop    %ebx
80107b18:	5e                   	pop    %esi
80107b19:	5d                   	pop    %ebp
80107b1a:	c3                   	ret    
80107b1b:	90                   	nop
80107b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107b20:	83 ec 0c             	sub    $0xc,%esp
80107b23:	56                   	push   %esi
      return 0;
80107b24:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107b26:	e8 15 ff ff ff       	call   80107a40 <freevm>
      return 0;
80107b2b:	83 c4 10             	add    $0x10,%esp
}
80107b2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b31:	89 f0                	mov    %esi,%eax
80107b33:	5b                   	pop    %ebx
80107b34:	5e                   	pop    %esi
80107b35:	5d                   	pop    %ebp
80107b36:	c3                   	ret    
80107b37:	89 f6                	mov    %esi,%esi
80107b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107b40 <kvmalloc>:
{
80107b40:	55                   	push   %ebp
80107b41:	89 e5                	mov    %esp,%ebp
80107b43:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107b46:	e8 75 ff ff ff       	call   80107ac0 <setupkvm>
80107b4b:	a3 84 6d 11 80       	mov    %eax,0x80116d84
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107b50:	05 00 00 00 80       	add    $0x80000000,%eax
80107b55:	0f 22 d8             	mov    %eax,%cr3
}
80107b58:	c9                   	leave  
80107b59:	c3                   	ret    
80107b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b60 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107b60:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b61:	31 c9                	xor    %ecx,%ecx
{
80107b63:	89 e5                	mov    %esp,%ebp
80107b65:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107b68:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b6b:	8b 45 08             	mov    0x8(%ebp),%eax
80107b6e:	e8 bd f8 ff ff       	call   80107430 <walkpgdir>
  if(pte == 0)
80107b73:	85 c0                	test   %eax,%eax
80107b75:	74 05                	je     80107b7c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107b77:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107b7a:	c9                   	leave  
80107b7b:	c3                   	ret    
    panic("clearpteu");
80107b7c:	83 ec 0c             	sub    $0xc,%esp
80107b7f:	68 b2 88 10 80       	push   $0x801088b2
80107b84:	e8 07 88 ff ff       	call   80100390 <panic>
80107b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b90 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107b90:	55                   	push   %ebp
80107b91:	89 e5                	mov    %esp,%ebp
80107b93:	57                   	push   %edi
80107b94:	56                   	push   %esi
80107b95:	53                   	push   %ebx
80107b96:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107b99:	e8 22 ff ff ff       	call   80107ac0 <setupkvm>
80107b9e:	85 c0                	test   %eax,%eax
80107ba0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107ba3:	0f 84 9f 00 00 00    	je     80107c48 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107ba9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107bac:	85 c9                	test   %ecx,%ecx
80107bae:	0f 84 94 00 00 00    	je     80107c48 <copyuvm+0xb8>
80107bb4:	31 ff                	xor    %edi,%edi
80107bb6:	eb 4a                	jmp    80107c02 <copyuvm+0x72>
80107bb8:	90                   	nop
80107bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107bc0:	83 ec 04             	sub    $0x4,%esp
80107bc3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107bc9:	68 00 10 00 00       	push   $0x1000
80107bce:	53                   	push   %ebx
80107bcf:	50                   	push   %eax
80107bd0:	e8 bb d6 ff ff       	call   80105290 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107bd5:	58                   	pop    %eax
80107bd6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107bdc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107be1:	5a                   	pop    %edx
80107be2:	ff 75 e4             	pushl  -0x1c(%ebp)
80107be5:	50                   	push   %eax
80107be6:	89 fa                	mov    %edi,%edx
80107be8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107beb:	e8 c0 f8 ff ff       	call   801074b0 <mappages>
80107bf0:	83 c4 10             	add    $0x10,%esp
80107bf3:	85 c0                	test   %eax,%eax
80107bf5:	78 61                	js     80107c58 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107bf7:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107bfd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107c00:	76 46                	jbe    80107c48 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107c02:	8b 45 08             	mov    0x8(%ebp),%eax
80107c05:	31 c9                	xor    %ecx,%ecx
80107c07:	89 fa                	mov    %edi,%edx
80107c09:	e8 22 f8 ff ff       	call   80107430 <walkpgdir>
80107c0e:	85 c0                	test   %eax,%eax
80107c10:	74 61                	je     80107c73 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107c12:	8b 00                	mov    (%eax),%eax
80107c14:	a8 01                	test   $0x1,%al
80107c16:	74 4e                	je     80107c66 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107c18:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80107c1a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80107c1f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107c25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107c28:	e8 03 ac ff ff       	call   80102830 <kalloc>
80107c2d:	85 c0                	test   %eax,%eax
80107c2f:	89 c6                	mov    %eax,%esi
80107c31:	75 8d                	jne    80107bc0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107c33:	83 ec 0c             	sub    $0xc,%esp
80107c36:	ff 75 e0             	pushl  -0x20(%ebp)
80107c39:	e8 02 fe ff ff       	call   80107a40 <freevm>
  return 0;
80107c3e:	83 c4 10             	add    $0x10,%esp
80107c41:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107c48:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c4e:	5b                   	pop    %ebx
80107c4f:	5e                   	pop    %esi
80107c50:	5f                   	pop    %edi
80107c51:	5d                   	pop    %ebp
80107c52:	c3                   	ret    
80107c53:	90                   	nop
80107c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107c58:	83 ec 0c             	sub    $0xc,%esp
80107c5b:	56                   	push   %esi
80107c5c:	e8 1f aa ff ff       	call   80102680 <kfree>
      goto bad;
80107c61:	83 c4 10             	add    $0x10,%esp
80107c64:	eb cd                	jmp    80107c33 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107c66:	83 ec 0c             	sub    $0xc,%esp
80107c69:	68 d6 88 10 80       	push   $0x801088d6
80107c6e:	e8 1d 87 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107c73:	83 ec 0c             	sub    $0xc,%esp
80107c76:	68 bc 88 10 80       	push   $0x801088bc
80107c7b:	e8 10 87 ff ff       	call   80100390 <panic>

80107c80 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107c80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107c81:	31 c9                	xor    %ecx,%ecx
{
80107c83:	89 e5                	mov    %esp,%ebp
80107c85:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107c88:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c8b:	8b 45 08             	mov    0x8(%ebp),%eax
80107c8e:	e8 9d f7 ff ff       	call   80107430 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107c93:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107c95:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107c96:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107c98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107c9d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ca0:	05 00 00 00 80       	add    $0x80000000,%eax
80107ca5:	83 fa 05             	cmp    $0x5,%edx
80107ca8:	ba 00 00 00 00       	mov    $0x0,%edx
80107cad:	0f 45 c2             	cmovne %edx,%eax
}
80107cb0:	c3                   	ret    
80107cb1:	eb 0d                	jmp    80107cc0 <copyout>
80107cb3:	90                   	nop
80107cb4:	90                   	nop
80107cb5:	90                   	nop
80107cb6:	90                   	nop
80107cb7:	90                   	nop
80107cb8:	90                   	nop
80107cb9:	90                   	nop
80107cba:	90                   	nop
80107cbb:	90                   	nop
80107cbc:	90                   	nop
80107cbd:	90                   	nop
80107cbe:	90                   	nop
80107cbf:	90                   	nop

80107cc0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107cc0:	55                   	push   %ebp
80107cc1:	89 e5                	mov    %esp,%ebp
80107cc3:	57                   	push   %edi
80107cc4:	56                   	push   %esi
80107cc5:	53                   	push   %ebx
80107cc6:	83 ec 1c             	sub    $0x1c,%esp
80107cc9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107ccc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ccf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107cd2:	85 db                	test   %ebx,%ebx
80107cd4:	75 40                	jne    80107d16 <copyout+0x56>
80107cd6:	eb 70                	jmp    80107d48 <copyout+0x88>
80107cd8:	90                   	nop
80107cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107ce0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107ce3:	89 f1                	mov    %esi,%ecx
80107ce5:	29 d1                	sub    %edx,%ecx
80107ce7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107ced:	39 d9                	cmp    %ebx,%ecx
80107cef:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107cf2:	29 f2                	sub    %esi,%edx
80107cf4:	83 ec 04             	sub    $0x4,%esp
80107cf7:	01 d0                	add    %edx,%eax
80107cf9:	51                   	push   %ecx
80107cfa:	57                   	push   %edi
80107cfb:	50                   	push   %eax
80107cfc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107cff:	e8 8c d5 ff ff       	call   80105290 <memmove>
    len -= n;
    buf += n;
80107d04:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107d07:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107d0a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107d10:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107d12:	29 cb                	sub    %ecx,%ebx
80107d14:	74 32                	je     80107d48 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107d16:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107d18:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107d1b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107d1e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107d24:	56                   	push   %esi
80107d25:	ff 75 08             	pushl  0x8(%ebp)
80107d28:	e8 53 ff ff ff       	call   80107c80 <uva2ka>
    if(pa0 == 0)
80107d2d:	83 c4 10             	add    $0x10,%esp
80107d30:	85 c0                	test   %eax,%eax
80107d32:	75 ac                	jne    80107ce0 <copyout+0x20>
  }
  return 0;
}
80107d34:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107d37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107d3c:	5b                   	pop    %ebx
80107d3d:	5e                   	pop    %esi
80107d3e:	5f                   	pop    %edi
80107d3f:	5d                   	pop    %ebp
80107d40:	c3                   	ret    
80107d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d48:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107d4b:	31 c0                	xor    %eax,%eax
}
80107d4d:	5b                   	pop    %ebx
80107d4e:	5e                   	pop    %esi
80107d4f:	5f                   	pop    %edi
80107d50:	5d                   	pop    %ebp
80107d51:	c3                   	ret    
