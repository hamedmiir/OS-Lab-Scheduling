
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
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 00 b6 10 80       	mov    $0x8010b600,%esp
8010002d:	b8 b0 31 10 80       	mov    $0x801031b0,%eax
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
80100044:	bb 34 b6 10 80       	mov    $0x8010b634,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 73 10 80       	push   $0x80107340
80100051:	68 00 b6 10 80       	push   $0x8010b600
80100056:	e8 d5 45 00 00       	call   80104630 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 4c fd 10 80 fc 	movl   $0x8010fcfc,0x8010fd4c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 50 fd 10 80 fc 	movl   $0x8010fcfc,0x8010fd50
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba fc fc 10 80       	mov    $0x8010fcfc,%edx
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
8010008b:	c7 43 50 fc fc 10 80 	movl   $0x8010fcfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 73 10 80       	push   $0x80107347
80100097:	50                   	push   %eax
80100098:	e8 63 44 00 00       	call   80104500 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 fd 10 80       	mov    0x8010fd50,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 50 fd 10 80    	mov    %ebx,0x8010fd50
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d fc fc 10 80       	cmp    $0x8010fcfc,%eax
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
801000df:	68 00 b6 10 80       	push   $0x8010b600
801000e4:	e8 87 46 00 00       	call   80104770 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 50 fd 10 80    	mov    0x8010fd50,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb fc fc 10 80    	cmp    $0x8010fcfc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc fc 10 80    	cmp    $0x8010fcfc,%ebx
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
80100120:	8b 1d 4c fd 10 80    	mov    0x8010fd4c,%ebx
80100126:	81 fb fc fc 10 80    	cmp    $0x8010fcfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc fc 10 80    	cmp    $0x8010fcfc,%ebx
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
8010015d:	68 00 b6 10 80       	push   $0x8010b600
80100162:	e8 c9 46 00 00       	call   80104830 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 43 00 00       	call   80104540 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 ad 22 00 00       	call   80102430 <iderw>
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
80100193:	68 4e 73 10 80       	push   $0x8010734e
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
801001ae:	e8 2d 44 00 00       	call   801045e0 <holdingsleep>
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
801001c4:	e9 67 22 00 00       	jmp    80102430 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 5f 73 10 80       	push   $0x8010735f
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
801001ef:	e8 ec 43 00 00       	call   801045e0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 43 00 00       	call   801045a0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010020b:	e8 60 45 00 00       	call   80104770 <acquire>
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
80100232:	a1 50 fd 10 80       	mov    0x8010fd50,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 fc fc 10 80 	movl   $0x8010fcfc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 50 fd 10 80       	mov    0x8010fd50,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 50 fd 10 80    	mov    %ebx,0x8010fd50
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 00 b6 10 80 	movl   $0x8010b600,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 cf 45 00 00       	jmp    80104830 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 73 10 80       	push   $0x80107366
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
80100280:	e8 eb 17 00 00       	call   80101a70 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
8010028c:	e8 df 44 00 00       	call   80104770 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 e0 ff 10 80    	mov    0x8010ffe0,%edx
801002a7:	39 15 e4 ff 10 80    	cmp    %edx,0x8010ffe4
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
801002bb:	68 60 a5 10 80       	push   $0x8010a560
801002c0:	68 e0 ff 10 80       	push   $0x8010ffe0
801002c5:	e8 c6 3d 00 00       	call   80104090 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 e0 ff 10 80    	mov    0x8010ffe0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 e4 ff 10 80    	cmp    0x8010ffe4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 10 38 00 00       	call   80103af0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 60 a5 10 80       	push   $0x8010a560
801002ef:	e8 3c 45 00 00       	call   80104830 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 16 00 00       	call   80101990 <ilock>
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
80100313:	a3 e0 ff 10 80       	mov    %eax,0x8010ffe0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 60 ff 10 80 	movsbl -0x7fef00a0(%eax),%eax
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
80100348:	68 60 a5 10 80       	push   $0x8010a560
8010034d:	e8 de 44 00 00       	call   80104830 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 16 00 00       	call   80101990 <ilock>
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
80100372:	89 15 e0 ff 10 80    	mov    %edx,0x8010ffe0
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
80100399:	c7 05 94 a5 10 80 00 	movl   $0x0,0x8010a594
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 92 26 00 00       	call   80102a40 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 6d 73 10 80       	push   $0x8010736d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 8b 7d 10 80 	movl   $0x80107d8b,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 73 42 00 00       	call   80104650 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 73 10 80       	push   $0x80107381
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 98 a5 10 80 01 	movl   $0x1,0x8010a598
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 98 a5 10 80    	mov    0x8010a598,%ecx
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
8010043a:	e8 01 5b 00 00       	call   80105f40 <uartputc>
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
801004ec:	e8 4f 5a 00 00       	call   80105f40 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 43 5a 00 00       	call   80105f40 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 37 5a 00 00       	call   80105f40 <uartputc>
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
80100524:	e8 07 44 00 00       	call   80104930 <memmove>
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
80100541:	e8 3a 43 00 00       	call   80104880 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 73 10 80       	push   $0x80107385
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
801005b1:	0f b6 92 b0 73 10 80 	movzbl -0x7fef8c50(%edx),%edx
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
8010060f:	e8 5c 14 00 00       	call   80101a70 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
8010061b:	e8 50 41 00 00       	call   80104770 <acquire>
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
80100642:	68 60 a5 10 80       	push   $0x8010a560
80100647:	e8 e4 41 00 00       	call   80104830 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 13 00 00       	call   80101990 <ilock>

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
80100669:	a1 94 a5 10 80       	mov    0x8010a594,%eax
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
8010071a:	68 60 a5 10 80       	push   $0x8010a560
8010071f:	e8 0c 41 00 00       	call   80104830 <release>
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
801007d0:	ba 98 73 10 80       	mov    $0x80107398,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 60 a5 10 80       	push   $0x8010a560
801007f0:	e8 7b 3f 00 00       	call   80104770 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 73 10 80       	push   $0x8010739f
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
8010081e:	8b 3d 34 a5 10 80    	mov    0x8010a534,%edi
80100824:	8b 1d e4 ff 10 80    	mov    0x8010ffe4,%ebx
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
80100849:	8d b7 00 00 11 80    	lea    -0x7fef0000(%edi),%esi
8010084f:	56                   	push   %esi
80100850:	e8 2b 40 00 00       	call   80104880 <memset>
    while( i != ((input.e - 1)%INPUT_BUF)){
80100855:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
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
80100870:	0f b6 8b 60 ff 10 80 	movzbl -0x7fef00a0(%ebx),%ecx
                  i = (i + 1) % INPUT_BUF;
80100877:	83 c3 01             	add    $0x1,%ebx
8010087a:	83 e3 7f             	and    $0x7f,%ebx
                  temp_buf[temp_cur][j] = input.buf[i];
8010087d:	88 8c 17 00 00 11 80 	mov    %cl,-0x7fef0000(%edi,%edx,1)
                  j++;
80100884:	83 c2 01             	add    $0x1,%edx
    while( i != ((input.e - 1)%INPUT_BUF)){
80100887:	39 c3                	cmp    %eax,%ebx
80100889:	75 e5                	jne    80100870 <InsertNewCmd+0x60>
8010088b:	b8 20 a5 10 80       	mov    $0x8010a520,%eax
      history.PervCmd[i] = history.PervCmd[i-1];
80100890:	8b 48 0c             	mov    0xc(%eax),%ecx
80100893:	83 e8 04             	sub    $0x4,%eax
80100896:	89 48 14             	mov    %ecx,0x14(%eax)
      history.size[i] = history.size[i-1];
80100899:	8b 48 2c             	mov    0x2c(%eax),%ecx
8010089c:	89 48 30             	mov    %ecx,0x30(%eax)
    for(int i = 4 ; i > 0 ; i--){
8010089f:	3d 10 a5 10 80       	cmp    $0x8010a510,%eax
801008a4:	75 ea                	jne    80100890 <InsertNewCmd+0x80>
    history.PervCmd[0] = temp_buf[temp_cur];
801008a6:	89 35 20 a5 10 80    	mov    %esi,0x8010a520
    history.size[0] = j;
801008ac:	89 15 3c a5 10 80    	mov    %edx,0x8010a53c
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
801008c0:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
801008c5:	3b 05 e4 ff 10 80    	cmp    0x8010ffe4,%eax
801008cb:	74 53                	je     80100920 <killLine+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008cd:	83 e8 01             	sub    $0x1,%eax
801008d0:	89 c2                	mov    %eax,%edx
801008d2:	83 e2 7f             	and    $0x7f,%edx
  while(input.e != input.w &&
801008d5:	80 ba 60 ff 10 80 0a 	cmpb   $0xa,-0x7fef00a0(%edx)
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
801008f8:	80 ba 60 ff 10 80 0a 	cmpb   $0xa,-0x7fef00a0(%edx)
801008ff:	74 1c                	je     8010091d <killLine+0x5d>
        input.e--;
80100901:	a3 e8 ff 10 80       	mov    %eax,0x8010ffe8
        consputc(BACKSPACE);
80100906:	b8 00 01 00 00       	mov    $0x100,%eax
8010090b:	e8 00 fb ff ff       	call   80100410 <consputc>
  while(input.e != input.w &&
80100910:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
80100915:	3b 05 e4 ff 10 80    	cmp    0x8010ffe4,%eax
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
8010093a:	a1 38 a5 10 80       	mov    0x8010a538,%eax
8010093f:	8b 1c 85 3c a5 10 80 	mov    -0x7fef5ac4(,%eax,4),%ebx
80100946:	85 db                	test   %ebx,%ebx
80100948:	7e 32                	jle    8010097c <fillBuf+0x4c>
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
8010094a:	8b 34 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%esi
80100951:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
80100956:	01 c3                	add    %eax,%ebx
80100958:	29 c6                	sub    %eax,%esi
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100960:	8d 50 01             	lea    0x1(%eax),%edx
80100963:	89 15 e8 ff 10 80    	mov    %edx,0x8010ffe8
80100969:	0f b6 0c 30          	movzbl (%eax,%esi,1),%ecx
8010096d:	83 e0 7f             	and    $0x7f,%eax
  for(int i = 0; i < history.size[history.cursor] ; i++)
80100970:	39 da                	cmp    %ebx,%edx
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
80100972:	88 88 60 ff 10 80    	mov    %cl,-0x7fef00a0(%eax)
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
80100980:	8b 0d 38 a5 10 80    	mov    0x8010a538,%ecx
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
801009a8:	3b 0d 34 a5 10 80    	cmp    0x8010a534,%ecx
  history.cursor = (history.cursor + 1) % 5;
801009ae:	89 ca                	mov    %ecx,%edx
801009b0:	89 0d 38 a5 10 80    	mov    %ecx,0x8010a538
      if ( history.cursor == history.cmd_count) 
801009b6:	74 08                	je     801009c0 <IncCursor+0x40>
}
801009b8:	5d                   	pop    %ebp
801009b9:	c3                   	ret    
801009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        history.cursor = history.cmd_count - 1;
801009c0:	83 ea 01             	sub    $0x1,%edx
801009c3:	89 15 38 a5 10 80    	mov    %edx,0x8010a538
}
801009c9:	5d                   	pop    %ebp
801009ca:	c3                   	ret    
801009cb:	90                   	nop
801009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009d0 <DecCursor>:
  if ( history.cursor < 0)
801009d0:	a1 38 a5 10 80       	mov    0x8010a538,%eax
{
801009d5:	55                   	push   %ebp
801009d6:	89 e5                	mov    %esp,%ebp
  if ( history.cursor < 0)
801009d8:	85 c0                	test   %eax,%eax
801009da:	78 08                	js     801009e4 <DecCursor+0x14>
  history.cursor = history.cursor - 1;
801009dc:	83 e8 01             	sub    $0x1,%eax
801009df:	a3 38 a5 10 80       	mov    %eax,0x8010a538
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
801009f7:	8b 1d e4 ff 10 80    	mov    0x8010ffe4,%ebx
801009fd:	eb 10                	jmp    80100a0f <printInput+0x1f>
801009ff:	90                   	nop
    consputc(input.buf[i]);
80100a00:	0f be 83 60 ff 10 80 	movsbl -0x7fef00a0(%ebx),%eax
    i = (i + 1) % INPUT_BUF;
80100a07:	83 c3 01             	add    $0x1,%ebx
    consputc(input.buf[i]);
80100a0a:	e8 01 fa ff ff       	call   80100410 <consputc>
  while( i != (input.e % INPUT_BUF)){ 
80100a0f:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
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
80100a30:	a1 38 a5 10 80       	mov    0x8010a538,%eax
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
80100a47:	a3 38 a5 10 80       	mov    %eax,0x8010a538
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
80100a67:	8b 1d 34 a5 10 80    	mov    0x8010a534,%ebx
80100a6d:	85 db                	test   %ebx,%ebx
80100a6f:	74 47                	je     80100ab8 <KeyUpPressed+0x58>
  if (history.cursor == 4)
80100a71:	8b 0d 38 a5 10 80    	mov    0x8010a538,%ecx
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
80100aa0:	89 15 38 a5 10 80    	mov    %edx,0x8010a538
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
80100ac0:	a1 34 a5 10 80       	mov    0x8010a534,%eax
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
80100aee:	68 60 a5 10 80       	push   $0x8010a560
80100af3:	e8 78 3c 00 00       	call   80104770 <acquire>
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
80100b40:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
80100b45:	89 c2                	mov    %eax,%edx
80100b47:	2b 15 e0 ff 10 80    	sub    0x8010ffe0,%edx
80100b4d:	83 fa 7f             	cmp    $0x7f,%edx
80100b50:	77 ae                	ja     80100b00 <consoleintr+0x20>
80100b52:	8d 50 01             	lea    0x1(%eax),%edx
80100b55:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100b58:	83 fb 0d             	cmp    $0xd,%ebx
        input.buf[input.e++ % INPUT_BUF] = c;
80100b5b:	89 15 e8 ff 10 80    	mov    %edx,0x8010ffe8
        c = (c == '\r') ? '\n' : c;
80100b61:	0f 84 f9 00 00 00    	je     80100c60 <consoleintr+0x180>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b67:	88 98 60 ff 10 80    	mov    %bl,-0x7fef00a0(%eax)
        consputc(c);
80100b6d:	89 d8                	mov    %ebx,%eax
80100b6f:	e8 9c f8 ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b74:	83 fb 0a             	cmp    $0xa,%ebx
80100b77:	0f 84 f4 00 00 00    	je     80100c71 <consoleintr+0x191>
80100b7d:	83 fb 04             	cmp    $0x4,%ebx
80100b80:	0f 84 eb 00 00 00    	je     80100c71 <consoleintr+0x191>
80100b86:	a1 e0 ff 10 80       	mov    0x8010ffe0,%eax
80100b8b:	83 e8 80             	sub    $0xffffff80,%eax
80100b8e:	39 05 e8 ff 10 80    	cmp    %eax,0x8010ffe8
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
80100bc3:	68 60 a5 10 80       	push   $0x8010a560
80100bc8:	e8 63 3c 00 00       	call   80104830 <release>
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
80100bf0:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
80100bf5:	3b 05 e4 ff 10 80    	cmp    0x8010ffe4,%eax
80100bfb:	0f 84 ff fe ff ff    	je     80100b00 <consoleintr+0x20>
        input.e--;
80100c01:	83 e8 01             	sub    $0x1,%eax
80100c04:	a3 e8 ff 10 80       	mov    %eax,0x8010ffe8
        consputc(BACKSPACE);
80100c09:	b8 00 01 00 00       	mov    $0x100,%eax
80100c0e:	e8 fd f7 ff ff       	call   80100410 <consputc>
80100c13:	e9 e8 fe ff ff       	jmp    80100b00 <consoleintr+0x20>
80100c18:	90                   	nop
80100c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if ( history.cmd_count == 0) 
80100c20:	a1 34 a5 10 80       	mov    0x8010a534,%eax
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
80100c57:	e9 c4 36 00 00       	jmp    80104320 <procdump>
80100c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100c60:	c6 80 60 ff 10 80 0a 	movb   $0xa,-0x7fef00a0(%eax)
        consputc(c);
80100c67:	b8 0a 00 00 00       	mov    $0xa,%eax
80100c6c:	e8 9f f7 ff ff       	call   80100410 <consputc>
80100c71:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
          if ( (input.e - input.w) != 1) {
80100c76:	89 c2                	mov    %eax,%edx
80100c78:	2b 15 e4 ff 10 80    	sub    0x8010ffe4,%edx
80100c7e:	83 fa 01             	cmp    $0x1,%edx
80100c81:	74 1b                	je     80100c9e <consoleintr+0x1be>
            InsertNewCmd();
80100c83:	e8 88 fb ff ff       	call   80100810 <InsertNewCmd>
            history.cmd_count++;
80100c88:	83 05 34 a5 10 80 01 	addl   $0x1,0x8010a534
80100c8f:	a1 e8 ff 10 80       	mov    0x8010ffe8,%eax
            history.cursor = -1;
80100c94:	c7 05 38 a5 10 80 ff 	movl   $0xffffffff,0x8010a538
80100c9b:	ff ff ff 
          wakeup(&input.r);
80100c9e:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100ca1:	a3 e4 ff 10 80       	mov    %eax,0x8010ffe4
          wakeup(&input.r);
80100ca6:	68 e0 ff 10 80       	push   $0x8010ffe0
80100cab:	e8 90 35 00 00       	call   80104240 <wakeup>
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
80100cc6:	68 a8 73 10 80       	push   $0x801073a8
80100ccb:	68 60 a5 10 80       	push   $0x8010a560
80100cd0:	e8 5b 39 00 00       	call   80104630 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100cd5:	58                   	pop    %eax
80100cd6:	5a                   	pop    %edx
80100cd7:	6a 00                	push   $0x0
80100cd9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100cdb:	c7 05 2c 0c 11 80 00 	movl   $0x80100600,0x80110c2c
80100ce2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100ce5:	c7 05 28 0c 11 80 70 	movl   $0x80100270,0x80110c28
80100cec:	02 10 80 
  cons.locking = 1;
80100cef:	c7 05 94 a5 10 80 01 	movl   $0x1,0x8010a594
80100cf6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100cf9:	e8 e2 18 00 00       	call   801025e0 <ioapicenable>
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
80100d1c:	e8 cf 2d 00 00       	call   80103af0 <myproc>
80100d21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100d27:	e8 84 21 00 00       	call   80102eb0 <begin_op>

  if((ip = namei(path)) == 0){
80100d2c:	83 ec 0c             	sub    $0xc,%esp
80100d2f:	ff 75 08             	pushl  0x8(%ebp)
80100d32:	e8 b9 14 00 00       	call   801021f0 <namei>
80100d37:	83 c4 10             	add    $0x10,%esp
80100d3a:	85 c0                	test   %eax,%eax
80100d3c:	0f 84 91 01 00 00    	je     80100ed3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100d42:	83 ec 0c             	sub    $0xc,%esp
80100d45:	89 c3                	mov    %eax,%ebx
80100d47:	50                   	push   %eax
80100d48:	e8 43 0c 00 00       	call   80101990 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100d4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100d53:	6a 34                	push   $0x34
80100d55:	6a 00                	push   $0x0
80100d57:	50                   	push   %eax
80100d58:	53                   	push   %ebx
80100d59:	e8 12 0f 00 00       	call   80101c70 <readi>
80100d5e:	83 c4 20             	add    $0x20,%esp
80100d61:	83 f8 34             	cmp    $0x34,%eax
80100d64:	74 22                	je     80100d88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100d66:	83 ec 0c             	sub    $0xc,%esp
80100d69:	53                   	push   %ebx
80100d6a:	e8 b1 0e 00 00       	call   80101c20 <iunlockput>
    end_op();
80100d6f:	e8 ac 21 00 00       	call   80102f20 <end_op>
80100d74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100d77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100d7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d7f:	5b                   	pop    %ebx
80100d80:	5e                   	pop    %esi
80100d81:	5f                   	pop    %edi
80100d82:	5d                   	pop    %ebp
80100d83:	c3                   	ret    
80100d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100d88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100d8f:	45 4c 46 
80100d92:	75 d2                	jne    80100d66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100d94:	e8 f7 62 00 00       	call   80107090 <setupkvm>
80100d99:	85 c0                	test   %eax,%eax
80100d9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100da1:	74 c3                	je     80100d66 <exec+0x56>
  sz = 0;
80100da3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100da5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100dac:	00 
80100dad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100db3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100db9:	0f 84 8c 02 00 00    	je     8010104b <exec+0x33b>
80100dbf:	31 f6                	xor    %esi,%esi
80100dc1:	eb 7f                	jmp    80100e42 <exec+0x132>
80100dc3:	90                   	nop
80100dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100dc8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100dcf:	75 63                	jne    80100e34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100dd1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100dd7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ddd:	0f 82 86 00 00 00    	jb     80100e69 <exec+0x159>
80100de3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100de9:	72 7e                	jb     80100e69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100deb:	83 ec 04             	sub    $0x4,%esp
80100dee:	50                   	push   %eax
80100def:	57                   	push   %edi
80100df0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100df6:	e8 b5 60 00 00       	call   80106eb0 <allocuvm>
80100dfb:	83 c4 10             	add    $0x10,%esp
80100dfe:	85 c0                	test   %eax,%eax
80100e00:	89 c7                	mov    %eax,%edi
80100e02:	74 65                	je     80100e69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100e04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100e0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100e0f:	75 58                	jne    80100e69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100e11:	83 ec 0c             	sub    $0xc,%esp
80100e14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100e1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100e20:	53                   	push   %ebx
80100e21:	50                   	push   %eax
80100e22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e28:	e8 c3 5f 00 00       	call   80106df0 <loaduvm>
80100e2d:	83 c4 20             	add    $0x20,%esp
80100e30:	85 c0                	test   %eax,%eax
80100e32:	78 35                	js     80100e69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100e3b:	83 c6 01             	add    $0x1,%esi
80100e3e:	39 f0                	cmp    %esi,%eax
80100e40:	7e 3d                	jle    80100e7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100e42:	89 f0                	mov    %esi,%eax
80100e44:	6a 20                	push   $0x20
80100e46:	c1 e0 05             	shl    $0x5,%eax
80100e49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100e4f:	50                   	push   %eax
80100e50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100e56:	50                   	push   %eax
80100e57:	53                   	push   %ebx
80100e58:	e8 13 0e 00 00       	call   80101c70 <readi>
80100e5d:	83 c4 10             	add    $0x10,%esp
80100e60:	83 f8 20             	cmp    $0x20,%eax
80100e63:	0f 84 5f ff ff ff    	je     80100dc8 <exec+0xb8>
    freevm(pgdir);
80100e69:	83 ec 0c             	sub    $0xc,%esp
80100e6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e72:	e8 99 61 00 00       	call   80107010 <freevm>
80100e77:	83 c4 10             	add    $0x10,%esp
80100e7a:	e9 e7 fe ff ff       	jmp    80100d66 <exec+0x56>
80100e7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100e85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100e8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100e91:	83 ec 0c             	sub    $0xc,%esp
80100e94:	53                   	push   %ebx
80100e95:	e8 86 0d 00 00       	call   80101c20 <iunlockput>
  end_op();
80100e9a:	e8 81 20 00 00       	call   80102f20 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100e9f:	83 c4 0c             	add    $0xc,%esp
80100ea2:	56                   	push   %esi
80100ea3:	57                   	push   %edi
80100ea4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100eaa:	e8 01 60 00 00       	call   80106eb0 <allocuvm>
80100eaf:	83 c4 10             	add    $0x10,%esp
80100eb2:	85 c0                	test   %eax,%eax
80100eb4:	89 c6                	mov    %eax,%esi
80100eb6:	75 3a                	jne    80100ef2 <exec+0x1e2>
    freevm(pgdir);
80100eb8:	83 ec 0c             	sub    $0xc,%esp
80100ebb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ec1:	e8 4a 61 00 00       	call   80107010 <freevm>
80100ec6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100ec9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ece:	e9 a9 fe ff ff       	jmp    80100d7c <exec+0x6c>
    end_op();
80100ed3:	e8 48 20 00 00       	call   80102f20 <end_op>
    cprintf("exec: fail\n");
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 c1 73 10 80       	push   $0x801073c1
80100ee0:	e8 7b f7 ff ff       	call   80100660 <cprintf>
    return -1;
80100ee5:	83 c4 10             	add    $0x10,%esp
80100ee8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100eed:	e9 8a fe ff ff       	jmp    80100d7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ef2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100ef8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100efb:	31 ff                	xor    %edi,%edi
80100efd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100eff:	50                   	push   %eax
80100f00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100f06:	e8 25 62 00 00       	call   80107130 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f0e:	83 c4 10             	add    $0x10,%esp
80100f11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100f17:	8b 00                	mov    (%eax),%eax
80100f19:	85 c0                	test   %eax,%eax
80100f1b:	74 70                	je     80100f8d <exec+0x27d>
80100f1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100f23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100f29:	eb 0a                	jmp    80100f35 <exec+0x225>
80100f2b:	90                   	nop
80100f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100f30:	83 ff 20             	cmp    $0x20,%edi
80100f33:	74 83                	je     80100eb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f35:	83 ec 0c             	sub    $0xc,%esp
80100f38:	50                   	push   %eax
80100f39:	e8 62 3b 00 00       	call   80104aa0 <strlen>
80100f3e:	f7 d0                	not    %eax
80100f40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f4c:	e8 4f 3b 00 00       	call   80104aa0 <strlen>
80100f51:	83 c0 01             	add    $0x1,%eax
80100f54:	50                   	push   %eax
80100f55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f5b:	53                   	push   %ebx
80100f5c:	56                   	push   %esi
80100f5d:	e8 2e 63 00 00       	call   80107290 <copyout>
80100f62:	83 c4 20             	add    $0x20,%esp
80100f65:	85 c0                	test   %eax,%eax
80100f67:	0f 88 4b ff ff ff    	js     80100eb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100f70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100f77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100f7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100f80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100f83:	85 c0                	test   %eax,%eax
80100f85:	75 a9                	jne    80100f30 <exec+0x220>
80100f87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100f94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100f96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100f9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100fa1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100fa8:	ff ff ff 
  ustack[1] = argc;
80100fab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100fb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100fb3:	83 c0 0c             	add    $0xc,%eax
80100fb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100fb8:	50                   	push   %eax
80100fb9:	52                   	push   %edx
80100fba:	53                   	push   %ebx
80100fbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100fc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100fc7:	e8 c4 62 00 00       	call   80107290 <copyout>
80100fcc:	83 c4 10             	add    $0x10,%esp
80100fcf:	85 c0                	test   %eax,%eax
80100fd1:	0f 88 e1 fe ff ff    	js     80100eb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100fd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100fda:	0f b6 00             	movzbl (%eax),%eax
80100fdd:	84 c0                	test   %al,%al
80100fdf:	74 17                	je     80100ff8 <exec+0x2e8>
80100fe1:	8b 55 08             	mov    0x8(%ebp),%edx
80100fe4:	89 d1                	mov    %edx,%ecx
80100fe6:	83 c1 01             	add    $0x1,%ecx
80100fe9:	3c 2f                	cmp    $0x2f,%al
80100feb:	0f b6 01             	movzbl (%ecx),%eax
80100fee:	0f 44 d1             	cmove  %ecx,%edx
80100ff1:	84 c0                	test   %al,%al
80100ff3:	75 f1                	jne    80100fe6 <exec+0x2d6>
80100ff5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ff8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100ffe:	50                   	push   %eax
80100fff:	6a 10                	push   $0x10
80101001:	ff 75 08             	pushl  0x8(%ebp)
80101004:	89 f8                	mov    %edi,%eax
80101006:	83 c0 6c             	add    $0x6c,%eax
80101009:	50                   	push   %eax
8010100a:	e8 51 3a 00 00       	call   80104a60 <safestrcpy>
  curproc->pgdir = pgdir;
8010100f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80101015:	89 f9                	mov    %edi,%ecx
80101017:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
8010101a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
8010101d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
8010101f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80101022:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101028:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
8010102b:	8b 41 18             	mov    0x18(%ecx),%eax
8010102e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101031:	89 0c 24             	mov    %ecx,(%esp)
80101034:	e8 27 5c 00 00       	call   80106c60 <switchuvm>
  freevm(oldpgdir);
80101039:	89 3c 24             	mov    %edi,(%esp)
8010103c:	e8 cf 5f 00 00       	call   80107010 <freevm>
  return 0;
80101041:	83 c4 10             	add    $0x10,%esp
80101044:	31 c0                	xor    %eax,%eax
80101046:	e9 31 fd ff ff       	jmp    80100d7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010104b:	be 00 20 00 00       	mov    $0x2000,%esi
80101050:	e9 3c fe ff ff       	jmp    80100e91 <exec+0x181>
80101055:	66 90                	xchg   %ax,%ax
80101057:	66 90                	xchg   %ax,%ax
80101059:	66 90                	xchg   %ax,%ax
8010105b:	66 90                	xchg   %ax,%ax
8010105d:	66 90                	xchg   %ax,%ax
8010105f:	90                   	nop

80101060 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101060:	55                   	push   %ebp
80101061:	89 e5                	mov    %esp,%ebp
80101063:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101066:	68 cd 73 10 80       	push   $0x801073cd
8010106b:	68 80 02 11 80       	push   $0x80110280
80101070:	e8 bb 35 00 00       	call   80104630 <initlock>
}
80101075:	83 c4 10             	add    $0x10,%esp
80101078:	c9                   	leave  
80101079:	c3                   	ret    
8010107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101080 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101084:	bb b4 02 11 80       	mov    $0x801102b4,%ebx
{
80101089:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010108c:	68 80 02 11 80       	push   $0x80110280
80101091:	e8 da 36 00 00       	call   80104770 <acquire>
80101096:	83 c4 10             	add    $0x10,%esp
80101099:	eb 10                	jmp    801010ab <filealloc+0x2b>
8010109b:	90                   	nop
8010109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010a0:	83 c3 18             	add    $0x18,%ebx
801010a3:	81 fb 14 0c 11 80    	cmp    $0x80110c14,%ebx
801010a9:	73 25                	jae    801010d0 <filealloc+0x50>
    if(f->ref == 0){
801010ab:	8b 43 04             	mov    0x4(%ebx),%eax
801010ae:	85 c0                	test   %eax,%eax
801010b0:	75 ee                	jne    801010a0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801010b2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801010b5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801010bc:	68 80 02 11 80       	push   $0x80110280
801010c1:	e8 6a 37 00 00       	call   80104830 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
801010c6:	89 d8                	mov    %ebx,%eax
      return f;
801010c8:	83 c4 10             	add    $0x10,%esp
}
801010cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010ce:	c9                   	leave  
801010cf:	c3                   	ret    
  release(&ftable.lock);
801010d0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801010d3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
801010d5:	68 80 02 11 80       	push   $0x80110280
801010da:	e8 51 37 00 00       	call   80104830 <release>
}
801010df:	89 d8                	mov    %ebx,%eax
  return 0;
801010e1:	83 c4 10             	add    $0x10,%esp
}
801010e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010e7:	c9                   	leave  
801010e8:	c3                   	ret    
801010e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801010f0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801010f0:	55                   	push   %ebp
801010f1:	89 e5                	mov    %esp,%ebp
801010f3:	53                   	push   %ebx
801010f4:	83 ec 10             	sub    $0x10,%esp
801010f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801010fa:	68 80 02 11 80       	push   $0x80110280
801010ff:	e8 6c 36 00 00       	call   80104770 <acquire>
  if(f->ref < 1)
80101104:	8b 43 04             	mov    0x4(%ebx),%eax
80101107:	83 c4 10             	add    $0x10,%esp
8010110a:	85 c0                	test   %eax,%eax
8010110c:	7e 1a                	jle    80101128 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010110e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101111:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101114:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101117:	68 80 02 11 80       	push   $0x80110280
8010111c:	e8 0f 37 00 00       	call   80104830 <release>
  return f;
}
80101121:	89 d8                	mov    %ebx,%eax
80101123:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101126:	c9                   	leave  
80101127:	c3                   	ret    
    panic("filedup");
80101128:	83 ec 0c             	sub    $0xc,%esp
8010112b:	68 d4 73 10 80       	push   $0x801073d4
80101130:	e8 5b f2 ff ff       	call   80100390 <panic>
80101135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101140 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	57                   	push   %edi
80101144:	56                   	push   %esi
80101145:	53                   	push   %ebx
80101146:	83 ec 28             	sub    $0x28,%esp
80101149:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010114c:	68 80 02 11 80       	push   $0x80110280
80101151:	e8 1a 36 00 00       	call   80104770 <acquire>
  if(f->ref < 1)
80101156:	8b 43 04             	mov    0x4(%ebx),%eax
80101159:	83 c4 10             	add    $0x10,%esp
8010115c:	85 c0                	test   %eax,%eax
8010115e:	0f 8e 9b 00 00 00    	jle    801011ff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101164:	83 e8 01             	sub    $0x1,%eax
80101167:	85 c0                	test   %eax,%eax
80101169:	89 43 04             	mov    %eax,0x4(%ebx)
8010116c:	74 1a                	je     80101188 <fileclose+0x48>
    release(&ftable.lock);
8010116e:	c7 45 08 80 02 11 80 	movl   $0x80110280,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101175:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101178:	5b                   	pop    %ebx
80101179:	5e                   	pop    %esi
8010117a:	5f                   	pop    %edi
8010117b:	5d                   	pop    %ebp
    release(&ftable.lock);
8010117c:	e9 af 36 00 00       	jmp    80104830 <release>
80101181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80101188:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
8010118c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
8010118e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101191:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80101194:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010119a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010119d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801011a0:	68 80 02 11 80       	push   $0x80110280
  ff = *f;
801011a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801011a8:	e8 83 36 00 00       	call   80104830 <release>
  if(ff.type == FD_PIPE)
801011ad:	83 c4 10             	add    $0x10,%esp
801011b0:	83 ff 01             	cmp    $0x1,%edi
801011b3:	74 13                	je     801011c8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
801011b5:	83 ff 02             	cmp    $0x2,%edi
801011b8:	74 26                	je     801011e0 <fileclose+0xa0>
}
801011ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011bd:	5b                   	pop    %ebx
801011be:	5e                   	pop    %esi
801011bf:	5f                   	pop    %edi
801011c0:	5d                   	pop    %ebp
801011c1:	c3                   	ret    
801011c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
801011c8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801011cc:	83 ec 08             	sub    $0x8,%esp
801011cf:	53                   	push   %ebx
801011d0:	56                   	push   %esi
801011d1:	e8 8a 24 00 00       	call   80103660 <pipeclose>
801011d6:	83 c4 10             	add    $0x10,%esp
801011d9:	eb df                	jmp    801011ba <fileclose+0x7a>
801011db:	90                   	nop
801011dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
801011e0:	e8 cb 1c 00 00       	call   80102eb0 <begin_op>
    iput(ff.ip);
801011e5:	83 ec 0c             	sub    $0xc,%esp
801011e8:	ff 75 e0             	pushl  -0x20(%ebp)
801011eb:	e8 d0 08 00 00       	call   80101ac0 <iput>
    end_op();
801011f0:	83 c4 10             	add    $0x10,%esp
}
801011f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011f6:	5b                   	pop    %ebx
801011f7:	5e                   	pop    %esi
801011f8:	5f                   	pop    %edi
801011f9:	5d                   	pop    %ebp
    end_op();
801011fa:	e9 21 1d 00 00       	jmp    80102f20 <end_op>
    panic("fileclose");
801011ff:	83 ec 0c             	sub    $0xc,%esp
80101202:	68 dc 73 10 80       	push   $0x801073dc
80101207:	e8 84 f1 ff ff       	call   80100390 <panic>
8010120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101210 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	53                   	push   %ebx
80101214:	83 ec 04             	sub    $0x4,%esp
80101217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010121a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010121d:	75 31                	jne    80101250 <filestat+0x40>
    ilock(f->ip);
8010121f:	83 ec 0c             	sub    $0xc,%esp
80101222:	ff 73 10             	pushl  0x10(%ebx)
80101225:	e8 66 07 00 00       	call   80101990 <ilock>
    stati(f->ip, st);
8010122a:	58                   	pop    %eax
8010122b:	5a                   	pop    %edx
8010122c:	ff 75 0c             	pushl  0xc(%ebp)
8010122f:	ff 73 10             	pushl  0x10(%ebx)
80101232:	e8 09 0a 00 00       	call   80101c40 <stati>
    iunlock(f->ip);
80101237:	59                   	pop    %ecx
80101238:	ff 73 10             	pushl  0x10(%ebx)
8010123b:	e8 30 08 00 00       	call   80101a70 <iunlock>
    return 0;
80101240:	83 c4 10             	add    $0x10,%esp
80101243:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101245:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101248:	c9                   	leave  
80101249:	c3                   	ret    
8010124a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101255:	eb ee                	jmp    80101245 <filestat+0x35>
80101257:	89 f6                	mov    %esi,%esi
80101259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101260 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	57                   	push   %edi
80101264:	56                   	push   %esi
80101265:	53                   	push   %ebx
80101266:	83 ec 0c             	sub    $0xc,%esp
80101269:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010126c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010126f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101272:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101276:	74 60                	je     801012d8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101278:	8b 03                	mov    (%ebx),%eax
8010127a:	83 f8 01             	cmp    $0x1,%eax
8010127d:	74 41                	je     801012c0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010127f:	83 f8 02             	cmp    $0x2,%eax
80101282:	75 5b                	jne    801012df <fileread+0x7f>
    ilock(f->ip);
80101284:	83 ec 0c             	sub    $0xc,%esp
80101287:	ff 73 10             	pushl  0x10(%ebx)
8010128a:	e8 01 07 00 00       	call   80101990 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010128f:	57                   	push   %edi
80101290:	ff 73 14             	pushl  0x14(%ebx)
80101293:	56                   	push   %esi
80101294:	ff 73 10             	pushl  0x10(%ebx)
80101297:	e8 d4 09 00 00       	call   80101c70 <readi>
8010129c:	83 c4 20             	add    $0x20,%esp
8010129f:	85 c0                	test   %eax,%eax
801012a1:	89 c6                	mov    %eax,%esi
801012a3:	7e 03                	jle    801012a8 <fileread+0x48>
      f->off += r;
801012a5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801012a8:	83 ec 0c             	sub    $0xc,%esp
801012ab:	ff 73 10             	pushl  0x10(%ebx)
801012ae:	e8 bd 07 00 00       	call   80101a70 <iunlock>
    return r;
801012b3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801012b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012b9:	89 f0                	mov    %esi,%eax
801012bb:	5b                   	pop    %ebx
801012bc:	5e                   	pop    %esi
801012bd:	5f                   	pop    %edi
801012be:	5d                   	pop    %ebp
801012bf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
801012c0:	8b 43 0c             	mov    0xc(%ebx),%eax
801012c3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012c9:	5b                   	pop    %ebx
801012ca:	5e                   	pop    %esi
801012cb:	5f                   	pop    %edi
801012cc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801012cd:	e9 3e 25 00 00       	jmp    80103810 <piperead>
801012d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801012d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801012dd:	eb d7                	jmp    801012b6 <fileread+0x56>
  panic("fileread");
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	68 e6 73 10 80       	push   $0x801073e6
801012e7:	e8 a4 f0 ff ff       	call   80100390 <panic>
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	83 ec 1c             	sub    $0x1c,%esp
801012f9:	8b 75 08             	mov    0x8(%ebp),%esi
801012fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801012ff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101303:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101306:	8b 45 10             	mov    0x10(%ebp),%eax
80101309:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010130c:	0f 84 aa 00 00 00    	je     801013bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101312:	8b 06                	mov    (%esi),%eax
80101314:	83 f8 01             	cmp    $0x1,%eax
80101317:	0f 84 c3 00 00 00    	je     801013e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010131d:	83 f8 02             	cmp    $0x2,%eax
80101320:	0f 85 d9 00 00 00    	jne    801013ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101326:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101329:	31 ff                	xor    %edi,%edi
    while(i < n){
8010132b:	85 c0                	test   %eax,%eax
8010132d:	7f 34                	jg     80101363 <filewrite+0x73>
8010132f:	e9 9c 00 00 00       	jmp    801013d0 <filewrite+0xe0>
80101334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101338:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010133b:	83 ec 0c             	sub    $0xc,%esp
8010133e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101341:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101344:	e8 27 07 00 00       	call   80101a70 <iunlock>
      end_op();
80101349:	e8 d2 1b 00 00       	call   80102f20 <end_op>
8010134e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101351:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101354:	39 c3                	cmp    %eax,%ebx
80101356:	0f 85 96 00 00 00    	jne    801013f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010135c:	01 df                	add    %ebx,%edi
    while(i < n){
8010135e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101361:	7e 6d                	jle    801013d0 <filewrite+0xe0>
      int n1 = n - i;
80101363:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101366:	b8 00 06 00 00       	mov    $0x600,%eax
8010136b:	29 fb                	sub    %edi,%ebx
8010136d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101373:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101376:	e8 35 1b 00 00       	call   80102eb0 <begin_op>
      ilock(f->ip);
8010137b:	83 ec 0c             	sub    $0xc,%esp
8010137e:	ff 76 10             	pushl  0x10(%esi)
80101381:	e8 0a 06 00 00       	call   80101990 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101386:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101389:	53                   	push   %ebx
8010138a:	ff 76 14             	pushl  0x14(%esi)
8010138d:	01 f8                	add    %edi,%eax
8010138f:	50                   	push   %eax
80101390:	ff 76 10             	pushl  0x10(%esi)
80101393:	e8 d8 09 00 00       	call   80101d70 <writei>
80101398:	83 c4 20             	add    $0x20,%esp
8010139b:	85 c0                	test   %eax,%eax
8010139d:	7f 99                	jg     80101338 <filewrite+0x48>
      iunlock(f->ip);
8010139f:	83 ec 0c             	sub    $0xc,%esp
801013a2:	ff 76 10             	pushl  0x10(%esi)
801013a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013a8:	e8 c3 06 00 00       	call   80101a70 <iunlock>
      end_op();
801013ad:	e8 6e 1b 00 00       	call   80102f20 <end_op>
      if(r < 0)
801013b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013b5:	83 c4 10             	add    $0x10,%esp
801013b8:	85 c0                	test   %eax,%eax
801013ba:	74 98                	je     80101354 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801013bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801013bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801013c4:	89 f8                	mov    %edi,%eax
801013c6:	5b                   	pop    %ebx
801013c7:	5e                   	pop    %esi
801013c8:	5f                   	pop    %edi
801013c9:	5d                   	pop    %ebp
801013ca:	c3                   	ret    
801013cb:	90                   	nop
801013cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801013d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801013d3:	75 e7                	jne    801013bc <filewrite+0xcc>
}
801013d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013d8:	89 f8                	mov    %edi,%eax
801013da:	5b                   	pop    %ebx
801013db:	5e                   	pop    %esi
801013dc:	5f                   	pop    %edi
801013dd:	5d                   	pop    %ebp
801013de:	c3                   	ret    
801013df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801013e0:	8b 46 0c             	mov    0xc(%esi),%eax
801013e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801013e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e9:	5b                   	pop    %ebx
801013ea:	5e                   	pop    %esi
801013eb:	5f                   	pop    %edi
801013ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801013ed:	e9 0e 23 00 00       	jmp    80103700 <pipewrite>
        panic("short filewrite");
801013f2:	83 ec 0c             	sub    $0xc,%esp
801013f5:	68 ef 73 10 80       	push   $0x801073ef
801013fa:	e8 91 ef ff ff       	call   80100390 <panic>
  panic("filewrite");
801013ff:	83 ec 0c             	sub    $0xc,%esp
80101402:	68 f5 73 10 80       	push   $0x801073f5
80101407:	e8 84 ef ff ff       	call   80100390 <panic>
8010140c:	66 90                	xchg   %ax,%ax
8010140e:	66 90                	xchg   %ax,%ax

80101410 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	57                   	push   %edi
80101414:	56                   	push   %esi
80101415:	53                   	push   %ebx
80101416:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101419:	8b 0d 80 0c 11 80    	mov    0x80110c80,%ecx
{
8010141f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101422:	85 c9                	test   %ecx,%ecx
80101424:	0f 84 87 00 00 00    	je     801014b1 <balloc+0xa1>
8010142a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101431:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101434:	83 ec 08             	sub    $0x8,%esp
80101437:	89 f0                	mov    %esi,%eax
80101439:	c1 f8 0c             	sar    $0xc,%eax
8010143c:	03 05 98 0c 11 80    	add    0x80110c98,%eax
80101442:	50                   	push   %eax
80101443:	ff 75 d8             	pushl  -0x28(%ebp)
80101446:	e8 85 ec ff ff       	call   801000d0 <bread>
8010144b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010144e:	a1 80 0c 11 80       	mov    0x80110c80,%eax
80101453:	83 c4 10             	add    $0x10,%esp
80101456:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101459:	31 c0                	xor    %eax,%eax
8010145b:	eb 2f                	jmp    8010148c <balloc+0x7c>
8010145d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101460:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101462:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101465:	bb 01 00 00 00       	mov    $0x1,%ebx
8010146a:	83 e1 07             	and    $0x7,%ecx
8010146d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010146f:	89 c1                	mov    %eax,%ecx
80101471:	c1 f9 03             	sar    $0x3,%ecx
80101474:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101479:	85 df                	test   %ebx,%edi
8010147b:	89 fa                	mov    %edi,%edx
8010147d:	74 41                	je     801014c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010147f:	83 c0 01             	add    $0x1,%eax
80101482:	83 c6 01             	add    $0x1,%esi
80101485:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010148a:	74 05                	je     80101491 <balloc+0x81>
8010148c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010148f:	77 cf                	ja     80101460 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101491:	83 ec 0c             	sub    $0xc,%esp
80101494:	ff 75 e4             	pushl  -0x1c(%ebp)
80101497:	e8 44 ed ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010149c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801014a3:	83 c4 10             	add    $0x10,%esp
801014a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014a9:	39 05 80 0c 11 80    	cmp    %eax,0x80110c80
801014af:	77 80                	ja     80101431 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801014b1:	83 ec 0c             	sub    $0xc,%esp
801014b4:	68 ff 73 10 80       	push   $0x801073ff
801014b9:	e8 d2 ee ff ff       	call   80100390 <panic>
801014be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801014c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801014c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801014c6:	09 da                	or     %ebx,%edx
801014c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801014cc:	57                   	push   %edi
801014cd:	e8 ae 1b 00 00       	call   80103080 <log_write>
        brelse(bp);
801014d2:	89 3c 24             	mov    %edi,(%esp)
801014d5:	e8 06 ed ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801014da:	58                   	pop    %eax
801014db:	5a                   	pop    %edx
801014dc:	56                   	push   %esi
801014dd:	ff 75 d8             	pushl  -0x28(%ebp)
801014e0:	e8 eb eb ff ff       	call   801000d0 <bread>
801014e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801014e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801014ea:	83 c4 0c             	add    $0xc,%esp
801014ed:	68 00 02 00 00       	push   $0x200
801014f2:	6a 00                	push   $0x0
801014f4:	50                   	push   %eax
801014f5:	e8 86 33 00 00       	call   80104880 <memset>
  log_write(bp);
801014fa:	89 1c 24             	mov    %ebx,(%esp)
801014fd:	e8 7e 1b 00 00       	call   80103080 <log_write>
  brelse(bp);
80101502:	89 1c 24             	mov    %ebx,(%esp)
80101505:	e8 d6 ec ff ff       	call   801001e0 <brelse>
}
8010150a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150d:	89 f0                	mov    %esi,%eax
8010150f:	5b                   	pop    %ebx
80101510:	5e                   	pop    %esi
80101511:	5f                   	pop    %edi
80101512:	5d                   	pop    %ebp
80101513:	c3                   	ret    
80101514:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010151a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101520 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101528:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010152a:	bb d4 0c 11 80       	mov    $0x80110cd4,%ebx
{
8010152f:	83 ec 28             	sub    $0x28,%esp
80101532:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101535:	68 a0 0c 11 80       	push   $0x80110ca0
8010153a:	e8 31 32 00 00       	call   80104770 <acquire>
8010153f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101542:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101545:	eb 17                	jmp    8010155e <iget+0x3e>
80101547:	89 f6                	mov    %esi,%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101550:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101556:	81 fb f4 28 11 80    	cmp    $0x801128f4,%ebx
8010155c:	73 22                	jae    80101580 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010155e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101561:	85 c9                	test   %ecx,%ecx
80101563:	7e 04                	jle    80101569 <iget+0x49>
80101565:	39 3b                	cmp    %edi,(%ebx)
80101567:	74 4f                	je     801015b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101569:	85 f6                	test   %esi,%esi
8010156b:	75 e3                	jne    80101550 <iget+0x30>
8010156d:	85 c9                	test   %ecx,%ecx
8010156f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101572:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101578:	81 fb f4 28 11 80    	cmp    $0x801128f4,%ebx
8010157e:	72 de                	jb     8010155e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101580:	85 f6                	test   %esi,%esi
80101582:	74 5b                	je     801015df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101584:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101587:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101589:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010158c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101593:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010159a:	68 a0 0c 11 80       	push   $0x80110ca0
8010159f:	e8 8c 32 00 00       	call   80104830 <release>

  return ip;
801015a4:	83 c4 10             	add    $0x10,%esp
}
801015a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015aa:	89 f0                	mov    %esi,%eax
801015ac:	5b                   	pop    %ebx
801015ad:	5e                   	pop    %esi
801015ae:	5f                   	pop    %edi
801015af:	5d                   	pop    %ebp
801015b0:	c3                   	ret    
801015b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801015b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801015bb:	75 ac                	jne    80101569 <iget+0x49>
      release(&icache.lock);
801015bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801015c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801015c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801015c5:	68 a0 0c 11 80       	push   $0x80110ca0
      ip->ref++;
801015ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801015cd:	e8 5e 32 00 00       	call   80104830 <release>
      return ip;
801015d2:	83 c4 10             	add    $0x10,%esp
}
801015d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015d8:	89 f0                	mov    %esi,%eax
801015da:	5b                   	pop    %ebx
801015db:	5e                   	pop    %esi
801015dc:	5f                   	pop    %edi
801015dd:	5d                   	pop    %ebp
801015de:	c3                   	ret    
    panic("iget: no inodes");
801015df:	83 ec 0c             	sub    $0xc,%esp
801015e2:	68 15 74 10 80       	push   $0x80107415
801015e7:	e8 a4 ed ff ff       	call   80100390 <panic>
801015ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	57                   	push   %edi
801015f4:	56                   	push   %esi
801015f5:	53                   	push   %ebx
801015f6:	89 c6                	mov    %eax,%esi
801015f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801015fb:	83 fa 0b             	cmp    $0xb,%edx
801015fe:	77 18                	ja     80101618 <bmap+0x28>
80101600:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101603:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101606:	85 db                	test   %ebx,%ebx
80101608:	74 76                	je     80101680 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010160a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010160d:	89 d8                	mov    %ebx,%eax
8010160f:	5b                   	pop    %ebx
80101610:	5e                   	pop    %esi
80101611:	5f                   	pop    %edi
80101612:	5d                   	pop    %ebp
80101613:	c3                   	ret    
80101614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101618:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010161b:	83 fb 7f             	cmp    $0x7f,%ebx
8010161e:	0f 87 90 00 00 00    	ja     801016b4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101624:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010162a:	8b 00                	mov    (%eax),%eax
8010162c:	85 d2                	test   %edx,%edx
8010162e:	74 70                	je     801016a0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101630:	83 ec 08             	sub    $0x8,%esp
80101633:	52                   	push   %edx
80101634:	50                   	push   %eax
80101635:	e8 96 ea ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010163a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010163e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101641:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101643:	8b 1a                	mov    (%edx),%ebx
80101645:	85 db                	test   %ebx,%ebx
80101647:	75 1d                	jne    80101666 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101649:	8b 06                	mov    (%esi),%eax
8010164b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010164e:	e8 bd fd ff ff       	call   80101410 <balloc>
80101653:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101656:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101659:	89 c3                	mov    %eax,%ebx
8010165b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010165d:	57                   	push   %edi
8010165e:	e8 1d 1a 00 00       	call   80103080 <log_write>
80101663:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101666:	83 ec 0c             	sub    $0xc,%esp
80101669:	57                   	push   %edi
8010166a:	e8 71 eb ff ff       	call   801001e0 <brelse>
8010166f:	83 c4 10             	add    $0x10,%esp
}
80101672:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101675:	89 d8                	mov    %ebx,%eax
80101677:	5b                   	pop    %ebx
80101678:	5e                   	pop    %esi
80101679:	5f                   	pop    %edi
8010167a:	5d                   	pop    %ebp
8010167b:	c3                   	ret    
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101680:	8b 00                	mov    (%eax),%eax
80101682:	e8 89 fd ff ff       	call   80101410 <balloc>
80101687:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010168a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010168d:	89 c3                	mov    %eax,%ebx
}
8010168f:	89 d8                	mov    %ebx,%eax
80101691:	5b                   	pop    %ebx
80101692:	5e                   	pop    %esi
80101693:	5f                   	pop    %edi
80101694:	5d                   	pop    %ebp
80101695:	c3                   	ret    
80101696:	8d 76 00             	lea    0x0(%esi),%esi
80101699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801016a0:	e8 6b fd ff ff       	call   80101410 <balloc>
801016a5:	89 c2                	mov    %eax,%edx
801016a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801016ad:	8b 06                	mov    (%esi),%eax
801016af:	e9 7c ff ff ff       	jmp    80101630 <bmap+0x40>
  panic("bmap: out of range");
801016b4:	83 ec 0c             	sub    $0xc,%esp
801016b7:	68 25 74 10 80       	push   $0x80107425
801016bc:	e8 cf ec ff ff       	call   80100390 <panic>
801016c1:	eb 0d                	jmp    801016d0 <readsb>
801016c3:	90                   	nop
801016c4:	90                   	nop
801016c5:	90                   	nop
801016c6:	90                   	nop
801016c7:	90                   	nop
801016c8:	90                   	nop
801016c9:	90                   	nop
801016ca:	90                   	nop
801016cb:	90                   	nop
801016cc:	90                   	nop
801016cd:	90                   	nop
801016ce:	90                   	nop
801016cf:	90                   	nop

801016d0 <readsb>:
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	56                   	push   %esi
801016d4:	53                   	push   %ebx
801016d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801016d8:	83 ec 08             	sub    $0x8,%esp
801016db:	6a 01                	push   $0x1
801016dd:	ff 75 08             	pushl  0x8(%ebp)
801016e0:	e8 eb e9 ff ff       	call   801000d0 <bread>
801016e5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801016ea:	83 c4 0c             	add    $0xc,%esp
801016ed:	6a 1c                	push   $0x1c
801016ef:	50                   	push   %eax
801016f0:	56                   	push   %esi
801016f1:	e8 3a 32 00 00       	call   80104930 <memmove>
  brelse(bp);
801016f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801016f9:	83 c4 10             	add    $0x10,%esp
}
801016fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016ff:	5b                   	pop    %ebx
80101700:	5e                   	pop    %esi
80101701:	5d                   	pop    %ebp
  brelse(bp);
80101702:	e9 d9 ea ff ff       	jmp    801001e0 <brelse>
80101707:	89 f6                	mov    %esi,%esi
80101709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101710 <bfree>:
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	56                   	push   %esi
80101714:	53                   	push   %ebx
80101715:	89 d3                	mov    %edx,%ebx
80101717:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101719:	83 ec 08             	sub    $0x8,%esp
8010171c:	68 80 0c 11 80       	push   $0x80110c80
80101721:	50                   	push   %eax
80101722:	e8 a9 ff ff ff       	call   801016d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101727:	58                   	pop    %eax
80101728:	5a                   	pop    %edx
80101729:	89 da                	mov    %ebx,%edx
8010172b:	c1 ea 0c             	shr    $0xc,%edx
8010172e:	03 15 98 0c 11 80    	add    0x80110c98,%edx
80101734:	52                   	push   %edx
80101735:	56                   	push   %esi
80101736:	e8 95 e9 ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010173b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010173d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101740:	ba 01 00 00 00       	mov    $0x1,%edx
80101745:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101748:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010174e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101751:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101753:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101758:	85 d1                	test   %edx,%ecx
8010175a:	74 25                	je     80101781 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010175c:	f7 d2                	not    %edx
8010175e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101760:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101763:	21 ca                	and    %ecx,%edx
80101765:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101769:	56                   	push   %esi
8010176a:	e8 11 19 00 00       	call   80103080 <log_write>
  brelse(bp);
8010176f:	89 34 24             	mov    %esi,(%esp)
80101772:	e8 69 ea ff ff       	call   801001e0 <brelse>
}
80101777:	83 c4 10             	add    $0x10,%esp
8010177a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010177d:	5b                   	pop    %ebx
8010177e:	5e                   	pop    %esi
8010177f:	5d                   	pop    %ebp
80101780:	c3                   	ret    
    panic("freeing free block");
80101781:	83 ec 0c             	sub    $0xc,%esp
80101784:	68 38 74 10 80       	push   $0x80107438
80101789:	e8 02 ec ff ff       	call   80100390 <panic>
8010178e:	66 90                	xchg   %ax,%ax

80101790 <iinit>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	53                   	push   %ebx
80101794:	bb e0 0c 11 80       	mov    $0x80110ce0,%ebx
80101799:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010179c:	68 4b 74 10 80       	push   $0x8010744b
801017a1:	68 a0 0c 11 80       	push   $0x80110ca0
801017a6:	e8 85 2e 00 00       	call   80104630 <initlock>
801017ab:	83 c4 10             	add    $0x10,%esp
801017ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801017b0:	83 ec 08             	sub    $0x8,%esp
801017b3:	68 52 74 10 80       	push   $0x80107452
801017b8:	53                   	push   %ebx
801017b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801017bf:	e8 3c 2d 00 00       	call   80104500 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801017c4:	83 c4 10             	add    $0x10,%esp
801017c7:	81 fb 00 29 11 80    	cmp    $0x80112900,%ebx
801017cd:	75 e1                	jne    801017b0 <iinit+0x20>
  readsb(dev, &sb);
801017cf:	83 ec 08             	sub    $0x8,%esp
801017d2:	68 80 0c 11 80       	push   $0x80110c80
801017d7:	ff 75 08             	pushl  0x8(%ebp)
801017da:	e8 f1 fe ff ff       	call   801016d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801017df:	ff 35 98 0c 11 80    	pushl  0x80110c98
801017e5:	ff 35 94 0c 11 80    	pushl  0x80110c94
801017eb:	ff 35 90 0c 11 80    	pushl  0x80110c90
801017f1:	ff 35 8c 0c 11 80    	pushl  0x80110c8c
801017f7:	ff 35 88 0c 11 80    	pushl  0x80110c88
801017fd:	ff 35 84 0c 11 80    	pushl  0x80110c84
80101803:	ff 35 80 0c 11 80    	pushl  0x80110c80
80101809:	68 b8 74 10 80       	push   $0x801074b8
8010180e:	e8 4d ee ff ff       	call   80100660 <cprintf>
}
80101813:	83 c4 30             	add    $0x30,%esp
80101816:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101819:	c9                   	leave  
8010181a:	c3                   	ret    
8010181b:	90                   	nop
8010181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101820 <ialloc>:
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	57                   	push   %edi
80101824:	56                   	push   %esi
80101825:	53                   	push   %ebx
80101826:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101829:	83 3d 88 0c 11 80 01 	cmpl   $0x1,0x80110c88
{
80101830:	8b 45 0c             	mov    0xc(%ebp),%eax
80101833:	8b 75 08             	mov    0x8(%ebp),%esi
80101836:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101839:	0f 86 91 00 00 00    	jbe    801018d0 <ialloc+0xb0>
8010183f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101844:	eb 21                	jmp    80101867 <ialloc+0x47>
80101846:	8d 76 00             	lea    0x0(%esi),%esi
80101849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101850:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101853:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101856:	57                   	push   %edi
80101857:	e8 84 e9 ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010185c:	83 c4 10             	add    $0x10,%esp
8010185f:	39 1d 88 0c 11 80    	cmp    %ebx,0x80110c88
80101865:	76 69                	jbe    801018d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101867:	89 d8                	mov    %ebx,%eax
80101869:	83 ec 08             	sub    $0x8,%esp
8010186c:	c1 e8 03             	shr    $0x3,%eax
8010186f:	03 05 94 0c 11 80    	add    0x80110c94,%eax
80101875:	50                   	push   %eax
80101876:	56                   	push   %esi
80101877:	e8 54 e8 ff ff       	call   801000d0 <bread>
8010187c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010187e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101880:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101883:	83 e0 07             	and    $0x7,%eax
80101886:	c1 e0 06             	shl    $0x6,%eax
80101889:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010188d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101891:	75 bd                	jne    80101850 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101893:	83 ec 04             	sub    $0x4,%esp
80101896:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101899:	6a 40                	push   $0x40
8010189b:	6a 00                	push   $0x0
8010189d:	51                   	push   %ecx
8010189e:	e8 dd 2f 00 00       	call   80104880 <memset>
      dip->type = type;
801018a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801018a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801018aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801018ad:	89 3c 24             	mov    %edi,(%esp)
801018b0:	e8 cb 17 00 00       	call   80103080 <log_write>
      brelse(bp);
801018b5:	89 3c 24             	mov    %edi,(%esp)
801018b8:	e8 23 e9 ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801018bd:	83 c4 10             	add    $0x10,%esp
}
801018c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801018c3:	89 da                	mov    %ebx,%edx
801018c5:	89 f0                	mov    %esi,%eax
}
801018c7:	5b                   	pop    %ebx
801018c8:	5e                   	pop    %esi
801018c9:	5f                   	pop    %edi
801018ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801018cb:	e9 50 fc ff ff       	jmp    80101520 <iget>
  panic("ialloc: no inodes");
801018d0:	83 ec 0c             	sub    $0xc,%esp
801018d3:	68 58 74 10 80       	push   $0x80107458
801018d8:	e8 b3 ea ff ff       	call   80100390 <panic>
801018dd:	8d 76 00             	lea    0x0(%esi),%esi

801018e0 <iupdate>:
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	56                   	push   %esi
801018e4:	53                   	push   %ebx
801018e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018e8:	83 ec 08             	sub    $0x8,%esp
801018eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018f1:	c1 e8 03             	shr    $0x3,%eax
801018f4:	03 05 94 0c 11 80    	add    0x80110c94,%eax
801018fa:	50                   	push   %eax
801018fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801018fe:	e8 cd e7 ff ff       	call   801000d0 <bread>
80101903:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101905:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101908:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010190c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010190f:	83 e0 07             	and    $0x7,%eax
80101912:	c1 e0 06             	shl    $0x6,%eax
80101915:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101919:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010191c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101920:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101923:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101927:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010192b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010192f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101933:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101937:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010193a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010193d:	6a 34                	push   $0x34
8010193f:	53                   	push   %ebx
80101940:	50                   	push   %eax
80101941:	e8 ea 2f 00 00       	call   80104930 <memmove>
  log_write(bp);
80101946:	89 34 24             	mov    %esi,(%esp)
80101949:	e8 32 17 00 00       	call   80103080 <log_write>
  brelse(bp);
8010194e:	89 75 08             	mov    %esi,0x8(%ebp)
80101951:	83 c4 10             	add    $0x10,%esp
}
80101954:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101957:	5b                   	pop    %ebx
80101958:	5e                   	pop    %esi
80101959:	5d                   	pop    %ebp
  brelse(bp);
8010195a:	e9 81 e8 ff ff       	jmp    801001e0 <brelse>
8010195f:	90                   	nop

80101960 <idup>:
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	53                   	push   %ebx
80101964:	83 ec 10             	sub    $0x10,%esp
80101967:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010196a:	68 a0 0c 11 80       	push   $0x80110ca0
8010196f:	e8 fc 2d 00 00       	call   80104770 <acquire>
  ip->ref++;
80101974:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101978:	c7 04 24 a0 0c 11 80 	movl   $0x80110ca0,(%esp)
8010197f:	e8 ac 2e 00 00       	call   80104830 <release>
}
80101984:	89 d8                	mov    %ebx,%eax
80101986:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101989:	c9                   	leave  
8010198a:	c3                   	ret    
8010198b:	90                   	nop
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <ilock>:
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	56                   	push   %esi
80101994:	53                   	push   %ebx
80101995:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101998:	85 db                	test   %ebx,%ebx
8010199a:	0f 84 b7 00 00 00    	je     80101a57 <ilock+0xc7>
801019a0:	8b 53 08             	mov    0x8(%ebx),%edx
801019a3:	85 d2                	test   %edx,%edx
801019a5:	0f 8e ac 00 00 00    	jle    80101a57 <ilock+0xc7>
  acquiresleep(&ip->lock);
801019ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801019ae:	83 ec 0c             	sub    $0xc,%esp
801019b1:	50                   	push   %eax
801019b2:	e8 89 2b 00 00       	call   80104540 <acquiresleep>
  if(ip->valid == 0){
801019b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801019ba:	83 c4 10             	add    $0x10,%esp
801019bd:	85 c0                	test   %eax,%eax
801019bf:	74 0f                	je     801019d0 <ilock+0x40>
}
801019c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019c4:	5b                   	pop    %ebx
801019c5:	5e                   	pop    %esi
801019c6:	5d                   	pop    %ebp
801019c7:	c3                   	ret    
801019c8:	90                   	nop
801019c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019d0:	8b 43 04             	mov    0x4(%ebx),%eax
801019d3:	83 ec 08             	sub    $0x8,%esp
801019d6:	c1 e8 03             	shr    $0x3,%eax
801019d9:	03 05 94 0c 11 80    	add    0x80110c94,%eax
801019df:	50                   	push   %eax
801019e0:	ff 33                	pushl  (%ebx)
801019e2:	e8 e9 e6 ff ff       	call   801000d0 <bread>
801019e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019ef:	83 e0 07             	and    $0x7,%eax
801019f2:	c1 e0 06             	shl    $0x6,%eax
801019f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801019f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801019ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101a03:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101a07:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101a0b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101a0f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a13:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a17:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a1b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a1e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a21:	6a 34                	push   $0x34
80101a23:	50                   	push   %eax
80101a24:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101a27:	50                   	push   %eax
80101a28:	e8 03 2f 00 00       	call   80104930 <memmove>
    brelse(bp);
80101a2d:	89 34 24             	mov    %esi,(%esp)
80101a30:	e8 ab e7 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101a35:	83 c4 10             	add    $0x10,%esp
80101a38:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101a3d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101a44:	0f 85 77 ff ff ff    	jne    801019c1 <ilock+0x31>
      panic("ilock: no type");
80101a4a:	83 ec 0c             	sub    $0xc,%esp
80101a4d:	68 70 74 10 80       	push   $0x80107470
80101a52:	e8 39 e9 ff ff       	call   80100390 <panic>
    panic("ilock");
80101a57:	83 ec 0c             	sub    $0xc,%esp
80101a5a:	68 6a 74 10 80       	push   $0x8010746a
80101a5f:	e8 2c e9 ff ff       	call   80100390 <panic>
80101a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101a70 <iunlock>:
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	56                   	push   %esi
80101a74:	53                   	push   %ebx
80101a75:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a78:	85 db                	test   %ebx,%ebx
80101a7a:	74 28                	je     80101aa4 <iunlock+0x34>
80101a7c:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a7f:	83 ec 0c             	sub    $0xc,%esp
80101a82:	56                   	push   %esi
80101a83:	e8 58 2b 00 00       	call   801045e0 <holdingsleep>
80101a88:	83 c4 10             	add    $0x10,%esp
80101a8b:	85 c0                	test   %eax,%eax
80101a8d:	74 15                	je     80101aa4 <iunlock+0x34>
80101a8f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a92:	85 c0                	test   %eax,%eax
80101a94:	7e 0e                	jle    80101aa4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101a96:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101a99:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a9c:	5b                   	pop    %ebx
80101a9d:	5e                   	pop    %esi
80101a9e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101a9f:	e9 fc 2a 00 00       	jmp    801045a0 <releasesleep>
    panic("iunlock");
80101aa4:	83 ec 0c             	sub    $0xc,%esp
80101aa7:	68 7f 74 10 80       	push   $0x8010747f
80101aac:	e8 df e8 ff ff       	call   80100390 <panic>
80101ab1:	eb 0d                	jmp    80101ac0 <iput>
80101ab3:	90                   	nop
80101ab4:	90                   	nop
80101ab5:	90                   	nop
80101ab6:	90                   	nop
80101ab7:	90                   	nop
80101ab8:	90                   	nop
80101ab9:	90                   	nop
80101aba:	90                   	nop
80101abb:	90                   	nop
80101abc:	90                   	nop
80101abd:	90                   	nop
80101abe:	90                   	nop
80101abf:	90                   	nop

80101ac0 <iput>:
{
80101ac0:	55                   	push   %ebp
80101ac1:	89 e5                	mov    %esp,%ebp
80101ac3:	57                   	push   %edi
80101ac4:	56                   	push   %esi
80101ac5:	53                   	push   %ebx
80101ac6:	83 ec 28             	sub    $0x28,%esp
80101ac9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101acc:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101acf:	57                   	push   %edi
80101ad0:	e8 6b 2a 00 00       	call   80104540 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101ad5:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101ad8:	83 c4 10             	add    $0x10,%esp
80101adb:	85 d2                	test   %edx,%edx
80101add:	74 07                	je     80101ae6 <iput+0x26>
80101adf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101ae4:	74 32                	je     80101b18 <iput+0x58>
  releasesleep(&ip->lock);
80101ae6:	83 ec 0c             	sub    $0xc,%esp
80101ae9:	57                   	push   %edi
80101aea:	e8 b1 2a 00 00       	call   801045a0 <releasesleep>
  acquire(&icache.lock);
80101aef:	c7 04 24 a0 0c 11 80 	movl   $0x80110ca0,(%esp)
80101af6:	e8 75 2c 00 00       	call   80104770 <acquire>
  ip->ref--;
80101afb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101aff:	83 c4 10             	add    $0x10,%esp
80101b02:	c7 45 08 a0 0c 11 80 	movl   $0x80110ca0,0x8(%ebp)
}
80101b09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b0c:	5b                   	pop    %ebx
80101b0d:	5e                   	pop    %esi
80101b0e:	5f                   	pop    %edi
80101b0f:	5d                   	pop    %ebp
  release(&icache.lock);
80101b10:	e9 1b 2d 00 00       	jmp    80104830 <release>
80101b15:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101b18:	83 ec 0c             	sub    $0xc,%esp
80101b1b:	68 a0 0c 11 80       	push   $0x80110ca0
80101b20:	e8 4b 2c 00 00       	call   80104770 <acquire>
    int r = ip->ref;
80101b25:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101b28:	c7 04 24 a0 0c 11 80 	movl   $0x80110ca0,(%esp)
80101b2f:	e8 fc 2c 00 00       	call   80104830 <release>
    if(r == 1){
80101b34:	83 c4 10             	add    $0x10,%esp
80101b37:	83 fe 01             	cmp    $0x1,%esi
80101b3a:	75 aa                	jne    80101ae6 <iput+0x26>
80101b3c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101b42:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101b45:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101b48:	89 cf                	mov    %ecx,%edi
80101b4a:	eb 0b                	jmp    80101b57 <iput+0x97>
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b50:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101b53:	39 fe                	cmp    %edi,%esi
80101b55:	74 19                	je     80101b70 <iput+0xb0>
    if(ip->addrs[i]){
80101b57:	8b 16                	mov    (%esi),%edx
80101b59:	85 d2                	test   %edx,%edx
80101b5b:	74 f3                	je     80101b50 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101b5d:	8b 03                	mov    (%ebx),%eax
80101b5f:	e8 ac fb ff ff       	call   80101710 <bfree>
      ip->addrs[i] = 0;
80101b64:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101b6a:	eb e4                	jmp    80101b50 <iput+0x90>
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101b70:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101b76:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b79:	85 c0                	test   %eax,%eax
80101b7b:	75 33                	jne    80101bb0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101b7d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101b80:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101b87:	53                   	push   %ebx
80101b88:	e8 53 fd ff ff       	call   801018e0 <iupdate>
      ip->type = 0;
80101b8d:	31 c0                	xor    %eax,%eax
80101b8f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101b93:	89 1c 24             	mov    %ebx,(%esp)
80101b96:	e8 45 fd ff ff       	call   801018e0 <iupdate>
      ip->valid = 0;
80101b9b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101ba2:	83 c4 10             	add    $0x10,%esp
80101ba5:	e9 3c ff ff ff       	jmp    80101ae6 <iput+0x26>
80101baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101bb0:	83 ec 08             	sub    $0x8,%esp
80101bb3:	50                   	push   %eax
80101bb4:	ff 33                	pushl  (%ebx)
80101bb6:	e8 15 e5 ff ff       	call   801000d0 <bread>
80101bbb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101bc1:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101bc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101bc7:	8d 70 5c             	lea    0x5c(%eax),%esi
80101bca:	83 c4 10             	add    $0x10,%esp
80101bcd:	89 cf                	mov    %ecx,%edi
80101bcf:	eb 0e                	jmp    80101bdf <iput+0x11f>
80101bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bd8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101bdb:	39 fe                	cmp    %edi,%esi
80101bdd:	74 0f                	je     80101bee <iput+0x12e>
      if(a[j])
80101bdf:	8b 16                	mov    (%esi),%edx
80101be1:	85 d2                	test   %edx,%edx
80101be3:	74 f3                	je     80101bd8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101be5:	8b 03                	mov    (%ebx),%eax
80101be7:	e8 24 fb ff ff       	call   80101710 <bfree>
80101bec:	eb ea                	jmp    80101bd8 <iput+0x118>
    brelse(bp);
80101bee:	83 ec 0c             	sub    $0xc,%esp
80101bf1:	ff 75 e4             	pushl  -0x1c(%ebp)
80101bf4:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bf7:	e8 e4 e5 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101bfc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101c02:	8b 03                	mov    (%ebx),%eax
80101c04:	e8 07 fb ff ff       	call   80101710 <bfree>
    ip->addrs[NDIRECT] = 0;
80101c09:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101c10:	00 00 00 
80101c13:	83 c4 10             	add    $0x10,%esp
80101c16:	e9 62 ff ff ff       	jmp    80101b7d <iput+0xbd>
80101c1b:	90                   	nop
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c20 <iunlockput>:
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	53                   	push   %ebx
80101c24:	83 ec 10             	sub    $0x10,%esp
80101c27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101c2a:	53                   	push   %ebx
80101c2b:	e8 40 fe ff ff       	call   80101a70 <iunlock>
  iput(ip);
80101c30:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101c33:	83 c4 10             	add    $0x10,%esp
}
80101c36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c39:	c9                   	leave  
  iput(ip);
80101c3a:	e9 81 fe ff ff       	jmp    80101ac0 <iput>
80101c3f:	90                   	nop

80101c40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	8b 55 08             	mov    0x8(%ebp),%edx
80101c46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101c49:	8b 0a                	mov    (%edx),%ecx
80101c4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101c4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101c51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101c54:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101c58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101c5b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101c5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101c63:	8b 52 58             	mov    0x58(%edx),%edx
80101c66:	89 50 10             	mov    %edx,0x10(%eax)
}
80101c69:	5d                   	pop    %ebp
80101c6a:	c3                   	ret    
80101c6b:	90                   	nop
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 1c             	sub    $0x1c,%esp
80101c79:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c87:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101c90:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101c93:	0f 84 a7 00 00 00    	je     80101d40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101c99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c9c:	8b 40 58             	mov    0x58(%eax),%eax
80101c9f:	39 c6                	cmp    %eax,%esi
80101ca1:	0f 87 ba 00 00 00    	ja     80101d61 <readi+0xf1>
80101ca7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101caa:	89 f9                	mov    %edi,%ecx
80101cac:	01 f1                	add    %esi,%ecx
80101cae:	0f 82 ad 00 00 00    	jb     80101d61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101cb4:	89 c2                	mov    %eax,%edx
80101cb6:	29 f2                	sub    %esi,%edx
80101cb8:	39 c8                	cmp    %ecx,%eax
80101cba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101cbd:	31 ff                	xor    %edi,%edi
80101cbf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101cc1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101cc4:	74 6c                	je     80101d32 <readi+0xc2>
80101cc6:	8d 76 00             	lea    0x0(%esi),%esi
80101cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cd0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101cd3:	89 f2                	mov    %esi,%edx
80101cd5:	c1 ea 09             	shr    $0x9,%edx
80101cd8:	89 d8                	mov    %ebx,%eax
80101cda:	e8 11 f9 ff ff       	call   801015f0 <bmap>
80101cdf:	83 ec 08             	sub    $0x8,%esp
80101ce2:	50                   	push   %eax
80101ce3:	ff 33                	pushl  (%ebx)
80101ce5:	e8 e6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ced:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101cef:	89 f0                	mov    %esi,%eax
80101cf1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101cf6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101cfb:	83 c4 0c             	add    $0xc,%esp
80101cfe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101d00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101d04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101d07:	29 fb                	sub    %edi,%ebx
80101d09:	39 d9                	cmp    %ebx,%ecx
80101d0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101d0e:	53                   	push   %ebx
80101d0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101d12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101d17:	e8 14 2c 00 00       	call   80104930 <memmove>
    brelse(bp);
80101d1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d1f:	89 14 24             	mov    %edx,(%esp)
80101d22:	e8 b9 e4 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d2a:	83 c4 10             	add    $0x10,%esp
80101d2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101d30:	77 9e                	ja     80101cd0 <readi+0x60>
  }
  return n;
80101d32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101d35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d38:	5b                   	pop    %ebx
80101d39:	5e                   	pop    %esi
80101d3a:	5f                   	pop    %edi
80101d3b:	5d                   	pop    %ebp
80101d3c:	c3                   	ret    
80101d3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d44:	66 83 f8 09          	cmp    $0x9,%ax
80101d48:	77 17                	ja     80101d61 <readi+0xf1>
80101d4a:	8b 04 c5 20 0c 11 80 	mov    -0x7feef3e0(,%eax,8),%eax
80101d51:	85 c0                	test   %eax,%eax
80101d53:	74 0c                	je     80101d61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101d55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101d58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d5b:	5b                   	pop    %ebx
80101d5c:	5e                   	pop    %esi
80101d5d:	5f                   	pop    %edi
80101d5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101d5f:	ff e0                	jmp    *%eax
      return -1;
80101d61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d66:	eb cd                	jmp    80101d35 <readi+0xc5>
80101d68:	90                   	nop
80101d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	57                   	push   %edi
80101d74:	56                   	push   %esi
80101d75:	53                   	push   %ebx
80101d76:	83 ec 1c             	sub    $0x1c,%esp
80101d79:	8b 45 08             	mov    0x8(%ebp),%eax
80101d7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101d87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101d8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101d8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101d90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101d93:	0f 84 b7 00 00 00    	je     80101e50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101d99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101d9f:	0f 82 eb 00 00 00    	jb     80101e90 <writei+0x120>
80101da5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101da8:	31 d2                	xor    %edx,%edx
80101daa:	89 f8                	mov    %edi,%eax
80101dac:	01 f0                	add    %esi,%eax
80101dae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101db1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101db6:	0f 87 d4 00 00 00    	ja     80101e90 <writei+0x120>
80101dbc:	85 d2                	test   %edx,%edx
80101dbe:	0f 85 cc 00 00 00    	jne    80101e90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101dc4:	85 ff                	test   %edi,%edi
80101dc6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101dcd:	74 72                	je     80101e41 <writei+0xd1>
80101dcf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101dd0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101dd3:	89 f2                	mov    %esi,%edx
80101dd5:	c1 ea 09             	shr    $0x9,%edx
80101dd8:	89 f8                	mov    %edi,%eax
80101dda:	e8 11 f8 ff ff       	call   801015f0 <bmap>
80101ddf:	83 ec 08             	sub    $0x8,%esp
80101de2:	50                   	push   %eax
80101de3:	ff 37                	pushl  (%edi)
80101de5:	e8 e6 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101dea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101ded:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101df0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101df2:	89 f0                	mov    %esi,%eax
80101df4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101df9:	83 c4 0c             	add    $0xc,%esp
80101dfc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101e03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101e07:	39 d9                	cmp    %ebx,%ecx
80101e09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101e0c:	53                   	push   %ebx
80101e0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101e12:	50                   	push   %eax
80101e13:	e8 18 2b 00 00       	call   80104930 <memmove>
    log_write(bp);
80101e18:	89 3c 24             	mov    %edi,(%esp)
80101e1b:	e8 60 12 00 00       	call   80103080 <log_write>
    brelse(bp);
80101e20:	89 3c 24             	mov    %edi,(%esp)
80101e23:	e8 b8 e3 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101e2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101e2e:	83 c4 10             	add    $0x10,%esp
80101e31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101e37:	77 97                	ja     80101dd0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101e39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101e3f:	77 37                	ja     80101e78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101e41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101e44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e47:	5b                   	pop    %ebx
80101e48:	5e                   	pop    %esi
80101e49:	5f                   	pop    %edi
80101e4a:	5d                   	pop    %ebp
80101e4b:	c3                   	ret    
80101e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101e50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101e54:	66 83 f8 09          	cmp    $0x9,%ax
80101e58:	77 36                	ja     80101e90 <writei+0x120>
80101e5a:	8b 04 c5 24 0c 11 80 	mov    -0x7feef3dc(,%eax,8),%eax
80101e61:	85 c0                	test   %eax,%eax
80101e63:	74 2b                	je     80101e90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101e65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101e68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e6b:	5b                   	pop    %ebx
80101e6c:	5e                   	pop    %esi
80101e6d:	5f                   	pop    %edi
80101e6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101e6f:	ff e0                	jmp    *%eax
80101e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101e78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101e7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101e7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101e81:	50                   	push   %eax
80101e82:	e8 59 fa ff ff       	call   801018e0 <iupdate>
80101e87:	83 c4 10             	add    $0x10,%esp
80101e8a:	eb b5                	jmp    80101e41 <writei+0xd1>
80101e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e95:	eb ad                	jmp    80101e44 <writei+0xd4>
80101e97:	89 f6                	mov    %esi,%esi
80101e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ea0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ea0:	55                   	push   %ebp
80101ea1:	89 e5                	mov    %esp,%ebp
80101ea3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ea6:	6a 0e                	push   $0xe
80101ea8:	ff 75 0c             	pushl  0xc(%ebp)
80101eab:	ff 75 08             	pushl  0x8(%ebp)
80101eae:	e8 ed 2a 00 00       	call   801049a0 <strncmp>
}
80101eb3:	c9                   	leave  
80101eb4:	c3                   	ret    
80101eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
80101ec4:	56                   	push   %esi
80101ec5:	53                   	push   %ebx
80101ec6:	83 ec 1c             	sub    $0x1c,%esp
80101ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101ecc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ed1:	0f 85 85 00 00 00    	jne    80101f5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ed7:	8b 53 58             	mov    0x58(%ebx),%edx
80101eda:	31 ff                	xor    %edi,%edi
80101edc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101edf:	85 d2                	test   %edx,%edx
80101ee1:	74 3e                	je     80101f21 <dirlookup+0x61>
80101ee3:	90                   	nop
80101ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ee8:	6a 10                	push   $0x10
80101eea:	57                   	push   %edi
80101eeb:	56                   	push   %esi
80101eec:	53                   	push   %ebx
80101eed:	e8 7e fd ff ff       	call   80101c70 <readi>
80101ef2:	83 c4 10             	add    $0x10,%esp
80101ef5:	83 f8 10             	cmp    $0x10,%eax
80101ef8:	75 55                	jne    80101f4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101efa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101eff:	74 18                	je     80101f19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101f01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f04:	83 ec 04             	sub    $0x4,%esp
80101f07:	6a 0e                	push   $0xe
80101f09:	50                   	push   %eax
80101f0a:	ff 75 0c             	pushl  0xc(%ebp)
80101f0d:	e8 8e 2a 00 00       	call   801049a0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101f12:	83 c4 10             	add    $0x10,%esp
80101f15:	85 c0                	test   %eax,%eax
80101f17:	74 17                	je     80101f30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f19:	83 c7 10             	add    $0x10,%edi
80101f1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f1f:	72 c7                	jb     80101ee8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101f21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101f24:	31 c0                	xor    %eax,%eax
}
80101f26:	5b                   	pop    %ebx
80101f27:	5e                   	pop    %esi
80101f28:	5f                   	pop    %edi
80101f29:	5d                   	pop    %ebp
80101f2a:	c3                   	ret    
80101f2b:	90                   	nop
80101f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101f30:	8b 45 10             	mov    0x10(%ebp),%eax
80101f33:	85 c0                	test   %eax,%eax
80101f35:	74 05                	je     80101f3c <dirlookup+0x7c>
        *poff = off;
80101f37:	8b 45 10             	mov    0x10(%ebp),%eax
80101f3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101f3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101f40:	8b 03                	mov    (%ebx),%eax
80101f42:	e8 d9 f5 ff ff       	call   80101520 <iget>
}
80101f47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f4a:	5b                   	pop    %ebx
80101f4b:	5e                   	pop    %esi
80101f4c:	5f                   	pop    %edi
80101f4d:	5d                   	pop    %ebp
80101f4e:	c3                   	ret    
      panic("dirlookup read");
80101f4f:	83 ec 0c             	sub    $0xc,%esp
80101f52:	68 99 74 10 80       	push   $0x80107499
80101f57:	e8 34 e4 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101f5c:	83 ec 0c             	sub    $0xc,%esp
80101f5f:	68 87 74 10 80       	push   $0x80107487
80101f64:	e8 27 e4 ff ff       	call   80100390 <panic>
80101f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101f70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	57                   	push   %edi
80101f74:	56                   	push   %esi
80101f75:	53                   	push   %ebx
80101f76:	89 cf                	mov    %ecx,%edi
80101f78:	89 c3                	mov    %eax,%ebx
80101f7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101f7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101f80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101f83:	0f 84 67 01 00 00    	je     801020f0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f89:	e8 62 1b 00 00       	call   80103af0 <myproc>
  acquire(&icache.lock);
80101f8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101f91:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101f94:	68 a0 0c 11 80       	push   $0x80110ca0
80101f99:	e8 d2 27 00 00       	call   80104770 <acquire>
  ip->ref++;
80101f9e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101fa2:	c7 04 24 a0 0c 11 80 	movl   $0x80110ca0,(%esp)
80101fa9:	e8 82 28 00 00       	call   80104830 <release>
80101fae:	83 c4 10             	add    $0x10,%esp
80101fb1:	eb 08                	jmp    80101fbb <namex+0x4b>
80101fb3:	90                   	nop
80101fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101fb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101fbb:	0f b6 03             	movzbl (%ebx),%eax
80101fbe:	3c 2f                	cmp    $0x2f,%al
80101fc0:	74 f6                	je     80101fb8 <namex+0x48>
  if(*path == 0)
80101fc2:	84 c0                	test   %al,%al
80101fc4:	0f 84 ee 00 00 00    	je     801020b8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101fca:	0f b6 03             	movzbl (%ebx),%eax
80101fcd:	3c 2f                	cmp    $0x2f,%al
80101fcf:	0f 84 b3 00 00 00    	je     80102088 <namex+0x118>
80101fd5:	84 c0                	test   %al,%al
80101fd7:	89 da                	mov    %ebx,%edx
80101fd9:	75 09                	jne    80101fe4 <namex+0x74>
80101fdb:	e9 a8 00 00 00       	jmp    80102088 <namex+0x118>
80101fe0:	84 c0                	test   %al,%al
80101fe2:	74 0a                	je     80101fee <namex+0x7e>
    path++;
80101fe4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101fe7:	0f b6 02             	movzbl (%edx),%eax
80101fea:	3c 2f                	cmp    $0x2f,%al
80101fec:	75 f2                	jne    80101fe0 <namex+0x70>
80101fee:	89 d1                	mov    %edx,%ecx
80101ff0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ff2:	83 f9 0d             	cmp    $0xd,%ecx
80101ff5:	0f 8e 91 00 00 00    	jle    8010208c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101ffb:	83 ec 04             	sub    $0x4,%esp
80101ffe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102001:	6a 0e                	push   $0xe
80102003:	53                   	push   %ebx
80102004:	57                   	push   %edi
80102005:	e8 26 29 00 00       	call   80104930 <memmove>
    path++;
8010200a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
8010200d:	83 c4 10             	add    $0x10,%esp
    path++;
80102010:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80102012:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102015:	75 11                	jne    80102028 <namex+0xb8>
80102017:	89 f6                	mov    %esi,%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80102020:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102023:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102026:	74 f8                	je     80102020 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102028:	83 ec 0c             	sub    $0xc,%esp
8010202b:	56                   	push   %esi
8010202c:	e8 5f f9 ff ff       	call   80101990 <ilock>
    if(ip->type != T_DIR){
80102031:	83 c4 10             	add    $0x10,%esp
80102034:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102039:	0f 85 91 00 00 00    	jne    801020d0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
8010203f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102042:	85 d2                	test   %edx,%edx
80102044:	74 09                	je     8010204f <namex+0xdf>
80102046:	80 3b 00             	cmpb   $0x0,(%ebx)
80102049:	0f 84 b7 00 00 00    	je     80102106 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010204f:	83 ec 04             	sub    $0x4,%esp
80102052:	6a 00                	push   $0x0
80102054:	57                   	push   %edi
80102055:	56                   	push   %esi
80102056:	e8 65 fe ff ff       	call   80101ec0 <dirlookup>
8010205b:	83 c4 10             	add    $0x10,%esp
8010205e:	85 c0                	test   %eax,%eax
80102060:	74 6e                	je     801020d0 <namex+0x160>
  iunlock(ip);
80102062:	83 ec 0c             	sub    $0xc,%esp
80102065:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102068:	56                   	push   %esi
80102069:	e8 02 fa ff ff       	call   80101a70 <iunlock>
  iput(ip);
8010206e:	89 34 24             	mov    %esi,(%esp)
80102071:	e8 4a fa ff ff       	call   80101ac0 <iput>
80102076:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102079:	83 c4 10             	add    $0x10,%esp
8010207c:	89 c6                	mov    %eax,%esi
8010207e:	e9 38 ff ff ff       	jmp    80101fbb <namex+0x4b>
80102083:	90                   	nop
80102084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80102088:	89 da                	mov    %ebx,%edx
8010208a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
8010208c:	83 ec 04             	sub    $0x4,%esp
8010208f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102092:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102095:	51                   	push   %ecx
80102096:	53                   	push   %ebx
80102097:	57                   	push   %edi
80102098:	e8 93 28 00 00       	call   80104930 <memmove>
    name[len] = 0;
8010209d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801020a0:	8b 55 dc             	mov    -0x24(%ebp),%edx
801020a3:	83 c4 10             	add    $0x10,%esp
801020a6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
801020aa:	89 d3                	mov    %edx,%ebx
801020ac:	e9 61 ff ff ff       	jmp    80102012 <namex+0xa2>
801020b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801020b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801020bb:	85 c0                	test   %eax,%eax
801020bd:	75 5d                	jne    8010211c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
801020bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020c2:	89 f0                	mov    %esi,%eax
801020c4:	5b                   	pop    %ebx
801020c5:	5e                   	pop    %esi
801020c6:	5f                   	pop    %edi
801020c7:	5d                   	pop    %ebp
801020c8:	c3                   	ret    
801020c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
801020d0:	83 ec 0c             	sub    $0xc,%esp
801020d3:	56                   	push   %esi
801020d4:	e8 97 f9 ff ff       	call   80101a70 <iunlock>
  iput(ip);
801020d9:	89 34 24             	mov    %esi,(%esp)
      return 0;
801020dc:	31 f6                	xor    %esi,%esi
  iput(ip);
801020de:	e8 dd f9 ff ff       	call   80101ac0 <iput>
      return 0;
801020e3:	83 c4 10             	add    $0x10,%esp
}
801020e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020e9:	89 f0                	mov    %esi,%eax
801020eb:	5b                   	pop    %ebx
801020ec:	5e                   	pop    %esi
801020ed:	5f                   	pop    %edi
801020ee:	5d                   	pop    %ebp
801020ef:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
801020f0:	ba 01 00 00 00       	mov    $0x1,%edx
801020f5:	b8 01 00 00 00       	mov    $0x1,%eax
801020fa:	e8 21 f4 ff ff       	call   80101520 <iget>
801020ff:	89 c6                	mov    %eax,%esi
80102101:	e9 b5 fe ff ff       	jmp    80101fbb <namex+0x4b>
      iunlock(ip);
80102106:	83 ec 0c             	sub    $0xc,%esp
80102109:	56                   	push   %esi
8010210a:	e8 61 f9 ff ff       	call   80101a70 <iunlock>
      return ip;
8010210f:	83 c4 10             	add    $0x10,%esp
}
80102112:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102115:	89 f0                	mov    %esi,%eax
80102117:	5b                   	pop    %ebx
80102118:	5e                   	pop    %esi
80102119:	5f                   	pop    %edi
8010211a:	5d                   	pop    %ebp
8010211b:	c3                   	ret    
    iput(ip);
8010211c:	83 ec 0c             	sub    $0xc,%esp
8010211f:	56                   	push   %esi
    return 0;
80102120:	31 f6                	xor    %esi,%esi
    iput(ip);
80102122:	e8 99 f9 ff ff       	call   80101ac0 <iput>
    return 0;
80102127:	83 c4 10             	add    $0x10,%esp
8010212a:	eb 93                	jmp    801020bf <namex+0x14f>
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102130 <dirlink>:
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	57                   	push   %edi
80102134:	56                   	push   %esi
80102135:	53                   	push   %ebx
80102136:	83 ec 20             	sub    $0x20,%esp
80102139:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010213c:	6a 00                	push   $0x0
8010213e:	ff 75 0c             	pushl  0xc(%ebp)
80102141:	53                   	push   %ebx
80102142:	e8 79 fd ff ff       	call   80101ec0 <dirlookup>
80102147:	83 c4 10             	add    $0x10,%esp
8010214a:	85 c0                	test   %eax,%eax
8010214c:	75 67                	jne    801021b5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010214e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102151:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102154:	85 ff                	test   %edi,%edi
80102156:	74 29                	je     80102181 <dirlink+0x51>
80102158:	31 ff                	xor    %edi,%edi
8010215a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010215d:	eb 09                	jmp    80102168 <dirlink+0x38>
8010215f:	90                   	nop
80102160:	83 c7 10             	add    $0x10,%edi
80102163:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102166:	73 19                	jae    80102181 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102168:	6a 10                	push   $0x10
8010216a:	57                   	push   %edi
8010216b:	56                   	push   %esi
8010216c:	53                   	push   %ebx
8010216d:	e8 fe fa ff ff       	call   80101c70 <readi>
80102172:	83 c4 10             	add    $0x10,%esp
80102175:	83 f8 10             	cmp    $0x10,%eax
80102178:	75 4e                	jne    801021c8 <dirlink+0x98>
    if(de.inum == 0)
8010217a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010217f:	75 df                	jne    80102160 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102181:	8d 45 da             	lea    -0x26(%ebp),%eax
80102184:	83 ec 04             	sub    $0x4,%esp
80102187:	6a 0e                	push   $0xe
80102189:	ff 75 0c             	pushl  0xc(%ebp)
8010218c:	50                   	push   %eax
8010218d:	e8 6e 28 00 00       	call   80104a00 <strncpy>
  de.inum = inum;
80102192:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102195:	6a 10                	push   $0x10
80102197:	57                   	push   %edi
80102198:	56                   	push   %esi
80102199:	53                   	push   %ebx
  de.inum = inum;
8010219a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010219e:	e8 cd fb ff ff       	call   80101d70 <writei>
801021a3:	83 c4 20             	add    $0x20,%esp
801021a6:	83 f8 10             	cmp    $0x10,%eax
801021a9:	75 2a                	jne    801021d5 <dirlink+0xa5>
  return 0;
801021ab:	31 c0                	xor    %eax,%eax
}
801021ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021b0:	5b                   	pop    %ebx
801021b1:	5e                   	pop    %esi
801021b2:	5f                   	pop    %edi
801021b3:	5d                   	pop    %ebp
801021b4:	c3                   	ret    
    iput(ip);
801021b5:	83 ec 0c             	sub    $0xc,%esp
801021b8:	50                   	push   %eax
801021b9:	e8 02 f9 ff ff       	call   80101ac0 <iput>
    return -1;
801021be:	83 c4 10             	add    $0x10,%esp
801021c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021c6:	eb e5                	jmp    801021ad <dirlink+0x7d>
      panic("dirlink read");
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 a8 74 10 80       	push   $0x801074a8
801021d0:	e8 bb e1 ff ff       	call   80100390 <panic>
    panic("dirlink");
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 46 7b 10 80       	push   $0x80107b46
801021dd:	e8 ae e1 ff ff       	call   80100390 <panic>
801021e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021f0 <namei>:

struct inode*
namei(char *path)
{
801021f0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021f1:	31 d2                	xor    %edx,%edx
{
801021f3:	89 e5                	mov    %esp,%ebp
801021f5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021f8:	8b 45 08             	mov    0x8(%ebp),%eax
801021fb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021fe:	e8 6d fd ff ff       	call   80101f70 <namex>
}
80102203:	c9                   	leave  
80102204:	c3                   	ret    
80102205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102210 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102210:	55                   	push   %ebp
  return namex(path, 1, name);
80102211:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102216:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102218:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010221b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010221e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010221f:	e9 4c fd ff ff       	jmp    80101f70 <namex>
80102224:	66 90                	xchg   %ax,%ax
80102226:	66 90                	xchg   %ax,%ax
80102228:	66 90                	xchg   %ax,%ax
8010222a:	66 90                	xchg   %ax,%ax
8010222c:	66 90                	xchg   %ax,%ax
8010222e:	66 90                	xchg   %ax,%ax

80102230 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	57                   	push   %edi
80102234:	56                   	push   %esi
80102235:	53                   	push   %ebx
80102236:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102239:	85 c0                	test   %eax,%eax
8010223b:	0f 84 b4 00 00 00    	je     801022f5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102241:	8b 58 08             	mov    0x8(%eax),%ebx
80102244:	89 c6                	mov    %eax,%esi
80102246:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010224c:	0f 87 96 00 00 00    	ja     801022e8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102252:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102257:	89 f6                	mov    %esi,%esi
80102259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102260:	89 ca                	mov    %ecx,%edx
80102262:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102263:	83 e0 c0             	and    $0xffffffc0,%eax
80102266:	3c 40                	cmp    $0x40,%al
80102268:	75 f6                	jne    80102260 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010226a:	31 ff                	xor    %edi,%edi
8010226c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102271:	89 f8                	mov    %edi,%eax
80102273:	ee                   	out    %al,(%dx)
80102274:	b8 01 00 00 00       	mov    $0x1,%eax
80102279:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010227e:	ee                   	out    %al,(%dx)
8010227f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102284:	89 d8                	mov    %ebx,%eax
80102286:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102287:	89 d8                	mov    %ebx,%eax
80102289:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010228e:	c1 f8 08             	sar    $0x8,%eax
80102291:	ee                   	out    %al,(%dx)
80102292:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102297:	89 f8                	mov    %edi,%eax
80102299:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010229a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010229e:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022a3:	c1 e0 04             	shl    $0x4,%eax
801022a6:	83 e0 10             	and    $0x10,%eax
801022a9:	83 c8 e0             	or     $0xffffffe0,%eax
801022ac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801022ad:	f6 06 04             	testb  $0x4,(%esi)
801022b0:	75 16                	jne    801022c8 <idestart+0x98>
801022b2:	b8 20 00 00 00       	mov    $0x20,%eax
801022b7:	89 ca                	mov    %ecx,%edx
801022b9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801022ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022bd:	5b                   	pop    %ebx
801022be:	5e                   	pop    %esi
801022bf:	5f                   	pop    %edi
801022c0:	5d                   	pop    %ebp
801022c1:	c3                   	ret    
801022c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022c8:	b8 30 00 00 00       	mov    $0x30,%eax
801022cd:	89 ca                	mov    %ecx,%edx
801022cf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801022d0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801022d5:	83 c6 5c             	add    $0x5c,%esi
801022d8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022dd:	fc                   	cld    
801022de:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801022e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022e3:	5b                   	pop    %ebx
801022e4:	5e                   	pop    %esi
801022e5:	5f                   	pop    %edi
801022e6:	5d                   	pop    %ebp
801022e7:	c3                   	ret    
    panic("incorrect blockno");
801022e8:	83 ec 0c             	sub    $0xc,%esp
801022eb:	68 14 75 10 80       	push   $0x80107514
801022f0:	e8 9b e0 ff ff       	call   80100390 <panic>
    panic("idestart");
801022f5:	83 ec 0c             	sub    $0xc,%esp
801022f8:	68 0b 75 10 80       	push   $0x8010750b
801022fd:	e8 8e e0 ff ff       	call   80100390 <panic>
80102302:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102310 <ideinit>:
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102316:	68 26 75 10 80       	push   $0x80107526
8010231b:	68 c0 a5 10 80       	push   $0x8010a5c0
80102320:	e8 0b 23 00 00       	call   80104630 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102325:	58                   	pop    %eax
80102326:	a1 c0 2f 11 80       	mov    0x80112fc0,%eax
8010232b:	5a                   	pop    %edx
8010232c:	83 e8 01             	sub    $0x1,%eax
8010232f:	50                   	push   %eax
80102330:	6a 0e                	push   $0xe
80102332:	e8 a9 02 00 00       	call   801025e0 <ioapicenable>
80102337:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010233a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010233f:	90                   	nop
80102340:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102341:	83 e0 c0             	and    $0xffffffc0,%eax
80102344:	3c 40                	cmp    $0x40,%al
80102346:	75 f8                	jne    80102340 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102348:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010234d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102352:	ee                   	out    %al,(%dx)
80102353:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102358:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010235d:	eb 06                	jmp    80102365 <ideinit+0x55>
8010235f:	90                   	nop
  for(i=0; i<1000; i++){
80102360:	83 e9 01             	sub    $0x1,%ecx
80102363:	74 0f                	je     80102374 <ideinit+0x64>
80102365:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102366:	84 c0                	test   %al,%al
80102368:	74 f6                	je     80102360 <ideinit+0x50>
      havedisk1 = 1;
8010236a:	c7 05 a0 a5 10 80 01 	movl   $0x1,0x8010a5a0
80102371:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102374:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102379:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010237e:	ee                   	out    %al,(%dx)
}
8010237f:	c9                   	leave  
80102380:	c3                   	ret    
80102381:	eb 0d                	jmp    80102390 <ideintr>
80102383:	90                   	nop
80102384:	90                   	nop
80102385:	90                   	nop
80102386:	90                   	nop
80102387:	90                   	nop
80102388:	90                   	nop
80102389:	90                   	nop
8010238a:	90                   	nop
8010238b:	90                   	nop
8010238c:	90                   	nop
8010238d:	90                   	nop
8010238e:	90                   	nop
8010238f:	90                   	nop

80102390 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	57                   	push   %edi
80102394:	56                   	push   %esi
80102395:	53                   	push   %ebx
80102396:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102399:	68 c0 a5 10 80       	push   $0x8010a5c0
8010239e:	e8 cd 23 00 00       	call   80104770 <acquire>

  if((b = idequeue) == 0){
801023a3:	8b 1d a4 a5 10 80    	mov    0x8010a5a4,%ebx
801023a9:	83 c4 10             	add    $0x10,%esp
801023ac:	85 db                	test   %ebx,%ebx
801023ae:	74 67                	je     80102417 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801023b0:	8b 43 58             	mov    0x58(%ebx),%eax
801023b3:	a3 a4 a5 10 80       	mov    %eax,0x8010a5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801023b8:	8b 3b                	mov    (%ebx),%edi
801023ba:	f7 c7 04 00 00 00    	test   $0x4,%edi
801023c0:	75 31                	jne    801023f3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023c7:	89 f6                	mov    %esi,%esi
801023c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801023d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023d1:	89 c6                	mov    %eax,%esi
801023d3:	83 e6 c0             	and    $0xffffffc0,%esi
801023d6:	89 f1                	mov    %esi,%ecx
801023d8:	80 f9 40             	cmp    $0x40,%cl
801023db:	75 f3                	jne    801023d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801023dd:	a8 21                	test   $0x21,%al
801023df:	75 12                	jne    801023f3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801023e1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801023e4:	b9 80 00 00 00       	mov    $0x80,%ecx
801023e9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023ee:	fc                   	cld    
801023ef:	f3 6d                	rep insl (%dx),%es:(%edi)
801023f1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801023f3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801023f6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801023f9:	89 f9                	mov    %edi,%ecx
801023fb:	83 c9 02             	or     $0x2,%ecx
801023fe:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102400:	53                   	push   %ebx
80102401:	e8 3a 1e 00 00       	call   80104240 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102406:	a1 a4 a5 10 80       	mov    0x8010a5a4,%eax
8010240b:	83 c4 10             	add    $0x10,%esp
8010240e:	85 c0                	test   %eax,%eax
80102410:	74 05                	je     80102417 <ideintr+0x87>
    idestart(idequeue);
80102412:	e8 19 fe ff ff       	call   80102230 <idestart>
    release(&idelock);
80102417:	83 ec 0c             	sub    $0xc,%esp
8010241a:	68 c0 a5 10 80       	push   $0x8010a5c0
8010241f:	e8 0c 24 00 00       	call   80104830 <release>

  release(&idelock);
}
80102424:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102427:	5b                   	pop    %ebx
80102428:	5e                   	pop    %esi
80102429:	5f                   	pop    %edi
8010242a:	5d                   	pop    %ebp
8010242b:	c3                   	ret    
8010242c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102430 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	53                   	push   %ebx
80102434:	83 ec 10             	sub    $0x10,%esp
80102437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010243a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010243d:	50                   	push   %eax
8010243e:	e8 9d 21 00 00       	call   801045e0 <holdingsleep>
80102443:	83 c4 10             	add    $0x10,%esp
80102446:	85 c0                	test   %eax,%eax
80102448:	0f 84 c6 00 00 00    	je     80102514 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010244e:	8b 03                	mov    (%ebx),%eax
80102450:	83 e0 06             	and    $0x6,%eax
80102453:	83 f8 02             	cmp    $0x2,%eax
80102456:	0f 84 ab 00 00 00    	je     80102507 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010245c:	8b 53 04             	mov    0x4(%ebx),%edx
8010245f:	85 d2                	test   %edx,%edx
80102461:	74 0d                	je     80102470 <iderw+0x40>
80102463:	a1 a0 a5 10 80       	mov    0x8010a5a0,%eax
80102468:	85 c0                	test   %eax,%eax
8010246a:	0f 84 b1 00 00 00    	je     80102521 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102470:	83 ec 0c             	sub    $0xc,%esp
80102473:	68 c0 a5 10 80       	push   $0x8010a5c0
80102478:	e8 f3 22 00 00       	call   80104770 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010247d:	8b 15 a4 a5 10 80    	mov    0x8010a5a4,%edx
80102483:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102486:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010248d:	85 d2                	test   %edx,%edx
8010248f:	75 09                	jne    8010249a <iderw+0x6a>
80102491:	eb 6d                	jmp    80102500 <iderw+0xd0>
80102493:	90                   	nop
80102494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102498:	89 c2                	mov    %eax,%edx
8010249a:	8b 42 58             	mov    0x58(%edx),%eax
8010249d:	85 c0                	test   %eax,%eax
8010249f:	75 f7                	jne    80102498 <iderw+0x68>
801024a1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801024a4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801024a6:	39 1d a4 a5 10 80    	cmp    %ebx,0x8010a5a4
801024ac:	74 42                	je     801024f0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024ae:	8b 03                	mov    (%ebx),%eax
801024b0:	83 e0 06             	and    $0x6,%eax
801024b3:	83 f8 02             	cmp    $0x2,%eax
801024b6:	74 23                	je     801024db <iderw+0xab>
801024b8:	90                   	nop
801024b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801024c0:	83 ec 08             	sub    $0x8,%esp
801024c3:	68 c0 a5 10 80       	push   $0x8010a5c0
801024c8:	53                   	push   %ebx
801024c9:	e8 c2 1b 00 00       	call   80104090 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024ce:	8b 03                	mov    (%ebx),%eax
801024d0:	83 c4 10             	add    $0x10,%esp
801024d3:	83 e0 06             	and    $0x6,%eax
801024d6:	83 f8 02             	cmp    $0x2,%eax
801024d9:	75 e5                	jne    801024c0 <iderw+0x90>
  }


  release(&idelock);
801024db:	c7 45 08 c0 a5 10 80 	movl   $0x8010a5c0,0x8(%ebp)
}
801024e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024e5:	c9                   	leave  
  release(&idelock);
801024e6:	e9 45 23 00 00       	jmp    80104830 <release>
801024eb:	90                   	nop
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801024f0:	89 d8                	mov    %ebx,%eax
801024f2:	e8 39 fd ff ff       	call   80102230 <idestart>
801024f7:	eb b5                	jmp    801024ae <iderw+0x7e>
801024f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102500:	ba a4 a5 10 80       	mov    $0x8010a5a4,%edx
80102505:	eb 9d                	jmp    801024a4 <iderw+0x74>
    panic("iderw: nothing to do");
80102507:	83 ec 0c             	sub    $0xc,%esp
8010250a:	68 40 75 10 80       	push   $0x80107540
8010250f:	e8 7c de ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102514:	83 ec 0c             	sub    $0xc,%esp
80102517:	68 2a 75 10 80       	push   $0x8010752a
8010251c:	e8 6f de ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102521:	83 ec 0c             	sub    $0xc,%esp
80102524:	68 55 75 10 80       	push   $0x80107555
80102529:	e8 62 de ff ff       	call   80100390 <panic>
8010252e:	66 90                	xchg   %ax,%ax

80102530 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102530:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102531:	c7 05 f4 28 11 80 00 	movl   $0xfec00000,0x801128f4
80102538:	00 c0 fe 
{
8010253b:	89 e5                	mov    %esp,%ebp
8010253d:	56                   	push   %esi
8010253e:	53                   	push   %ebx
  ioapic->reg = reg;
8010253f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102546:	00 00 00 
  return ioapic->data;
80102549:	a1 f4 28 11 80       	mov    0x801128f4,%eax
8010254e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102551:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102557:	8b 0d f4 28 11 80    	mov    0x801128f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010255d:	0f b6 15 20 2a 11 80 	movzbl 0x80112a20,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102564:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102567:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010256a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010256d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102570:	39 c2                	cmp    %eax,%edx
80102572:	74 16                	je     8010258a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102574:	83 ec 0c             	sub    $0xc,%esp
80102577:	68 74 75 10 80       	push   $0x80107574
8010257c:	e8 df e0 ff ff       	call   80100660 <cprintf>
80102581:	8b 0d f4 28 11 80    	mov    0x801128f4,%ecx
80102587:	83 c4 10             	add    $0x10,%esp
8010258a:	83 c3 21             	add    $0x21,%ebx
{
8010258d:	ba 10 00 00 00       	mov    $0x10,%edx
80102592:	b8 20 00 00 00       	mov    $0x20,%eax
80102597:	89 f6                	mov    %esi,%esi
80102599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801025a0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801025a2:	8b 0d f4 28 11 80    	mov    0x801128f4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801025a8:	89 c6                	mov    %eax,%esi
801025aa:	81 ce 00 00 01 00    	or     $0x10000,%esi
801025b0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801025b3:	89 71 10             	mov    %esi,0x10(%ecx)
801025b6:	8d 72 01             	lea    0x1(%edx),%esi
801025b9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801025bc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801025be:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801025c0:	8b 0d f4 28 11 80    	mov    0x801128f4,%ecx
801025c6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801025cd:	75 d1                	jne    801025a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801025cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025d2:	5b                   	pop    %ebx
801025d3:	5e                   	pop    %esi
801025d4:	5d                   	pop    %ebp
801025d5:	c3                   	ret    
801025d6:	8d 76 00             	lea    0x0(%esi),%esi
801025d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025e0:	55                   	push   %ebp
  ioapic->reg = reg;
801025e1:	8b 0d f4 28 11 80    	mov    0x801128f4,%ecx
{
801025e7:	89 e5                	mov    %esp,%ebp
801025e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025ec:	8d 50 20             	lea    0x20(%eax),%edx
801025ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801025f3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025f5:	8b 0d f4 28 11 80    	mov    0x801128f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801025fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102601:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102604:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102606:	a1 f4 28 11 80       	mov    0x801128f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010260b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010260e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102611:	5d                   	pop    %ebp
80102612:	c3                   	ret    
80102613:	66 90                	xchg   %ax,%ax
80102615:	66 90                	xchg   %ax,%ax
80102617:	66 90                	xchg   %ax,%ax
80102619:	66 90                	xchg   %ax,%ax
8010261b:	66 90                	xchg   %ax,%ax
8010261d:	66 90                	xchg   %ax,%ax
8010261f:	90                   	nop

80102620 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	53                   	push   %ebx
80102624:	83 ec 04             	sub    $0x4,%esp
80102627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010262a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102630:	75 70                	jne    801026a2 <kfree+0x82>
80102632:	81 fb 68 57 11 80    	cmp    $0x80115768,%ebx
80102638:	72 68                	jb     801026a2 <kfree+0x82>
8010263a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102640:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102645:	77 5b                	ja     801026a2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102647:	83 ec 04             	sub    $0x4,%esp
8010264a:	68 00 10 00 00       	push   $0x1000
8010264f:	6a 01                	push   $0x1
80102651:	53                   	push   %ebx
80102652:	e8 29 22 00 00       	call   80104880 <memset>

  if(kmem.use_lock)
80102657:	8b 15 34 29 11 80    	mov    0x80112934,%edx
8010265d:	83 c4 10             	add    $0x10,%esp
80102660:	85 d2                	test   %edx,%edx
80102662:	75 2c                	jne    80102690 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102664:	a1 38 29 11 80       	mov    0x80112938,%eax
80102669:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010266b:	a1 34 29 11 80       	mov    0x80112934,%eax
  kmem.freelist = r;
80102670:	89 1d 38 29 11 80    	mov    %ebx,0x80112938
  if(kmem.use_lock)
80102676:	85 c0                	test   %eax,%eax
80102678:	75 06                	jne    80102680 <kfree+0x60>
    release(&kmem.lock);
}
8010267a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010267d:	c9                   	leave  
8010267e:	c3                   	ret    
8010267f:	90                   	nop
    release(&kmem.lock);
80102680:	c7 45 08 00 29 11 80 	movl   $0x80112900,0x8(%ebp)
}
80102687:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010268a:	c9                   	leave  
    release(&kmem.lock);
8010268b:	e9 a0 21 00 00       	jmp    80104830 <release>
    acquire(&kmem.lock);
80102690:	83 ec 0c             	sub    $0xc,%esp
80102693:	68 00 29 11 80       	push   $0x80112900
80102698:	e8 d3 20 00 00       	call   80104770 <acquire>
8010269d:	83 c4 10             	add    $0x10,%esp
801026a0:	eb c2                	jmp    80102664 <kfree+0x44>
    panic("kfree");
801026a2:	83 ec 0c             	sub    $0xc,%esp
801026a5:	68 a6 75 10 80       	push   $0x801075a6
801026aa:	e8 e1 dc ff ff       	call   80100390 <panic>
801026af:	90                   	nop

801026b0 <freerange>:
{
801026b0:	55                   	push   %ebp
801026b1:	89 e5                	mov    %esp,%ebp
801026b3:	56                   	push   %esi
801026b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801026bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026cd:	39 de                	cmp    %ebx,%esi
801026cf:	72 23                	jb     801026f4 <freerange+0x44>
801026d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801026de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026e7:	50                   	push   %eax
801026e8:	e8 33 ff ff ff       	call   80102620 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026ed:	83 c4 10             	add    $0x10,%esp
801026f0:	39 f3                	cmp    %esi,%ebx
801026f2:	76 e4                	jbe    801026d8 <freerange+0x28>
}
801026f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026f7:	5b                   	pop    %ebx
801026f8:	5e                   	pop    %esi
801026f9:	5d                   	pop    %ebp
801026fa:	c3                   	ret    
801026fb:	90                   	nop
801026fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102700 <kinit1>:
{
80102700:	55                   	push   %ebp
80102701:	89 e5                	mov    %esp,%ebp
80102703:	56                   	push   %esi
80102704:	53                   	push   %ebx
80102705:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102708:	83 ec 08             	sub    $0x8,%esp
8010270b:	68 ac 75 10 80       	push   $0x801075ac
80102710:	68 00 29 11 80       	push   $0x80112900
80102715:	e8 16 1f 00 00       	call   80104630 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010271a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010271d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102720:	c7 05 34 29 11 80 00 	movl   $0x0,0x80112934
80102727:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010272a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102730:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102736:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010273c:	39 de                	cmp    %ebx,%esi
8010273e:	72 1c                	jb     8010275c <kinit1+0x5c>
    kfree(p);
80102740:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102746:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102749:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010274f:	50                   	push   %eax
80102750:	e8 cb fe ff ff       	call   80102620 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102755:	83 c4 10             	add    $0x10,%esp
80102758:	39 de                	cmp    %ebx,%esi
8010275a:	73 e4                	jae    80102740 <kinit1+0x40>
}
8010275c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010275f:	5b                   	pop    %ebx
80102760:	5e                   	pop    %esi
80102761:	5d                   	pop    %ebp
80102762:	c3                   	ret    
80102763:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <kinit2>:
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
80102773:	56                   	push   %esi
80102774:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102775:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102778:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010277b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102781:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102787:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010278d:	39 de                	cmp    %ebx,%esi
8010278f:	72 23                	jb     801027b4 <kinit2+0x44>
80102791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102798:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010279e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027a7:	50                   	push   %eax
801027a8:	e8 73 fe ff ff       	call   80102620 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ad:	83 c4 10             	add    $0x10,%esp
801027b0:	39 de                	cmp    %ebx,%esi
801027b2:	73 e4                	jae    80102798 <kinit2+0x28>
  kmem.use_lock = 1;
801027b4:	c7 05 34 29 11 80 01 	movl   $0x1,0x80112934
801027bb:	00 00 00 
}
801027be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027c1:	5b                   	pop    %ebx
801027c2:	5e                   	pop    %esi
801027c3:	5d                   	pop    %ebp
801027c4:	c3                   	ret    
801027c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801027d0:	a1 34 29 11 80       	mov    0x80112934,%eax
801027d5:	85 c0                	test   %eax,%eax
801027d7:	75 1f                	jne    801027f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801027d9:	a1 38 29 11 80       	mov    0x80112938,%eax
  if(r)
801027de:	85 c0                	test   %eax,%eax
801027e0:	74 0e                	je     801027f0 <kalloc+0x20>
    kmem.freelist = r->next;
801027e2:	8b 10                	mov    (%eax),%edx
801027e4:	89 15 38 29 11 80    	mov    %edx,0x80112938
801027ea:	c3                   	ret    
801027eb:	90                   	nop
801027ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801027f0:	f3 c3                	repz ret 
801027f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801027f8:	55                   	push   %ebp
801027f9:	89 e5                	mov    %esp,%ebp
801027fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801027fe:	68 00 29 11 80       	push   $0x80112900
80102803:	e8 68 1f 00 00       	call   80104770 <acquire>
  r = kmem.freelist;
80102808:	a1 38 29 11 80       	mov    0x80112938,%eax
  if(r)
8010280d:	83 c4 10             	add    $0x10,%esp
80102810:	8b 15 34 29 11 80    	mov    0x80112934,%edx
80102816:	85 c0                	test   %eax,%eax
80102818:	74 08                	je     80102822 <kalloc+0x52>
    kmem.freelist = r->next;
8010281a:	8b 08                	mov    (%eax),%ecx
8010281c:	89 0d 38 29 11 80    	mov    %ecx,0x80112938
  if(kmem.use_lock)
80102822:	85 d2                	test   %edx,%edx
80102824:	74 16                	je     8010283c <kalloc+0x6c>
    release(&kmem.lock);
80102826:	83 ec 0c             	sub    $0xc,%esp
80102829:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010282c:	68 00 29 11 80       	push   $0x80112900
80102831:	e8 fa 1f 00 00       	call   80104830 <release>
  return (char*)r;
80102836:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102839:	83 c4 10             	add    $0x10,%esp
}
8010283c:	c9                   	leave  
8010283d:	c3                   	ret    
8010283e:	66 90                	xchg   %ax,%ax

80102840 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102840:	ba 64 00 00 00       	mov    $0x64,%edx
80102845:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102846:	a8 01                	test   $0x1,%al
80102848:	0f 84 c2 00 00 00    	je     80102910 <kbdgetc+0xd0>
8010284e:	ba 60 00 00 00       	mov    $0x60,%edx
80102853:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102854:	0f b6 d0             	movzbl %al,%edx
80102857:	8b 0d f4 a5 10 80    	mov    0x8010a5f4,%ecx

  if(data == 0xE0){
8010285d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102863:	0f 84 7f 00 00 00    	je     801028e8 <kbdgetc+0xa8>
{
80102869:	55                   	push   %ebp
8010286a:	89 e5                	mov    %esp,%ebp
8010286c:	53                   	push   %ebx
8010286d:	89 cb                	mov    %ecx,%ebx
8010286f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102872:	84 c0                	test   %al,%al
80102874:	78 4a                	js     801028c0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102876:	85 db                	test   %ebx,%ebx
80102878:	74 09                	je     80102883 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010287a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010287d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102880:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102883:	0f b6 82 e0 76 10 80 	movzbl -0x7fef8920(%edx),%eax
8010288a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010288c:	0f b6 82 e0 75 10 80 	movzbl -0x7fef8a20(%edx),%eax
80102893:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102895:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102897:	89 0d f4 a5 10 80    	mov    %ecx,0x8010a5f4
  c = charcode[shift & (CTL | SHIFT)][data];
8010289d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801028a0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801028a3:	8b 04 85 c0 75 10 80 	mov    -0x7fef8a40(,%eax,4),%eax
801028aa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801028ae:	74 31                	je     801028e1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801028b0:	8d 50 9f             	lea    -0x61(%eax),%edx
801028b3:	83 fa 19             	cmp    $0x19,%edx
801028b6:	77 40                	ja     801028f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801028b8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028bb:	5b                   	pop    %ebx
801028bc:	5d                   	pop    %ebp
801028bd:	c3                   	ret    
801028be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801028c0:	83 e0 7f             	and    $0x7f,%eax
801028c3:	85 db                	test   %ebx,%ebx
801028c5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801028c8:	0f b6 82 e0 76 10 80 	movzbl -0x7fef8920(%edx),%eax
801028cf:	83 c8 40             	or     $0x40,%eax
801028d2:	0f b6 c0             	movzbl %al,%eax
801028d5:	f7 d0                	not    %eax
801028d7:	21 c1                	and    %eax,%ecx
    return 0;
801028d9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801028db:	89 0d f4 a5 10 80    	mov    %ecx,0x8010a5f4
}
801028e1:	5b                   	pop    %ebx
801028e2:	5d                   	pop    %ebp
801028e3:	c3                   	ret    
801028e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801028e8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801028eb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801028ed:	89 0d f4 a5 10 80    	mov    %ecx,0x8010a5f4
    return 0;
801028f3:	c3                   	ret    
801028f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801028f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801028fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801028fe:	5b                   	pop    %ebx
      c += 'a' - 'A';
801028ff:	83 f9 1a             	cmp    $0x1a,%ecx
80102902:	0f 42 c2             	cmovb  %edx,%eax
}
80102905:	5d                   	pop    %ebp
80102906:	c3                   	ret    
80102907:	89 f6                	mov    %esi,%esi
80102909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102915:	c3                   	ret    
80102916:	8d 76 00             	lea    0x0(%esi),%esi
80102919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102920 <kbdintr>:

void
kbdintr(void)
{
80102920:	55                   	push   %ebp
80102921:	89 e5                	mov    %esp,%ebp
80102923:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102926:	68 40 28 10 80       	push   $0x80102840
8010292b:	e8 b0 e1 ff ff       	call   80100ae0 <consoleintr>
}
80102930:	83 c4 10             	add    $0x10,%esp
80102933:	c9                   	leave  
80102934:	c3                   	ret    
80102935:	66 90                	xchg   %ax,%ax
80102937:	66 90                	xchg   %ax,%ax
80102939:	66 90                	xchg   %ax,%ax
8010293b:	66 90                	xchg   %ax,%ax
8010293d:	66 90                	xchg   %ax,%ax
8010293f:	90                   	nop

80102940 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102940:	a1 3c 29 11 80       	mov    0x8011293c,%eax
{
80102945:	55                   	push   %ebp
80102946:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102948:	85 c0                	test   %eax,%eax
8010294a:	0f 84 c8 00 00 00    	je     80102a18 <lapicinit+0xd8>
  lapic[index] = value;
80102950:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102957:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010295a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010295d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102964:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102967:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010296a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102971:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102974:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102977:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010297e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102981:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102984:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010298b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010298e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102991:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102998:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010299b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010299e:	8b 50 30             	mov    0x30(%eax),%edx
801029a1:	c1 ea 10             	shr    $0x10,%edx
801029a4:	80 fa 03             	cmp    $0x3,%dl
801029a7:	77 77                	ja     80102a20 <lapicinit+0xe0>
  lapic[index] = value;
801029a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801029b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801029e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801029f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801029f4:	8b 50 20             	mov    0x20(%eax),%edx
801029f7:	89 f6                	mov    %esi,%esi
801029f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a00:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a06:	80 e6 10             	and    $0x10,%dh
80102a09:	75 f5                	jne    80102a00 <lapicinit+0xc0>
  lapic[index] = value;
80102a0b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a12:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a15:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    
80102a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102a20:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a27:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a2a:	8b 50 20             	mov    0x20(%eax),%edx
80102a2d:	e9 77 ff ff ff       	jmp    801029a9 <lapicinit+0x69>
80102a32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a40 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102a40:	8b 15 3c 29 11 80    	mov    0x8011293c,%edx
{
80102a46:	55                   	push   %ebp
80102a47:	31 c0                	xor    %eax,%eax
80102a49:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102a4b:	85 d2                	test   %edx,%edx
80102a4d:	74 06                	je     80102a55 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102a4f:	8b 42 20             	mov    0x20(%edx),%eax
80102a52:	c1 e8 18             	shr    $0x18,%eax
}
80102a55:	5d                   	pop    %ebp
80102a56:	c3                   	ret    
80102a57:	89 f6                	mov    %esi,%esi
80102a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a60 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102a60:	a1 3c 29 11 80       	mov    0x8011293c,%eax
{
80102a65:	55                   	push   %ebp
80102a66:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102a68:	85 c0                	test   %eax,%eax
80102a6a:	74 0d                	je     80102a79 <lapiceoi+0x19>
  lapic[index] = value;
80102a6c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a73:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a76:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102a79:	5d                   	pop    %ebp
80102a7a:	c3                   	ret    
80102a7b:	90                   	nop
80102a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a80 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
}
80102a83:	5d                   	pop    %ebp
80102a84:	c3                   	ret    
80102a85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a90 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102a90:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a91:	b8 0f 00 00 00       	mov    $0xf,%eax
80102a96:	ba 70 00 00 00       	mov    $0x70,%edx
80102a9b:	89 e5                	mov    %esp,%ebp
80102a9d:	53                   	push   %ebx
80102a9e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102aa1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102aa4:	ee                   	out    %al,(%dx)
80102aa5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102aaa:	ba 71 00 00 00       	mov    $0x71,%edx
80102aaf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102ab0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102ab2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102ab5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102abb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102abd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102ac0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102ac3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102ac5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102ac8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102ace:	a1 3c 29 11 80       	mov    0x8011293c,%eax
80102ad3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ad9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102adc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ae3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ae6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ae9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102af0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102af3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102af6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102afc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102aff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b05:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b08:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b0e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b11:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b17:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102b1a:	5b                   	pop    %ebx
80102b1b:	5d                   	pop    %ebp
80102b1c:	c3                   	ret    
80102b1d:	8d 76 00             	lea    0x0(%esi),%esi

80102b20 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b20:	55                   	push   %ebp
80102b21:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b26:	ba 70 00 00 00       	mov    $0x70,%edx
80102b2b:	89 e5                	mov    %esp,%ebp
80102b2d:	57                   	push   %edi
80102b2e:	56                   	push   %esi
80102b2f:	53                   	push   %ebx
80102b30:	83 ec 4c             	sub    $0x4c,%esp
80102b33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b34:	ba 71 00 00 00       	mov    $0x71,%edx
80102b39:	ec                   	in     (%dx),%al
80102b3a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b3d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102b42:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102b45:	8d 76 00             	lea    0x0(%esi),%esi
80102b48:	31 c0                	xor    %eax,%eax
80102b4a:	89 da                	mov    %ebx,%edx
80102b4c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b4d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102b52:	89 ca                	mov    %ecx,%edx
80102b54:	ec                   	in     (%dx),%al
80102b55:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b58:	89 da                	mov    %ebx,%edx
80102b5a:	b8 02 00 00 00       	mov    $0x2,%eax
80102b5f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b60:	89 ca                	mov    %ecx,%edx
80102b62:	ec                   	in     (%dx),%al
80102b63:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b66:	89 da                	mov    %ebx,%edx
80102b68:	b8 04 00 00 00       	mov    $0x4,%eax
80102b6d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b6e:	89 ca                	mov    %ecx,%edx
80102b70:	ec                   	in     (%dx),%al
80102b71:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b74:	89 da                	mov    %ebx,%edx
80102b76:	b8 07 00 00 00       	mov    $0x7,%eax
80102b7b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b7c:	89 ca                	mov    %ecx,%edx
80102b7e:	ec                   	in     (%dx),%al
80102b7f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b82:	89 da                	mov    %ebx,%edx
80102b84:	b8 08 00 00 00       	mov    $0x8,%eax
80102b89:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b8a:	89 ca                	mov    %ecx,%edx
80102b8c:	ec                   	in     (%dx),%al
80102b8d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b8f:	89 da                	mov    %ebx,%edx
80102b91:	b8 09 00 00 00       	mov    $0x9,%eax
80102b96:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b97:	89 ca                	mov    %ecx,%edx
80102b99:	ec                   	in     (%dx),%al
80102b9a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b9c:	89 da                	mov    %ebx,%edx
80102b9e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102ba3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba4:	89 ca                	mov    %ecx,%edx
80102ba6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102ba7:	84 c0                	test   %al,%al
80102ba9:	78 9d                	js     80102b48 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102bab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102baf:	89 fa                	mov    %edi,%edx
80102bb1:	0f b6 fa             	movzbl %dl,%edi
80102bb4:	89 f2                	mov    %esi,%edx
80102bb6:	0f b6 f2             	movzbl %dl,%esi
80102bb9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bbc:	89 da                	mov    %ebx,%edx
80102bbe:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102bc1:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102bc4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102bc8:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102bcb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102bcf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102bd2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102bd6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102bd9:	31 c0                	xor    %eax,%eax
80102bdb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdc:	89 ca                	mov    %ecx,%edx
80102bde:	ec                   	in     (%dx),%al
80102bdf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be2:	89 da                	mov    %ebx,%edx
80102be4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102be7:	b8 02 00 00 00       	mov    $0x2,%eax
80102bec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bed:	89 ca                	mov    %ecx,%edx
80102bef:	ec                   	in     (%dx),%al
80102bf0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf3:	89 da                	mov    %ebx,%edx
80102bf5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102bf8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bfd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfe:	89 ca                	mov    %ecx,%edx
80102c00:	ec                   	in     (%dx),%al
80102c01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c04:	89 da                	mov    %ebx,%edx
80102c06:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c09:	b8 07 00 00 00       	mov    $0x7,%eax
80102c0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c0f:	89 ca                	mov    %ecx,%edx
80102c11:	ec                   	in     (%dx),%al
80102c12:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c15:	89 da                	mov    %ebx,%edx
80102c17:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c1a:	b8 08 00 00 00       	mov    $0x8,%eax
80102c1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c20:	89 ca                	mov    %ecx,%edx
80102c22:	ec                   	in     (%dx),%al
80102c23:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c26:	89 da                	mov    %ebx,%edx
80102c28:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c2b:	b8 09 00 00 00       	mov    $0x9,%eax
80102c30:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c31:	89 ca                	mov    %ecx,%edx
80102c33:	ec                   	in     (%dx),%al
80102c34:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c37:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102c3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c3d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102c40:	6a 18                	push   $0x18
80102c42:	50                   	push   %eax
80102c43:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102c46:	50                   	push   %eax
80102c47:	e8 84 1c 00 00       	call   801048d0 <memcmp>
80102c4c:	83 c4 10             	add    $0x10,%esp
80102c4f:	85 c0                	test   %eax,%eax
80102c51:	0f 85 f1 fe ff ff    	jne    80102b48 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102c57:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102c5b:	75 78                	jne    80102cd5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102c5d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c60:	89 c2                	mov    %eax,%edx
80102c62:	83 e0 0f             	and    $0xf,%eax
80102c65:	c1 ea 04             	shr    $0x4,%edx
80102c68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c6e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102c71:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c74:	89 c2                	mov    %eax,%edx
80102c76:	83 e0 0f             	and    $0xf,%eax
80102c79:	c1 ea 04             	shr    $0x4,%edx
80102c7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c82:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102c85:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c88:	89 c2                	mov    %eax,%edx
80102c8a:	83 e0 0f             	and    $0xf,%eax
80102c8d:	c1 ea 04             	shr    $0x4,%edx
80102c90:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c93:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c96:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102c99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c9c:	89 c2                	mov    %eax,%edx
80102c9e:	83 e0 0f             	and    $0xf,%eax
80102ca1:	c1 ea 04             	shr    $0x4,%edx
80102ca4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ca7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102caa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102cad:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cb0:	89 c2                	mov    %eax,%edx
80102cb2:	83 e0 0f             	and    $0xf,%eax
80102cb5:	c1 ea 04             	shr    $0x4,%edx
80102cb8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cbb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cbe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102cc1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cc4:	89 c2                	mov    %eax,%edx
80102cc6:	83 e0 0f             	and    $0xf,%eax
80102cc9:	c1 ea 04             	shr    $0x4,%edx
80102ccc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ccf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cd2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102cd5:	8b 75 08             	mov    0x8(%ebp),%esi
80102cd8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cdb:	89 06                	mov    %eax,(%esi)
80102cdd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ce0:	89 46 04             	mov    %eax,0x4(%esi)
80102ce3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ce6:	89 46 08             	mov    %eax,0x8(%esi)
80102ce9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cec:	89 46 0c             	mov    %eax,0xc(%esi)
80102cef:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cf2:	89 46 10             	mov    %eax,0x10(%esi)
80102cf5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cf8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102cfb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d05:	5b                   	pop    %ebx
80102d06:	5e                   	pop    %esi
80102d07:	5f                   	pop    %edi
80102d08:	5d                   	pop    %ebp
80102d09:	c3                   	ret    
80102d0a:	66 90                	xchg   %ax,%ax
80102d0c:	66 90                	xchg   %ax,%ax
80102d0e:	66 90                	xchg   %ax,%ax

80102d10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d10:	8b 0d 88 29 11 80    	mov    0x80112988,%ecx
80102d16:	85 c9                	test   %ecx,%ecx
80102d18:	0f 8e 8a 00 00 00    	jle    80102da8 <install_trans+0x98>
{
80102d1e:	55                   	push   %ebp
80102d1f:	89 e5                	mov    %esp,%ebp
80102d21:	57                   	push   %edi
80102d22:	56                   	push   %esi
80102d23:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102d24:	31 db                	xor    %ebx,%ebx
{
80102d26:	83 ec 0c             	sub    $0xc,%esp
80102d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d30:	a1 74 29 11 80       	mov    0x80112974,%eax
80102d35:	83 ec 08             	sub    $0x8,%esp
80102d38:	01 d8                	add    %ebx,%eax
80102d3a:	83 c0 01             	add    $0x1,%eax
80102d3d:	50                   	push   %eax
80102d3e:	ff 35 84 29 11 80    	pushl  0x80112984
80102d44:	e8 87 d3 ff ff       	call   801000d0 <bread>
80102d49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d4b:	58                   	pop    %eax
80102d4c:	5a                   	pop    %edx
80102d4d:	ff 34 9d 8c 29 11 80 	pushl  -0x7feed674(,%ebx,4)
80102d54:	ff 35 84 29 11 80    	pushl  0x80112984
  for (tail = 0; tail < log.lh.n; tail++) {
80102d5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d5d:	e8 6e d3 ff ff       	call   801000d0 <bread>
80102d62:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d64:	8d 47 5c             	lea    0x5c(%edi),%eax
80102d67:	83 c4 0c             	add    $0xc,%esp
80102d6a:	68 00 02 00 00       	push   $0x200
80102d6f:	50                   	push   %eax
80102d70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d73:	50                   	push   %eax
80102d74:	e8 b7 1b 00 00       	call   80104930 <memmove>
    bwrite(dbuf);  // write dst to disk
80102d79:	89 34 24             	mov    %esi,(%esp)
80102d7c:	e8 1f d4 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102d81:	89 3c 24             	mov    %edi,(%esp)
80102d84:	e8 57 d4 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102d89:	89 34 24             	mov    %esi,(%esp)
80102d8c:	e8 4f d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d91:	83 c4 10             	add    $0x10,%esp
80102d94:	39 1d 88 29 11 80    	cmp    %ebx,0x80112988
80102d9a:	7f 94                	jg     80102d30 <install_trans+0x20>
  }
}
80102d9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d9f:	5b                   	pop    %ebx
80102da0:	5e                   	pop    %esi
80102da1:	5f                   	pop    %edi
80102da2:	5d                   	pop    %ebp
80102da3:	c3                   	ret    
80102da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102da8:	f3 c3                	repz ret 
80102daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102db0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	56                   	push   %esi
80102db4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102db5:	83 ec 08             	sub    $0x8,%esp
80102db8:	ff 35 74 29 11 80    	pushl  0x80112974
80102dbe:	ff 35 84 29 11 80    	pushl  0x80112984
80102dc4:	e8 07 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102dc9:	8b 1d 88 29 11 80    	mov    0x80112988,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102dcf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102dd2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102dd4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102dd6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102dd9:	7e 16                	jle    80102df1 <write_head+0x41>
80102ddb:	c1 e3 02             	shl    $0x2,%ebx
80102dde:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102de0:	8b 8a 8c 29 11 80    	mov    -0x7feed674(%edx),%ecx
80102de6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102dea:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102ded:	39 da                	cmp    %ebx,%edx
80102def:	75 ef                	jne    80102de0 <write_head+0x30>
  }
  bwrite(buf);
80102df1:	83 ec 0c             	sub    $0xc,%esp
80102df4:	56                   	push   %esi
80102df5:	e8 a6 d3 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102dfa:	89 34 24             	mov    %esi,(%esp)
80102dfd:	e8 de d3 ff ff       	call   801001e0 <brelse>
}
80102e02:	83 c4 10             	add    $0x10,%esp
80102e05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e08:	5b                   	pop    %ebx
80102e09:	5e                   	pop    %esi
80102e0a:	5d                   	pop    %ebp
80102e0b:	c3                   	ret    
80102e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e10 <initlog>:
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 2c             	sub    $0x2c,%esp
80102e17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e1a:	68 e0 77 10 80       	push   $0x801077e0
80102e1f:	68 40 29 11 80       	push   $0x80112940
80102e24:	e8 07 18 00 00       	call   80104630 <initlock>
  readsb(dev, &sb);
80102e29:	58                   	pop    %eax
80102e2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e2d:	5a                   	pop    %edx
80102e2e:	50                   	push   %eax
80102e2f:	53                   	push   %ebx
80102e30:	e8 9b e8 ff ff       	call   801016d0 <readsb>
  log.size = sb.nlog;
80102e35:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102e38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102e3b:	59                   	pop    %ecx
  log.dev = dev;
80102e3c:	89 1d 84 29 11 80    	mov    %ebx,0x80112984
  log.size = sb.nlog;
80102e42:	89 15 78 29 11 80    	mov    %edx,0x80112978
  log.start = sb.logstart;
80102e48:	a3 74 29 11 80       	mov    %eax,0x80112974
  struct buf *buf = bread(log.dev, log.start);
80102e4d:	5a                   	pop    %edx
80102e4e:	50                   	push   %eax
80102e4f:	53                   	push   %ebx
80102e50:	e8 7b d2 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102e55:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102e58:	83 c4 10             	add    $0x10,%esp
80102e5b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102e5d:	89 1d 88 29 11 80    	mov    %ebx,0x80112988
  for (i = 0; i < log.lh.n; i++) {
80102e63:	7e 1c                	jle    80102e81 <initlog+0x71>
80102e65:	c1 e3 02             	shl    $0x2,%ebx
80102e68:	31 d2                	xor    %edx,%edx
80102e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102e70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102e74:	83 c2 04             	add    $0x4,%edx
80102e77:	89 8a 88 29 11 80    	mov    %ecx,-0x7feed678(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102e7d:	39 d3                	cmp    %edx,%ebx
80102e7f:	75 ef                	jne    80102e70 <initlog+0x60>
  brelse(buf);
80102e81:	83 ec 0c             	sub    $0xc,%esp
80102e84:	50                   	push   %eax
80102e85:	e8 56 d3 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e8a:	e8 81 fe ff ff       	call   80102d10 <install_trans>
  log.lh.n = 0;
80102e8f:	c7 05 88 29 11 80 00 	movl   $0x0,0x80112988
80102e96:	00 00 00 
  write_head(); // clear the log
80102e99:	e8 12 ff ff ff       	call   80102db0 <write_head>
}
80102e9e:	83 c4 10             	add    $0x10,%esp
80102ea1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ea4:	c9                   	leave  
80102ea5:	c3                   	ret    
80102ea6:	8d 76 00             	lea    0x0(%esi),%esi
80102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102eb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102eb6:	68 40 29 11 80       	push   $0x80112940
80102ebb:	e8 b0 18 00 00       	call   80104770 <acquire>
80102ec0:	83 c4 10             	add    $0x10,%esp
80102ec3:	eb 18                	jmp    80102edd <begin_op+0x2d>
80102ec5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ec8:	83 ec 08             	sub    $0x8,%esp
80102ecb:	68 40 29 11 80       	push   $0x80112940
80102ed0:	68 40 29 11 80       	push   $0x80112940
80102ed5:	e8 b6 11 00 00       	call   80104090 <sleep>
80102eda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102edd:	a1 80 29 11 80       	mov    0x80112980,%eax
80102ee2:	85 c0                	test   %eax,%eax
80102ee4:	75 e2                	jne    80102ec8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ee6:	a1 7c 29 11 80       	mov    0x8011297c,%eax
80102eeb:	8b 15 88 29 11 80    	mov    0x80112988,%edx
80102ef1:	83 c0 01             	add    $0x1,%eax
80102ef4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ef7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102efa:	83 fa 1e             	cmp    $0x1e,%edx
80102efd:	7f c9                	jg     80102ec8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102eff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f02:	a3 7c 29 11 80       	mov    %eax,0x8011297c
      release(&log.lock);
80102f07:	68 40 29 11 80       	push   $0x80112940
80102f0c:	e8 1f 19 00 00       	call   80104830 <release>
      break;
    }
  }
}
80102f11:	83 c4 10             	add    $0x10,%esp
80102f14:	c9                   	leave  
80102f15:	c3                   	ret    
80102f16:	8d 76 00             	lea    0x0(%esi),%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	57                   	push   %edi
80102f24:	56                   	push   %esi
80102f25:	53                   	push   %ebx
80102f26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f29:	68 40 29 11 80       	push   $0x80112940
80102f2e:	e8 3d 18 00 00       	call   80104770 <acquire>
  log.outstanding -= 1;
80102f33:	a1 7c 29 11 80       	mov    0x8011297c,%eax
  if(log.committing)
80102f38:	8b 35 80 29 11 80    	mov    0x80112980,%esi
80102f3e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102f41:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102f44:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102f46:	89 1d 7c 29 11 80    	mov    %ebx,0x8011297c
  if(log.committing)
80102f4c:	0f 85 1a 01 00 00    	jne    8010306c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102f52:	85 db                	test   %ebx,%ebx
80102f54:	0f 85 ee 00 00 00    	jne    80103048 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102f5a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102f5d:	c7 05 80 29 11 80 01 	movl   $0x1,0x80112980
80102f64:	00 00 00 
  release(&log.lock);
80102f67:	68 40 29 11 80       	push   $0x80112940
80102f6c:	e8 bf 18 00 00       	call   80104830 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f71:	8b 0d 88 29 11 80    	mov    0x80112988,%ecx
80102f77:	83 c4 10             	add    $0x10,%esp
80102f7a:	85 c9                	test   %ecx,%ecx
80102f7c:	0f 8e 85 00 00 00    	jle    80103007 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f82:	a1 74 29 11 80       	mov    0x80112974,%eax
80102f87:	83 ec 08             	sub    $0x8,%esp
80102f8a:	01 d8                	add    %ebx,%eax
80102f8c:	83 c0 01             	add    $0x1,%eax
80102f8f:	50                   	push   %eax
80102f90:	ff 35 84 29 11 80    	pushl  0x80112984
80102f96:	e8 35 d1 ff ff       	call   801000d0 <bread>
80102f9b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f9d:	58                   	pop    %eax
80102f9e:	5a                   	pop    %edx
80102f9f:	ff 34 9d 8c 29 11 80 	pushl  -0x7feed674(,%ebx,4)
80102fa6:	ff 35 84 29 11 80    	pushl  0x80112984
  for (tail = 0; tail < log.lh.n; tail++) {
80102fac:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102faf:	e8 1c d1 ff ff       	call   801000d0 <bread>
80102fb4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102fb6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102fb9:	83 c4 0c             	add    $0xc,%esp
80102fbc:	68 00 02 00 00       	push   $0x200
80102fc1:	50                   	push   %eax
80102fc2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102fc5:	50                   	push   %eax
80102fc6:	e8 65 19 00 00       	call   80104930 <memmove>
    bwrite(to);  // write the log
80102fcb:	89 34 24             	mov    %esi,(%esp)
80102fce:	e8 cd d1 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102fd3:	89 3c 24             	mov    %edi,(%esp)
80102fd6:	e8 05 d2 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102fdb:	89 34 24             	mov    %esi,(%esp)
80102fde:	e8 fd d1 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102fe3:	83 c4 10             	add    $0x10,%esp
80102fe6:	3b 1d 88 29 11 80    	cmp    0x80112988,%ebx
80102fec:	7c 94                	jl     80102f82 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102fee:	e8 bd fd ff ff       	call   80102db0 <write_head>
    install_trans(); // Now install writes to home locations
80102ff3:	e8 18 fd ff ff       	call   80102d10 <install_trans>
    log.lh.n = 0;
80102ff8:	c7 05 88 29 11 80 00 	movl   $0x0,0x80112988
80102fff:	00 00 00 
    write_head();    // Erase the transaction from the log
80103002:	e8 a9 fd ff ff       	call   80102db0 <write_head>
    acquire(&log.lock);
80103007:	83 ec 0c             	sub    $0xc,%esp
8010300a:	68 40 29 11 80       	push   $0x80112940
8010300f:	e8 5c 17 00 00       	call   80104770 <acquire>
    wakeup(&log);
80103014:	c7 04 24 40 29 11 80 	movl   $0x80112940,(%esp)
    log.committing = 0;
8010301b:	c7 05 80 29 11 80 00 	movl   $0x0,0x80112980
80103022:	00 00 00 
    wakeup(&log);
80103025:	e8 16 12 00 00       	call   80104240 <wakeup>
    release(&log.lock);
8010302a:	c7 04 24 40 29 11 80 	movl   $0x80112940,(%esp)
80103031:	e8 fa 17 00 00       	call   80104830 <release>
80103036:	83 c4 10             	add    $0x10,%esp
}
80103039:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303c:	5b                   	pop    %ebx
8010303d:	5e                   	pop    %esi
8010303e:	5f                   	pop    %edi
8010303f:	5d                   	pop    %ebp
80103040:	c3                   	ret    
80103041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103048:	83 ec 0c             	sub    $0xc,%esp
8010304b:	68 40 29 11 80       	push   $0x80112940
80103050:	e8 eb 11 00 00       	call   80104240 <wakeup>
  release(&log.lock);
80103055:	c7 04 24 40 29 11 80 	movl   $0x80112940,(%esp)
8010305c:	e8 cf 17 00 00       	call   80104830 <release>
80103061:	83 c4 10             	add    $0x10,%esp
}
80103064:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103067:	5b                   	pop    %ebx
80103068:	5e                   	pop    %esi
80103069:	5f                   	pop    %edi
8010306a:	5d                   	pop    %ebp
8010306b:	c3                   	ret    
    panic("log.committing");
8010306c:	83 ec 0c             	sub    $0xc,%esp
8010306f:	68 e4 77 10 80       	push   $0x801077e4
80103074:	e8 17 d3 ff ff       	call   80100390 <panic>
80103079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103080 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103080:	55                   	push   %ebp
80103081:	89 e5                	mov    %esp,%ebp
80103083:	53                   	push   %ebx
80103084:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103087:	8b 15 88 29 11 80    	mov    0x80112988,%edx
{
8010308d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103090:	83 fa 1d             	cmp    $0x1d,%edx
80103093:	0f 8f 9d 00 00 00    	jg     80103136 <log_write+0xb6>
80103099:	a1 78 29 11 80       	mov    0x80112978,%eax
8010309e:	83 e8 01             	sub    $0x1,%eax
801030a1:	39 c2                	cmp    %eax,%edx
801030a3:	0f 8d 8d 00 00 00    	jge    80103136 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
801030a9:	a1 7c 29 11 80       	mov    0x8011297c,%eax
801030ae:	85 c0                	test   %eax,%eax
801030b0:	0f 8e 8d 00 00 00    	jle    80103143 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
801030b6:	83 ec 0c             	sub    $0xc,%esp
801030b9:	68 40 29 11 80       	push   $0x80112940
801030be:	e8 ad 16 00 00       	call   80104770 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801030c3:	8b 0d 88 29 11 80    	mov    0x80112988,%ecx
801030c9:	83 c4 10             	add    $0x10,%esp
801030cc:	83 f9 00             	cmp    $0x0,%ecx
801030cf:	7e 57                	jle    80103128 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030d1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801030d4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030d6:	3b 15 8c 29 11 80    	cmp    0x8011298c,%edx
801030dc:	75 0b                	jne    801030e9 <log_write+0x69>
801030de:	eb 38                	jmp    80103118 <log_write+0x98>
801030e0:	39 14 85 8c 29 11 80 	cmp    %edx,-0x7feed674(,%eax,4)
801030e7:	74 2f                	je     80103118 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801030e9:	83 c0 01             	add    $0x1,%eax
801030ec:	39 c1                	cmp    %eax,%ecx
801030ee:	75 f0                	jne    801030e0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801030f0:	89 14 85 8c 29 11 80 	mov    %edx,-0x7feed674(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801030f7:	83 c0 01             	add    $0x1,%eax
801030fa:	a3 88 29 11 80       	mov    %eax,0x80112988
  b->flags |= B_DIRTY; // prevent eviction
801030ff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103102:	c7 45 08 40 29 11 80 	movl   $0x80112940,0x8(%ebp)
}
80103109:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010310c:	c9                   	leave  
  release(&log.lock);
8010310d:	e9 1e 17 00 00       	jmp    80104830 <release>
80103112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103118:	89 14 85 8c 29 11 80 	mov    %edx,-0x7feed674(,%eax,4)
8010311f:	eb de                	jmp    801030ff <log_write+0x7f>
80103121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103128:	8b 43 08             	mov    0x8(%ebx),%eax
8010312b:	a3 8c 29 11 80       	mov    %eax,0x8011298c
  if (i == log.lh.n)
80103130:	75 cd                	jne    801030ff <log_write+0x7f>
80103132:	31 c0                	xor    %eax,%eax
80103134:	eb c1                	jmp    801030f7 <log_write+0x77>
    panic("too big a transaction");
80103136:	83 ec 0c             	sub    $0xc,%esp
80103139:	68 f3 77 10 80       	push   $0x801077f3
8010313e:	e8 4d d2 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103143:	83 ec 0c             	sub    $0xc,%esp
80103146:	68 09 78 10 80       	push   $0x80107809
8010314b:	e8 40 d2 ff ff       	call   80100390 <panic>

80103150 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103150:	55                   	push   %ebp
80103151:	89 e5                	mov    %esp,%ebp
80103153:	53                   	push   %ebx
80103154:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103157:	e8 74 09 00 00       	call   80103ad0 <cpuid>
8010315c:	89 c3                	mov    %eax,%ebx
8010315e:	e8 6d 09 00 00       	call   80103ad0 <cpuid>
80103163:	83 ec 04             	sub    $0x4,%esp
80103166:	53                   	push   %ebx
80103167:	50                   	push   %eax
80103168:	68 24 78 10 80       	push   $0x80107824
8010316d:	e8 ee d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103172:	e8 d9 29 00 00       	call   80105b50 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103177:	e8 d4 08 00 00       	call   80103a50 <mycpu>
8010317c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010317e:	b8 01 00 00 00       	mov    $0x1,%eax
80103183:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010318a:	e8 21 0c 00 00       	call   80103db0 <scheduler>
8010318f:	90                   	nop

80103190 <mpenter>:
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103196:	e8 a5 3a 00 00       	call   80106c40 <switchkvm>
  seginit();
8010319b:	e8 10 3a 00 00       	call   80106bb0 <seginit>
  lapicinit();
801031a0:	e8 9b f7 ff ff       	call   80102940 <lapicinit>
  mpmain();
801031a5:	e8 a6 ff ff ff       	call   80103150 <mpmain>
801031aa:	66 90                	xchg   %ax,%ax
801031ac:	66 90                	xchg   %ax,%ax
801031ae:	66 90                	xchg   %ax,%ax

801031b0 <main>:
{
801031b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801031b4:	83 e4 f0             	and    $0xfffffff0,%esp
801031b7:	ff 71 fc             	pushl  -0x4(%ecx)
801031ba:	55                   	push   %ebp
801031bb:	89 e5                	mov    %esp,%ebp
801031bd:	53                   	push   %ebx
801031be:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801031bf:	83 ec 08             	sub    $0x8,%esp
801031c2:	68 00 00 40 80       	push   $0x80400000
801031c7:	68 68 57 11 80       	push   $0x80115768
801031cc:	e8 2f f5 ff ff       	call   80102700 <kinit1>
  kvmalloc();      // kernel page table
801031d1:	e8 3a 3f 00 00       	call   80107110 <kvmalloc>
  mpinit();        // detect other processors
801031d6:	e8 75 01 00 00       	call   80103350 <mpinit>
  lapicinit();     // interrupt controller
801031db:	e8 60 f7 ff ff       	call   80102940 <lapicinit>
  seginit();       // segment descriptors
801031e0:	e8 cb 39 00 00       	call   80106bb0 <seginit>
  picinit();       // disable pic
801031e5:	e8 46 03 00 00       	call   80103530 <picinit>
  ioapicinit();    // another interrupt controller
801031ea:	e8 41 f3 ff ff       	call   80102530 <ioapicinit>
  consoleinit();   // console hardware
801031ef:	e8 cc da ff ff       	call   80100cc0 <consoleinit>
  uartinit();      // serial port
801031f4:	e8 87 2c 00 00       	call   80105e80 <uartinit>
  pinit();         // process table
801031f9:	e8 32 08 00 00       	call   80103a30 <pinit>
  tvinit();        // trap vectors
801031fe:	e8 cd 28 00 00       	call   80105ad0 <tvinit>
  binit();         // buffer cache
80103203:	e8 38 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103208:	e8 53 de ff ff       	call   80101060 <fileinit>
  ideinit();       // disk 
8010320d:	e8 fe f0 ff ff       	call   80102310 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103212:	83 c4 0c             	add    $0xc,%esp
80103215:	68 8a 00 00 00       	push   $0x8a
8010321a:	68 8c a4 10 80       	push   $0x8010a48c
8010321f:	68 00 70 00 80       	push   $0x80007000
80103224:	e8 07 17 00 00       	call   80104930 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103229:	69 05 c0 2f 11 80 b0 	imul   $0xb0,0x80112fc0,%eax
80103230:	00 00 00 
80103233:	83 c4 10             	add    $0x10,%esp
80103236:	05 40 2a 11 80       	add    $0x80112a40,%eax
8010323b:	3d 40 2a 11 80       	cmp    $0x80112a40,%eax
80103240:	76 71                	jbe    801032b3 <main+0x103>
80103242:	bb 40 2a 11 80       	mov    $0x80112a40,%ebx
80103247:	89 f6                	mov    %esi,%esi
80103249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103250:	e8 fb 07 00 00       	call   80103a50 <mycpu>
80103255:	39 d8                	cmp    %ebx,%eax
80103257:	74 41                	je     8010329a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103259:	e8 72 f5 ff ff       	call   801027d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010325e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103263:	c7 05 f8 6f 00 80 90 	movl   $0x80103190,0x80006ff8
8010326a:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010326d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103274:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103277:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010327c:	0f b6 03             	movzbl (%ebx),%eax
8010327f:	83 ec 08             	sub    $0x8,%esp
80103282:	68 00 70 00 00       	push   $0x7000
80103287:	50                   	push   %eax
80103288:	e8 03 f8 ff ff       	call   80102a90 <lapicstartap>
8010328d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103290:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103296:	85 c0                	test   %eax,%eax
80103298:	74 f6                	je     80103290 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010329a:	69 05 c0 2f 11 80 b0 	imul   $0xb0,0x80112fc0,%eax
801032a1:	00 00 00 
801032a4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801032aa:	05 40 2a 11 80       	add    $0x80112a40,%eax
801032af:	39 c3                	cmp    %eax,%ebx
801032b1:	72 9d                	jb     80103250 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801032b3:	83 ec 08             	sub    $0x8,%esp
801032b6:	68 00 00 00 8e       	push   $0x8e000000
801032bb:	68 00 00 40 80       	push   $0x80400000
801032c0:	e8 ab f4 ff ff       	call   80102770 <kinit2>
  userinit();      // first user process
801032c5:	e8 56 08 00 00       	call   80103b20 <userinit>
  mpmain();        // finish this processor's setup
801032ca:	e8 81 fe ff ff       	call   80103150 <mpmain>
801032cf:	90                   	nop

801032d0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	57                   	push   %edi
801032d4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801032d5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801032db:	53                   	push   %ebx
  e = addr+len;
801032dc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801032df:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801032e2:	39 de                	cmp    %ebx,%esi
801032e4:	72 10                	jb     801032f6 <mpsearch1+0x26>
801032e6:	eb 50                	jmp    80103338 <mpsearch1+0x68>
801032e8:	90                   	nop
801032e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032f0:	39 fb                	cmp    %edi,%ebx
801032f2:	89 fe                	mov    %edi,%esi
801032f4:	76 42                	jbe    80103338 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801032f6:	83 ec 04             	sub    $0x4,%esp
801032f9:	8d 7e 10             	lea    0x10(%esi),%edi
801032fc:	6a 04                	push   $0x4
801032fe:	68 38 78 10 80       	push   $0x80107838
80103303:	56                   	push   %esi
80103304:	e8 c7 15 00 00       	call   801048d0 <memcmp>
80103309:	83 c4 10             	add    $0x10,%esp
8010330c:	85 c0                	test   %eax,%eax
8010330e:	75 e0                	jne    801032f0 <mpsearch1+0x20>
80103310:	89 f1                	mov    %esi,%ecx
80103312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103318:	0f b6 11             	movzbl (%ecx),%edx
8010331b:	83 c1 01             	add    $0x1,%ecx
8010331e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103320:	39 f9                	cmp    %edi,%ecx
80103322:	75 f4                	jne    80103318 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103324:	84 c0                	test   %al,%al
80103326:	75 c8                	jne    801032f0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103328:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010332b:	89 f0                	mov    %esi,%eax
8010332d:	5b                   	pop    %ebx
8010332e:	5e                   	pop    %esi
8010332f:	5f                   	pop    %edi
80103330:	5d                   	pop    %ebp
80103331:	c3                   	ret    
80103332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103338:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010333b:	31 f6                	xor    %esi,%esi
}
8010333d:	89 f0                	mov    %esi,%eax
8010333f:	5b                   	pop    %ebx
80103340:	5e                   	pop    %esi
80103341:	5f                   	pop    %edi
80103342:	5d                   	pop    %ebp
80103343:	c3                   	ret    
80103344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010334a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103350 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	57                   	push   %edi
80103354:	56                   	push   %esi
80103355:	53                   	push   %ebx
80103356:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103359:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103360:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103367:	c1 e0 08             	shl    $0x8,%eax
8010336a:	09 d0                	or     %edx,%eax
8010336c:	c1 e0 04             	shl    $0x4,%eax
8010336f:	85 c0                	test   %eax,%eax
80103371:	75 1b                	jne    8010338e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103373:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010337a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103381:	c1 e0 08             	shl    $0x8,%eax
80103384:	09 d0                	or     %edx,%eax
80103386:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103389:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010338e:	ba 00 04 00 00       	mov    $0x400,%edx
80103393:	e8 38 ff ff ff       	call   801032d0 <mpsearch1>
80103398:	85 c0                	test   %eax,%eax
8010339a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010339d:	0f 84 3d 01 00 00    	je     801034e0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801033a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801033a6:	8b 58 04             	mov    0x4(%eax),%ebx
801033a9:	85 db                	test   %ebx,%ebx
801033ab:	0f 84 4f 01 00 00    	je     80103500 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801033b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801033b7:	83 ec 04             	sub    $0x4,%esp
801033ba:	6a 04                	push   $0x4
801033bc:	68 55 78 10 80       	push   $0x80107855
801033c1:	56                   	push   %esi
801033c2:	e8 09 15 00 00       	call   801048d0 <memcmp>
801033c7:	83 c4 10             	add    $0x10,%esp
801033ca:	85 c0                	test   %eax,%eax
801033cc:	0f 85 2e 01 00 00    	jne    80103500 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801033d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801033d9:	3c 01                	cmp    $0x1,%al
801033db:	0f 95 c2             	setne  %dl
801033de:	3c 04                	cmp    $0x4,%al
801033e0:	0f 95 c0             	setne  %al
801033e3:	20 c2                	and    %al,%dl
801033e5:	0f 85 15 01 00 00    	jne    80103500 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801033eb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801033f2:	66 85 ff             	test   %di,%di
801033f5:	74 1a                	je     80103411 <mpinit+0xc1>
801033f7:	89 f0                	mov    %esi,%eax
801033f9:	01 f7                	add    %esi,%edi
  sum = 0;
801033fb:	31 d2                	xor    %edx,%edx
801033fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103400:	0f b6 08             	movzbl (%eax),%ecx
80103403:	83 c0 01             	add    $0x1,%eax
80103406:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103408:	39 c7                	cmp    %eax,%edi
8010340a:	75 f4                	jne    80103400 <mpinit+0xb0>
8010340c:	84 d2                	test   %dl,%dl
8010340e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103411:	85 f6                	test   %esi,%esi
80103413:	0f 84 e7 00 00 00    	je     80103500 <mpinit+0x1b0>
80103419:	84 d2                	test   %dl,%dl
8010341b:	0f 85 df 00 00 00    	jne    80103500 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103421:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103427:	a3 3c 29 11 80       	mov    %eax,0x8011293c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010342c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103433:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103439:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010343e:	01 d6                	add    %edx,%esi
80103440:	39 c6                	cmp    %eax,%esi
80103442:	76 23                	jbe    80103467 <mpinit+0x117>
    switch(*p){
80103444:	0f b6 10             	movzbl (%eax),%edx
80103447:	80 fa 04             	cmp    $0x4,%dl
8010344a:	0f 87 ca 00 00 00    	ja     8010351a <mpinit+0x1ca>
80103450:	ff 24 95 7c 78 10 80 	jmp    *-0x7fef8784(,%edx,4)
80103457:	89 f6                	mov    %esi,%esi
80103459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103460:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103463:	39 c6                	cmp    %eax,%esi
80103465:	77 dd                	ja     80103444 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103467:	85 db                	test   %ebx,%ebx
80103469:	0f 84 9e 00 00 00    	je     8010350d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010346f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103472:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103476:	74 15                	je     8010348d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103478:	b8 70 00 00 00       	mov    $0x70,%eax
8010347d:	ba 22 00 00 00       	mov    $0x22,%edx
80103482:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103483:	ba 23 00 00 00       	mov    $0x23,%edx
80103488:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103489:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010348c:	ee                   	out    %al,(%dx)
  }
}
8010348d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103490:	5b                   	pop    %ebx
80103491:	5e                   	pop    %esi
80103492:	5f                   	pop    %edi
80103493:	5d                   	pop    %ebp
80103494:	c3                   	ret    
80103495:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103498:	8b 0d c0 2f 11 80    	mov    0x80112fc0,%ecx
8010349e:	83 f9 07             	cmp    $0x7,%ecx
801034a1:	7f 19                	jg     801034bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801034a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801034a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801034ad:	83 c1 01             	add    $0x1,%ecx
801034b0:	89 0d c0 2f 11 80    	mov    %ecx,0x80112fc0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801034b6:	88 97 40 2a 11 80    	mov    %dl,-0x7feed5c0(%edi)
      p += sizeof(struct mpproc);
801034bc:	83 c0 14             	add    $0x14,%eax
      continue;
801034bf:	e9 7c ff ff ff       	jmp    80103440 <mpinit+0xf0>
801034c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801034c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801034cc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801034cf:	88 15 20 2a 11 80    	mov    %dl,0x80112a20
      continue;
801034d5:	e9 66 ff ff ff       	jmp    80103440 <mpinit+0xf0>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801034e0:	ba 00 00 01 00       	mov    $0x10000,%edx
801034e5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801034ea:	e8 e1 fd ff ff       	call   801032d0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034ef:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801034f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034f4:	0f 85 a9 fe ff ff    	jne    801033a3 <mpinit+0x53>
801034fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103500:	83 ec 0c             	sub    $0xc,%esp
80103503:	68 3d 78 10 80       	push   $0x8010783d
80103508:	e8 83 ce ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010350d:	83 ec 0c             	sub    $0xc,%esp
80103510:	68 5c 78 10 80       	push   $0x8010785c
80103515:	e8 76 ce ff ff       	call   80100390 <panic>
      ismp = 0;
8010351a:	31 db                	xor    %ebx,%ebx
8010351c:	e9 26 ff ff ff       	jmp    80103447 <mpinit+0xf7>
80103521:	66 90                	xchg   %ax,%ax
80103523:	66 90                	xchg   %ax,%ax
80103525:	66 90                	xchg   %ax,%ax
80103527:	66 90                	xchg   %ax,%ax
80103529:	66 90                	xchg   %ax,%ax
8010352b:	66 90                	xchg   %ax,%ax
8010352d:	66 90                	xchg   %ax,%ax
8010352f:	90                   	nop

80103530 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103530:	55                   	push   %ebp
80103531:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103536:	ba 21 00 00 00       	mov    $0x21,%edx
8010353b:	89 e5                	mov    %esp,%ebp
8010353d:	ee                   	out    %al,(%dx)
8010353e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103543:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103544:	5d                   	pop    %ebp
80103545:	c3                   	ret    
80103546:	66 90                	xchg   %ax,%ax
80103548:	66 90                	xchg   %ax,%ax
8010354a:	66 90                	xchg   %ax,%ax
8010354c:	66 90                	xchg   %ax,%ax
8010354e:	66 90                	xchg   %ax,%ax

80103550 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	57                   	push   %edi
80103554:	56                   	push   %esi
80103555:	53                   	push   %ebx
80103556:	83 ec 0c             	sub    $0xc,%esp
80103559:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010355c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010355f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103565:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010356b:	e8 10 db ff ff       	call   80101080 <filealloc>
80103570:	85 c0                	test   %eax,%eax
80103572:	89 03                	mov    %eax,(%ebx)
80103574:	74 22                	je     80103598 <pipealloc+0x48>
80103576:	e8 05 db ff ff       	call   80101080 <filealloc>
8010357b:	85 c0                	test   %eax,%eax
8010357d:	89 06                	mov    %eax,(%esi)
8010357f:	74 3f                	je     801035c0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103581:	e8 4a f2 ff ff       	call   801027d0 <kalloc>
80103586:	85 c0                	test   %eax,%eax
80103588:	89 c7                	mov    %eax,%edi
8010358a:	75 54                	jne    801035e0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010358c:	8b 03                	mov    (%ebx),%eax
8010358e:	85 c0                	test   %eax,%eax
80103590:	75 34                	jne    801035c6 <pipealloc+0x76>
80103592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103598:	8b 06                	mov    (%esi),%eax
8010359a:	85 c0                	test   %eax,%eax
8010359c:	74 0c                	je     801035aa <pipealloc+0x5a>
    fileclose(*f1);
8010359e:	83 ec 0c             	sub    $0xc,%esp
801035a1:	50                   	push   %eax
801035a2:	e8 99 db ff ff       	call   80101140 <fileclose>
801035a7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801035aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801035ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801035b2:	5b                   	pop    %ebx
801035b3:	5e                   	pop    %esi
801035b4:	5f                   	pop    %edi
801035b5:	5d                   	pop    %ebp
801035b6:	c3                   	ret    
801035b7:	89 f6                	mov    %esi,%esi
801035b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801035c0:	8b 03                	mov    (%ebx),%eax
801035c2:	85 c0                	test   %eax,%eax
801035c4:	74 e4                	je     801035aa <pipealloc+0x5a>
    fileclose(*f0);
801035c6:	83 ec 0c             	sub    $0xc,%esp
801035c9:	50                   	push   %eax
801035ca:	e8 71 db ff ff       	call   80101140 <fileclose>
  if(*f1)
801035cf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801035d1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801035d4:	85 c0                	test   %eax,%eax
801035d6:	75 c6                	jne    8010359e <pipealloc+0x4e>
801035d8:	eb d0                	jmp    801035aa <pipealloc+0x5a>
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801035e0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801035e3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801035ea:	00 00 00 
  p->writeopen = 1;
801035ed:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801035f4:	00 00 00 
  p->nwrite = 0;
801035f7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801035fe:	00 00 00 
  p->nread = 0;
80103601:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103608:	00 00 00 
  initlock(&p->lock, "pipe");
8010360b:	68 90 78 10 80       	push   $0x80107890
80103610:	50                   	push   %eax
80103611:	e8 1a 10 00 00       	call   80104630 <initlock>
  (*f0)->type = FD_PIPE;
80103616:	8b 03                	mov    (%ebx),%eax
  return 0;
80103618:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010361b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103621:	8b 03                	mov    (%ebx),%eax
80103623:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103627:	8b 03                	mov    (%ebx),%eax
80103629:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010362d:	8b 03                	mov    (%ebx),%eax
8010362f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103632:	8b 06                	mov    (%esi),%eax
80103634:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010363a:	8b 06                	mov    (%esi),%eax
8010363c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103640:	8b 06                	mov    (%esi),%eax
80103642:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103646:	8b 06                	mov    (%esi),%eax
80103648:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010364b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010364e:	31 c0                	xor    %eax,%eax
}
80103650:	5b                   	pop    %ebx
80103651:	5e                   	pop    %esi
80103652:	5f                   	pop    %edi
80103653:	5d                   	pop    %ebp
80103654:	c3                   	ret    
80103655:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103660 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	56                   	push   %esi
80103664:	53                   	push   %ebx
80103665:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103668:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010366b:	83 ec 0c             	sub    $0xc,%esp
8010366e:	53                   	push   %ebx
8010366f:	e8 fc 10 00 00       	call   80104770 <acquire>
  if(writable){
80103674:	83 c4 10             	add    $0x10,%esp
80103677:	85 f6                	test   %esi,%esi
80103679:	74 45                	je     801036c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010367b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103681:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103684:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010368b:	00 00 00 
    wakeup(&p->nread);
8010368e:	50                   	push   %eax
8010368f:	e8 ac 0b 00 00       	call   80104240 <wakeup>
80103694:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103697:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010369d:	85 d2                	test   %edx,%edx
8010369f:	75 0a                	jne    801036ab <pipeclose+0x4b>
801036a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801036a7:	85 c0                	test   %eax,%eax
801036a9:	74 35                	je     801036e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801036ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801036ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036b1:	5b                   	pop    %ebx
801036b2:	5e                   	pop    %esi
801036b3:	5d                   	pop    %ebp
    release(&p->lock);
801036b4:	e9 77 11 00 00       	jmp    80104830 <release>
801036b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801036c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801036c6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801036c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801036d0:	00 00 00 
    wakeup(&p->nwrite);
801036d3:	50                   	push   %eax
801036d4:	e8 67 0b 00 00       	call   80104240 <wakeup>
801036d9:	83 c4 10             	add    $0x10,%esp
801036dc:	eb b9                	jmp    80103697 <pipeclose+0x37>
801036de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801036e0:	83 ec 0c             	sub    $0xc,%esp
801036e3:	53                   	push   %ebx
801036e4:	e8 47 11 00 00       	call   80104830 <release>
    kfree((char*)p);
801036e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801036ec:	83 c4 10             	add    $0x10,%esp
}
801036ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036f2:	5b                   	pop    %ebx
801036f3:	5e                   	pop    %esi
801036f4:	5d                   	pop    %ebp
    kfree((char*)p);
801036f5:	e9 26 ef ff ff       	jmp    80102620 <kfree>
801036fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103700 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	57                   	push   %edi
80103704:	56                   	push   %esi
80103705:	53                   	push   %ebx
80103706:	83 ec 28             	sub    $0x28,%esp
80103709:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010370c:	53                   	push   %ebx
8010370d:	e8 5e 10 00 00       	call   80104770 <acquire>
  for(i = 0; i < n; i++){
80103712:	8b 45 10             	mov    0x10(%ebp),%eax
80103715:	83 c4 10             	add    $0x10,%esp
80103718:	85 c0                	test   %eax,%eax
8010371a:	0f 8e c9 00 00 00    	jle    801037e9 <pipewrite+0xe9>
80103720:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103723:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103729:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010372f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103732:	03 4d 10             	add    0x10(%ebp),%ecx
80103735:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103738:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010373e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103744:	39 d0                	cmp    %edx,%eax
80103746:	75 71                	jne    801037b9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103748:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010374e:	85 c0                	test   %eax,%eax
80103750:	74 4e                	je     801037a0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103752:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103758:	eb 3a                	jmp    80103794 <pipewrite+0x94>
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103760:	83 ec 0c             	sub    $0xc,%esp
80103763:	57                   	push   %edi
80103764:	e8 d7 0a 00 00       	call   80104240 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103769:	5a                   	pop    %edx
8010376a:	59                   	pop    %ecx
8010376b:	53                   	push   %ebx
8010376c:	56                   	push   %esi
8010376d:	e8 1e 09 00 00       	call   80104090 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103772:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103778:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010377e:	83 c4 10             	add    $0x10,%esp
80103781:	05 00 02 00 00       	add    $0x200,%eax
80103786:	39 c2                	cmp    %eax,%edx
80103788:	75 36                	jne    801037c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010378a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103790:	85 c0                	test   %eax,%eax
80103792:	74 0c                	je     801037a0 <pipewrite+0xa0>
80103794:	e8 57 03 00 00       	call   80103af0 <myproc>
80103799:	8b 40 24             	mov    0x24(%eax),%eax
8010379c:	85 c0                	test   %eax,%eax
8010379e:	74 c0                	je     80103760 <pipewrite+0x60>
        release(&p->lock);
801037a0:	83 ec 0c             	sub    $0xc,%esp
801037a3:	53                   	push   %ebx
801037a4:	e8 87 10 00 00       	call   80104830 <release>
        return -1;
801037a9:	83 c4 10             	add    $0x10,%esp
801037ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801037b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037b4:	5b                   	pop    %ebx
801037b5:	5e                   	pop    %esi
801037b6:	5f                   	pop    %edi
801037b7:	5d                   	pop    %ebp
801037b8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037b9:	89 c2                	mov    %eax,%edx
801037bb:	90                   	nop
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801037c0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801037c3:	8d 42 01             	lea    0x1(%edx),%eax
801037c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801037cc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801037d2:	83 c6 01             	add    $0x1,%esi
801037d5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801037d9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801037dc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801037df:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801037e3:	0f 85 4f ff ff ff    	jne    80103738 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801037e9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801037ef:	83 ec 0c             	sub    $0xc,%esp
801037f2:	50                   	push   %eax
801037f3:	e8 48 0a 00 00       	call   80104240 <wakeup>
  release(&p->lock);
801037f8:	89 1c 24             	mov    %ebx,(%esp)
801037fb:	e8 30 10 00 00       	call   80104830 <release>
  return n;
80103800:	83 c4 10             	add    $0x10,%esp
80103803:	8b 45 10             	mov    0x10(%ebp),%eax
80103806:	eb a9                	jmp    801037b1 <pipewrite+0xb1>
80103808:	90                   	nop
80103809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103810 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	57                   	push   %edi
80103814:	56                   	push   %esi
80103815:	53                   	push   %ebx
80103816:	83 ec 18             	sub    $0x18,%esp
80103819:	8b 75 08             	mov    0x8(%ebp),%esi
8010381c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010381f:	56                   	push   %esi
80103820:	e8 4b 0f 00 00       	call   80104770 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103825:	83 c4 10             	add    $0x10,%esp
80103828:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010382e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103834:	75 6a                	jne    801038a0 <piperead+0x90>
80103836:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010383c:	85 db                	test   %ebx,%ebx
8010383e:	0f 84 c4 00 00 00    	je     80103908 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103844:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010384a:	eb 2d                	jmp    80103879 <piperead+0x69>
8010384c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103850:	83 ec 08             	sub    $0x8,%esp
80103853:	56                   	push   %esi
80103854:	53                   	push   %ebx
80103855:	e8 36 08 00 00       	call   80104090 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010385a:	83 c4 10             	add    $0x10,%esp
8010385d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103863:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103869:	75 35                	jne    801038a0 <piperead+0x90>
8010386b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103871:	85 d2                	test   %edx,%edx
80103873:	0f 84 8f 00 00 00    	je     80103908 <piperead+0xf8>
    if(myproc()->killed){
80103879:	e8 72 02 00 00       	call   80103af0 <myproc>
8010387e:	8b 48 24             	mov    0x24(%eax),%ecx
80103881:	85 c9                	test   %ecx,%ecx
80103883:	74 cb                	je     80103850 <piperead+0x40>
      release(&p->lock);
80103885:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103888:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010388d:	56                   	push   %esi
8010388e:	e8 9d 0f 00 00       	call   80104830 <release>
      return -1;
80103893:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103896:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103899:	89 d8                	mov    %ebx,%eax
8010389b:	5b                   	pop    %ebx
8010389c:	5e                   	pop    %esi
8010389d:	5f                   	pop    %edi
8010389e:	5d                   	pop    %ebp
8010389f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801038a0:	8b 45 10             	mov    0x10(%ebp),%eax
801038a3:	85 c0                	test   %eax,%eax
801038a5:	7e 61                	jle    80103908 <piperead+0xf8>
    if(p->nread == p->nwrite)
801038a7:	31 db                	xor    %ebx,%ebx
801038a9:	eb 13                	jmp    801038be <piperead+0xae>
801038ab:	90                   	nop
801038ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038b0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801038b6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801038bc:	74 1f                	je     801038dd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801038be:	8d 41 01             	lea    0x1(%ecx),%eax
801038c1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801038c7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801038cd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801038d2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801038d5:	83 c3 01             	add    $0x1,%ebx
801038d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801038db:	75 d3                	jne    801038b0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801038dd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801038e3:	83 ec 0c             	sub    $0xc,%esp
801038e6:	50                   	push   %eax
801038e7:	e8 54 09 00 00       	call   80104240 <wakeup>
  release(&p->lock);
801038ec:	89 34 24             	mov    %esi,(%esp)
801038ef:	e8 3c 0f 00 00       	call   80104830 <release>
  return i;
801038f4:	83 c4 10             	add    $0x10,%esp
}
801038f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038fa:	89 d8                	mov    %ebx,%eax
801038fc:	5b                   	pop    %ebx
801038fd:	5e                   	pop    %esi
801038fe:	5f                   	pop    %edi
801038ff:	5d                   	pop    %ebp
80103900:	c3                   	ret    
80103901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103908:	31 db                	xor    %ebx,%ebx
8010390a:	eb d1                	jmp    801038dd <piperead+0xcd>
8010390c:	66 90                	xchg   %ax,%ax
8010390e:	66 90                	xchg   %ax,%ax

80103910 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103914:	bb 14 30 11 80       	mov    $0x80113014,%ebx
{
80103919:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010391c:	68 e0 2f 11 80       	push   $0x80112fe0
80103921:	e8 4a 0e 00 00       	call   80104770 <acquire>
80103926:	83 c4 10             	add    $0x10,%esp
80103929:	eb 10                	jmp    8010393b <allocproc+0x2b>
8010392b:	90                   	nop
8010392c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103930:	83 c3 7c             	add    $0x7c,%ebx
80103933:	81 fb 14 4f 11 80    	cmp    $0x80114f14,%ebx
80103939:	73 75                	jae    801039b0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010393b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010393e:	85 c0                	test   %eax,%eax
80103940:	75 ee                	jne    80103930 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103942:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103947:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010394a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103951:	8d 50 01             	lea    0x1(%eax),%edx
80103954:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103957:	68 e0 2f 11 80       	push   $0x80112fe0
  p->pid = nextpid++;
8010395c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103962:	e8 c9 0e 00 00       	call   80104830 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103967:	e8 64 ee ff ff       	call   801027d0 <kalloc>
8010396c:	83 c4 10             	add    $0x10,%esp
8010396f:	85 c0                	test   %eax,%eax
80103971:	89 43 08             	mov    %eax,0x8(%ebx)
80103974:	74 53                	je     801039c9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103976:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010397c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010397f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103984:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103987:	c7 40 14 c1 5a 10 80 	movl   $0x80105ac1,0x14(%eax)
  p->context = (struct context*)sp;
8010398e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103991:	6a 14                	push   $0x14
80103993:	6a 00                	push   $0x0
80103995:	50                   	push   %eax
80103996:	e8 e5 0e 00 00       	call   80104880 <memset>
  p->context->eip = (uint)forkret;
8010399b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010399e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801039a1:	c7 40 10 e0 39 10 80 	movl   $0x801039e0,0x10(%eax)
}
801039a8:	89 d8                	mov    %ebx,%eax
801039aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ad:	c9                   	leave  
801039ae:	c3                   	ret    
801039af:	90                   	nop
  release(&ptable.lock);
801039b0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801039b3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801039b5:	68 e0 2f 11 80       	push   $0x80112fe0
801039ba:	e8 71 0e 00 00       	call   80104830 <release>
}
801039bf:	89 d8                	mov    %ebx,%eax
  return 0;
801039c1:	83 c4 10             	add    $0x10,%esp
}
801039c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039c7:	c9                   	leave  
801039c8:	c3                   	ret    
    p->state = UNUSED;
801039c9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801039d0:	31 db                	xor    %ebx,%ebx
801039d2:	eb d4                	jmp    801039a8 <allocproc+0x98>
801039d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801039e6:	68 e0 2f 11 80       	push   $0x80112fe0
801039eb:	e8 40 0e 00 00       	call   80104830 <release>

  if (first) {
801039f0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801039f5:	83 c4 10             	add    $0x10,%esp
801039f8:	85 c0                	test   %eax,%eax
801039fa:	75 04                	jne    80103a00 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039fc:	c9                   	leave  
801039fd:	c3                   	ret    
801039fe:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103a00:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103a03:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103a0a:	00 00 00 
    iinit(ROOTDEV);
80103a0d:	6a 01                	push   $0x1
80103a0f:	e8 7c dd ff ff       	call   80101790 <iinit>
    initlog(ROOTDEV);
80103a14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103a1b:	e8 f0 f3 ff ff       	call   80102e10 <initlog>
80103a20:	83 c4 10             	add    $0x10,%esp
}
80103a23:	c9                   	leave  
80103a24:	c3                   	ret    
80103a25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a30 <pinit>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a36:	68 95 78 10 80       	push   $0x80107895
80103a3b:	68 e0 2f 11 80       	push   $0x80112fe0
80103a40:	e8 eb 0b 00 00       	call   80104630 <initlock>
}
80103a45:	83 c4 10             	add    $0x10,%esp
80103a48:	c9                   	leave  
80103a49:	c3                   	ret    
80103a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a50 <mycpu>:
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	56                   	push   %esi
80103a54:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a55:	9c                   	pushf  
80103a56:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a57:	f6 c4 02             	test   $0x2,%ah
80103a5a:	75 5e                	jne    80103aba <mycpu+0x6a>
  apicid = lapicid();
80103a5c:	e8 df ef ff ff       	call   80102a40 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103a61:	8b 35 c0 2f 11 80    	mov    0x80112fc0,%esi
80103a67:	85 f6                	test   %esi,%esi
80103a69:	7e 42                	jle    80103aad <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103a6b:	0f b6 15 40 2a 11 80 	movzbl 0x80112a40,%edx
80103a72:	39 d0                	cmp    %edx,%eax
80103a74:	74 30                	je     80103aa6 <mycpu+0x56>
80103a76:	b9 f0 2a 11 80       	mov    $0x80112af0,%ecx
  for (i = 0; i < ncpu; ++i) {
80103a7b:	31 d2                	xor    %edx,%edx
80103a7d:	8d 76 00             	lea    0x0(%esi),%esi
80103a80:	83 c2 01             	add    $0x1,%edx
80103a83:	39 f2                	cmp    %esi,%edx
80103a85:	74 26                	je     80103aad <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103a87:	0f b6 19             	movzbl (%ecx),%ebx
80103a8a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103a90:	39 c3                	cmp    %eax,%ebx
80103a92:	75 ec                	jne    80103a80 <mycpu+0x30>
80103a94:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103a9a:	05 40 2a 11 80       	add    $0x80112a40,%eax
}
80103a9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa2:	5b                   	pop    %ebx
80103aa3:	5e                   	pop    %esi
80103aa4:	5d                   	pop    %ebp
80103aa5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103aa6:	b8 40 2a 11 80       	mov    $0x80112a40,%eax
      return &cpus[i];
80103aab:	eb f2                	jmp    80103a9f <mycpu+0x4f>
  panic("unknown apicid\n");
80103aad:	83 ec 0c             	sub    $0xc,%esp
80103ab0:	68 9c 78 10 80       	push   $0x8010789c
80103ab5:	e8 d6 c8 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103aba:	83 ec 0c             	sub    $0xc,%esp
80103abd:	68 f4 79 10 80       	push   $0x801079f4
80103ac2:	e8 c9 c8 ff ff       	call   80100390 <panic>
80103ac7:	89 f6                	mov    %esi,%esi
80103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ad0 <cpuid>:
cpuid() {
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103ad6:	e8 75 ff ff ff       	call   80103a50 <mycpu>
80103adb:	2d 40 2a 11 80       	sub    $0x80112a40,%eax
}
80103ae0:	c9                   	leave  
  return mycpu()-cpus;
80103ae1:	c1 f8 04             	sar    $0x4,%eax
80103ae4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103aea:	c3                   	ret    
80103aeb:	90                   	nop
80103aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103af0 <myproc>:
myproc(void) {
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	53                   	push   %ebx
80103af4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103af7:	e8 a4 0b 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103afc:	e8 4f ff ff ff       	call   80103a50 <mycpu>
  p = c->proc;
80103b01:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b07:	e8 d4 0b 00 00       	call   801046e0 <popcli>
}
80103b0c:	83 c4 04             	add    $0x4,%esp
80103b0f:	89 d8                	mov    %ebx,%eax
80103b11:	5b                   	pop    %ebx
80103b12:	5d                   	pop    %ebp
80103b13:	c3                   	ret    
80103b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103b20 <userinit>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	53                   	push   %ebx
80103b24:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103b27:	e8 e4 fd ff ff       	call   80103910 <allocproc>
80103b2c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b2e:	a3 f8 a5 10 80       	mov    %eax,0x8010a5f8
  if((p->pgdir = setupkvm()) == 0)
80103b33:	e8 58 35 00 00       	call   80107090 <setupkvm>
80103b38:	85 c0                	test   %eax,%eax
80103b3a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b3d:	0f 84 bd 00 00 00    	je     80103c00 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b43:	83 ec 04             	sub    $0x4,%esp
80103b46:	68 2c 00 00 00       	push   $0x2c
80103b4b:	68 60 a4 10 80       	push   $0x8010a460
80103b50:	50                   	push   %eax
80103b51:	e8 1a 32 00 00       	call   80106d70 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103b56:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103b59:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b5f:	6a 4c                	push   $0x4c
80103b61:	6a 00                	push   $0x0
80103b63:	ff 73 18             	pushl  0x18(%ebx)
80103b66:	e8 15 0d 00 00       	call   80104880 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b6b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b6e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b73:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b78:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b7b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b7f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b82:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b86:	8b 43 18             	mov    0x18(%ebx),%eax
80103b89:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b8d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b91:	8b 43 18             	mov    0x18(%ebx),%eax
80103b94:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b98:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b9c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b9f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ba6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ba9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103bb0:	8b 43 18             	mov    0x18(%ebx),%eax
80103bb3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bba:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bbd:	6a 10                	push   $0x10
80103bbf:	68 c5 78 10 80       	push   $0x801078c5
80103bc4:	50                   	push   %eax
80103bc5:	e8 96 0e 00 00       	call   80104a60 <safestrcpy>
  p->cwd = namei("/");
80103bca:	c7 04 24 ce 78 10 80 	movl   $0x801078ce,(%esp)
80103bd1:	e8 1a e6 ff ff       	call   801021f0 <namei>
80103bd6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bd9:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
80103be0:	e8 8b 0b 00 00       	call   80104770 <acquire>
  p->state = RUNNABLE;
80103be5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103bec:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
80103bf3:	e8 38 0c 00 00       	call   80104830 <release>
}
80103bf8:	83 c4 10             	add    $0x10,%esp
80103bfb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bfe:	c9                   	leave  
80103bff:	c3                   	ret    
    panic("userinit: out of memory?");
80103c00:	83 ec 0c             	sub    $0xc,%esp
80103c03:	68 ac 78 10 80       	push   $0x801078ac
80103c08:	e8 83 c7 ff ff       	call   80100390 <panic>
80103c0d:	8d 76 00             	lea    0x0(%esi),%esi

80103c10 <growproc>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
80103c15:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c18:	e8 83 0a 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103c1d:	e8 2e fe ff ff       	call   80103a50 <mycpu>
  p = c->proc;
80103c22:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c28:	e8 b3 0a 00 00       	call   801046e0 <popcli>
  if(n > 0){
80103c2d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103c30:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103c32:	7f 1c                	jg     80103c50 <growproc+0x40>
  } else if(n < 0){
80103c34:	75 3a                	jne    80103c70 <growproc+0x60>
  switchuvm(curproc);
80103c36:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103c39:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c3b:	53                   	push   %ebx
80103c3c:	e8 1f 30 00 00       	call   80106c60 <switchuvm>
  return 0;
80103c41:	83 c4 10             	add    $0x10,%esp
80103c44:	31 c0                	xor    %eax,%eax
}
80103c46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c49:	5b                   	pop    %ebx
80103c4a:	5e                   	pop    %esi
80103c4b:	5d                   	pop    %ebp
80103c4c:	c3                   	ret    
80103c4d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c50:	83 ec 04             	sub    $0x4,%esp
80103c53:	01 c6                	add    %eax,%esi
80103c55:	56                   	push   %esi
80103c56:	50                   	push   %eax
80103c57:	ff 73 04             	pushl  0x4(%ebx)
80103c5a:	e8 51 32 00 00       	call   80106eb0 <allocuvm>
80103c5f:	83 c4 10             	add    $0x10,%esp
80103c62:	85 c0                	test   %eax,%eax
80103c64:	75 d0                	jne    80103c36 <growproc+0x26>
      return -1;
80103c66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c6b:	eb d9                	jmp    80103c46 <growproc+0x36>
80103c6d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c70:	83 ec 04             	sub    $0x4,%esp
80103c73:	01 c6                	add    %eax,%esi
80103c75:	56                   	push   %esi
80103c76:	50                   	push   %eax
80103c77:	ff 73 04             	pushl  0x4(%ebx)
80103c7a:	e8 61 33 00 00       	call   80106fe0 <deallocuvm>
80103c7f:	83 c4 10             	add    $0x10,%esp
80103c82:	85 c0                	test   %eax,%eax
80103c84:	75 b0                	jne    80103c36 <growproc+0x26>
80103c86:	eb de                	jmp    80103c66 <growproc+0x56>
80103c88:	90                   	nop
80103c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c90 <fork>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	57                   	push   %edi
80103c94:	56                   	push   %esi
80103c95:	53                   	push   %ebx
80103c96:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c99:	e8 02 0a 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103c9e:	e8 ad fd ff ff       	call   80103a50 <mycpu>
  p = c->proc;
80103ca3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ca9:	e8 32 0a 00 00       	call   801046e0 <popcli>
  if((np = allocproc()) == 0){
80103cae:	e8 5d fc ff ff       	call   80103910 <allocproc>
80103cb3:	85 c0                	test   %eax,%eax
80103cb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103cb8:	0f 84 b7 00 00 00    	je     80103d75 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cbe:	83 ec 08             	sub    $0x8,%esp
80103cc1:	ff 33                	pushl  (%ebx)
80103cc3:	ff 73 04             	pushl  0x4(%ebx)
80103cc6:	89 c7                	mov    %eax,%edi
80103cc8:	e8 93 34 00 00       	call   80107160 <copyuvm>
80103ccd:	83 c4 10             	add    $0x10,%esp
80103cd0:	85 c0                	test   %eax,%eax
80103cd2:	89 47 04             	mov    %eax,0x4(%edi)
80103cd5:	0f 84 a1 00 00 00    	je     80103d7c <fork+0xec>
  np->sz = curproc->sz;
80103cdb:	8b 03                	mov    (%ebx),%eax
80103cdd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ce0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103ce2:	89 59 14             	mov    %ebx,0x14(%ecx)
80103ce5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103ce7:	8b 79 18             	mov    0x18(%ecx),%edi
80103cea:	8b 73 18             	mov    0x18(%ebx),%esi
80103ced:	b9 13 00 00 00       	mov    $0x13,%ecx
80103cf2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103cf4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103cf6:	8b 40 18             	mov    0x18(%eax),%eax
80103cf9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103d00:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d04:	85 c0                	test   %eax,%eax
80103d06:	74 13                	je     80103d1b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d08:	83 ec 0c             	sub    $0xc,%esp
80103d0b:	50                   	push   %eax
80103d0c:	e8 df d3 ff ff       	call   801010f0 <filedup>
80103d11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d14:	83 c4 10             	add    $0x10,%esp
80103d17:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103d1b:	83 c6 01             	add    $0x1,%esi
80103d1e:	83 fe 10             	cmp    $0x10,%esi
80103d21:	75 dd                	jne    80103d00 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103d23:	83 ec 0c             	sub    $0xc,%esp
80103d26:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d29:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103d2c:	e8 2f dc ff ff       	call   80101960 <idup>
80103d31:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d34:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103d37:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d3a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d3d:	6a 10                	push   $0x10
80103d3f:	53                   	push   %ebx
80103d40:	50                   	push   %eax
80103d41:	e8 1a 0d 00 00       	call   80104a60 <safestrcpy>
  pid = np->pid;
80103d46:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103d49:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
80103d50:	e8 1b 0a 00 00       	call   80104770 <acquire>
  np->state = RUNNABLE;
80103d55:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103d5c:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
80103d63:	e8 c8 0a 00 00       	call   80104830 <release>
  return pid;
80103d68:	83 c4 10             	add    $0x10,%esp
}
80103d6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d6e:	89 d8                	mov    %ebx,%eax
80103d70:	5b                   	pop    %ebx
80103d71:	5e                   	pop    %esi
80103d72:	5f                   	pop    %edi
80103d73:	5d                   	pop    %ebp
80103d74:	c3                   	ret    
    return -1;
80103d75:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d7a:	eb ef                	jmp    80103d6b <fork+0xdb>
    kfree(np->kstack);
80103d7c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103d7f:	83 ec 0c             	sub    $0xc,%esp
80103d82:	ff 73 08             	pushl  0x8(%ebx)
80103d85:	e8 96 e8 ff ff       	call   80102620 <kfree>
    np->kstack = 0;
80103d8a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103d91:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103d98:	83 c4 10             	add    $0x10,%esp
80103d9b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103da0:	eb c9                	jmp    80103d6b <fork+0xdb>
80103da2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103db0 <scheduler>:
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	57                   	push   %edi
80103db4:	56                   	push   %esi
80103db5:	53                   	push   %ebx
80103db6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103db9:	e8 92 fc ff ff       	call   80103a50 <mycpu>
80103dbe:	8d 78 04             	lea    0x4(%eax),%edi
80103dc1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103dc3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103dca:	00 00 00 
80103dcd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103dd0:	fb                   	sti    
    acquire(&ptable.lock);
80103dd1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dd4:	bb 14 30 11 80       	mov    $0x80113014,%ebx
    acquire(&ptable.lock);
80103dd9:	68 e0 2f 11 80       	push   $0x80112fe0
80103dde:	e8 8d 09 00 00       	call   80104770 <acquire>
80103de3:	83 c4 10             	add    $0x10,%esp
80103de6:	8d 76 00             	lea    0x0(%esi),%esi
80103de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103df0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103df4:	75 33                	jne    80103e29 <scheduler+0x79>
      switchuvm(p);
80103df6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103df9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103dff:	53                   	push   %ebx
80103e00:	e8 5b 2e 00 00       	call   80106c60 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103e05:	58                   	pop    %eax
80103e06:	5a                   	pop    %edx
80103e07:	ff 73 1c             	pushl  0x1c(%ebx)
80103e0a:	57                   	push   %edi
      p->state = RUNNING;
80103e0b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103e12:	e8 a4 0c 00 00       	call   80104abb <swtch>
      switchkvm();
80103e17:	e8 24 2e 00 00       	call   80106c40 <switchkvm>
      c->proc = 0;
80103e1c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103e23:	00 00 00 
80103e26:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e29:	83 c3 7c             	add    $0x7c,%ebx
80103e2c:	81 fb 14 4f 11 80    	cmp    $0x80114f14,%ebx
80103e32:	72 bc                	jb     80103df0 <scheduler+0x40>
    release(&ptable.lock);
80103e34:	83 ec 0c             	sub    $0xc,%esp
80103e37:	68 e0 2f 11 80       	push   $0x80112fe0
80103e3c:	e8 ef 09 00 00       	call   80104830 <release>
    sti();
80103e41:	83 c4 10             	add    $0x10,%esp
80103e44:	eb 8a                	jmp    80103dd0 <scheduler+0x20>
80103e46:	8d 76 00             	lea    0x0(%esi),%esi
80103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e50 <sched>:
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	56                   	push   %esi
80103e54:	53                   	push   %ebx
  pushcli();
80103e55:	e8 46 08 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103e5a:	e8 f1 fb ff ff       	call   80103a50 <mycpu>
  p = c->proc;
80103e5f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e65:	e8 76 08 00 00       	call   801046e0 <popcli>
  if(!holding(&ptable.lock))
80103e6a:	83 ec 0c             	sub    $0xc,%esp
80103e6d:	68 e0 2f 11 80       	push   $0x80112fe0
80103e72:	e8 c9 08 00 00       	call   80104740 <holding>
80103e77:	83 c4 10             	add    $0x10,%esp
80103e7a:	85 c0                	test   %eax,%eax
80103e7c:	74 4f                	je     80103ecd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103e7e:	e8 cd fb ff ff       	call   80103a50 <mycpu>
80103e83:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e8a:	75 68                	jne    80103ef4 <sched+0xa4>
  if(p->state == RUNNING)
80103e8c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e90:	74 55                	je     80103ee7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e92:	9c                   	pushf  
80103e93:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e94:	f6 c4 02             	test   $0x2,%ah
80103e97:	75 41                	jne    80103eda <sched+0x8a>
  intena = mycpu()->intena;
80103e99:	e8 b2 fb ff ff       	call   80103a50 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e9e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103ea1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103ea7:	e8 a4 fb ff ff       	call   80103a50 <mycpu>
80103eac:	83 ec 08             	sub    $0x8,%esp
80103eaf:	ff 70 04             	pushl  0x4(%eax)
80103eb2:	53                   	push   %ebx
80103eb3:	e8 03 0c 00 00       	call   80104abb <swtch>
  mycpu()->intena = intena;
80103eb8:	e8 93 fb ff ff       	call   80103a50 <mycpu>
}
80103ebd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103ec0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103ec6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ec9:	5b                   	pop    %ebx
80103eca:	5e                   	pop    %esi
80103ecb:	5d                   	pop    %ebp
80103ecc:	c3                   	ret    
    panic("sched ptable.lock");
80103ecd:	83 ec 0c             	sub    $0xc,%esp
80103ed0:	68 d0 78 10 80       	push   $0x801078d0
80103ed5:	e8 b6 c4 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103eda:	83 ec 0c             	sub    $0xc,%esp
80103edd:	68 fc 78 10 80       	push   $0x801078fc
80103ee2:	e8 a9 c4 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ee7:	83 ec 0c             	sub    $0xc,%esp
80103eea:	68 ee 78 10 80       	push   $0x801078ee
80103eef:	e8 9c c4 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103ef4:	83 ec 0c             	sub    $0xc,%esp
80103ef7:	68 e2 78 10 80       	push   $0x801078e2
80103efc:	e8 8f c4 ff ff       	call   80100390 <panic>
80103f01:	eb 0d                	jmp    80103f10 <exit>
80103f03:	90                   	nop
80103f04:	90                   	nop
80103f05:	90                   	nop
80103f06:	90                   	nop
80103f07:	90                   	nop
80103f08:	90                   	nop
80103f09:	90                   	nop
80103f0a:	90                   	nop
80103f0b:	90                   	nop
80103f0c:	90                   	nop
80103f0d:	90                   	nop
80103f0e:	90                   	nop
80103f0f:	90                   	nop

80103f10 <exit>:
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	57                   	push   %edi
80103f14:	56                   	push   %esi
80103f15:	53                   	push   %ebx
80103f16:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103f19:	e8 82 07 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103f1e:	e8 2d fb ff ff       	call   80103a50 <mycpu>
  p = c->proc;
80103f23:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f29:	e8 b2 07 00 00       	call   801046e0 <popcli>
  if(curproc == initproc)
80103f2e:	39 35 f8 a5 10 80    	cmp    %esi,0x8010a5f8
80103f34:	8d 5e 28             	lea    0x28(%esi),%ebx
80103f37:	8d 7e 68             	lea    0x68(%esi),%edi
80103f3a:	0f 84 e7 00 00 00    	je     80104027 <exit+0x117>
    if(curproc->ofile[fd]){
80103f40:	8b 03                	mov    (%ebx),%eax
80103f42:	85 c0                	test   %eax,%eax
80103f44:	74 12                	je     80103f58 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103f46:	83 ec 0c             	sub    $0xc,%esp
80103f49:	50                   	push   %eax
80103f4a:	e8 f1 d1 ff ff       	call   80101140 <fileclose>
      curproc->ofile[fd] = 0;
80103f4f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103f55:	83 c4 10             	add    $0x10,%esp
80103f58:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103f5b:	39 fb                	cmp    %edi,%ebx
80103f5d:	75 e1                	jne    80103f40 <exit+0x30>
  begin_op();
80103f5f:	e8 4c ef ff ff       	call   80102eb0 <begin_op>
  iput(curproc->cwd);
80103f64:	83 ec 0c             	sub    $0xc,%esp
80103f67:	ff 76 68             	pushl  0x68(%esi)
80103f6a:	e8 51 db ff ff       	call   80101ac0 <iput>
  end_op();
80103f6f:	e8 ac ef ff ff       	call   80102f20 <end_op>
  curproc->cwd = 0;
80103f74:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103f7b:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
80103f82:	e8 e9 07 00 00       	call   80104770 <acquire>
  wakeup1(curproc->parent);
80103f87:	8b 56 14             	mov    0x14(%esi),%edx
80103f8a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f8d:	b8 14 30 11 80       	mov    $0x80113014,%eax
80103f92:	eb 0e                	jmp    80103fa2 <exit+0x92>
80103f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f98:	83 c0 7c             	add    $0x7c,%eax
80103f9b:	3d 14 4f 11 80       	cmp    $0x80114f14,%eax
80103fa0:	73 1c                	jae    80103fbe <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103fa2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fa6:	75 f0                	jne    80103f98 <exit+0x88>
80103fa8:	3b 50 20             	cmp    0x20(%eax),%edx
80103fab:	75 eb                	jne    80103f98 <exit+0x88>
      p->state = RUNNABLE;
80103fad:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fb4:	83 c0 7c             	add    $0x7c,%eax
80103fb7:	3d 14 4f 11 80       	cmp    $0x80114f14,%eax
80103fbc:	72 e4                	jb     80103fa2 <exit+0x92>
      p->parent = initproc;
80103fbe:	8b 0d f8 a5 10 80    	mov    0x8010a5f8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc4:	ba 14 30 11 80       	mov    $0x80113014,%edx
80103fc9:	eb 10                	jmp    80103fdb <exit+0xcb>
80103fcb:	90                   	nop
80103fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fd0:	83 c2 7c             	add    $0x7c,%edx
80103fd3:	81 fa 14 4f 11 80    	cmp    $0x80114f14,%edx
80103fd9:	73 33                	jae    8010400e <exit+0xfe>
    if(p->parent == curproc){
80103fdb:	39 72 14             	cmp    %esi,0x14(%edx)
80103fde:	75 f0                	jne    80103fd0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103fe0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103fe4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103fe7:	75 e7                	jne    80103fd0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fe9:	b8 14 30 11 80       	mov    $0x80113014,%eax
80103fee:	eb 0a                	jmp    80103ffa <exit+0xea>
80103ff0:	83 c0 7c             	add    $0x7c,%eax
80103ff3:	3d 14 4f 11 80       	cmp    $0x80114f14,%eax
80103ff8:	73 d6                	jae    80103fd0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103ffa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ffe:	75 f0                	jne    80103ff0 <exit+0xe0>
80104000:	3b 48 20             	cmp    0x20(%eax),%ecx
80104003:	75 eb                	jne    80103ff0 <exit+0xe0>
      p->state = RUNNABLE;
80104005:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010400c:	eb e2                	jmp    80103ff0 <exit+0xe0>
  curproc->state = ZOMBIE;
8010400e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104015:	e8 36 fe ff ff       	call   80103e50 <sched>
  panic("zombie exit");
8010401a:	83 ec 0c             	sub    $0xc,%esp
8010401d:	68 1d 79 10 80       	push   $0x8010791d
80104022:	e8 69 c3 ff ff       	call   80100390 <panic>
    panic("init exiting");
80104027:	83 ec 0c             	sub    $0xc,%esp
8010402a:	68 10 79 10 80       	push   $0x80107910
8010402f:	e8 5c c3 ff ff       	call   80100390 <panic>
80104034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010403a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104040 <yield>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	53                   	push   %ebx
80104044:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104047:	68 e0 2f 11 80       	push   $0x80112fe0
8010404c:	e8 1f 07 00 00       	call   80104770 <acquire>
  pushcli();
80104051:	e8 4a 06 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80104056:	e8 f5 f9 ff ff       	call   80103a50 <mycpu>
  p = c->proc;
8010405b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104061:	e8 7a 06 00 00       	call   801046e0 <popcli>
  myproc()->state = RUNNABLE;
80104066:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010406d:	e8 de fd ff ff       	call   80103e50 <sched>
  release(&ptable.lock);
80104072:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
80104079:	e8 b2 07 00 00       	call   80104830 <release>
}
8010407e:	83 c4 10             	add    $0x10,%esp
80104081:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104084:	c9                   	leave  
80104085:	c3                   	ret    
80104086:	8d 76 00             	lea    0x0(%esi),%esi
80104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104090 <sleep>:
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	57                   	push   %edi
80104094:	56                   	push   %esi
80104095:	53                   	push   %ebx
80104096:	83 ec 0c             	sub    $0xc,%esp
80104099:	8b 7d 08             	mov    0x8(%ebp),%edi
8010409c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010409f:	e8 fc 05 00 00       	call   801046a0 <pushcli>
  c = mycpu();
801040a4:	e8 a7 f9 ff ff       	call   80103a50 <mycpu>
  p = c->proc;
801040a9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040af:	e8 2c 06 00 00       	call   801046e0 <popcli>
  if(p == 0)
801040b4:	85 db                	test   %ebx,%ebx
801040b6:	0f 84 87 00 00 00    	je     80104143 <sleep+0xb3>
  if(lk == 0)
801040bc:	85 f6                	test   %esi,%esi
801040be:	74 76                	je     80104136 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801040c0:	81 fe e0 2f 11 80    	cmp    $0x80112fe0,%esi
801040c6:	74 50                	je     80104118 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801040c8:	83 ec 0c             	sub    $0xc,%esp
801040cb:	68 e0 2f 11 80       	push   $0x80112fe0
801040d0:	e8 9b 06 00 00       	call   80104770 <acquire>
    release(lk);
801040d5:	89 34 24             	mov    %esi,(%esp)
801040d8:	e8 53 07 00 00       	call   80104830 <release>
  p->chan = chan;
801040dd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040e0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040e7:	e8 64 fd ff ff       	call   80103e50 <sched>
  p->chan = 0;
801040ec:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801040f3:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
801040fa:	e8 31 07 00 00       	call   80104830 <release>
    acquire(lk);
801040ff:	89 75 08             	mov    %esi,0x8(%ebp)
80104102:	83 c4 10             	add    $0x10,%esp
}
80104105:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104108:	5b                   	pop    %ebx
80104109:	5e                   	pop    %esi
8010410a:	5f                   	pop    %edi
8010410b:	5d                   	pop    %ebp
    acquire(lk);
8010410c:	e9 5f 06 00 00       	jmp    80104770 <acquire>
80104111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104118:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010411b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104122:	e8 29 fd ff ff       	call   80103e50 <sched>
  p->chan = 0;
80104127:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010412e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104131:	5b                   	pop    %ebx
80104132:	5e                   	pop    %esi
80104133:	5f                   	pop    %edi
80104134:	5d                   	pop    %ebp
80104135:	c3                   	ret    
    panic("sleep without lk");
80104136:	83 ec 0c             	sub    $0xc,%esp
80104139:	68 2f 79 10 80       	push   $0x8010792f
8010413e:	e8 4d c2 ff ff       	call   80100390 <panic>
    panic("sleep");
80104143:	83 ec 0c             	sub    $0xc,%esp
80104146:	68 29 79 10 80       	push   $0x80107929
8010414b:	e8 40 c2 ff ff       	call   80100390 <panic>

80104150 <wait>:
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	56                   	push   %esi
80104154:	53                   	push   %ebx
  pushcli();
80104155:	e8 46 05 00 00       	call   801046a0 <pushcli>
  c = mycpu();
8010415a:	e8 f1 f8 ff ff       	call   80103a50 <mycpu>
  p = c->proc;
8010415f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104165:	e8 76 05 00 00       	call   801046e0 <popcli>
  acquire(&ptable.lock);
8010416a:	83 ec 0c             	sub    $0xc,%esp
8010416d:	68 e0 2f 11 80       	push   $0x80112fe0
80104172:	e8 f9 05 00 00       	call   80104770 <acquire>
80104177:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010417a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010417c:	bb 14 30 11 80       	mov    $0x80113014,%ebx
80104181:	eb 10                	jmp    80104193 <wait+0x43>
80104183:	90                   	nop
80104184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104188:	83 c3 7c             	add    $0x7c,%ebx
8010418b:	81 fb 14 4f 11 80    	cmp    $0x80114f14,%ebx
80104191:	73 1b                	jae    801041ae <wait+0x5e>
      if(p->parent != curproc)
80104193:	39 73 14             	cmp    %esi,0x14(%ebx)
80104196:	75 f0                	jne    80104188 <wait+0x38>
      if(p->state == ZOMBIE){
80104198:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010419c:	74 32                	je     801041d0 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010419e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
801041a1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041a6:	81 fb 14 4f 11 80    	cmp    $0x80114f14,%ebx
801041ac:	72 e5                	jb     80104193 <wait+0x43>
    if(!havekids || curproc->killed){
801041ae:	85 c0                	test   %eax,%eax
801041b0:	74 74                	je     80104226 <wait+0xd6>
801041b2:	8b 46 24             	mov    0x24(%esi),%eax
801041b5:	85 c0                	test   %eax,%eax
801041b7:	75 6d                	jne    80104226 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801041b9:	83 ec 08             	sub    $0x8,%esp
801041bc:	68 e0 2f 11 80       	push   $0x80112fe0
801041c1:	56                   	push   %esi
801041c2:	e8 c9 fe ff ff       	call   80104090 <sleep>
    havekids = 0;
801041c7:	83 c4 10             	add    $0x10,%esp
801041ca:	eb ae                	jmp    8010417a <wait+0x2a>
801041cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801041d0:	83 ec 0c             	sub    $0xc,%esp
801041d3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801041d6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041d9:	e8 42 e4 ff ff       	call   80102620 <kfree>
        freevm(p->pgdir);
801041de:	5a                   	pop    %edx
801041df:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801041e2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801041e9:	e8 22 2e 00 00       	call   80107010 <freevm>
        release(&ptable.lock);
801041ee:	c7 04 24 e0 2f 11 80 	movl   $0x80112fe0,(%esp)
        p->pid = 0;
801041f5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041fc:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104203:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104207:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010420e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104215:	e8 16 06 00 00       	call   80104830 <release>
        return pid;
8010421a:	83 c4 10             	add    $0x10,%esp
}
8010421d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104220:	89 f0                	mov    %esi,%eax
80104222:	5b                   	pop    %ebx
80104223:	5e                   	pop    %esi
80104224:	5d                   	pop    %ebp
80104225:	c3                   	ret    
      release(&ptable.lock);
80104226:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104229:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010422e:	68 e0 2f 11 80       	push   $0x80112fe0
80104233:	e8 f8 05 00 00       	call   80104830 <release>
      return -1;
80104238:	83 c4 10             	add    $0x10,%esp
8010423b:	eb e0                	jmp    8010421d <wait+0xcd>
8010423d:	8d 76 00             	lea    0x0(%esi),%esi

80104240 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
80104244:	83 ec 10             	sub    $0x10,%esp
80104247:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010424a:	68 e0 2f 11 80       	push   $0x80112fe0
8010424f:	e8 1c 05 00 00       	call   80104770 <acquire>
80104254:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104257:	b8 14 30 11 80       	mov    $0x80113014,%eax
8010425c:	eb 0c                	jmp    8010426a <wakeup+0x2a>
8010425e:	66 90                	xchg   %ax,%ax
80104260:	83 c0 7c             	add    $0x7c,%eax
80104263:	3d 14 4f 11 80       	cmp    $0x80114f14,%eax
80104268:	73 1c                	jae    80104286 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010426a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010426e:	75 f0                	jne    80104260 <wakeup+0x20>
80104270:	3b 58 20             	cmp    0x20(%eax),%ebx
80104273:	75 eb                	jne    80104260 <wakeup+0x20>
      p->state = RUNNABLE;
80104275:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010427c:	83 c0 7c             	add    $0x7c,%eax
8010427f:	3d 14 4f 11 80       	cmp    $0x80114f14,%eax
80104284:	72 e4                	jb     8010426a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104286:	c7 45 08 e0 2f 11 80 	movl   $0x80112fe0,0x8(%ebp)
}
8010428d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104290:	c9                   	leave  
  release(&ptable.lock);
80104291:	e9 9a 05 00 00       	jmp    80104830 <release>
80104296:	8d 76 00             	lea    0x0(%esi),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 10             	sub    $0x10,%esp
801042a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801042aa:	68 e0 2f 11 80       	push   $0x80112fe0
801042af:	e8 bc 04 00 00       	call   80104770 <acquire>
801042b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b7:	b8 14 30 11 80       	mov    $0x80113014,%eax
801042bc:	eb 0c                	jmp    801042ca <kill+0x2a>
801042be:	66 90                	xchg   %ax,%ax
801042c0:	83 c0 7c             	add    $0x7c,%eax
801042c3:	3d 14 4f 11 80       	cmp    $0x80114f14,%eax
801042c8:	73 36                	jae    80104300 <kill+0x60>
    if(p->pid == pid){
801042ca:	39 58 10             	cmp    %ebx,0x10(%eax)
801042cd:	75 f1                	jne    801042c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801042cf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801042d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801042da:	75 07                	jne    801042e3 <kill+0x43>
        p->state = RUNNABLE;
801042dc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801042e3:	83 ec 0c             	sub    $0xc,%esp
801042e6:	68 e0 2f 11 80       	push   $0x80112fe0
801042eb:	e8 40 05 00 00       	call   80104830 <release>
      return 0;
801042f0:	83 c4 10             	add    $0x10,%esp
801042f3:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801042f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f8:	c9                   	leave  
801042f9:	c3                   	ret    
801042fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104300:	83 ec 0c             	sub    $0xc,%esp
80104303:	68 e0 2f 11 80       	push   $0x80112fe0
80104308:	e8 23 05 00 00       	call   80104830 <release>
  return -1;
8010430d:	83 c4 10             	add    $0x10,%esp
80104310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104318:	c9                   	leave  
80104319:	c3                   	ret    
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	53                   	push   %ebx
80104326:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104329:	bb 14 30 11 80       	mov    $0x80113014,%ebx
{
8010432e:	83 ec 3c             	sub    $0x3c,%esp
80104331:	eb 24                	jmp    80104357 <procdump+0x37>
80104333:	90                   	nop
80104334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 8b 7d 10 80       	push   $0x80107d8b
80104340:	e8 1b c3 ff ff       	call   80100660 <cprintf>
80104345:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104348:	83 c3 7c             	add    $0x7c,%ebx
8010434b:	81 fb 14 4f 11 80    	cmp    $0x80114f14,%ebx
80104351:	0f 83 81 00 00 00    	jae    801043d8 <procdump+0xb8>
    if(p->state == UNUSED)
80104357:	8b 43 0c             	mov    0xc(%ebx),%eax
8010435a:	85 c0                	test   %eax,%eax
8010435c:	74 ea                	je     80104348 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010435e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104361:	ba 40 79 10 80       	mov    $0x80107940,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104366:	77 11                	ja     80104379 <procdump+0x59>
80104368:	8b 14 85 54 7a 10 80 	mov    -0x7fef85ac(,%eax,4),%edx
      state = "???";
8010436f:	b8 40 79 10 80       	mov    $0x80107940,%eax
80104374:	85 d2                	test   %edx,%edx
80104376:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104379:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010437c:	50                   	push   %eax
8010437d:	52                   	push   %edx
8010437e:	ff 73 10             	pushl  0x10(%ebx)
80104381:	68 44 79 10 80       	push   $0x80107944
80104386:	e8 d5 c2 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010438b:	83 c4 10             	add    $0x10,%esp
8010438e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104392:	75 a4                	jne    80104338 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104394:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104397:	83 ec 08             	sub    $0x8,%esp
8010439a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010439d:	50                   	push   %eax
8010439e:	8b 43 1c             	mov    0x1c(%ebx),%eax
801043a1:	8b 40 0c             	mov    0xc(%eax),%eax
801043a4:	83 c0 08             	add    $0x8,%eax
801043a7:	50                   	push   %eax
801043a8:	e8 a3 02 00 00       	call   80104650 <getcallerpcs>
801043ad:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801043b0:	8b 17                	mov    (%edi),%edx
801043b2:	85 d2                	test   %edx,%edx
801043b4:	74 82                	je     80104338 <procdump+0x18>
        cprintf(" %p", pc[i]);
801043b6:	83 ec 08             	sub    $0x8,%esp
801043b9:	83 c7 04             	add    $0x4,%edi
801043bc:	52                   	push   %edx
801043bd:	68 81 73 10 80       	push   $0x80107381
801043c2:	e8 99 c2 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801043c7:	83 c4 10             	add    $0x10,%esp
801043ca:	39 fe                	cmp    %edi,%esi
801043cc:	75 e2                	jne    801043b0 <procdump+0x90>
801043ce:	e9 65 ff ff ff       	jmp    80104338 <procdump+0x18>
801043d3:	90                   	nop
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
801043d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043db:	5b                   	pop    %ebx
801043dc:	5e                   	pop    %esi
801043dd:	5f                   	pop    %edi
801043de:	5d                   	pop    %ebp
801043df:	c3                   	ret    

801043e0 <printProcess>:

void
printProcess(struct proc* p)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 0c             	sub    $0xc,%esp
801043e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cprintf("name : %s\n", p->name);
801043ea:	8d 43 6c             	lea    0x6c(%ebx),%eax
801043ed:	50                   	push   %eax
801043ee:	68 4d 79 10 80       	push   $0x8010794d
801043f3:	e8 68 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PID : %d\n",p->pid);
801043f8:	58                   	pop    %eax
801043f9:	5a                   	pop    %edx
801043fa:	ff 73 10             	pushl  0x10(%ebx)
801043fd:	68 59 79 10 80       	push   $0x80107959
80104402:	e8 59 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PPID : %d\n",p->parent->pid);
80104407:	59                   	pop    %ecx
80104408:	58                   	pop    %eax
80104409:	8b 43 14             	mov    0x14(%ebx),%eax
8010440c:	ff 70 10             	pushl  0x10(%eax)
8010440f:	68 58 79 10 80       	push   $0x80107958
80104414:	e8 47 c2 ff ff       	call   80100660 <cprintf>
  switch (p->state)
80104419:	83 c4 10             	add    $0x10,%esp
8010441c:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104420:	77 6e                	ja     80104490 <printProcess+0xb0>
80104422:	8b 43 0c             	mov    0xc(%ebx),%eax
80104425:	ff 24 85 3c 7a 10 80 	jmp    *-0x7fef85c4(,%eax,4)
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    case 3:
      cprintf("state : RUNNABLE\n");
      break;
    case 4:
      cprintf("state : RUNNING\n");
80104430:	c7 45 08 a7 79 10 80 	movl   $0x801079a7,0x8(%ebp)
      break;
    case 5:
      cprintf("state : ZOMBIE\n");
      break;
  }
}
80104437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010443a:	c9                   	leave  
      cprintf("state : RUNNING\n");
8010443b:	e9 20 c2 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : ZOMBIE\n");
80104440:	c7 45 08 b8 79 10 80 	movl   $0x801079b8,0x8(%ebp)
}
80104447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010444a:	c9                   	leave  
      cprintf("state : ZOMBIE\n");
8010444b:	e9 10 c2 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : UNUSED\n");
80104450:	c7 45 08 63 79 10 80 	movl   $0x80107963,0x8(%ebp)
}
80104457:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010445a:	c9                   	leave  
      cprintf("state : UNUSED\n");
8010445b:	e9 00 c2 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : EMBRYO\n");
80104460:	c7 45 08 73 79 10 80 	movl   $0x80107973,0x8(%ebp)
}
80104467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010446a:	c9                   	leave  
      cprintf("state : EMBRYO\n");
8010446b:	e9 f0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : SLEEPING\n");
80104470:	c7 45 08 83 79 10 80 	movl   $0x80107983,0x8(%ebp)
}
80104477:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010447a:	c9                   	leave  
      cprintf("state : SLEEPING\n");
8010447b:	e9 e0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : RUNNABLE\n");
80104480:	c7 45 08 95 79 10 80 	movl   $0x80107995,0x8(%ebp)
}
80104487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010448a:	c9                   	leave  
      cprintf("state : RUNNABLE\n");
8010448b:	e9 d0 c1 ff ff       	jmp    80100660 <cprintf>
}
80104490:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104493:	c9                   	leave  
80104494:	c3                   	ret    
80104495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044a0 <getprocs>:

int
getprocs(void)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
  struct proc* p;
  cprintf("\n-----------------------------\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044a4:	bb 14 30 11 80       	mov    $0x80113014,%ebx
{
801044a9:	83 ec 10             	sub    $0x10,%esp
  cprintf("\n-----------------------------\n");
801044ac:	68 1c 7a 10 80       	push   $0x80107a1c
801044b1:	e8 aa c1 ff ff       	call   80100660 <cprintf>
801044b6:	83 c4 10             	add    $0x10,%esp
801044b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  { if (p->pid == 0)
801044c0:	8b 43 10             	mov    0x10(%ebx),%eax
801044c3:	85 c0                	test   %eax,%eax
801044c5:	74 18                	je     801044df <getprocs+0x3f>
        continue;    
    printProcess(p);
801044c7:	83 ec 0c             	sub    $0xc,%esp
801044ca:	53                   	push   %ebx
801044cb:	e8 10 ff ff ff       	call   801043e0 <printProcess>
    cprintf("\n-----------------------------\n");
801044d0:	c7 04 24 1c 7a 10 80 	movl   $0x80107a1c,(%esp)
801044d7:	e8 84 c1 ff ff       	call   80100660 <cprintf>
801044dc:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044df:	83 c3 7c             	add    $0x7c,%ebx
801044e2:	81 fb 14 4f 11 80    	cmp    $0x80114f14,%ebx
801044e8:	72 d6                	jb     801044c0 <getprocs+0x20>
  }
  return 23;
801044ea:	b8 17 00 00 00       	mov    $0x17,%eax
801044ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044f2:	c9                   	leave  
801044f3:	c3                   	ret    
801044f4:	66 90                	xchg   %ax,%ax
801044f6:	66 90                	xchg   %ax,%ax
801044f8:	66 90                	xchg   %ax,%ax
801044fa:	66 90                	xchg   %ax,%ax
801044fc:	66 90                	xchg   %ax,%ax
801044fe:	66 90                	xchg   %ax,%ax

80104500 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 0c             	sub    $0xc,%esp
80104507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010450a:	68 6c 7a 10 80       	push   $0x80107a6c
8010450f:	8d 43 04             	lea    0x4(%ebx),%eax
80104512:	50                   	push   %eax
80104513:	e8 18 01 00 00       	call   80104630 <initlock>
  lk->name = name;
80104518:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010451b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104521:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104524:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010452b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010452e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104531:	c9                   	leave  
80104532:	c3                   	ret    
80104533:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104548:	83 ec 0c             	sub    $0xc,%esp
8010454b:	8d 73 04             	lea    0x4(%ebx),%esi
8010454e:	56                   	push   %esi
8010454f:	e8 1c 02 00 00       	call   80104770 <acquire>
  while (lk->locked) {
80104554:	8b 13                	mov    (%ebx),%edx
80104556:	83 c4 10             	add    $0x10,%esp
80104559:	85 d2                	test   %edx,%edx
8010455b:	74 16                	je     80104573 <acquiresleep+0x33>
8010455d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104560:	83 ec 08             	sub    $0x8,%esp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
80104565:	e8 26 fb ff ff       	call   80104090 <sleep>
  while (lk->locked) {
8010456a:	8b 03                	mov    (%ebx),%eax
8010456c:	83 c4 10             	add    $0x10,%esp
8010456f:	85 c0                	test   %eax,%eax
80104571:	75 ed                	jne    80104560 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104573:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104579:	e8 72 f5 ff ff       	call   80103af0 <myproc>
8010457e:	8b 40 10             	mov    0x10(%eax),%eax
80104581:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104584:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104587:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010458a:	5b                   	pop    %ebx
8010458b:	5e                   	pop    %esi
8010458c:	5d                   	pop    %ebp
  release(&lk->lk);
8010458d:	e9 9e 02 00 00       	jmp    80104830 <release>
80104592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045a0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	56                   	push   %esi
801045a4:	53                   	push   %ebx
801045a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045a8:	83 ec 0c             	sub    $0xc,%esp
801045ab:	8d 73 04             	lea    0x4(%ebx),%esi
801045ae:	56                   	push   %esi
801045af:	e8 bc 01 00 00       	call   80104770 <acquire>
  lk->locked = 0;
801045b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801045ba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801045c1:	89 1c 24             	mov    %ebx,(%esp)
801045c4:	e8 77 fc ff ff       	call   80104240 <wakeup>
  release(&lk->lk);
801045c9:	89 75 08             	mov    %esi,0x8(%ebp)
801045cc:	83 c4 10             	add    $0x10,%esp
}
801045cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d2:	5b                   	pop    %ebx
801045d3:	5e                   	pop    %esi
801045d4:	5d                   	pop    %ebp
  release(&lk->lk);
801045d5:	e9 56 02 00 00       	jmp    80104830 <release>
801045da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045e0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	56                   	push   %esi
801045e5:	53                   	push   %ebx
801045e6:	31 ff                	xor    %edi,%edi
801045e8:	83 ec 18             	sub    $0x18,%esp
801045eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801045ee:	8d 73 04             	lea    0x4(%ebx),%esi
801045f1:	56                   	push   %esi
801045f2:	e8 79 01 00 00       	call   80104770 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801045f7:	8b 03                	mov    (%ebx),%eax
801045f9:	83 c4 10             	add    $0x10,%esp
801045fc:	85 c0                	test   %eax,%eax
801045fe:	74 13                	je     80104613 <holdingsleep+0x33>
80104600:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104603:	e8 e8 f4 ff ff       	call   80103af0 <myproc>
80104608:	39 58 10             	cmp    %ebx,0x10(%eax)
8010460b:	0f 94 c0             	sete   %al
8010460e:	0f b6 c0             	movzbl %al,%eax
80104611:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104613:	83 ec 0c             	sub    $0xc,%esp
80104616:	56                   	push   %esi
80104617:	e8 14 02 00 00       	call   80104830 <release>
  return r;
}
8010461c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010461f:	89 f8                	mov    %edi,%eax
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5f                   	pop    %edi
80104624:	5d                   	pop    %ebp
80104625:	c3                   	ret    
80104626:	66 90                	xchg   %ax,%ax
80104628:	66 90                	xchg   %ax,%ax
8010462a:	66 90                	xchg   %ax,%ax
8010462c:	66 90                	xchg   %ax,%ax
8010462e:	66 90                	xchg   %ax,%ax

80104630 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104636:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104639:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010463f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104642:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104649:	5d                   	pop    %ebp
8010464a:	c3                   	ret    
8010464b:	90                   	nop
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104650 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104650:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104651:	31 d2                	xor    %edx,%edx
{
80104653:	89 e5                	mov    %esp,%ebp
80104655:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104656:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104659:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010465c:	83 e8 08             	sub    $0x8,%eax
8010465f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104660:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104666:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010466c:	77 1a                	ja     80104688 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010466e:	8b 58 04             	mov    0x4(%eax),%ebx
80104671:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104674:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104677:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104679:	83 fa 0a             	cmp    $0xa,%edx
8010467c:	75 e2                	jne    80104660 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010467e:	5b                   	pop    %ebx
8010467f:	5d                   	pop    %ebp
80104680:	c3                   	ret    
80104681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104688:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010468b:	83 c1 28             	add    $0x28,%ecx
8010468e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104690:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104696:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104699:	39 c1                	cmp    %eax,%ecx
8010469b:	75 f3                	jne    80104690 <getcallerpcs+0x40>
}
8010469d:	5b                   	pop    %ebx
8010469e:	5d                   	pop    %ebp
8010469f:	c3                   	ret    

801046a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 04             	sub    $0x4,%esp
801046a7:	9c                   	pushf  
801046a8:	5b                   	pop    %ebx
  asm volatile("cli");
801046a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801046aa:	e8 a1 f3 ff ff       	call   80103a50 <mycpu>
801046af:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801046b5:	85 c0                	test   %eax,%eax
801046b7:	75 11                	jne    801046ca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801046b9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801046bf:	e8 8c f3 ff ff       	call   80103a50 <mycpu>
801046c4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801046ca:	e8 81 f3 ff ff       	call   80103a50 <mycpu>
801046cf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801046d6:	83 c4 04             	add    $0x4,%esp
801046d9:	5b                   	pop    %ebx
801046da:	5d                   	pop    %ebp
801046db:	c3                   	ret    
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <popcli>:

void
popcli(void)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046e6:	9c                   	pushf  
801046e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046e8:	f6 c4 02             	test   $0x2,%ah
801046eb:	75 35                	jne    80104722 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801046ed:	e8 5e f3 ff ff       	call   80103a50 <mycpu>
801046f2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801046f9:	78 34                	js     8010472f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046fb:	e8 50 f3 ff ff       	call   80103a50 <mycpu>
80104700:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104706:	85 d2                	test   %edx,%edx
80104708:	74 06                	je     80104710 <popcli+0x30>
    sti();
}
8010470a:	c9                   	leave  
8010470b:	c3                   	ret    
8010470c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104710:	e8 3b f3 ff ff       	call   80103a50 <mycpu>
80104715:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010471b:	85 c0                	test   %eax,%eax
8010471d:	74 eb                	je     8010470a <popcli+0x2a>
  asm volatile("sti");
8010471f:	fb                   	sti    
}
80104720:	c9                   	leave  
80104721:	c3                   	ret    
    panic("popcli - interruptible");
80104722:	83 ec 0c             	sub    $0xc,%esp
80104725:	68 77 7a 10 80       	push   $0x80107a77
8010472a:	e8 61 bc ff ff       	call   80100390 <panic>
    panic("popcli");
8010472f:	83 ec 0c             	sub    $0xc,%esp
80104732:	68 8e 7a 10 80       	push   $0x80107a8e
80104737:	e8 54 bc ff ff       	call   80100390 <panic>
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <holding>:
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	8b 75 08             	mov    0x8(%ebp),%esi
80104748:	31 db                	xor    %ebx,%ebx
  pushcli();
8010474a:	e8 51 ff ff ff       	call   801046a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010474f:	8b 06                	mov    (%esi),%eax
80104751:	85 c0                	test   %eax,%eax
80104753:	74 10                	je     80104765 <holding+0x25>
80104755:	8b 5e 08             	mov    0x8(%esi),%ebx
80104758:	e8 f3 f2 ff ff       	call   80103a50 <mycpu>
8010475d:	39 c3                	cmp    %eax,%ebx
8010475f:	0f 94 c3             	sete   %bl
80104762:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104765:	e8 76 ff ff ff       	call   801046e0 <popcli>
}
8010476a:	89 d8                	mov    %ebx,%eax
8010476c:	5b                   	pop    %ebx
8010476d:	5e                   	pop    %esi
8010476e:	5d                   	pop    %ebp
8010476f:	c3                   	ret    

80104770 <acquire>:
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	56                   	push   %esi
80104774:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104775:	e8 26 ff ff ff       	call   801046a0 <pushcli>
  if(holding(lk))
8010477a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010477d:	83 ec 0c             	sub    $0xc,%esp
80104780:	53                   	push   %ebx
80104781:	e8 ba ff ff ff       	call   80104740 <holding>
80104786:	83 c4 10             	add    $0x10,%esp
80104789:	85 c0                	test   %eax,%eax
8010478b:	0f 85 83 00 00 00    	jne    80104814 <acquire+0xa4>
80104791:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104793:	ba 01 00 00 00       	mov    $0x1,%edx
80104798:	eb 09                	jmp    801047a3 <acquire+0x33>
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047a3:	89 d0                	mov    %edx,%eax
801047a5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801047a8:	85 c0                	test   %eax,%eax
801047aa:	75 f4                	jne    801047a0 <acquire+0x30>
  __sync_synchronize();
801047ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801047b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047b4:	e8 97 f2 ff ff       	call   80103a50 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801047b9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801047bc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801047bf:	89 e8                	mov    %ebp,%eax
801047c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047c8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801047ce:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801047d4:	77 1a                	ja     801047f0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801047d6:	8b 48 04             	mov    0x4(%eax),%ecx
801047d9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801047dc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801047df:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801047e1:	83 fe 0a             	cmp    $0xa,%esi
801047e4:	75 e2                	jne    801047c8 <acquire+0x58>
}
801047e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047e9:	5b                   	pop    %ebx
801047ea:	5e                   	pop    %esi
801047eb:	5d                   	pop    %ebp
801047ec:	c3                   	ret    
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
801047f0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801047f3:	83 c2 28             	add    $0x28,%edx
801047f6:	8d 76 00             	lea    0x0(%esi),%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104800:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104806:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104809:	39 d0                	cmp    %edx,%eax
8010480b:	75 f3                	jne    80104800 <acquire+0x90>
}
8010480d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104810:	5b                   	pop    %ebx
80104811:	5e                   	pop    %esi
80104812:	5d                   	pop    %ebp
80104813:	c3                   	ret    
    panic("acquire");
80104814:	83 ec 0c             	sub    $0xc,%esp
80104817:	68 95 7a 10 80       	push   $0x80107a95
8010481c:	e8 6f bb ff ff       	call   80100390 <panic>
80104821:	eb 0d                	jmp    80104830 <release>
80104823:	90                   	nop
80104824:	90                   	nop
80104825:	90                   	nop
80104826:	90                   	nop
80104827:	90                   	nop
80104828:	90                   	nop
80104829:	90                   	nop
8010482a:	90                   	nop
8010482b:	90                   	nop
8010482c:	90                   	nop
8010482d:	90                   	nop
8010482e:	90                   	nop
8010482f:	90                   	nop

80104830 <release>:
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 10             	sub    $0x10,%esp
80104837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010483a:	53                   	push   %ebx
8010483b:	e8 00 ff ff ff       	call   80104740 <holding>
80104840:	83 c4 10             	add    $0x10,%esp
80104843:	85 c0                	test   %eax,%eax
80104845:	74 22                	je     80104869 <release+0x39>
  lk->pcs[0] = 0;
80104847:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010484e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104855:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010485a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104860:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104863:	c9                   	leave  
  popcli();
80104864:	e9 77 fe ff ff       	jmp    801046e0 <popcli>
    panic("release");
80104869:	83 ec 0c             	sub    $0xc,%esp
8010486c:	68 9d 7a 10 80       	push   $0x80107a9d
80104871:	e8 1a bb ff ff       	call   80100390 <panic>
80104876:	66 90                	xchg   %ax,%ax
80104878:	66 90                	xchg   %ax,%ax
8010487a:	66 90                	xchg   %ax,%ax
8010487c:	66 90                	xchg   %ax,%ax
8010487e:	66 90                	xchg   %ax,%ax

80104880 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	57                   	push   %edi
80104884:	53                   	push   %ebx
80104885:	8b 55 08             	mov    0x8(%ebp),%edx
80104888:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010488b:	f6 c2 03             	test   $0x3,%dl
8010488e:	75 05                	jne    80104895 <memset+0x15>
80104890:	f6 c1 03             	test   $0x3,%cl
80104893:	74 13                	je     801048a8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104895:	89 d7                	mov    %edx,%edi
80104897:	8b 45 0c             	mov    0xc(%ebp),%eax
8010489a:	fc                   	cld    
8010489b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010489d:	5b                   	pop    %ebx
8010489e:	89 d0                	mov    %edx,%eax
801048a0:	5f                   	pop    %edi
801048a1:	5d                   	pop    %ebp
801048a2:	c3                   	ret    
801048a3:	90                   	nop
801048a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801048a8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801048ac:	c1 e9 02             	shr    $0x2,%ecx
801048af:	89 f8                	mov    %edi,%eax
801048b1:	89 fb                	mov    %edi,%ebx
801048b3:	c1 e0 18             	shl    $0x18,%eax
801048b6:	c1 e3 10             	shl    $0x10,%ebx
801048b9:	09 d8                	or     %ebx,%eax
801048bb:	09 f8                	or     %edi,%eax
801048bd:	c1 e7 08             	shl    $0x8,%edi
801048c0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801048c2:	89 d7                	mov    %edx,%edi
801048c4:	fc                   	cld    
801048c5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801048c7:	5b                   	pop    %ebx
801048c8:	89 d0                	mov    %edx,%eax
801048ca:	5f                   	pop    %edi
801048cb:	5d                   	pop    %ebp
801048cc:	c3                   	ret    
801048cd:	8d 76 00             	lea    0x0(%esi),%esi

801048d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	57                   	push   %edi
801048d4:	56                   	push   %esi
801048d5:	53                   	push   %ebx
801048d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801048d9:	8b 75 08             	mov    0x8(%ebp),%esi
801048dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801048df:	85 db                	test   %ebx,%ebx
801048e1:	74 29                	je     8010490c <memcmp+0x3c>
    if(*s1 != *s2)
801048e3:	0f b6 16             	movzbl (%esi),%edx
801048e6:	0f b6 0f             	movzbl (%edi),%ecx
801048e9:	38 d1                	cmp    %dl,%cl
801048eb:	75 2b                	jne    80104918 <memcmp+0x48>
801048ed:	b8 01 00 00 00       	mov    $0x1,%eax
801048f2:	eb 14                	jmp    80104908 <memcmp+0x38>
801048f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048f8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801048fc:	83 c0 01             	add    $0x1,%eax
801048ff:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104904:	38 ca                	cmp    %cl,%dl
80104906:	75 10                	jne    80104918 <memcmp+0x48>
  while(n-- > 0){
80104908:	39 d8                	cmp    %ebx,%eax
8010490a:	75 ec                	jne    801048f8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010490c:	5b                   	pop    %ebx
  return 0;
8010490d:	31 c0                	xor    %eax,%eax
}
8010490f:	5e                   	pop    %esi
80104910:	5f                   	pop    %edi
80104911:	5d                   	pop    %ebp
80104912:	c3                   	ret    
80104913:	90                   	nop
80104914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104918:	0f b6 c2             	movzbl %dl,%eax
}
8010491b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010491c:	29 c8                	sub    %ecx,%eax
}
8010491e:	5e                   	pop    %esi
8010491f:	5f                   	pop    %edi
80104920:	5d                   	pop    %ebp
80104921:	c3                   	ret    
80104922:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	8b 45 08             	mov    0x8(%ebp),%eax
80104938:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010493b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010493e:	39 c3                	cmp    %eax,%ebx
80104940:	73 26                	jae    80104968 <memmove+0x38>
80104942:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104945:	39 c8                	cmp    %ecx,%eax
80104947:	73 1f                	jae    80104968 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104949:	85 f6                	test   %esi,%esi
8010494b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010494e:	74 0f                	je     8010495f <memmove+0x2f>
      *--d = *--s;
80104950:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104954:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104957:	83 ea 01             	sub    $0x1,%edx
8010495a:	83 fa ff             	cmp    $0xffffffff,%edx
8010495d:	75 f1                	jne    80104950 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010495f:	5b                   	pop    %ebx
80104960:	5e                   	pop    %esi
80104961:	5d                   	pop    %ebp
80104962:	c3                   	ret    
80104963:	90                   	nop
80104964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104968:	31 d2                	xor    %edx,%edx
8010496a:	85 f6                	test   %esi,%esi
8010496c:	74 f1                	je     8010495f <memmove+0x2f>
8010496e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104970:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104974:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104977:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010497a:	39 d6                	cmp    %edx,%esi
8010497c:	75 f2                	jne    80104970 <memmove+0x40>
}
8010497e:	5b                   	pop    %ebx
8010497f:	5e                   	pop    %esi
80104980:	5d                   	pop    %ebp
80104981:	c3                   	ret    
80104982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104993:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104994:	eb 9a                	jmp    80104930 <memmove>
80104996:	8d 76 00             	lea    0x0(%esi),%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049a0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	57                   	push   %edi
801049a4:	56                   	push   %esi
801049a5:	8b 7d 10             	mov    0x10(%ebp),%edi
801049a8:	53                   	push   %ebx
801049a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801049ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801049af:	85 ff                	test   %edi,%edi
801049b1:	74 2f                	je     801049e2 <strncmp+0x42>
801049b3:	0f b6 01             	movzbl (%ecx),%eax
801049b6:	0f b6 1e             	movzbl (%esi),%ebx
801049b9:	84 c0                	test   %al,%al
801049bb:	74 37                	je     801049f4 <strncmp+0x54>
801049bd:	38 c3                	cmp    %al,%bl
801049bf:	75 33                	jne    801049f4 <strncmp+0x54>
801049c1:	01 f7                	add    %esi,%edi
801049c3:	eb 13                	jmp    801049d8 <strncmp+0x38>
801049c5:	8d 76 00             	lea    0x0(%esi),%esi
801049c8:	0f b6 01             	movzbl (%ecx),%eax
801049cb:	84 c0                	test   %al,%al
801049cd:	74 21                	je     801049f0 <strncmp+0x50>
801049cf:	0f b6 1a             	movzbl (%edx),%ebx
801049d2:	89 d6                	mov    %edx,%esi
801049d4:	38 d8                	cmp    %bl,%al
801049d6:	75 1c                	jne    801049f4 <strncmp+0x54>
    n--, p++, q++;
801049d8:	8d 56 01             	lea    0x1(%esi),%edx
801049db:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801049de:	39 fa                	cmp    %edi,%edx
801049e0:	75 e6                	jne    801049c8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801049e2:	5b                   	pop    %ebx
    return 0;
801049e3:	31 c0                	xor    %eax,%eax
}
801049e5:	5e                   	pop    %esi
801049e6:	5f                   	pop    %edi
801049e7:	5d                   	pop    %ebp
801049e8:	c3                   	ret    
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049f0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801049f4:	29 d8                	sub    %ebx,%eax
}
801049f6:	5b                   	pop    %ebx
801049f7:	5e                   	pop    %esi
801049f8:	5f                   	pop    %edi
801049f9:	5d                   	pop    %ebp
801049fa:	c3                   	ret    
801049fb:	90                   	nop
801049fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a00 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
80104a05:	8b 45 08             	mov    0x8(%ebp),%eax
80104a08:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104a0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104a0e:	89 c2                	mov    %eax,%edx
80104a10:	eb 19                	jmp    80104a2b <strncpy+0x2b>
80104a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a18:	83 c3 01             	add    $0x1,%ebx
80104a1b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104a1f:	83 c2 01             	add    $0x1,%edx
80104a22:	84 c9                	test   %cl,%cl
80104a24:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a27:	74 09                	je     80104a32 <strncpy+0x32>
80104a29:	89 f1                	mov    %esi,%ecx
80104a2b:	85 c9                	test   %ecx,%ecx
80104a2d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104a30:	7f e6                	jg     80104a18 <strncpy+0x18>
    ;
  while(n-- > 0)
80104a32:	31 c9                	xor    %ecx,%ecx
80104a34:	85 f6                	test   %esi,%esi
80104a36:	7e 17                	jle    80104a4f <strncpy+0x4f>
80104a38:	90                   	nop
80104a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104a40:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104a44:	89 f3                	mov    %esi,%ebx
80104a46:	83 c1 01             	add    $0x1,%ecx
80104a49:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104a4b:	85 db                	test   %ebx,%ebx
80104a4d:	7f f1                	jg     80104a40 <strncpy+0x40>
  return os;
}
80104a4f:	5b                   	pop    %ebx
80104a50:	5e                   	pop    %esi
80104a51:	5d                   	pop    %ebp
80104a52:	c3                   	ret    
80104a53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
80104a65:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a68:	8b 45 08             	mov    0x8(%ebp),%eax
80104a6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104a6e:	85 c9                	test   %ecx,%ecx
80104a70:	7e 26                	jle    80104a98 <safestrcpy+0x38>
80104a72:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104a76:	89 c1                	mov    %eax,%ecx
80104a78:	eb 17                	jmp    80104a91 <safestrcpy+0x31>
80104a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a80:	83 c2 01             	add    $0x1,%edx
80104a83:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104a87:	83 c1 01             	add    $0x1,%ecx
80104a8a:	84 db                	test   %bl,%bl
80104a8c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104a8f:	74 04                	je     80104a95 <safestrcpy+0x35>
80104a91:	39 f2                	cmp    %esi,%edx
80104a93:	75 eb                	jne    80104a80 <safestrcpy+0x20>
    ;
  *s = 0;
80104a95:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104a98:	5b                   	pop    %ebx
80104a99:	5e                   	pop    %esi
80104a9a:	5d                   	pop    %ebp
80104a9b:	c3                   	ret    
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104aa0 <strlen>:

int
strlen(const char *s)
{
80104aa0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104aa1:	31 c0                	xor    %eax,%eax
{
80104aa3:	89 e5                	mov    %esp,%ebp
80104aa5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104aa8:	80 3a 00             	cmpb   $0x0,(%edx)
80104aab:	74 0c                	je     80104ab9 <strlen+0x19>
80104aad:	8d 76 00             	lea    0x0(%esi),%esi
80104ab0:	83 c0 01             	add    $0x1,%eax
80104ab3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104ab7:	75 f7                	jne    80104ab0 <strlen+0x10>
    ;
  return n;
}
80104ab9:	5d                   	pop    %ebp
80104aba:	c3                   	ret    

80104abb <swtch>:
80104abb:	8b 44 24 04          	mov    0x4(%esp),%eax
80104abf:	8b 54 24 08          	mov    0x8(%esp),%edx
80104ac3:	55                   	push   %ebp
80104ac4:	53                   	push   %ebx
80104ac5:	56                   	push   %esi
80104ac6:	57                   	push   %edi
80104ac7:	89 20                	mov    %esp,(%eax)
80104ac9:	89 d4                	mov    %edx,%esp
80104acb:	5f                   	pop    %edi
80104acc:	5e                   	pop    %esi
80104acd:	5b                   	pop    %ebx
80104ace:	5d                   	pop    %ebp
80104acf:	c3                   	ret    

80104ad0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 04             	sub    $0x4,%esp
80104ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104ada:	e8 11 f0 ff ff       	call   80103af0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104adf:	8b 00                	mov    (%eax),%eax
80104ae1:	39 d8                	cmp    %ebx,%eax
80104ae3:	76 1b                	jbe    80104b00 <fetchint+0x30>
80104ae5:	8d 53 04             	lea    0x4(%ebx),%edx
80104ae8:	39 d0                	cmp    %edx,%eax
80104aea:	72 14                	jb     80104b00 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104aec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104aef:	8b 13                	mov    (%ebx),%edx
80104af1:	89 10                	mov    %edx,(%eax)
  return 0;
80104af3:	31 c0                	xor    %eax,%eax
}
80104af5:	83 c4 04             	add    $0x4,%esp
80104af8:	5b                   	pop    %ebx
80104af9:	5d                   	pop    %ebp
80104afa:	c3                   	ret    
80104afb:	90                   	nop
80104afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b05:	eb ee                	jmp    80104af5 <fetchint+0x25>
80104b07:	89 f6                	mov    %esi,%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b10 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	53                   	push   %ebx
80104b14:	83 ec 04             	sub    $0x4,%esp
80104b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104b1a:	e8 d1 ef ff ff       	call   80103af0 <myproc>

  if(addr >= curproc->sz)
80104b1f:	39 18                	cmp    %ebx,(%eax)
80104b21:	76 29                	jbe    80104b4c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104b23:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104b26:	89 da                	mov    %ebx,%edx
80104b28:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104b2a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104b2c:	39 c3                	cmp    %eax,%ebx
80104b2e:	73 1c                	jae    80104b4c <fetchstr+0x3c>
    if(*s == 0)
80104b30:	80 3b 00             	cmpb   $0x0,(%ebx)
80104b33:	75 10                	jne    80104b45 <fetchstr+0x35>
80104b35:	eb 39                	jmp    80104b70 <fetchstr+0x60>
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b40:	80 3a 00             	cmpb   $0x0,(%edx)
80104b43:	74 1b                	je     80104b60 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104b45:	83 c2 01             	add    $0x1,%edx
80104b48:	39 d0                	cmp    %edx,%eax
80104b4a:	77 f4                	ja     80104b40 <fetchstr+0x30>
    return -1;
80104b4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104b51:	83 c4 04             	add    $0x4,%esp
80104b54:	5b                   	pop    %ebx
80104b55:	5d                   	pop    %ebp
80104b56:	c3                   	ret    
80104b57:	89 f6                	mov    %esi,%esi
80104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b60:	83 c4 04             	add    $0x4,%esp
80104b63:	89 d0                	mov    %edx,%eax
80104b65:	29 d8                	sub    %ebx,%eax
80104b67:	5b                   	pop    %ebx
80104b68:	5d                   	pop    %ebp
80104b69:	c3                   	ret    
80104b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104b70:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104b72:	eb dd                	jmp    80104b51 <fetchstr+0x41>
80104b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b80 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	56                   	push   %esi
80104b84:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b85:	e8 66 ef ff ff       	call   80103af0 <myproc>
80104b8a:	8b 40 18             	mov    0x18(%eax),%eax
80104b8d:	8b 55 08             	mov    0x8(%ebp),%edx
80104b90:	8b 40 44             	mov    0x44(%eax),%eax
80104b93:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b96:	e8 55 ef ff ff       	call   80103af0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b9b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b9d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ba0:	39 c6                	cmp    %eax,%esi
80104ba2:	73 1c                	jae    80104bc0 <argint+0x40>
80104ba4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ba7:	39 d0                	cmp    %edx,%eax
80104ba9:	72 15                	jb     80104bc0 <argint+0x40>
  *ip = *(int*)(addr);
80104bab:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bae:	8b 53 04             	mov    0x4(%ebx),%edx
80104bb1:	89 10                	mov    %edx,(%eax)
  return 0;
80104bb3:	31 c0                	xor    %eax,%eax
}
80104bb5:	5b                   	pop    %ebx
80104bb6:	5e                   	pop    %esi
80104bb7:	5d                   	pop    %ebp
80104bb8:	c3                   	ret    
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bc5:	eb ee                	jmp    80104bb5 <argint+0x35>
80104bc7:	89 f6                	mov    %esi,%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	83 ec 10             	sub    $0x10,%esp
80104bd8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104bdb:	e8 10 ef ff ff       	call   80103af0 <myproc>
80104be0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104be2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104be5:	83 ec 08             	sub    $0x8,%esp
80104be8:	50                   	push   %eax
80104be9:	ff 75 08             	pushl  0x8(%ebp)
80104bec:	e8 8f ff ff ff       	call   80104b80 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104bf1:	83 c4 10             	add    $0x10,%esp
80104bf4:	85 c0                	test   %eax,%eax
80104bf6:	78 28                	js     80104c20 <argptr+0x50>
80104bf8:	85 db                	test   %ebx,%ebx
80104bfa:	78 24                	js     80104c20 <argptr+0x50>
80104bfc:	8b 16                	mov    (%esi),%edx
80104bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c01:	39 c2                	cmp    %eax,%edx
80104c03:	76 1b                	jbe    80104c20 <argptr+0x50>
80104c05:	01 c3                	add    %eax,%ebx
80104c07:	39 da                	cmp    %ebx,%edx
80104c09:	72 15                	jb     80104c20 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104c0b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c0e:	89 02                	mov    %eax,(%edx)
  return 0;
80104c10:	31 c0                	xor    %eax,%eax
}
80104c12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c15:	5b                   	pop    %ebx
80104c16:	5e                   	pop    %esi
80104c17:	5d                   	pop    %ebp
80104c18:	c3                   	ret    
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c25:	eb eb                	jmp    80104c12 <argptr+0x42>
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c30 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104c36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c39:	50                   	push   %eax
80104c3a:	ff 75 08             	pushl  0x8(%ebp)
80104c3d:	e8 3e ff ff ff       	call   80104b80 <argint>
80104c42:	83 c4 10             	add    $0x10,%esp
80104c45:	85 c0                	test   %eax,%eax
80104c47:	78 17                	js     80104c60 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104c49:	83 ec 08             	sub    $0x8,%esp
80104c4c:	ff 75 0c             	pushl  0xc(%ebp)
80104c4f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c52:	e8 b9 fe ff ff       	call   80104b10 <fetchstr>
80104c57:	83 c4 10             	add    $0x10,%esp
}
80104c5a:	c9                   	leave  
80104c5b:	c3                   	ret    
80104c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c65:	c9                   	leave  
80104c66:	c3                   	ret    
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <syscall>:
[SYS_getprocs]   sys_getprocs,
};

void
syscall(void)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	53                   	push   %ebx
80104c74:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80104c77:	e8 74 ee ff ff       	call   80103af0 <myproc>
  num = curproc->tf->eax;
80104c7c:	8b 50 18             	mov    0x18(%eax),%edx
  struct proc *curproc = myproc();
80104c7f:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104c81:	8b 42 1c             	mov    0x1c(%edx),%eax
  if (num == 22) {
80104c84:	83 f8 16             	cmp    $0x16,%eax
80104c87:	74 37                	je     80104cc0 <syscall+0x50>
    int arg = 0;
    argint(0 ,&arg);    
    curproc->tf->eax = sys_incNum(arg);    
  }
  else if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c89:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104c8c:	83 f9 16             	cmp    $0x16,%ecx
80104c8f:	77 1f                	ja     80104cb0 <syscall+0x40>
80104c91:	8b 04 85 c0 7a 10 80 	mov    -0x7fef8540(,%eax,4),%eax
80104c98:	85 c0                	test   %eax,%eax
80104c9a:	74 14                	je     80104cb0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104c9c:	ff d0                	call   *%eax
80104c9e:	8b 53 18             	mov    0x18(%ebx),%edx
80104ca1:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    curproc->tf->eax = -1;
  }
}
80104ca4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ca7:	c9                   	leave  
80104ca8:	c3                   	ret    
80104ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curproc->tf->eax = -1;
80104cb0:	c7 42 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%edx)
}
80104cb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cba:	c9                   	leave  
80104cbb:	c3                   	ret    
80104cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    argint(0 ,&arg);    
80104cc0:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cc3:	83 ec 08             	sub    $0x8,%esp
    int arg = 0;
80104cc6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    argint(0 ,&arg);    
80104ccd:	50                   	push   %eax
80104cce:	6a 00                	push   $0x0
80104cd0:	e8 ab fe ff ff       	call   80104b80 <argint>
    curproc->tf->eax = sys_incNum(arg);    
80104cd5:	58                   	pop    %eax
80104cd6:	ff 75 f4             	pushl  -0xc(%ebp)
80104cd9:	e8 a2 0d 00 00       	call   80105a80 <sys_incNum>
80104cde:	8b 53 18             	mov    0x18(%ebx),%edx
80104ce1:	83 c4 10             	add    $0x10,%esp
80104ce4:	89 42 1c             	mov    %eax,0x1c(%edx)
}
80104ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cea:	c9                   	leave  
80104ceb:	c3                   	ret    
80104cec:	66 90                	xchg   %ax,%ax
80104cee:	66 90                	xchg   %ax,%ax

80104cf0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	57                   	push   %edi
80104cf4:	56                   	push   %esi
80104cf5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104cf6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104cf9:	83 ec 44             	sub    $0x44,%esp
80104cfc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104cff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104d02:	56                   	push   %esi
80104d03:	50                   	push   %eax
{
80104d04:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104d07:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d0a:	e8 01 d5 ff ff       	call   80102210 <nameiparent>
80104d0f:	83 c4 10             	add    $0x10,%esp
80104d12:	85 c0                	test   %eax,%eax
80104d14:	0f 84 46 01 00 00    	je     80104e60 <create+0x170>
    return 0;
  ilock(dp);
80104d1a:	83 ec 0c             	sub    $0xc,%esp
80104d1d:	89 c3                	mov    %eax,%ebx
80104d1f:	50                   	push   %eax
80104d20:	e8 6b cc ff ff       	call   80101990 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104d25:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104d28:	83 c4 0c             	add    $0xc,%esp
80104d2b:	50                   	push   %eax
80104d2c:	56                   	push   %esi
80104d2d:	53                   	push   %ebx
80104d2e:	e8 8d d1 ff ff       	call   80101ec0 <dirlookup>
80104d33:	83 c4 10             	add    $0x10,%esp
80104d36:	85 c0                	test   %eax,%eax
80104d38:	89 c7                	mov    %eax,%edi
80104d3a:	74 34                	je     80104d70 <create+0x80>
    iunlockput(dp);
80104d3c:	83 ec 0c             	sub    $0xc,%esp
80104d3f:	53                   	push   %ebx
80104d40:	e8 db ce ff ff       	call   80101c20 <iunlockput>
    ilock(ip);
80104d45:	89 3c 24             	mov    %edi,(%esp)
80104d48:	e8 43 cc ff ff       	call   80101990 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104d4d:	83 c4 10             	add    $0x10,%esp
80104d50:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104d55:	0f 85 95 00 00 00    	jne    80104df0 <create+0x100>
80104d5b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104d60:	0f 85 8a 00 00 00    	jne    80104df0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d69:	89 f8                	mov    %edi,%eax
80104d6b:	5b                   	pop    %ebx
80104d6c:	5e                   	pop    %esi
80104d6d:	5f                   	pop    %edi
80104d6e:	5d                   	pop    %ebp
80104d6f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104d70:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104d74:	83 ec 08             	sub    $0x8,%esp
80104d77:	50                   	push   %eax
80104d78:	ff 33                	pushl  (%ebx)
80104d7a:	e8 a1 ca ff ff       	call   80101820 <ialloc>
80104d7f:	83 c4 10             	add    $0x10,%esp
80104d82:	85 c0                	test   %eax,%eax
80104d84:	89 c7                	mov    %eax,%edi
80104d86:	0f 84 e8 00 00 00    	je     80104e74 <create+0x184>
  ilock(ip);
80104d8c:	83 ec 0c             	sub    $0xc,%esp
80104d8f:	50                   	push   %eax
80104d90:	e8 fb cb ff ff       	call   80101990 <ilock>
  ip->major = major;
80104d95:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104d99:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104d9d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104da1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104da5:	b8 01 00 00 00       	mov    $0x1,%eax
80104daa:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104dae:	89 3c 24             	mov    %edi,(%esp)
80104db1:	e8 2a cb ff ff       	call   801018e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104db6:	83 c4 10             	add    $0x10,%esp
80104db9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104dbe:	74 50                	je     80104e10 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104dc0:	83 ec 04             	sub    $0x4,%esp
80104dc3:	ff 77 04             	pushl  0x4(%edi)
80104dc6:	56                   	push   %esi
80104dc7:	53                   	push   %ebx
80104dc8:	e8 63 d3 ff ff       	call   80102130 <dirlink>
80104dcd:	83 c4 10             	add    $0x10,%esp
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	0f 88 8f 00 00 00    	js     80104e67 <create+0x177>
  iunlockput(dp);
80104dd8:	83 ec 0c             	sub    $0xc,%esp
80104ddb:	53                   	push   %ebx
80104ddc:	e8 3f ce ff ff       	call   80101c20 <iunlockput>
  return ip;
80104de1:	83 c4 10             	add    $0x10,%esp
}
80104de4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104de7:	89 f8                	mov    %edi,%eax
80104de9:	5b                   	pop    %ebx
80104dea:	5e                   	pop    %esi
80104deb:	5f                   	pop    %edi
80104dec:	5d                   	pop    %ebp
80104ded:	c3                   	ret    
80104dee:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104df0:	83 ec 0c             	sub    $0xc,%esp
80104df3:	57                   	push   %edi
    return 0;
80104df4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104df6:	e8 25 ce ff ff       	call   80101c20 <iunlockput>
    return 0;
80104dfb:	83 c4 10             	add    $0x10,%esp
}
80104dfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e01:	89 f8                	mov    %edi,%eax
80104e03:	5b                   	pop    %ebx
80104e04:	5e                   	pop    %esi
80104e05:	5f                   	pop    %edi
80104e06:	5d                   	pop    %ebp
80104e07:	c3                   	ret    
80104e08:	90                   	nop
80104e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104e10:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104e15:	83 ec 0c             	sub    $0xc,%esp
80104e18:	53                   	push   %ebx
80104e19:	e8 c2 ca ff ff       	call   801018e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e1e:	83 c4 0c             	add    $0xc,%esp
80104e21:	ff 77 04             	pushl  0x4(%edi)
80104e24:	68 3c 7b 10 80       	push   $0x80107b3c
80104e29:	57                   	push   %edi
80104e2a:	e8 01 d3 ff ff       	call   80102130 <dirlink>
80104e2f:	83 c4 10             	add    $0x10,%esp
80104e32:	85 c0                	test   %eax,%eax
80104e34:	78 1c                	js     80104e52 <create+0x162>
80104e36:	83 ec 04             	sub    $0x4,%esp
80104e39:	ff 73 04             	pushl  0x4(%ebx)
80104e3c:	68 3b 7b 10 80       	push   $0x80107b3b
80104e41:	57                   	push   %edi
80104e42:	e8 e9 d2 ff ff       	call   80102130 <dirlink>
80104e47:	83 c4 10             	add    $0x10,%esp
80104e4a:	85 c0                	test   %eax,%eax
80104e4c:	0f 89 6e ff ff ff    	jns    80104dc0 <create+0xd0>
      panic("create dots");
80104e52:	83 ec 0c             	sub    $0xc,%esp
80104e55:	68 2f 7b 10 80       	push   $0x80107b2f
80104e5a:	e8 31 b5 ff ff       	call   80100390 <panic>
80104e5f:	90                   	nop
    return 0;
80104e60:	31 ff                	xor    %edi,%edi
80104e62:	e9 ff fe ff ff       	jmp    80104d66 <create+0x76>
    panic("create: dirlink");
80104e67:	83 ec 0c             	sub    $0xc,%esp
80104e6a:	68 3e 7b 10 80       	push   $0x80107b3e
80104e6f:	e8 1c b5 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	68 20 7b 10 80       	push   $0x80107b20
80104e7c:	e8 0f b5 ff ff       	call   80100390 <panic>
80104e81:	eb 0d                	jmp    80104e90 <argfd.constprop.0>
80104e83:	90                   	nop
80104e84:	90                   	nop
80104e85:	90                   	nop
80104e86:	90                   	nop
80104e87:	90                   	nop
80104e88:	90                   	nop
80104e89:	90                   	nop
80104e8a:	90                   	nop
80104e8b:	90                   	nop
80104e8c:	90                   	nop
80104e8d:	90                   	nop
80104e8e:	90                   	nop
80104e8f:	90                   	nop

80104e90 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104e97:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104e9a:	89 d6                	mov    %edx,%esi
80104e9c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e9f:	50                   	push   %eax
80104ea0:	6a 00                	push   $0x0
80104ea2:	e8 d9 fc ff ff       	call   80104b80 <argint>
80104ea7:	83 c4 10             	add    $0x10,%esp
80104eaa:	85 c0                	test   %eax,%eax
80104eac:	78 2a                	js     80104ed8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eae:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104eb2:	77 24                	ja     80104ed8 <argfd.constprop.0+0x48>
80104eb4:	e8 37 ec ff ff       	call   80103af0 <myproc>
80104eb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ebc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	74 14                	je     80104ed8 <argfd.constprop.0+0x48>
  if(pfd)
80104ec4:	85 db                	test   %ebx,%ebx
80104ec6:	74 02                	je     80104eca <argfd.constprop.0+0x3a>
    *pfd = fd;
80104ec8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104eca:	89 06                	mov    %eax,(%esi)
  return 0;
80104ecc:	31 c0                	xor    %eax,%eax
}
80104ece:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ed1:	5b                   	pop    %ebx
80104ed2:	5e                   	pop    %esi
80104ed3:	5d                   	pop    %ebp
80104ed4:	c3                   	ret    
80104ed5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ed8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104edd:	eb ef                	jmp    80104ece <argfd.constprop.0+0x3e>
80104edf:	90                   	nop

80104ee0 <sys_dup>:
{
80104ee0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104ee1:	31 c0                	xor    %eax,%eax
{
80104ee3:	89 e5                	mov    %esp,%ebp
80104ee5:	56                   	push   %esi
80104ee6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104ee7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104eea:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104eed:	e8 9e ff ff ff       	call   80104e90 <argfd.constprop.0>
80104ef2:	85 c0                	test   %eax,%eax
80104ef4:	78 42                	js     80104f38 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104ef6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104ef9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104efb:	e8 f0 eb ff ff       	call   80103af0 <myproc>
80104f00:	eb 0e                	jmp    80104f10 <sys_dup+0x30>
80104f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104f08:	83 c3 01             	add    $0x1,%ebx
80104f0b:	83 fb 10             	cmp    $0x10,%ebx
80104f0e:	74 28                	je     80104f38 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104f10:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f14:	85 d2                	test   %edx,%edx
80104f16:	75 f0                	jne    80104f08 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104f18:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104f1c:	83 ec 0c             	sub    $0xc,%esp
80104f1f:	ff 75 f4             	pushl  -0xc(%ebp)
80104f22:	e8 c9 c1 ff ff       	call   801010f0 <filedup>
  return fd;
80104f27:	83 c4 10             	add    $0x10,%esp
}
80104f2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f2d:	89 d8                	mov    %ebx,%eax
80104f2f:	5b                   	pop    %ebx
80104f30:	5e                   	pop    %esi
80104f31:	5d                   	pop    %ebp
80104f32:	c3                   	ret    
80104f33:	90                   	nop
80104f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f38:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f3b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f40:	89 d8                	mov    %ebx,%eax
80104f42:	5b                   	pop    %ebx
80104f43:	5e                   	pop    %esi
80104f44:	5d                   	pop    %ebp
80104f45:	c3                   	ret    
80104f46:	8d 76 00             	lea    0x0(%esi),%esi
80104f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f50 <sys_read>:
{
80104f50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f51:	31 c0                	xor    %eax,%eax
{
80104f53:	89 e5                	mov    %esp,%ebp
80104f55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f5b:	e8 30 ff ff ff       	call   80104e90 <argfd.constprop.0>
80104f60:	85 c0                	test   %eax,%eax
80104f62:	78 4c                	js     80104fb0 <sys_read+0x60>
80104f64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f67:	83 ec 08             	sub    $0x8,%esp
80104f6a:	50                   	push   %eax
80104f6b:	6a 02                	push   $0x2
80104f6d:	e8 0e fc ff ff       	call   80104b80 <argint>
80104f72:	83 c4 10             	add    $0x10,%esp
80104f75:	85 c0                	test   %eax,%eax
80104f77:	78 37                	js     80104fb0 <sys_read+0x60>
80104f79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f7c:	83 ec 04             	sub    $0x4,%esp
80104f7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104f82:	50                   	push   %eax
80104f83:	6a 01                	push   $0x1
80104f85:	e8 46 fc ff ff       	call   80104bd0 <argptr>
80104f8a:	83 c4 10             	add    $0x10,%esp
80104f8d:	85 c0                	test   %eax,%eax
80104f8f:	78 1f                	js     80104fb0 <sys_read+0x60>
  return fileread(f, p, n);
80104f91:	83 ec 04             	sub    $0x4,%esp
80104f94:	ff 75 f0             	pushl  -0x10(%ebp)
80104f97:	ff 75 f4             	pushl  -0xc(%ebp)
80104f9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f9d:	e8 be c2 ff ff       	call   80101260 <fileread>
80104fa2:	83 c4 10             	add    $0x10,%esp
}
80104fa5:	c9                   	leave  
80104fa6:	c3                   	ret    
80104fa7:	89 f6                	mov    %esi,%esi
80104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fb5:	c9                   	leave  
80104fb6:	c3                   	ret    
80104fb7:	89 f6                	mov    %esi,%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fc0 <sys_write>:
{
80104fc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc1:	31 c0                	xor    %eax,%eax
{
80104fc3:	89 e5                	mov    %esp,%ebp
80104fc5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104fcb:	e8 c0 fe ff ff       	call   80104e90 <argfd.constprop.0>
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	78 4c                	js     80105020 <sys_write+0x60>
80104fd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fd7:	83 ec 08             	sub    $0x8,%esp
80104fda:	50                   	push   %eax
80104fdb:	6a 02                	push   $0x2
80104fdd:	e8 9e fb ff ff       	call   80104b80 <argint>
80104fe2:	83 c4 10             	add    $0x10,%esp
80104fe5:	85 c0                	test   %eax,%eax
80104fe7:	78 37                	js     80105020 <sys_write+0x60>
80104fe9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fec:	83 ec 04             	sub    $0x4,%esp
80104fef:	ff 75 f0             	pushl  -0x10(%ebp)
80104ff2:	50                   	push   %eax
80104ff3:	6a 01                	push   $0x1
80104ff5:	e8 d6 fb ff ff       	call   80104bd0 <argptr>
80104ffa:	83 c4 10             	add    $0x10,%esp
80104ffd:	85 c0                	test   %eax,%eax
80104fff:	78 1f                	js     80105020 <sys_write+0x60>
  return filewrite(f, p, n);
80105001:	83 ec 04             	sub    $0x4,%esp
80105004:	ff 75 f0             	pushl  -0x10(%ebp)
80105007:	ff 75 f4             	pushl  -0xc(%ebp)
8010500a:	ff 75 ec             	pushl  -0x14(%ebp)
8010500d:	e8 de c2 ff ff       	call   801012f0 <filewrite>
80105012:	83 c4 10             	add    $0x10,%esp
}
80105015:	c9                   	leave  
80105016:	c3                   	ret    
80105017:	89 f6                	mov    %esi,%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105025:	c9                   	leave  
80105026:	c3                   	ret    
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105030 <sys_close>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105036:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105039:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010503c:	e8 4f fe ff ff       	call   80104e90 <argfd.constprop.0>
80105041:	85 c0                	test   %eax,%eax
80105043:	78 2b                	js     80105070 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105045:	e8 a6 ea ff ff       	call   80103af0 <myproc>
8010504a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010504d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105050:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105057:	00 
  fileclose(f);
80105058:	ff 75 f4             	pushl  -0xc(%ebp)
8010505b:	e8 e0 c0 ff ff       	call   80101140 <fileclose>
  return 0;
80105060:	83 c4 10             	add    $0x10,%esp
80105063:	31 c0                	xor    %eax,%eax
}
80105065:	c9                   	leave  
80105066:	c3                   	ret    
80105067:	89 f6                	mov    %esi,%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105075:	c9                   	leave  
80105076:	c3                   	ret    
80105077:	89 f6                	mov    %esi,%esi
80105079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105080 <sys_fstat>:
{
80105080:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105081:	31 c0                	xor    %eax,%eax
{
80105083:	89 e5                	mov    %esp,%ebp
80105085:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105088:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010508b:	e8 00 fe ff ff       	call   80104e90 <argfd.constprop.0>
80105090:	85 c0                	test   %eax,%eax
80105092:	78 2c                	js     801050c0 <sys_fstat+0x40>
80105094:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105097:	83 ec 04             	sub    $0x4,%esp
8010509a:	6a 14                	push   $0x14
8010509c:	50                   	push   %eax
8010509d:	6a 01                	push   $0x1
8010509f:	e8 2c fb ff ff       	call   80104bd0 <argptr>
801050a4:	83 c4 10             	add    $0x10,%esp
801050a7:	85 c0                	test   %eax,%eax
801050a9:	78 15                	js     801050c0 <sys_fstat+0x40>
  return filestat(f, st);
801050ab:	83 ec 08             	sub    $0x8,%esp
801050ae:	ff 75 f4             	pushl  -0xc(%ebp)
801050b1:	ff 75 f0             	pushl  -0x10(%ebp)
801050b4:	e8 57 c1 ff ff       	call   80101210 <filestat>
801050b9:	83 c4 10             	add    $0x10,%esp
}
801050bc:	c9                   	leave  
801050bd:	c3                   	ret    
801050be:	66 90                	xchg   %ax,%ax
    return -1;
801050c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050c5:	c9                   	leave  
801050c6:	c3                   	ret    
801050c7:	89 f6                	mov    %esi,%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050d0 <sys_link>:
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	57                   	push   %edi
801050d4:	56                   	push   %esi
801050d5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050d6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801050d9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050dc:	50                   	push   %eax
801050dd:	6a 00                	push   $0x0
801050df:	e8 4c fb ff ff       	call   80104c30 <argstr>
801050e4:	83 c4 10             	add    $0x10,%esp
801050e7:	85 c0                	test   %eax,%eax
801050e9:	0f 88 fb 00 00 00    	js     801051ea <sys_link+0x11a>
801050ef:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050f2:	83 ec 08             	sub    $0x8,%esp
801050f5:	50                   	push   %eax
801050f6:	6a 01                	push   $0x1
801050f8:	e8 33 fb ff ff       	call   80104c30 <argstr>
801050fd:	83 c4 10             	add    $0x10,%esp
80105100:	85 c0                	test   %eax,%eax
80105102:	0f 88 e2 00 00 00    	js     801051ea <sys_link+0x11a>
  begin_op();
80105108:	e8 a3 dd ff ff       	call   80102eb0 <begin_op>
  if((ip = namei(old)) == 0){
8010510d:	83 ec 0c             	sub    $0xc,%esp
80105110:	ff 75 d4             	pushl  -0x2c(%ebp)
80105113:	e8 d8 d0 ff ff       	call   801021f0 <namei>
80105118:	83 c4 10             	add    $0x10,%esp
8010511b:	85 c0                	test   %eax,%eax
8010511d:	89 c3                	mov    %eax,%ebx
8010511f:	0f 84 ea 00 00 00    	je     8010520f <sys_link+0x13f>
  ilock(ip);
80105125:	83 ec 0c             	sub    $0xc,%esp
80105128:	50                   	push   %eax
80105129:	e8 62 c8 ff ff       	call   80101990 <ilock>
  if(ip->type == T_DIR){
8010512e:	83 c4 10             	add    $0x10,%esp
80105131:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105136:	0f 84 bb 00 00 00    	je     801051f7 <sys_link+0x127>
  ip->nlink++;
8010513c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105141:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105144:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105147:	53                   	push   %ebx
80105148:	e8 93 c7 ff ff       	call   801018e0 <iupdate>
  iunlock(ip);
8010514d:	89 1c 24             	mov    %ebx,(%esp)
80105150:	e8 1b c9 ff ff       	call   80101a70 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105155:	58                   	pop    %eax
80105156:	5a                   	pop    %edx
80105157:	57                   	push   %edi
80105158:	ff 75 d0             	pushl  -0x30(%ebp)
8010515b:	e8 b0 d0 ff ff       	call   80102210 <nameiparent>
80105160:	83 c4 10             	add    $0x10,%esp
80105163:	85 c0                	test   %eax,%eax
80105165:	89 c6                	mov    %eax,%esi
80105167:	74 5b                	je     801051c4 <sys_link+0xf4>
  ilock(dp);
80105169:	83 ec 0c             	sub    $0xc,%esp
8010516c:	50                   	push   %eax
8010516d:	e8 1e c8 ff ff       	call   80101990 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105172:	83 c4 10             	add    $0x10,%esp
80105175:	8b 03                	mov    (%ebx),%eax
80105177:	39 06                	cmp    %eax,(%esi)
80105179:	75 3d                	jne    801051b8 <sys_link+0xe8>
8010517b:	83 ec 04             	sub    $0x4,%esp
8010517e:	ff 73 04             	pushl  0x4(%ebx)
80105181:	57                   	push   %edi
80105182:	56                   	push   %esi
80105183:	e8 a8 cf ff ff       	call   80102130 <dirlink>
80105188:	83 c4 10             	add    $0x10,%esp
8010518b:	85 c0                	test   %eax,%eax
8010518d:	78 29                	js     801051b8 <sys_link+0xe8>
  iunlockput(dp);
8010518f:	83 ec 0c             	sub    $0xc,%esp
80105192:	56                   	push   %esi
80105193:	e8 88 ca ff ff       	call   80101c20 <iunlockput>
  iput(ip);
80105198:	89 1c 24             	mov    %ebx,(%esp)
8010519b:	e8 20 c9 ff ff       	call   80101ac0 <iput>
  end_op();
801051a0:	e8 7b dd ff ff       	call   80102f20 <end_op>
  return 0;
801051a5:	83 c4 10             	add    $0x10,%esp
801051a8:	31 c0                	xor    %eax,%eax
}
801051aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ad:	5b                   	pop    %ebx
801051ae:	5e                   	pop    %esi
801051af:	5f                   	pop    %edi
801051b0:	5d                   	pop    %ebp
801051b1:	c3                   	ret    
801051b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801051b8:	83 ec 0c             	sub    $0xc,%esp
801051bb:	56                   	push   %esi
801051bc:	e8 5f ca ff ff       	call   80101c20 <iunlockput>
    goto bad;
801051c1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801051c4:	83 ec 0c             	sub    $0xc,%esp
801051c7:	53                   	push   %ebx
801051c8:	e8 c3 c7 ff ff       	call   80101990 <ilock>
  ip->nlink--;
801051cd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051d2:	89 1c 24             	mov    %ebx,(%esp)
801051d5:	e8 06 c7 ff ff       	call   801018e0 <iupdate>
  iunlockput(ip);
801051da:	89 1c 24             	mov    %ebx,(%esp)
801051dd:	e8 3e ca ff ff       	call   80101c20 <iunlockput>
  end_op();
801051e2:	e8 39 dd ff ff       	call   80102f20 <end_op>
  return -1;
801051e7:	83 c4 10             	add    $0x10,%esp
}
801051ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801051ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051f2:	5b                   	pop    %ebx
801051f3:	5e                   	pop    %esi
801051f4:	5f                   	pop    %edi
801051f5:	5d                   	pop    %ebp
801051f6:	c3                   	ret    
    iunlockput(ip);
801051f7:	83 ec 0c             	sub    $0xc,%esp
801051fa:	53                   	push   %ebx
801051fb:	e8 20 ca ff ff       	call   80101c20 <iunlockput>
    end_op();
80105200:	e8 1b dd ff ff       	call   80102f20 <end_op>
    return -1;
80105205:	83 c4 10             	add    $0x10,%esp
80105208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010520d:	eb 9b                	jmp    801051aa <sys_link+0xda>
    end_op();
8010520f:	e8 0c dd ff ff       	call   80102f20 <end_op>
    return -1;
80105214:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105219:	eb 8f                	jmp    801051aa <sys_link+0xda>
8010521b:	90                   	nop
8010521c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105220 <sys_unlink>:
{
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	57                   	push   %edi
80105224:	56                   	push   %esi
80105225:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105226:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105229:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010522c:	50                   	push   %eax
8010522d:	6a 00                	push   $0x0
8010522f:	e8 fc f9 ff ff       	call   80104c30 <argstr>
80105234:	83 c4 10             	add    $0x10,%esp
80105237:	85 c0                	test   %eax,%eax
80105239:	0f 88 77 01 00 00    	js     801053b6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010523f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105242:	e8 69 dc ff ff       	call   80102eb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105247:	83 ec 08             	sub    $0x8,%esp
8010524a:	53                   	push   %ebx
8010524b:	ff 75 c0             	pushl  -0x40(%ebp)
8010524e:	e8 bd cf ff ff       	call   80102210 <nameiparent>
80105253:	83 c4 10             	add    $0x10,%esp
80105256:	85 c0                	test   %eax,%eax
80105258:	89 c6                	mov    %eax,%esi
8010525a:	0f 84 60 01 00 00    	je     801053c0 <sys_unlink+0x1a0>
  ilock(dp);
80105260:	83 ec 0c             	sub    $0xc,%esp
80105263:	50                   	push   %eax
80105264:	e8 27 c7 ff ff       	call   80101990 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105269:	58                   	pop    %eax
8010526a:	5a                   	pop    %edx
8010526b:	68 3c 7b 10 80       	push   $0x80107b3c
80105270:	53                   	push   %ebx
80105271:	e8 2a cc ff ff       	call   80101ea0 <namecmp>
80105276:	83 c4 10             	add    $0x10,%esp
80105279:	85 c0                	test   %eax,%eax
8010527b:	0f 84 03 01 00 00    	je     80105384 <sys_unlink+0x164>
80105281:	83 ec 08             	sub    $0x8,%esp
80105284:	68 3b 7b 10 80       	push   $0x80107b3b
80105289:	53                   	push   %ebx
8010528a:	e8 11 cc ff ff       	call   80101ea0 <namecmp>
8010528f:	83 c4 10             	add    $0x10,%esp
80105292:	85 c0                	test   %eax,%eax
80105294:	0f 84 ea 00 00 00    	je     80105384 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010529a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010529d:	83 ec 04             	sub    $0x4,%esp
801052a0:	50                   	push   %eax
801052a1:	53                   	push   %ebx
801052a2:	56                   	push   %esi
801052a3:	e8 18 cc ff ff       	call   80101ec0 <dirlookup>
801052a8:	83 c4 10             	add    $0x10,%esp
801052ab:	85 c0                	test   %eax,%eax
801052ad:	89 c3                	mov    %eax,%ebx
801052af:	0f 84 cf 00 00 00    	je     80105384 <sys_unlink+0x164>
  ilock(ip);
801052b5:	83 ec 0c             	sub    $0xc,%esp
801052b8:	50                   	push   %eax
801052b9:	e8 d2 c6 ff ff       	call   80101990 <ilock>
  if(ip->nlink < 1)
801052be:	83 c4 10             	add    $0x10,%esp
801052c1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801052c6:	0f 8e 10 01 00 00    	jle    801053dc <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801052cc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052d1:	74 6d                	je     80105340 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801052d3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801052d6:	83 ec 04             	sub    $0x4,%esp
801052d9:	6a 10                	push   $0x10
801052db:	6a 00                	push   $0x0
801052dd:	50                   	push   %eax
801052de:	e8 9d f5 ff ff       	call   80104880 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052e3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801052e6:	6a 10                	push   $0x10
801052e8:	ff 75 c4             	pushl  -0x3c(%ebp)
801052eb:	50                   	push   %eax
801052ec:	56                   	push   %esi
801052ed:	e8 7e ca ff ff       	call   80101d70 <writei>
801052f2:	83 c4 20             	add    $0x20,%esp
801052f5:	83 f8 10             	cmp    $0x10,%eax
801052f8:	0f 85 eb 00 00 00    	jne    801053e9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801052fe:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105303:	0f 84 97 00 00 00    	je     801053a0 <sys_unlink+0x180>
  iunlockput(dp);
80105309:	83 ec 0c             	sub    $0xc,%esp
8010530c:	56                   	push   %esi
8010530d:	e8 0e c9 ff ff       	call   80101c20 <iunlockput>
  ip->nlink--;
80105312:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105317:	89 1c 24             	mov    %ebx,(%esp)
8010531a:	e8 c1 c5 ff ff       	call   801018e0 <iupdate>
  iunlockput(ip);
8010531f:	89 1c 24             	mov    %ebx,(%esp)
80105322:	e8 f9 c8 ff ff       	call   80101c20 <iunlockput>
  end_op();
80105327:	e8 f4 db ff ff       	call   80102f20 <end_op>
  return 0;
8010532c:	83 c4 10             	add    $0x10,%esp
8010532f:	31 c0                	xor    %eax,%eax
}
80105331:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105334:	5b                   	pop    %ebx
80105335:	5e                   	pop    %esi
80105336:	5f                   	pop    %edi
80105337:	5d                   	pop    %ebp
80105338:	c3                   	ret    
80105339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105340:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105344:	76 8d                	jbe    801052d3 <sys_unlink+0xb3>
80105346:	bf 20 00 00 00       	mov    $0x20,%edi
8010534b:	eb 0f                	jmp    8010535c <sys_unlink+0x13c>
8010534d:	8d 76 00             	lea    0x0(%esi),%esi
80105350:	83 c7 10             	add    $0x10,%edi
80105353:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105356:	0f 83 77 ff ff ff    	jae    801052d3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010535c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010535f:	6a 10                	push   $0x10
80105361:	57                   	push   %edi
80105362:	50                   	push   %eax
80105363:	53                   	push   %ebx
80105364:	e8 07 c9 ff ff       	call   80101c70 <readi>
80105369:	83 c4 10             	add    $0x10,%esp
8010536c:	83 f8 10             	cmp    $0x10,%eax
8010536f:	75 5e                	jne    801053cf <sys_unlink+0x1af>
    if(de.inum != 0)
80105371:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105376:	74 d8                	je     80105350 <sys_unlink+0x130>
    iunlockput(ip);
80105378:	83 ec 0c             	sub    $0xc,%esp
8010537b:	53                   	push   %ebx
8010537c:	e8 9f c8 ff ff       	call   80101c20 <iunlockput>
    goto bad;
80105381:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105384:	83 ec 0c             	sub    $0xc,%esp
80105387:	56                   	push   %esi
80105388:	e8 93 c8 ff ff       	call   80101c20 <iunlockput>
  end_op();
8010538d:	e8 8e db ff ff       	call   80102f20 <end_op>
  return -1;
80105392:	83 c4 10             	add    $0x10,%esp
80105395:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010539a:	eb 95                	jmp    80105331 <sys_unlink+0x111>
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801053a0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801053a5:	83 ec 0c             	sub    $0xc,%esp
801053a8:	56                   	push   %esi
801053a9:	e8 32 c5 ff ff       	call   801018e0 <iupdate>
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	e9 53 ff ff ff       	jmp    80105309 <sys_unlink+0xe9>
    return -1;
801053b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053bb:	e9 71 ff ff ff       	jmp    80105331 <sys_unlink+0x111>
    end_op();
801053c0:	e8 5b db ff ff       	call   80102f20 <end_op>
    return -1;
801053c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ca:	e9 62 ff ff ff       	jmp    80105331 <sys_unlink+0x111>
      panic("isdirempty: readi");
801053cf:	83 ec 0c             	sub    $0xc,%esp
801053d2:	68 60 7b 10 80       	push   $0x80107b60
801053d7:	e8 b4 af ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801053dc:	83 ec 0c             	sub    $0xc,%esp
801053df:	68 4e 7b 10 80       	push   $0x80107b4e
801053e4:	e8 a7 af ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801053e9:	83 ec 0c             	sub    $0xc,%esp
801053ec:	68 72 7b 10 80       	push   $0x80107b72
801053f1:	e8 9a af ff ff       	call   80100390 <panic>
801053f6:	8d 76 00             	lea    0x0(%esi),%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105400 <sys_open>:

int
sys_open(void)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105406:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105409:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010540c:	50                   	push   %eax
8010540d:	6a 00                	push   $0x0
8010540f:	e8 1c f8 ff ff       	call   80104c30 <argstr>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	85 c0                	test   %eax,%eax
80105419:	0f 88 1d 01 00 00    	js     8010553c <sys_open+0x13c>
8010541f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105422:	83 ec 08             	sub    $0x8,%esp
80105425:	50                   	push   %eax
80105426:	6a 01                	push   $0x1
80105428:	e8 53 f7 ff ff       	call   80104b80 <argint>
8010542d:	83 c4 10             	add    $0x10,%esp
80105430:	85 c0                	test   %eax,%eax
80105432:	0f 88 04 01 00 00    	js     8010553c <sys_open+0x13c>
    return -1;

  begin_op();
80105438:	e8 73 da ff ff       	call   80102eb0 <begin_op>

  if(omode & O_CREATE){
8010543d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105441:	0f 85 a9 00 00 00    	jne    801054f0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105447:	83 ec 0c             	sub    $0xc,%esp
8010544a:	ff 75 e0             	pushl  -0x20(%ebp)
8010544d:	e8 9e cd ff ff       	call   801021f0 <namei>
80105452:	83 c4 10             	add    $0x10,%esp
80105455:	85 c0                	test   %eax,%eax
80105457:	89 c6                	mov    %eax,%esi
80105459:	0f 84 b2 00 00 00    	je     80105511 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010545f:	83 ec 0c             	sub    $0xc,%esp
80105462:	50                   	push   %eax
80105463:	e8 28 c5 ff ff       	call   80101990 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105468:	83 c4 10             	add    $0x10,%esp
8010546b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105470:	0f 84 aa 00 00 00    	je     80105520 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105476:	e8 05 bc ff ff       	call   80101080 <filealloc>
8010547b:	85 c0                	test   %eax,%eax
8010547d:	89 c7                	mov    %eax,%edi
8010547f:	0f 84 a6 00 00 00    	je     8010552b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105485:	e8 66 e6 ff ff       	call   80103af0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010548a:	31 db                	xor    %ebx,%ebx
8010548c:	eb 0e                	jmp    8010549c <sys_open+0x9c>
8010548e:	66 90                	xchg   %ax,%ax
80105490:	83 c3 01             	add    $0x1,%ebx
80105493:	83 fb 10             	cmp    $0x10,%ebx
80105496:	0f 84 ac 00 00 00    	je     80105548 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010549c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801054a0:	85 d2                	test   %edx,%edx
801054a2:	75 ec                	jne    80105490 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054a4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801054a7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801054ab:	56                   	push   %esi
801054ac:	e8 bf c5 ff ff       	call   80101a70 <iunlock>
  end_op();
801054b1:	e8 6a da ff ff       	call   80102f20 <end_op>

  f->type = FD_INODE;
801054b6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054bf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801054c2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801054c5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801054cc:	89 d0                	mov    %edx,%eax
801054ce:	f7 d0                	not    %eax
801054d0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054d3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801054d6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054d9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801054dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054e0:	89 d8                	mov    %ebx,%eax
801054e2:	5b                   	pop    %ebx
801054e3:	5e                   	pop    %esi
801054e4:	5f                   	pop    %edi
801054e5:	5d                   	pop    %ebp
801054e6:	c3                   	ret    
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801054f6:	31 c9                	xor    %ecx,%ecx
801054f8:	6a 00                	push   $0x0
801054fa:	ba 02 00 00 00       	mov    $0x2,%edx
801054ff:	e8 ec f7 ff ff       	call   80104cf0 <create>
    if(ip == 0){
80105504:	83 c4 10             	add    $0x10,%esp
80105507:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105509:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010550b:	0f 85 65 ff ff ff    	jne    80105476 <sys_open+0x76>
      end_op();
80105511:	e8 0a da ff ff       	call   80102f20 <end_op>
      return -1;
80105516:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010551b:	eb c0                	jmp    801054dd <sys_open+0xdd>
8010551d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105520:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105523:	85 c9                	test   %ecx,%ecx
80105525:	0f 84 4b ff ff ff    	je     80105476 <sys_open+0x76>
    iunlockput(ip);
8010552b:	83 ec 0c             	sub    $0xc,%esp
8010552e:	56                   	push   %esi
8010552f:	e8 ec c6 ff ff       	call   80101c20 <iunlockput>
    end_op();
80105534:	e8 e7 d9 ff ff       	call   80102f20 <end_op>
    return -1;
80105539:	83 c4 10             	add    $0x10,%esp
8010553c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105541:	eb 9a                	jmp    801054dd <sys_open+0xdd>
80105543:	90                   	nop
80105544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105548:	83 ec 0c             	sub    $0xc,%esp
8010554b:	57                   	push   %edi
8010554c:	e8 ef bb ff ff       	call   80101140 <fileclose>
80105551:	83 c4 10             	add    $0x10,%esp
80105554:	eb d5                	jmp    8010552b <sys_open+0x12b>
80105556:	8d 76 00             	lea    0x0(%esi),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <sys_mkdir>:

int
sys_mkdir(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105566:	e8 45 d9 ff ff       	call   80102eb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010556b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010556e:	83 ec 08             	sub    $0x8,%esp
80105571:	50                   	push   %eax
80105572:	6a 00                	push   $0x0
80105574:	e8 b7 f6 ff ff       	call   80104c30 <argstr>
80105579:	83 c4 10             	add    $0x10,%esp
8010557c:	85 c0                	test   %eax,%eax
8010557e:	78 30                	js     801055b0 <sys_mkdir+0x50>
80105580:	83 ec 0c             	sub    $0xc,%esp
80105583:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105586:	31 c9                	xor    %ecx,%ecx
80105588:	6a 00                	push   $0x0
8010558a:	ba 01 00 00 00       	mov    $0x1,%edx
8010558f:	e8 5c f7 ff ff       	call   80104cf0 <create>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	85 c0                	test   %eax,%eax
80105599:	74 15                	je     801055b0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010559b:	83 ec 0c             	sub    $0xc,%esp
8010559e:	50                   	push   %eax
8010559f:	e8 7c c6 ff ff       	call   80101c20 <iunlockput>
  end_op();
801055a4:	e8 77 d9 ff ff       	call   80102f20 <end_op>
  return 0;
801055a9:	83 c4 10             	add    $0x10,%esp
801055ac:	31 c0                	xor    %eax,%eax
}
801055ae:	c9                   	leave  
801055af:	c3                   	ret    
    end_op();
801055b0:	e8 6b d9 ff ff       	call   80102f20 <end_op>
    return -1;
801055b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055ba:	c9                   	leave  
801055bb:	c3                   	ret    
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055c0 <sys_mknod>:

int
sys_mknod(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801055c6:	e8 e5 d8 ff ff       	call   80102eb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801055cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801055ce:	83 ec 08             	sub    $0x8,%esp
801055d1:	50                   	push   %eax
801055d2:	6a 00                	push   $0x0
801055d4:	e8 57 f6 ff ff       	call   80104c30 <argstr>
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	85 c0                	test   %eax,%eax
801055de:	78 60                	js     80105640 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801055e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055e3:	83 ec 08             	sub    $0x8,%esp
801055e6:	50                   	push   %eax
801055e7:	6a 01                	push   $0x1
801055e9:	e8 92 f5 ff ff       	call   80104b80 <argint>
  if((argstr(0, &path)) < 0 ||
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	85 c0                	test   %eax,%eax
801055f3:	78 4b                	js     80105640 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801055f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055f8:	83 ec 08             	sub    $0x8,%esp
801055fb:	50                   	push   %eax
801055fc:	6a 02                	push   $0x2
801055fe:	e8 7d f5 ff ff       	call   80104b80 <argint>
     argint(1, &major) < 0 ||
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	78 36                	js     80105640 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010560a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010560e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105611:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105615:	ba 03 00 00 00       	mov    $0x3,%edx
8010561a:	50                   	push   %eax
8010561b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010561e:	e8 cd f6 ff ff       	call   80104cf0 <create>
80105623:	83 c4 10             	add    $0x10,%esp
80105626:	85 c0                	test   %eax,%eax
80105628:	74 16                	je     80105640 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010562a:	83 ec 0c             	sub    $0xc,%esp
8010562d:	50                   	push   %eax
8010562e:	e8 ed c5 ff ff       	call   80101c20 <iunlockput>
  end_op();
80105633:	e8 e8 d8 ff ff       	call   80102f20 <end_op>
  return 0;
80105638:	83 c4 10             	add    $0x10,%esp
8010563b:	31 c0                	xor    %eax,%eax
}
8010563d:	c9                   	leave  
8010563e:	c3                   	ret    
8010563f:	90                   	nop
    end_op();
80105640:	e8 db d8 ff ff       	call   80102f20 <end_op>
    return -1;
80105645:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010564a:	c9                   	leave  
8010564b:	c3                   	ret    
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_chdir>:

int
sys_chdir(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	56                   	push   %esi
80105654:	53                   	push   %ebx
80105655:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105658:	e8 93 e4 ff ff       	call   80103af0 <myproc>
8010565d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010565f:	e8 4c d8 ff ff       	call   80102eb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105664:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105667:	83 ec 08             	sub    $0x8,%esp
8010566a:	50                   	push   %eax
8010566b:	6a 00                	push   $0x0
8010566d:	e8 be f5 ff ff       	call   80104c30 <argstr>
80105672:	83 c4 10             	add    $0x10,%esp
80105675:	85 c0                	test   %eax,%eax
80105677:	78 77                	js     801056f0 <sys_chdir+0xa0>
80105679:	83 ec 0c             	sub    $0xc,%esp
8010567c:	ff 75 f4             	pushl  -0xc(%ebp)
8010567f:	e8 6c cb ff ff       	call   801021f0 <namei>
80105684:	83 c4 10             	add    $0x10,%esp
80105687:	85 c0                	test   %eax,%eax
80105689:	89 c3                	mov    %eax,%ebx
8010568b:	74 63                	je     801056f0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010568d:	83 ec 0c             	sub    $0xc,%esp
80105690:	50                   	push   %eax
80105691:	e8 fa c2 ff ff       	call   80101990 <ilock>
  if(ip->type != T_DIR){
80105696:	83 c4 10             	add    $0x10,%esp
80105699:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010569e:	75 30                	jne    801056d0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	53                   	push   %ebx
801056a4:	e8 c7 c3 ff ff       	call   80101a70 <iunlock>
  iput(curproc->cwd);
801056a9:	58                   	pop    %eax
801056aa:	ff 76 68             	pushl  0x68(%esi)
801056ad:	e8 0e c4 ff ff       	call   80101ac0 <iput>
  end_op();
801056b2:	e8 69 d8 ff ff       	call   80102f20 <end_op>
  curproc->cwd = ip;
801056b7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801056ba:	83 c4 10             	add    $0x10,%esp
801056bd:	31 c0                	xor    %eax,%eax
}
801056bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056c2:	5b                   	pop    %ebx
801056c3:	5e                   	pop    %esi
801056c4:	5d                   	pop    %ebp
801056c5:	c3                   	ret    
801056c6:	8d 76 00             	lea    0x0(%esi),%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801056d0:	83 ec 0c             	sub    $0xc,%esp
801056d3:	53                   	push   %ebx
801056d4:	e8 47 c5 ff ff       	call   80101c20 <iunlockput>
    end_op();
801056d9:	e8 42 d8 ff ff       	call   80102f20 <end_op>
    return -1;
801056de:	83 c4 10             	add    $0x10,%esp
801056e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e6:	eb d7                	jmp    801056bf <sys_chdir+0x6f>
801056e8:	90                   	nop
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801056f0:	e8 2b d8 ff ff       	call   80102f20 <end_op>
    return -1;
801056f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056fa:	eb c3                	jmp    801056bf <sys_chdir+0x6f>
801056fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105700 <sys_exec>:

int
sys_exec(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	57                   	push   %edi
80105704:	56                   	push   %esi
80105705:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105706:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010570c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105712:	50                   	push   %eax
80105713:	6a 00                	push   $0x0
80105715:	e8 16 f5 ff ff       	call   80104c30 <argstr>
8010571a:	83 c4 10             	add    $0x10,%esp
8010571d:	85 c0                	test   %eax,%eax
8010571f:	0f 88 87 00 00 00    	js     801057ac <sys_exec+0xac>
80105725:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010572b:	83 ec 08             	sub    $0x8,%esp
8010572e:	50                   	push   %eax
8010572f:	6a 01                	push   $0x1
80105731:	e8 4a f4 ff ff       	call   80104b80 <argint>
80105736:	83 c4 10             	add    $0x10,%esp
80105739:	85 c0                	test   %eax,%eax
8010573b:	78 6f                	js     801057ac <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010573d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105743:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105746:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105748:	68 80 00 00 00       	push   $0x80
8010574d:	6a 00                	push   $0x0
8010574f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105755:	50                   	push   %eax
80105756:	e8 25 f1 ff ff       	call   80104880 <memset>
8010575b:	83 c4 10             	add    $0x10,%esp
8010575e:	eb 2c                	jmp    8010578c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105760:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105766:	85 c0                	test   %eax,%eax
80105768:	74 56                	je     801057c0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010576a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105770:	83 ec 08             	sub    $0x8,%esp
80105773:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105776:	52                   	push   %edx
80105777:	50                   	push   %eax
80105778:	e8 93 f3 ff ff       	call   80104b10 <fetchstr>
8010577d:	83 c4 10             	add    $0x10,%esp
80105780:	85 c0                	test   %eax,%eax
80105782:	78 28                	js     801057ac <sys_exec+0xac>
  for(i=0;; i++){
80105784:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105787:	83 fb 20             	cmp    $0x20,%ebx
8010578a:	74 20                	je     801057ac <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010578c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105792:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105799:	83 ec 08             	sub    $0x8,%esp
8010579c:	57                   	push   %edi
8010579d:	01 f0                	add    %esi,%eax
8010579f:	50                   	push   %eax
801057a0:	e8 2b f3 ff ff       	call   80104ad0 <fetchint>
801057a5:	83 c4 10             	add    $0x10,%esp
801057a8:	85 c0                	test   %eax,%eax
801057aa:	79 b4                	jns    80105760 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801057ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801057af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057b4:	5b                   	pop    %ebx
801057b5:	5e                   	pop    %esi
801057b6:	5f                   	pop    %edi
801057b7:	5d                   	pop    %ebp
801057b8:	c3                   	ret    
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801057c0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801057c6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801057c9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801057d0:	00 00 00 00 
  return exec(path, argv);
801057d4:	50                   	push   %eax
801057d5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801057db:	e8 30 b5 ff ff       	call   80100d10 <exec>
801057e0:	83 c4 10             	add    $0x10,%esp
}
801057e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057e6:	5b                   	pop    %ebx
801057e7:	5e                   	pop    %esi
801057e8:	5f                   	pop    %edi
801057e9:	5d                   	pop    %ebp
801057ea:	c3                   	ret    
801057eb:	90                   	nop
801057ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057f0 <sys_pipe>:

int
sys_pipe(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	57                   	push   %edi
801057f4:	56                   	push   %esi
801057f5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057f6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801057f9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057fc:	6a 08                	push   $0x8
801057fe:	50                   	push   %eax
801057ff:	6a 00                	push   $0x0
80105801:	e8 ca f3 ff ff       	call   80104bd0 <argptr>
80105806:	83 c4 10             	add    $0x10,%esp
80105809:	85 c0                	test   %eax,%eax
8010580b:	0f 88 ae 00 00 00    	js     801058bf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105811:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105814:	83 ec 08             	sub    $0x8,%esp
80105817:	50                   	push   %eax
80105818:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010581b:	50                   	push   %eax
8010581c:	e8 2f dd ff ff       	call   80103550 <pipealloc>
80105821:	83 c4 10             	add    $0x10,%esp
80105824:	85 c0                	test   %eax,%eax
80105826:	0f 88 93 00 00 00    	js     801058bf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010582c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010582f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105831:	e8 ba e2 ff ff       	call   80103af0 <myproc>
80105836:	eb 10                	jmp    80105848 <sys_pipe+0x58>
80105838:	90                   	nop
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105840:	83 c3 01             	add    $0x1,%ebx
80105843:	83 fb 10             	cmp    $0x10,%ebx
80105846:	74 60                	je     801058a8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105848:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010584c:	85 f6                	test   %esi,%esi
8010584e:	75 f0                	jne    80105840 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105850:	8d 73 08             	lea    0x8(%ebx),%esi
80105853:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105857:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010585a:	e8 91 e2 ff ff       	call   80103af0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010585f:	31 d2                	xor    %edx,%edx
80105861:	eb 0d                	jmp    80105870 <sys_pipe+0x80>
80105863:	90                   	nop
80105864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105868:	83 c2 01             	add    $0x1,%edx
8010586b:	83 fa 10             	cmp    $0x10,%edx
8010586e:	74 28                	je     80105898 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105870:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105874:	85 c9                	test   %ecx,%ecx
80105876:	75 f0                	jne    80105868 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105878:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010587c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010587f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105881:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105884:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105887:	31 c0                	xor    %eax,%eax
}
80105889:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010588c:	5b                   	pop    %ebx
8010588d:	5e                   	pop    %esi
8010588e:	5f                   	pop    %edi
8010588f:	5d                   	pop    %ebp
80105890:	c3                   	ret    
80105891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105898:	e8 53 e2 ff ff       	call   80103af0 <myproc>
8010589d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801058a4:	00 
801058a5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801058a8:	83 ec 0c             	sub    $0xc,%esp
801058ab:	ff 75 e0             	pushl  -0x20(%ebp)
801058ae:	e8 8d b8 ff ff       	call   80101140 <fileclose>
    fileclose(wf);
801058b3:	58                   	pop    %eax
801058b4:	ff 75 e4             	pushl  -0x1c(%ebp)
801058b7:	e8 84 b8 ff ff       	call   80101140 <fileclose>
    return -1;
801058bc:	83 c4 10             	add    $0x10,%esp
801058bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c4:	eb c3                	jmp    80105889 <sys_pipe+0x99>
801058c6:	66 90                	xchg   %ax,%ax
801058c8:	66 90                	xchg   %ax,%ax
801058ca:	66 90                	xchg   %ax,%ax
801058cc:	66 90                	xchg   %ax,%ax
801058ce:	66 90                	xchg   %ax,%ax

801058d0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801058d3:	5d                   	pop    %ebp
  return fork();
801058d4:	e9 b7 e3 ff ff       	jmp    80103c90 <fork>
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_exit>:

int
sys_exit(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 08             	sub    $0x8,%esp
  exit();
801058e6:	e8 25 e6 ff ff       	call   80103f10 <exit>
  return 0;  // not reached
}
801058eb:	31 c0                	xor    %eax,%eax
801058ed:	c9                   	leave  
801058ee:	c3                   	ret    
801058ef:	90                   	nop

801058f0 <sys_wait>:

int
sys_wait(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801058f3:	5d                   	pop    %ebp
  return wait();
801058f4:	e9 57 e8 ff ff       	jmp    80104150 <wait>
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105900 <sys_kill>:

int
sys_kill(void)
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105906:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105909:	50                   	push   %eax
8010590a:	6a 00                	push   $0x0
8010590c:	e8 6f f2 ff ff       	call   80104b80 <argint>
80105911:	83 c4 10             	add    $0x10,%esp
80105914:	85 c0                	test   %eax,%eax
80105916:	78 18                	js     80105930 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105918:	83 ec 0c             	sub    $0xc,%esp
8010591b:	ff 75 f4             	pushl  -0xc(%ebp)
8010591e:	e8 7d e9 ff ff       	call   801042a0 <kill>
80105923:	83 c4 10             	add    $0x10,%esp
}
80105926:	c9                   	leave  
80105927:	c3                   	ret    
80105928:	90                   	nop
80105929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105935:	c9                   	leave  
80105936:	c3                   	ret    
80105937:	89 f6                	mov    %esi,%esi
80105939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105940 <sys_getpid>:

int
sys_getpid(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105946:	e8 a5 e1 ff ff       	call   80103af0 <myproc>
8010594b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010594e:	c9                   	leave  
8010594f:	c3                   	ret    

80105950 <sys_sbrk>:

int
sys_sbrk(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105954:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105957:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010595a:	50                   	push   %eax
8010595b:	6a 00                	push   $0x0
8010595d:	e8 1e f2 ff ff       	call   80104b80 <argint>
80105962:	83 c4 10             	add    $0x10,%esp
80105965:	85 c0                	test   %eax,%eax
80105967:	78 27                	js     80105990 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105969:	e8 82 e1 ff ff       	call   80103af0 <myproc>
  if(growproc(n) < 0)
8010596e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105971:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105973:	ff 75 f4             	pushl  -0xc(%ebp)
80105976:	e8 95 e2 ff ff       	call   80103c10 <growproc>
8010597b:	83 c4 10             	add    $0x10,%esp
8010597e:	85 c0                	test   %eax,%eax
80105980:	78 0e                	js     80105990 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105982:	89 d8                	mov    %ebx,%eax
80105984:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105987:	c9                   	leave  
80105988:	c3                   	ret    
80105989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105990:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105995:	eb eb                	jmp    80105982 <sys_sbrk+0x32>
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059a0 <sys_sleep>:

int
sys_sleep(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801059a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801059aa:	50                   	push   %eax
801059ab:	6a 00                	push   $0x0
801059ad:	e8 ce f1 ff ff       	call   80104b80 <argint>
801059b2:	83 c4 10             	add    $0x10,%esp
801059b5:	85 c0                	test   %eax,%eax
801059b7:	0f 88 8a 00 00 00    	js     80105a47 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801059bd:	83 ec 0c             	sub    $0xc,%esp
801059c0:	68 20 4f 11 80       	push   $0x80114f20
801059c5:	e8 a6 ed ff ff       	call   80104770 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801059ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059cd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801059d0:	8b 1d 60 57 11 80    	mov    0x80115760,%ebx
  while(ticks - ticks0 < n){
801059d6:	85 d2                	test   %edx,%edx
801059d8:	75 27                	jne    80105a01 <sys_sleep+0x61>
801059da:	eb 54                	jmp    80105a30 <sys_sleep+0x90>
801059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801059e0:	83 ec 08             	sub    $0x8,%esp
801059e3:	68 20 4f 11 80       	push   $0x80114f20
801059e8:	68 60 57 11 80       	push   $0x80115760
801059ed:	e8 9e e6 ff ff       	call   80104090 <sleep>
  while(ticks - ticks0 < n){
801059f2:	a1 60 57 11 80       	mov    0x80115760,%eax
801059f7:	83 c4 10             	add    $0x10,%esp
801059fa:	29 d8                	sub    %ebx,%eax
801059fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801059ff:	73 2f                	jae    80105a30 <sys_sleep+0x90>
    if(myproc()->killed){
80105a01:	e8 ea e0 ff ff       	call   80103af0 <myproc>
80105a06:	8b 40 24             	mov    0x24(%eax),%eax
80105a09:	85 c0                	test   %eax,%eax
80105a0b:	74 d3                	je     801059e0 <sys_sleep+0x40>
      release(&tickslock);
80105a0d:	83 ec 0c             	sub    $0xc,%esp
80105a10:	68 20 4f 11 80       	push   $0x80114f20
80105a15:	e8 16 ee ff ff       	call   80104830 <release>
      return -1;
80105a1a:	83 c4 10             	add    $0x10,%esp
80105a1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a25:	c9                   	leave  
80105a26:	c3                   	ret    
80105a27:	89 f6                	mov    %esi,%esi
80105a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105a30:	83 ec 0c             	sub    $0xc,%esp
80105a33:	68 20 4f 11 80       	push   $0x80114f20
80105a38:	e8 f3 ed ff ff       	call   80104830 <release>
  return 0;
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	31 c0                	xor    %eax,%eax
}
80105a42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a45:	c9                   	leave  
80105a46:	c3                   	ret    
    return -1;
80105a47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a4c:	eb f4                	jmp    80105a42 <sys_sleep+0xa2>
80105a4e:	66 90                	xchg   %ax,%ax

80105a50 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	53                   	push   %ebx
80105a54:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105a57:	68 20 4f 11 80       	push   $0x80114f20
80105a5c:	e8 0f ed ff ff       	call   80104770 <acquire>
  xticks = ticks;
80105a61:	8b 1d 60 57 11 80    	mov    0x80115760,%ebx
  release(&tickslock);
80105a67:	c7 04 24 20 4f 11 80 	movl   $0x80114f20,(%esp)
80105a6e:	e8 bd ed ff ff       	call   80104830 <release>
  return xticks;
}
80105a73:	89 d8                	mov    %ebx,%eax
80105a75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a78:	c9                   	leave  
80105a79:	c3                   	ret    
80105a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a80 <sys_incNum>:

int
sys_incNum(int num)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	83 ec 10             	sub    $0x10,%esp
  num++;
80105a86:	8b 45 08             	mov    0x8(%ebp),%eax
80105a89:	83 c0 01             	add    $0x1,%eax
  cprintf("increased and print in kernel surface %d\n",num);
80105a8c:	50                   	push   %eax
80105a8d:	68 84 7b 10 80       	push   $0x80107b84
80105a92:	e8 c9 ab ff ff       	call   80100660 <cprintf>
  return 22;
}
80105a97:	b8 16 00 00 00       	mov    $0x16,%eax
80105a9c:	c9                   	leave  
80105a9d:	c3                   	ret    
80105a9e:	66 90                	xchg   %ax,%ax

80105aa0 <sys_getprocs>:

int
sys_getprocs()
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
  return getprocs();
80105aa3:	5d                   	pop    %ebp
  return getprocs();
80105aa4:	e9 f7 e9 ff ff       	jmp    801044a0 <getprocs>

80105aa9 <alltraps>:
80105aa9:	1e                   	push   %ds
80105aaa:	06                   	push   %es
80105aab:	0f a0                	push   %fs
80105aad:	0f a8                	push   %gs
80105aaf:	60                   	pusha  
80105ab0:	66 b8 10 00          	mov    $0x10,%ax
80105ab4:	8e d8                	mov    %eax,%ds
80105ab6:	8e c0                	mov    %eax,%es
80105ab8:	54                   	push   %esp
80105ab9:	e8 c2 00 00 00       	call   80105b80 <trap>
80105abe:	83 c4 04             	add    $0x4,%esp

80105ac1 <trapret>:
80105ac1:	61                   	popa   
80105ac2:	0f a9                	pop    %gs
80105ac4:	0f a1                	pop    %fs
80105ac6:	07                   	pop    %es
80105ac7:	1f                   	pop    %ds
80105ac8:	83 c4 08             	add    $0x8,%esp
80105acb:	cf                   	iret   
80105acc:	66 90                	xchg   %ax,%ax
80105ace:	66 90                	xchg   %ax,%ax

80105ad0 <tvinit>:
80105ad0:	55                   	push   %ebp
80105ad1:	31 c0                	xor    %eax,%eax
80105ad3:	89 e5                	mov    %esp,%ebp
80105ad5:	83 ec 08             	sub    $0x8,%esp
80105ad8:	90                   	nop
80105ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ae0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105ae7:	c7 04 c5 62 4f 11 80 	movl   $0x8e000008,-0x7feeb09e(,%eax,8)
80105aee:	08 00 00 8e 
80105af2:	66 89 14 c5 60 4f 11 	mov    %dx,-0x7feeb0a0(,%eax,8)
80105af9:	80 
80105afa:	c1 ea 10             	shr    $0x10,%edx
80105afd:	66 89 14 c5 66 4f 11 	mov    %dx,-0x7feeb09a(,%eax,8)
80105b04:	80 
80105b05:	83 c0 01             	add    $0x1,%eax
80105b08:	3d 00 01 00 00       	cmp    $0x100,%eax
80105b0d:	75 d1                	jne    80105ae0 <tvinit+0x10>
80105b0f:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105b14:	83 ec 08             	sub    $0x8,%esp
80105b17:	c7 05 62 51 11 80 08 	movl   $0xef000008,0x80115162
80105b1e:	00 00 ef 
80105b21:	68 ae 7b 10 80       	push   $0x80107bae
80105b26:	68 20 4f 11 80       	push   $0x80114f20
80105b2b:	66 a3 60 51 11 80    	mov    %ax,0x80115160
80105b31:	c1 e8 10             	shr    $0x10,%eax
80105b34:	66 a3 66 51 11 80    	mov    %ax,0x80115166
80105b3a:	e8 f1 ea ff ff       	call   80104630 <initlock>
80105b3f:	83 c4 10             	add    $0x10,%esp
80105b42:	c9                   	leave  
80105b43:	c3                   	ret    
80105b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105b50 <idtinit>:
80105b50:	55                   	push   %ebp
80105b51:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b56:	89 e5                	mov    %esp,%ebp
80105b58:	83 ec 10             	sub    $0x10,%esp
80105b5b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80105b5f:	b8 60 4f 11 80       	mov    $0x80114f60,%eax
80105b64:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80105b68:	c1 e8 10             	shr    $0x10,%eax
80105b6b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80105b6f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b72:	0f 01 18             	lidtl  (%eax)
80105b75:	c9                   	leave  
80105b76:	c3                   	ret    
80105b77:	89 f6                	mov    %esi,%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b80 <trap>:
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	57                   	push   %edi
80105b84:	56                   	push   %esi
80105b85:	53                   	push   %ebx
80105b86:	83 ec 1c             	sub    $0x1c,%esp
80105b89:	8b 7d 08             	mov    0x8(%ebp),%edi
80105b8c:	8b 47 30             	mov    0x30(%edi),%eax
80105b8f:	83 f8 40             	cmp    $0x40,%eax
80105b92:	0f 84 f0 00 00 00    	je     80105c88 <trap+0x108>
80105b98:	83 e8 20             	sub    $0x20,%eax
80105b9b:	83 f8 1f             	cmp    $0x1f,%eax
80105b9e:	77 10                	ja     80105bb0 <trap+0x30>
80105ba0:	ff 24 85 54 7c 10 80 	jmp    *-0x7fef83ac(,%eax,4)
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105bb0:	e8 3b df ff ff       	call   80103af0 <myproc>
80105bb5:	85 c0                	test   %eax,%eax
80105bb7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105bba:	0f 84 14 02 00 00    	je     80105dd4 <trap+0x254>
80105bc0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105bc4:	0f 84 0a 02 00 00    	je     80105dd4 <trap+0x254>
80105bca:	0f 20 d1             	mov    %cr2,%ecx
80105bcd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105bd0:	e8 fb de ff ff       	call   80103ad0 <cpuid>
80105bd5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bd8:	8b 47 34             	mov    0x34(%edi),%eax
80105bdb:	8b 77 30             	mov    0x30(%edi),%esi
80105bde:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105be1:	e8 0a df ff ff       	call   80103af0 <myproc>
80105be6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105be9:	e8 02 df ff ff       	call   80103af0 <myproc>
80105bee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105bf1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105bf4:	51                   	push   %ecx
80105bf5:	53                   	push   %ebx
80105bf6:	52                   	push   %edx
80105bf7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105bfa:	ff 75 e4             	pushl  -0x1c(%ebp)
80105bfd:	56                   	push   %esi
80105bfe:	83 c2 6c             	add    $0x6c,%edx
80105c01:	52                   	push   %edx
80105c02:	ff 70 10             	pushl  0x10(%eax)
80105c05:	68 10 7c 10 80       	push   $0x80107c10
80105c0a:	e8 51 aa ff ff       	call   80100660 <cprintf>
80105c0f:	83 c4 20             	add    $0x20,%esp
80105c12:	e8 d9 de ff ff       	call   80103af0 <myproc>
80105c17:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105c1e:	e8 cd de ff ff       	call   80103af0 <myproc>
80105c23:	85 c0                	test   %eax,%eax
80105c25:	74 1d                	je     80105c44 <trap+0xc4>
80105c27:	e8 c4 de ff ff       	call   80103af0 <myproc>
80105c2c:	8b 50 24             	mov    0x24(%eax),%edx
80105c2f:	85 d2                	test   %edx,%edx
80105c31:	74 11                	je     80105c44 <trap+0xc4>
80105c33:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c37:	83 e0 03             	and    $0x3,%eax
80105c3a:	66 83 f8 03          	cmp    $0x3,%ax
80105c3e:	0f 84 4c 01 00 00    	je     80105d90 <trap+0x210>
80105c44:	e8 a7 de ff ff       	call   80103af0 <myproc>
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	74 0b                	je     80105c58 <trap+0xd8>
80105c4d:	e8 9e de ff ff       	call   80103af0 <myproc>
80105c52:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c56:	74 68                	je     80105cc0 <trap+0x140>
80105c58:	e8 93 de ff ff       	call   80103af0 <myproc>
80105c5d:	85 c0                	test   %eax,%eax
80105c5f:	74 19                	je     80105c7a <trap+0xfa>
80105c61:	e8 8a de ff ff       	call   80103af0 <myproc>
80105c66:	8b 40 24             	mov    0x24(%eax),%eax
80105c69:	85 c0                	test   %eax,%eax
80105c6b:	74 0d                	je     80105c7a <trap+0xfa>
80105c6d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c71:	83 e0 03             	and    $0x3,%eax
80105c74:	66 83 f8 03          	cmp    $0x3,%ax
80105c78:	74 37                	je     80105cb1 <trap+0x131>
80105c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c7d:	5b                   	pop    %ebx
80105c7e:	5e                   	pop    %esi
80105c7f:	5f                   	pop    %edi
80105c80:	5d                   	pop    %ebp
80105c81:	c3                   	ret    
80105c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c88:	e8 63 de ff ff       	call   80103af0 <myproc>
80105c8d:	8b 58 24             	mov    0x24(%eax),%ebx
80105c90:	85 db                	test   %ebx,%ebx
80105c92:	0f 85 e8 00 00 00    	jne    80105d80 <trap+0x200>
80105c98:	e8 53 de ff ff       	call   80103af0 <myproc>
80105c9d:	89 78 18             	mov    %edi,0x18(%eax)
80105ca0:	e8 cb ef ff ff       	call   80104c70 <syscall>
80105ca5:	e8 46 de ff ff       	call   80103af0 <myproc>
80105caa:	8b 48 24             	mov    0x24(%eax),%ecx
80105cad:	85 c9                	test   %ecx,%ecx
80105caf:	74 c9                	je     80105c7a <trap+0xfa>
80105cb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cb4:	5b                   	pop    %ebx
80105cb5:	5e                   	pop    %esi
80105cb6:	5f                   	pop    %edi
80105cb7:	5d                   	pop    %ebp
80105cb8:	e9 53 e2 ff ff       	jmp    80103f10 <exit>
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi
80105cc0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105cc4:	75 92                	jne    80105c58 <trap+0xd8>
80105cc6:	e8 75 e3 ff ff       	call   80104040 <yield>
80105ccb:	eb 8b                	jmp    80105c58 <trap+0xd8>
80105ccd:	8d 76 00             	lea    0x0(%esi),%esi
80105cd0:	e8 fb dd ff ff       	call   80103ad0 <cpuid>
80105cd5:	85 c0                	test   %eax,%eax
80105cd7:	0f 84 c3 00 00 00    	je     80105da0 <trap+0x220>
80105cdd:	e8 7e cd ff ff       	call   80102a60 <lapiceoi>
80105ce2:	e8 09 de ff ff       	call   80103af0 <myproc>
80105ce7:	85 c0                	test   %eax,%eax
80105ce9:	0f 85 38 ff ff ff    	jne    80105c27 <trap+0xa7>
80105cef:	e9 50 ff ff ff       	jmp    80105c44 <trap+0xc4>
80105cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105cf8:	e8 23 cc ff ff       	call   80102920 <kbdintr>
80105cfd:	e8 5e cd ff ff       	call   80102a60 <lapiceoi>
80105d02:	e8 e9 dd ff ff       	call   80103af0 <myproc>
80105d07:	85 c0                	test   %eax,%eax
80105d09:	0f 85 18 ff ff ff    	jne    80105c27 <trap+0xa7>
80105d0f:	e9 30 ff ff ff       	jmp    80105c44 <trap+0xc4>
80105d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d18:	e8 53 02 00 00       	call   80105f70 <uartintr>
80105d1d:	e8 3e cd ff ff       	call   80102a60 <lapiceoi>
80105d22:	e8 c9 dd ff ff       	call   80103af0 <myproc>
80105d27:	85 c0                	test   %eax,%eax
80105d29:	0f 85 f8 fe ff ff    	jne    80105c27 <trap+0xa7>
80105d2f:	e9 10 ff ff ff       	jmp    80105c44 <trap+0xc4>
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d38:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105d3c:	8b 77 38             	mov    0x38(%edi),%esi
80105d3f:	e8 8c dd ff ff       	call   80103ad0 <cpuid>
80105d44:	56                   	push   %esi
80105d45:	53                   	push   %ebx
80105d46:	50                   	push   %eax
80105d47:	68 b8 7b 10 80       	push   $0x80107bb8
80105d4c:	e8 0f a9 ff ff       	call   80100660 <cprintf>
80105d51:	e8 0a cd ff ff       	call   80102a60 <lapiceoi>
80105d56:	83 c4 10             	add    $0x10,%esp
80105d59:	e8 92 dd ff ff       	call   80103af0 <myproc>
80105d5e:	85 c0                	test   %eax,%eax
80105d60:	0f 85 c1 fe ff ff    	jne    80105c27 <trap+0xa7>
80105d66:	e9 d9 fe ff ff       	jmp    80105c44 <trap+0xc4>
80105d6b:	90                   	nop
80105d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d70:	e8 1b c6 ff ff       	call   80102390 <ideintr>
80105d75:	e9 63 ff ff ff       	jmp    80105cdd <trap+0x15d>
80105d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d80:	e8 8b e1 ff ff       	call   80103f10 <exit>
80105d85:	e9 0e ff ff ff       	jmp    80105c98 <trap+0x118>
80105d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d90:	e8 7b e1 ff ff       	call   80103f10 <exit>
80105d95:	e9 aa fe ff ff       	jmp    80105c44 <trap+0xc4>
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105da0:	83 ec 0c             	sub    $0xc,%esp
80105da3:	68 20 4f 11 80       	push   $0x80114f20
80105da8:	e8 c3 e9 ff ff       	call   80104770 <acquire>
80105dad:	c7 04 24 60 57 11 80 	movl   $0x80115760,(%esp)
80105db4:	83 05 60 57 11 80 01 	addl   $0x1,0x80115760
80105dbb:	e8 80 e4 ff ff       	call   80104240 <wakeup>
80105dc0:	c7 04 24 20 4f 11 80 	movl   $0x80114f20,(%esp)
80105dc7:	e8 64 ea ff ff       	call   80104830 <release>
80105dcc:	83 c4 10             	add    $0x10,%esp
80105dcf:	e9 09 ff ff ff       	jmp    80105cdd <trap+0x15d>
80105dd4:	0f 20 d6             	mov    %cr2,%esi
80105dd7:	e8 f4 dc ff ff       	call   80103ad0 <cpuid>
80105ddc:	83 ec 0c             	sub    $0xc,%esp
80105ddf:	56                   	push   %esi
80105de0:	53                   	push   %ebx
80105de1:	50                   	push   %eax
80105de2:	ff 77 30             	pushl  0x30(%edi)
80105de5:	68 dc 7b 10 80       	push   $0x80107bdc
80105dea:	e8 71 a8 ff ff       	call   80100660 <cprintf>
80105def:	83 c4 14             	add    $0x14,%esp
80105df2:	68 b3 7b 10 80       	push   $0x80107bb3
80105df7:	e8 94 a5 ff ff       	call   80100390 <panic>
80105dfc:	66 90                	xchg   %ax,%ax
80105dfe:	66 90                	xchg   %ax,%ax

80105e00 <uartgetc>:
80105e00:	a1 fc a5 10 80       	mov    0x8010a5fc,%eax
80105e05:	55                   	push   %ebp
80105e06:	89 e5                	mov    %esp,%ebp
80105e08:	85 c0                	test   %eax,%eax
80105e0a:	74 1c                	je     80105e28 <uartgetc+0x28>
80105e0c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e11:	ec                   	in     (%dx),%al
80105e12:	a8 01                	test   $0x1,%al
80105e14:	74 12                	je     80105e28 <uartgetc+0x28>
80105e16:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e1b:	ec                   	in     (%dx),%al
80105e1c:	0f b6 c0             	movzbl %al,%eax
80105e1f:	5d                   	pop    %ebp
80105e20:	c3                   	ret    
80105e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e2d:	5d                   	pop    %ebp
80105e2e:	c3                   	ret    
80105e2f:	90                   	nop

80105e30 <uartputc.part.0>:
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	57                   	push   %edi
80105e34:	56                   	push   %esi
80105e35:	53                   	push   %ebx
80105e36:	89 c7                	mov    %eax,%edi
80105e38:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e3d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e42:	83 ec 0c             	sub    $0xc,%esp
80105e45:	eb 1b                	jmp    80105e62 <uartputc.part.0+0x32>
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e50:	83 ec 0c             	sub    $0xc,%esp
80105e53:	6a 0a                	push   $0xa
80105e55:	e8 26 cc ff ff       	call   80102a80 <microdelay>
80105e5a:	83 c4 10             	add    $0x10,%esp
80105e5d:	83 eb 01             	sub    $0x1,%ebx
80105e60:	74 07                	je     80105e69 <uartputc.part.0+0x39>
80105e62:	89 f2                	mov    %esi,%edx
80105e64:	ec                   	in     (%dx),%al
80105e65:	a8 20                	test   $0x20,%al
80105e67:	74 e7                	je     80105e50 <uartputc.part.0+0x20>
80105e69:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e6e:	89 f8                	mov    %edi,%eax
80105e70:	ee                   	out    %al,(%dx)
80105e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e74:	5b                   	pop    %ebx
80105e75:	5e                   	pop    %esi
80105e76:	5f                   	pop    %edi
80105e77:	5d                   	pop    %ebp
80105e78:	c3                   	ret    
80105e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e80 <uartinit>:
80105e80:	55                   	push   %ebp
80105e81:	31 c9                	xor    %ecx,%ecx
80105e83:	89 c8                	mov    %ecx,%eax
80105e85:	89 e5                	mov    %esp,%ebp
80105e87:	57                   	push   %edi
80105e88:	56                   	push   %esi
80105e89:	53                   	push   %ebx
80105e8a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e8f:	89 da                	mov    %ebx,%edx
80105e91:	83 ec 0c             	sub    $0xc,%esp
80105e94:	ee                   	out    %al,(%dx)
80105e95:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e9a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105e9f:	89 fa                	mov    %edi,%edx
80105ea1:	ee                   	out    %al,(%dx)
80105ea2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ea7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105eac:	ee                   	out    %al,(%dx)
80105ead:	be f9 03 00 00       	mov    $0x3f9,%esi
80105eb2:	89 c8                	mov    %ecx,%eax
80105eb4:	89 f2                	mov    %esi,%edx
80105eb6:	ee                   	out    %al,(%dx)
80105eb7:	b8 03 00 00 00       	mov    $0x3,%eax
80105ebc:	89 fa                	mov    %edi,%edx
80105ebe:	ee                   	out    %al,(%dx)
80105ebf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ec4:	89 c8                	mov    %ecx,%eax
80105ec6:	ee                   	out    %al,(%dx)
80105ec7:	b8 01 00 00 00       	mov    $0x1,%eax
80105ecc:	89 f2                	mov    %esi,%edx
80105ece:	ee                   	out    %al,(%dx)
80105ecf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ed4:	ec                   	in     (%dx),%al
80105ed5:	3c ff                	cmp    $0xff,%al
80105ed7:	74 5a                	je     80105f33 <uartinit+0xb3>
80105ed9:	c7 05 fc a5 10 80 01 	movl   $0x1,0x8010a5fc
80105ee0:	00 00 00 
80105ee3:	89 da                	mov    %ebx,%edx
80105ee5:	ec                   	in     (%dx),%al
80105ee6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105eeb:	ec                   	in     (%dx),%al
80105eec:	83 ec 08             	sub    $0x8,%esp
80105eef:	bb d4 7c 10 80       	mov    $0x80107cd4,%ebx
80105ef4:	6a 00                	push   $0x0
80105ef6:	6a 04                	push   $0x4
80105ef8:	e8 e3 c6 ff ff       	call   801025e0 <ioapicenable>
80105efd:	83 c4 10             	add    $0x10,%esp
80105f00:	b8 78 00 00 00       	mov    $0x78,%eax
80105f05:	eb 13                	jmp    80105f1a <uartinit+0x9a>
80105f07:	89 f6                	mov    %esi,%esi
80105f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f10:	83 c3 01             	add    $0x1,%ebx
80105f13:	0f be 03             	movsbl (%ebx),%eax
80105f16:	84 c0                	test   %al,%al
80105f18:	74 19                	je     80105f33 <uartinit+0xb3>
80105f1a:	8b 15 fc a5 10 80    	mov    0x8010a5fc,%edx
80105f20:	85 d2                	test   %edx,%edx
80105f22:	74 ec                	je     80105f10 <uartinit+0x90>
80105f24:	83 c3 01             	add    $0x1,%ebx
80105f27:	e8 04 ff ff ff       	call   80105e30 <uartputc.part.0>
80105f2c:	0f be 03             	movsbl (%ebx),%eax
80105f2f:	84 c0                	test   %al,%al
80105f31:	75 e7                	jne    80105f1a <uartinit+0x9a>
80105f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f36:	5b                   	pop    %ebx
80105f37:	5e                   	pop    %esi
80105f38:	5f                   	pop    %edi
80105f39:	5d                   	pop    %ebp
80105f3a:	c3                   	ret    
80105f3b:	90                   	nop
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f40 <uartputc>:
80105f40:	8b 15 fc a5 10 80    	mov    0x8010a5fc,%edx
80105f46:	55                   	push   %ebp
80105f47:	89 e5                	mov    %esp,%ebp
80105f49:	85 d2                	test   %edx,%edx
80105f4b:	8b 45 08             	mov    0x8(%ebp),%eax
80105f4e:	74 10                	je     80105f60 <uartputc+0x20>
80105f50:	5d                   	pop    %ebp
80105f51:	e9 da fe ff ff       	jmp    80105e30 <uartputc.part.0>
80105f56:	8d 76 00             	lea    0x0(%esi),%esi
80105f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f60:	5d                   	pop    %ebp
80105f61:	c3                   	ret    
80105f62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f70 <uartintr>:
80105f70:	55                   	push   %ebp
80105f71:	89 e5                	mov    %esp,%ebp
80105f73:	83 ec 14             	sub    $0x14,%esp
80105f76:	68 00 5e 10 80       	push   $0x80105e00
80105f7b:	e8 60 ab ff ff       	call   80100ae0 <consoleintr>
80105f80:	83 c4 10             	add    $0x10,%esp
80105f83:	c9                   	leave  
80105f84:	c3                   	ret    

80105f85 <vector0>:
80105f85:	6a 00                	push   $0x0
80105f87:	6a 00                	push   $0x0
80105f89:	e9 1b fb ff ff       	jmp    80105aa9 <alltraps>

80105f8e <vector1>:
80105f8e:	6a 00                	push   $0x0
80105f90:	6a 01                	push   $0x1
80105f92:	e9 12 fb ff ff       	jmp    80105aa9 <alltraps>

80105f97 <vector2>:
80105f97:	6a 00                	push   $0x0
80105f99:	6a 02                	push   $0x2
80105f9b:	e9 09 fb ff ff       	jmp    80105aa9 <alltraps>

80105fa0 <vector3>:
80105fa0:	6a 00                	push   $0x0
80105fa2:	6a 03                	push   $0x3
80105fa4:	e9 00 fb ff ff       	jmp    80105aa9 <alltraps>

80105fa9 <vector4>:
80105fa9:	6a 00                	push   $0x0
80105fab:	6a 04                	push   $0x4
80105fad:	e9 f7 fa ff ff       	jmp    80105aa9 <alltraps>

80105fb2 <vector5>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	6a 05                	push   $0x5
80105fb6:	e9 ee fa ff ff       	jmp    80105aa9 <alltraps>

80105fbb <vector6>:
80105fbb:	6a 00                	push   $0x0
80105fbd:	6a 06                	push   $0x6
80105fbf:	e9 e5 fa ff ff       	jmp    80105aa9 <alltraps>

80105fc4 <vector7>:
80105fc4:	6a 00                	push   $0x0
80105fc6:	6a 07                	push   $0x7
80105fc8:	e9 dc fa ff ff       	jmp    80105aa9 <alltraps>

80105fcd <vector8>:
80105fcd:	6a 08                	push   $0x8
80105fcf:	e9 d5 fa ff ff       	jmp    80105aa9 <alltraps>

80105fd4 <vector9>:
80105fd4:	6a 00                	push   $0x0
80105fd6:	6a 09                	push   $0x9
80105fd8:	e9 cc fa ff ff       	jmp    80105aa9 <alltraps>

80105fdd <vector10>:
80105fdd:	6a 0a                	push   $0xa
80105fdf:	e9 c5 fa ff ff       	jmp    80105aa9 <alltraps>

80105fe4 <vector11>:
80105fe4:	6a 0b                	push   $0xb
80105fe6:	e9 be fa ff ff       	jmp    80105aa9 <alltraps>

80105feb <vector12>:
80105feb:	6a 0c                	push   $0xc
80105fed:	e9 b7 fa ff ff       	jmp    80105aa9 <alltraps>

80105ff2 <vector13>:
80105ff2:	6a 0d                	push   $0xd
80105ff4:	e9 b0 fa ff ff       	jmp    80105aa9 <alltraps>

80105ff9 <vector14>:
80105ff9:	6a 0e                	push   $0xe
80105ffb:	e9 a9 fa ff ff       	jmp    80105aa9 <alltraps>

80106000 <vector15>:
80106000:	6a 00                	push   $0x0
80106002:	6a 0f                	push   $0xf
80106004:	e9 a0 fa ff ff       	jmp    80105aa9 <alltraps>

80106009 <vector16>:
80106009:	6a 00                	push   $0x0
8010600b:	6a 10                	push   $0x10
8010600d:	e9 97 fa ff ff       	jmp    80105aa9 <alltraps>

80106012 <vector17>:
80106012:	6a 11                	push   $0x11
80106014:	e9 90 fa ff ff       	jmp    80105aa9 <alltraps>

80106019 <vector18>:
80106019:	6a 00                	push   $0x0
8010601b:	6a 12                	push   $0x12
8010601d:	e9 87 fa ff ff       	jmp    80105aa9 <alltraps>

80106022 <vector19>:
80106022:	6a 00                	push   $0x0
80106024:	6a 13                	push   $0x13
80106026:	e9 7e fa ff ff       	jmp    80105aa9 <alltraps>

8010602b <vector20>:
8010602b:	6a 00                	push   $0x0
8010602d:	6a 14                	push   $0x14
8010602f:	e9 75 fa ff ff       	jmp    80105aa9 <alltraps>

80106034 <vector21>:
80106034:	6a 00                	push   $0x0
80106036:	6a 15                	push   $0x15
80106038:	e9 6c fa ff ff       	jmp    80105aa9 <alltraps>

8010603d <vector22>:
8010603d:	6a 00                	push   $0x0
8010603f:	6a 16                	push   $0x16
80106041:	e9 63 fa ff ff       	jmp    80105aa9 <alltraps>

80106046 <vector23>:
80106046:	6a 00                	push   $0x0
80106048:	6a 17                	push   $0x17
8010604a:	e9 5a fa ff ff       	jmp    80105aa9 <alltraps>

8010604f <vector24>:
8010604f:	6a 00                	push   $0x0
80106051:	6a 18                	push   $0x18
80106053:	e9 51 fa ff ff       	jmp    80105aa9 <alltraps>

80106058 <vector25>:
80106058:	6a 00                	push   $0x0
8010605a:	6a 19                	push   $0x19
8010605c:	e9 48 fa ff ff       	jmp    80105aa9 <alltraps>

80106061 <vector26>:
80106061:	6a 00                	push   $0x0
80106063:	6a 1a                	push   $0x1a
80106065:	e9 3f fa ff ff       	jmp    80105aa9 <alltraps>

8010606a <vector27>:
8010606a:	6a 00                	push   $0x0
8010606c:	6a 1b                	push   $0x1b
8010606e:	e9 36 fa ff ff       	jmp    80105aa9 <alltraps>

80106073 <vector28>:
80106073:	6a 00                	push   $0x0
80106075:	6a 1c                	push   $0x1c
80106077:	e9 2d fa ff ff       	jmp    80105aa9 <alltraps>

8010607c <vector29>:
8010607c:	6a 00                	push   $0x0
8010607e:	6a 1d                	push   $0x1d
80106080:	e9 24 fa ff ff       	jmp    80105aa9 <alltraps>

80106085 <vector30>:
80106085:	6a 00                	push   $0x0
80106087:	6a 1e                	push   $0x1e
80106089:	e9 1b fa ff ff       	jmp    80105aa9 <alltraps>

8010608e <vector31>:
8010608e:	6a 00                	push   $0x0
80106090:	6a 1f                	push   $0x1f
80106092:	e9 12 fa ff ff       	jmp    80105aa9 <alltraps>

80106097 <vector32>:
80106097:	6a 00                	push   $0x0
80106099:	6a 20                	push   $0x20
8010609b:	e9 09 fa ff ff       	jmp    80105aa9 <alltraps>

801060a0 <vector33>:
801060a0:	6a 00                	push   $0x0
801060a2:	6a 21                	push   $0x21
801060a4:	e9 00 fa ff ff       	jmp    80105aa9 <alltraps>

801060a9 <vector34>:
801060a9:	6a 00                	push   $0x0
801060ab:	6a 22                	push   $0x22
801060ad:	e9 f7 f9 ff ff       	jmp    80105aa9 <alltraps>

801060b2 <vector35>:
801060b2:	6a 00                	push   $0x0
801060b4:	6a 23                	push   $0x23
801060b6:	e9 ee f9 ff ff       	jmp    80105aa9 <alltraps>

801060bb <vector36>:
801060bb:	6a 00                	push   $0x0
801060bd:	6a 24                	push   $0x24
801060bf:	e9 e5 f9 ff ff       	jmp    80105aa9 <alltraps>

801060c4 <vector37>:
801060c4:	6a 00                	push   $0x0
801060c6:	6a 25                	push   $0x25
801060c8:	e9 dc f9 ff ff       	jmp    80105aa9 <alltraps>

801060cd <vector38>:
801060cd:	6a 00                	push   $0x0
801060cf:	6a 26                	push   $0x26
801060d1:	e9 d3 f9 ff ff       	jmp    80105aa9 <alltraps>

801060d6 <vector39>:
801060d6:	6a 00                	push   $0x0
801060d8:	6a 27                	push   $0x27
801060da:	e9 ca f9 ff ff       	jmp    80105aa9 <alltraps>

801060df <vector40>:
801060df:	6a 00                	push   $0x0
801060e1:	6a 28                	push   $0x28
801060e3:	e9 c1 f9 ff ff       	jmp    80105aa9 <alltraps>

801060e8 <vector41>:
801060e8:	6a 00                	push   $0x0
801060ea:	6a 29                	push   $0x29
801060ec:	e9 b8 f9 ff ff       	jmp    80105aa9 <alltraps>

801060f1 <vector42>:
801060f1:	6a 00                	push   $0x0
801060f3:	6a 2a                	push   $0x2a
801060f5:	e9 af f9 ff ff       	jmp    80105aa9 <alltraps>

801060fa <vector43>:
801060fa:	6a 00                	push   $0x0
801060fc:	6a 2b                	push   $0x2b
801060fe:	e9 a6 f9 ff ff       	jmp    80105aa9 <alltraps>

80106103 <vector44>:
80106103:	6a 00                	push   $0x0
80106105:	6a 2c                	push   $0x2c
80106107:	e9 9d f9 ff ff       	jmp    80105aa9 <alltraps>

8010610c <vector45>:
8010610c:	6a 00                	push   $0x0
8010610e:	6a 2d                	push   $0x2d
80106110:	e9 94 f9 ff ff       	jmp    80105aa9 <alltraps>

80106115 <vector46>:
80106115:	6a 00                	push   $0x0
80106117:	6a 2e                	push   $0x2e
80106119:	e9 8b f9 ff ff       	jmp    80105aa9 <alltraps>

8010611e <vector47>:
8010611e:	6a 00                	push   $0x0
80106120:	6a 2f                	push   $0x2f
80106122:	e9 82 f9 ff ff       	jmp    80105aa9 <alltraps>

80106127 <vector48>:
80106127:	6a 00                	push   $0x0
80106129:	6a 30                	push   $0x30
8010612b:	e9 79 f9 ff ff       	jmp    80105aa9 <alltraps>

80106130 <vector49>:
80106130:	6a 00                	push   $0x0
80106132:	6a 31                	push   $0x31
80106134:	e9 70 f9 ff ff       	jmp    80105aa9 <alltraps>

80106139 <vector50>:
80106139:	6a 00                	push   $0x0
8010613b:	6a 32                	push   $0x32
8010613d:	e9 67 f9 ff ff       	jmp    80105aa9 <alltraps>

80106142 <vector51>:
80106142:	6a 00                	push   $0x0
80106144:	6a 33                	push   $0x33
80106146:	e9 5e f9 ff ff       	jmp    80105aa9 <alltraps>

8010614b <vector52>:
8010614b:	6a 00                	push   $0x0
8010614d:	6a 34                	push   $0x34
8010614f:	e9 55 f9 ff ff       	jmp    80105aa9 <alltraps>

80106154 <vector53>:
80106154:	6a 00                	push   $0x0
80106156:	6a 35                	push   $0x35
80106158:	e9 4c f9 ff ff       	jmp    80105aa9 <alltraps>

8010615d <vector54>:
8010615d:	6a 00                	push   $0x0
8010615f:	6a 36                	push   $0x36
80106161:	e9 43 f9 ff ff       	jmp    80105aa9 <alltraps>

80106166 <vector55>:
80106166:	6a 00                	push   $0x0
80106168:	6a 37                	push   $0x37
8010616a:	e9 3a f9 ff ff       	jmp    80105aa9 <alltraps>

8010616f <vector56>:
8010616f:	6a 00                	push   $0x0
80106171:	6a 38                	push   $0x38
80106173:	e9 31 f9 ff ff       	jmp    80105aa9 <alltraps>

80106178 <vector57>:
80106178:	6a 00                	push   $0x0
8010617a:	6a 39                	push   $0x39
8010617c:	e9 28 f9 ff ff       	jmp    80105aa9 <alltraps>

80106181 <vector58>:
80106181:	6a 00                	push   $0x0
80106183:	6a 3a                	push   $0x3a
80106185:	e9 1f f9 ff ff       	jmp    80105aa9 <alltraps>

8010618a <vector59>:
8010618a:	6a 00                	push   $0x0
8010618c:	6a 3b                	push   $0x3b
8010618e:	e9 16 f9 ff ff       	jmp    80105aa9 <alltraps>

80106193 <vector60>:
80106193:	6a 00                	push   $0x0
80106195:	6a 3c                	push   $0x3c
80106197:	e9 0d f9 ff ff       	jmp    80105aa9 <alltraps>

8010619c <vector61>:
8010619c:	6a 00                	push   $0x0
8010619e:	6a 3d                	push   $0x3d
801061a0:	e9 04 f9 ff ff       	jmp    80105aa9 <alltraps>

801061a5 <vector62>:
801061a5:	6a 00                	push   $0x0
801061a7:	6a 3e                	push   $0x3e
801061a9:	e9 fb f8 ff ff       	jmp    80105aa9 <alltraps>

801061ae <vector63>:
801061ae:	6a 00                	push   $0x0
801061b0:	6a 3f                	push   $0x3f
801061b2:	e9 f2 f8 ff ff       	jmp    80105aa9 <alltraps>

801061b7 <vector64>:
801061b7:	6a 00                	push   $0x0
801061b9:	6a 40                	push   $0x40
801061bb:	e9 e9 f8 ff ff       	jmp    80105aa9 <alltraps>

801061c0 <vector65>:
801061c0:	6a 00                	push   $0x0
801061c2:	6a 41                	push   $0x41
801061c4:	e9 e0 f8 ff ff       	jmp    80105aa9 <alltraps>

801061c9 <vector66>:
801061c9:	6a 00                	push   $0x0
801061cb:	6a 42                	push   $0x42
801061cd:	e9 d7 f8 ff ff       	jmp    80105aa9 <alltraps>

801061d2 <vector67>:
801061d2:	6a 00                	push   $0x0
801061d4:	6a 43                	push   $0x43
801061d6:	e9 ce f8 ff ff       	jmp    80105aa9 <alltraps>

801061db <vector68>:
801061db:	6a 00                	push   $0x0
801061dd:	6a 44                	push   $0x44
801061df:	e9 c5 f8 ff ff       	jmp    80105aa9 <alltraps>

801061e4 <vector69>:
801061e4:	6a 00                	push   $0x0
801061e6:	6a 45                	push   $0x45
801061e8:	e9 bc f8 ff ff       	jmp    80105aa9 <alltraps>

801061ed <vector70>:
801061ed:	6a 00                	push   $0x0
801061ef:	6a 46                	push   $0x46
801061f1:	e9 b3 f8 ff ff       	jmp    80105aa9 <alltraps>

801061f6 <vector71>:
801061f6:	6a 00                	push   $0x0
801061f8:	6a 47                	push   $0x47
801061fa:	e9 aa f8 ff ff       	jmp    80105aa9 <alltraps>

801061ff <vector72>:
801061ff:	6a 00                	push   $0x0
80106201:	6a 48                	push   $0x48
80106203:	e9 a1 f8 ff ff       	jmp    80105aa9 <alltraps>

80106208 <vector73>:
80106208:	6a 00                	push   $0x0
8010620a:	6a 49                	push   $0x49
8010620c:	e9 98 f8 ff ff       	jmp    80105aa9 <alltraps>

80106211 <vector74>:
80106211:	6a 00                	push   $0x0
80106213:	6a 4a                	push   $0x4a
80106215:	e9 8f f8 ff ff       	jmp    80105aa9 <alltraps>

8010621a <vector75>:
8010621a:	6a 00                	push   $0x0
8010621c:	6a 4b                	push   $0x4b
8010621e:	e9 86 f8 ff ff       	jmp    80105aa9 <alltraps>

80106223 <vector76>:
80106223:	6a 00                	push   $0x0
80106225:	6a 4c                	push   $0x4c
80106227:	e9 7d f8 ff ff       	jmp    80105aa9 <alltraps>

8010622c <vector77>:
8010622c:	6a 00                	push   $0x0
8010622e:	6a 4d                	push   $0x4d
80106230:	e9 74 f8 ff ff       	jmp    80105aa9 <alltraps>

80106235 <vector78>:
80106235:	6a 00                	push   $0x0
80106237:	6a 4e                	push   $0x4e
80106239:	e9 6b f8 ff ff       	jmp    80105aa9 <alltraps>

8010623e <vector79>:
8010623e:	6a 00                	push   $0x0
80106240:	6a 4f                	push   $0x4f
80106242:	e9 62 f8 ff ff       	jmp    80105aa9 <alltraps>

80106247 <vector80>:
80106247:	6a 00                	push   $0x0
80106249:	6a 50                	push   $0x50
8010624b:	e9 59 f8 ff ff       	jmp    80105aa9 <alltraps>

80106250 <vector81>:
80106250:	6a 00                	push   $0x0
80106252:	6a 51                	push   $0x51
80106254:	e9 50 f8 ff ff       	jmp    80105aa9 <alltraps>

80106259 <vector82>:
80106259:	6a 00                	push   $0x0
8010625b:	6a 52                	push   $0x52
8010625d:	e9 47 f8 ff ff       	jmp    80105aa9 <alltraps>

80106262 <vector83>:
80106262:	6a 00                	push   $0x0
80106264:	6a 53                	push   $0x53
80106266:	e9 3e f8 ff ff       	jmp    80105aa9 <alltraps>

8010626b <vector84>:
8010626b:	6a 00                	push   $0x0
8010626d:	6a 54                	push   $0x54
8010626f:	e9 35 f8 ff ff       	jmp    80105aa9 <alltraps>

80106274 <vector85>:
80106274:	6a 00                	push   $0x0
80106276:	6a 55                	push   $0x55
80106278:	e9 2c f8 ff ff       	jmp    80105aa9 <alltraps>

8010627d <vector86>:
8010627d:	6a 00                	push   $0x0
8010627f:	6a 56                	push   $0x56
80106281:	e9 23 f8 ff ff       	jmp    80105aa9 <alltraps>

80106286 <vector87>:
80106286:	6a 00                	push   $0x0
80106288:	6a 57                	push   $0x57
8010628a:	e9 1a f8 ff ff       	jmp    80105aa9 <alltraps>

8010628f <vector88>:
8010628f:	6a 00                	push   $0x0
80106291:	6a 58                	push   $0x58
80106293:	e9 11 f8 ff ff       	jmp    80105aa9 <alltraps>

80106298 <vector89>:
80106298:	6a 00                	push   $0x0
8010629a:	6a 59                	push   $0x59
8010629c:	e9 08 f8 ff ff       	jmp    80105aa9 <alltraps>

801062a1 <vector90>:
801062a1:	6a 00                	push   $0x0
801062a3:	6a 5a                	push   $0x5a
801062a5:	e9 ff f7 ff ff       	jmp    80105aa9 <alltraps>

801062aa <vector91>:
801062aa:	6a 00                	push   $0x0
801062ac:	6a 5b                	push   $0x5b
801062ae:	e9 f6 f7 ff ff       	jmp    80105aa9 <alltraps>

801062b3 <vector92>:
801062b3:	6a 00                	push   $0x0
801062b5:	6a 5c                	push   $0x5c
801062b7:	e9 ed f7 ff ff       	jmp    80105aa9 <alltraps>

801062bc <vector93>:
801062bc:	6a 00                	push   $0x0
801062be:	6a 5d                	push   $0x5d
801062c0:	e9 e4 f7 ff ff       	jmp    80105aa9 <alltraps>

801062c5 <vector94>:
801062c5:	6a 00                	push   $0x0
801062c7:	6a 5e                	push   $0x5e
801062c9:	e9 db f7 ff ff       	jmp    80105aa9 <alltraps>

801062ce <vector95>:
801062ce:	6a 00                	push   $0x0
801062d0:	6a 5f                	push   $0x5f
801062d2:	e9 d2 f7 ff ff       	jmp    80105aa9 <alltraps>

801062d7 <vector96>:
801062d7:	6a 00                	push   $0x0
801062d9:	6a 60                	push   $0x60
801062db:	e9 c9 f7 ff ff       	jmp    80105aa9 <alltraps>

801062e0 <vector97>:
801062e0:	6a 00                	push   $0x0
801062e2:	6a 61                	push   $0x61
801062e4:	e9 c0 f7 ff ff       	jmp    80105aa9 <alltraps>

801062e9 <vector98>:
801062e9:	6a 00                	push   $0x0
801062eb:	6a 62                	push   $0x62
801062ed:	e9 b7 f7 ff ff       	jmp    80105aa9 <alltraps>

801062f2 <vector99>:
801062f2:	6a 00                	push   $0x0
801062f4:	6a 63                	push   $0x63
801062f6:	e9 ae f7 ff ff       	jmp    80105aa9 <alltraps>

801062fb <vector100>:
801062fb:	6a 00                	push   $0x0
801062fd:	6a 64                	push   $0x64
801062ff:	e9 a5 f7 ff ff       	jmp    80105aa9 <alltraps>

80106304 <vector101>:
80106304:	6a 00                	push   $0x0
80106306:	6a 65                	push   $0x65
80106308:	e9 9c f7 ff ff       	jmp    80105aa9 <alltraps>

8010630d <vector102>:
8010630d:	6a 00                	push   $0x0
8010630f:	6a 66                	push   $0x66
80106311:	e9 93 f7 ff ff       	jmp    80105aa9 <alltraps>

80106316 <vector103>:
80106316:	6a 00                	push   $0x0
80106318:	6a 67                	push   $0x67
8010631a:	e9 8a f7 ff ff       	jmp    80105aa9 <alltraps>

8010631f <vector104>:
8010631f:	6a 00                	push   $0x0
80106321:	6a 68                	push   $0x68
80106323:	e9 81 f7 ff ff       	jmp    80105aa9 <alltraps>

80106328 <vector105>:
80106328:	6a 00                	push   $0x0
8010632a:	6a 69                	push   $0x69
8010632c:	e9 78 f7 ff ff       	jmp    80105aa9 <alltraps>

80106331 <vector106>:
80106331:	6a 00                	push   $0x0
80106333:	6a 6a                	push   $0x6a
80106335:	e9 6f f7 ff ff       	jmp    80105aa9 <alltraps>

8010633a <vector107>:
8010633a:	6a 00                	push   $0x0
8010633c:	6a 6b                	push   $0x6b
8010633e:	e9 66 f7 ff ff       	jmp    80105aa9 <alltraps>

80106343 <vector108>:
80106343:	6a 00                	push   $0x0
80106345:	6a 6c                	push   $0x6c
80106347:	e9 5d f7 ff ff       	jmp    80105aa9 <alltraps>

8010634c <vector109>:
8010634c:	6a 00                	push   $0x0
8010634e:	6a 6d                	push   $0x6d
80106350:	e9 54 f7 ff ff       	jmp    80105aa9 <alltraps>

80106355 <vector110>:
80106355:	6a 00                	push   $0x0
80106357:	6a 6e                	push   $0x6e
80106359:	e9 4b f7 ff ff       	jmp    80105aa9 <alltraps>

8010635e <vector111>:
8010635e:	6a 00                	push   $0x0
80106360:	6a 6f                	push   $0x6f
80106362:	e9 42 f7 ff ff       	jmp    80105aa9 <alltraps>

80106367 <vector112>:
80106367:	6a 00                	push   $0x0
80106369:	6a 70                	push   $0x70
8010636b:	e9 39 f7 ff ff       	jmp    80105aa9 <alltraps>

80106370 <vector113>:
80106370:	6a 00                	push   $0x0
80106372:	6a 71                	push   $0x71
80106374:	e9 30 f7 ff ff       	jmp    80105aa9 <alltraps>

80106379 <vector114>:
80106379:	6a 00                	push   $0x0
8010637b:	6a 72                	push   $0x72
8010637d:	e9 27 f7 ff ff       	jmp    80105aa9 <alltraps>

80106382 <vector115>:
80106382:	6a 00                	push   $0x0
80106384:	6a 73                	push   $0x73
80106386:	e9 1e f7 ff ff       	jmp    80105aa9 <alltraps>

8010638b <vector116>:
8010638b:	6a 00                	push   $0x0
8010638d:	6a 74                	push   $0x74
8010638f:	e9 15 f7 ff ff       	jmp    80105aa9 <alltraps>

80106394 <vector117>:
80106394:	6a 00                	push   $0x0
80106396:	6a 75                	push   $0x75
80106398:	e9 0c f7 ff ff       	jmp    80105aa9 <alltraps>

8010639d <vector118>:
8010639d:	6a 00                	push   $0x0
8010639f:	6a 76                	push   $0x76
801063a1:	e9 03 f7 ff ff       	jmp    80105aa9 <alltraps>

801063a6 <vector119>:
801063a6:	6a 00                	push   $0x0
801063a8:	6a 77                	push   $0x77
801063aa:	e9 fa f6 ff ff       	jmp    80105aa9 <alltraps>

801063af <vector120>:
801063af:	6a 00                	push   $0x0
801063b1:	6a 78                	push   $0x78
801063b3:	e9 f1 f6 ff ff       	jmp    80105aa9 <alltraps>

801063b8 <vector121>:
801063b8:	6a 00                	push   $0x0
801063ba:	6a 79                	push   $0x79
801063bc:	e9 e8 f6 ff ff       	jmp    80105aa9 <alltraps>

801063c1 <vector122>:
801063c1:	6a 00                	push   $0x0
801063c3:	6a 7a                	push   $0x7a
801063c5:	e9 df f6 ff ff       	jmp    80105aa9 <alltraps>

801063ca <vector123>:
801063ca:	6a 00                	push   $0x0
801063cc:	6a 7b                	push   $0x7b
801063ce:	e9 d6 f6 ff ff       	jmp    80105aa9 <alltraps>

801063d3 <vector124>:
801063d3:	6a 00                	push   $0x0
801063d5:	6a 7c                	push   $0x7c
801063d7:	e9 cd f6 ff ff       	jmp    80105aa9 <alltraps>

801063dc <vector125>:
801063dc:	6a 00                	push   $0x0
801063de:	6a 7d                	push   $0x7d
801063e0:	e9 c4 f6 ff ff       	jmp    80105aa9 <alltraps>

801063e5 <vector126>:
801063e5:	6a 00                	push   $0x0
801063e7:	6a 7e                	push   $0x7e
801063e9:	e9 bb f6 ff ff       	jmp    80105aa9 <alltraps>

801063ee <vector127>:
801063ee:	6a 00                	push   $0x0
801063f0:	6a 7f                	push   $0x7f
801063f2:	e9 b2 f6 ff ff       	jmp    80105aa9 <alltraps>

801063f7 <vector128>:
801063f7:	6a 00                	push   $0x0
801063f9:	68 80 00 00 00       	push   $0x80
801063fe:	e9 a6 f6 ff ff       	jmp    80105aa9 <alltraps>

80106403 <vector129>:
80106403:	6a 00                	push   $0x0
80106405:	68 81 00 00 00       	push   $0x81
8010640a:	e9 9a f6 ff ff       	jmp    80105aa9 <alltraps>

8010640f <vector130>:
8010640f:	6a 00                	push   $0x0
80106411:	68 82 00 00 00       	push   $0x82
80106416:	e9 8e f6 ff ff       	jmp    80105aa9 <alltraps>

8010641b <vector131>:
8010641b:	6a 00                	push   $0x0
8010641d:	68 83 00 00 00       	push   $0x83
80106422:	e9 82 f6 ff ff       	jmp    80105aa9 <alltraps>

80106427 <vector132>:
80106427:	6a 00                	push   $0x0
80106429:	68 84 00 00 00       	push   $0x84
8010642e:	e9 76 f6 ff ff       	jmp    80105aa9 <alltraps>

80106433 <vector133>:
80106433:	6a 00                	push   $0x0
80106435:	68 85 00 00 00       	push   $0x85
8010643a:	e9 6a f6 ff ff       	jmp    80105aa9 <alltraps>

8010643f <vector134>:
8010643f:	6a 00                	push   $0x0
80106441:	68 86 00 00 00       	push   $0x86
80106446:	e9 5e f6 ff ff       	jmp    80105aa9 <alltraps>

8010644b <vector135>:
8010644b:	6a 00                	push   $0x0
8010644d:	68 87 00 00 00       	push   $0x87
80106452:	e9 52 f6 ff ff       	jmp    80105aa9 <alltraps>

80106457 <vector136>:
80106457:	6a 00                	push   $0x0
80106459:	68 88 00 00 00       	push   $0x88
8010645e:	e9 46 f6 ff ff       	jmp    80105aa9 <alltraps>

80106463 <vector137>:
80106463:	6a 00                	push   $0x0
80106465:	68 89 00 00 00       	push   $0x89
8010646a:	e9 3a f6 ff ff       	jmp    80105aa9 <alltraps>

8010646f <vector138>:
8010646f:	6a 00                	push   $0x0
80106471:	68 8a 00 00 00       	push   $0x8a
80106476:	e9 2e f6 ff ff       	jmp    80105aa9 <alltraps>

8010647b <vector139>:
8010647b:	6a 00                	push   $0x0
8010647d:	68 8b 00 00 00       	push   $0x8b
80106482:	e9 22 f6 ff ff       	jmp    80105aa9 <alltraps>

80106487 <vector140>:
80106487:	6a 00                	push   $0x0
80106489:	68 8c 00 00 00       	push   $0x8c
8010648e:	e9 16 f6 ff ff       	jmp    80105aa9 <alltraps>

80106493 <vector141>:
80106493:	6a 00                	push   $0x0
80106495:	68 8d 00 00 00       	push   $0x8d
8010649a:	e9 0a f6 ff ff       	jmp    80105aa9 <alltraps>

8010649f <vector142>:
8010649f:	6a 00                	push   $0x0
801064a1:	68 8e 00 00 00       	push   $0x8e
801064a6:	e9 fe f5 ff ff       	jmp    80105aa9 <alltraps>

801064ab <vector143>:
801064ab:	6a 00                	push   $0x0
801064ad:	68 8f 00 00 00       	push   $0x8f
801064b2:	e9 f2 f5 ff ff       	jmp    80105aa9 <alltraps>

801064b7 <vector144>:
801064b7:	6a 00                	push   $0x0
801064b9:	68 90 00 00 00       	push   $0x90
801064be:	e9 e6 f5 ff ff       	jmp    80105aa9 <alltraps>

801064c3 <vector145>:
801064c3:	6a 00                	push   $0x0
801064c5:	68 91 00 00 00       	push   $0x91
801064ca:	e9 da f5 ff ff       	jmp    80105aa9 <alltraps>

801064cf <vector146>:
801064cf:	6a 00                	push   $0x0
801064d1:	68 92 00 00 00       	push   $0x92
801064d6:	e9 ce f5 ff ff       	jmp    80105aa9 <alltraps>

801064db <vector147>:
801064db:	6a 00                	push   $0x0
801064dd:	68 93 00 00 00       	push   $0x93
801064e2:	e9 c2 f5 ff ff       	jmp    80105aa9 <alltraps>

801064e7 <vector148>:
801064e7:	6a 00                	push   $0x0
801064e9:	68 94 00 00 00       	push   $0x94
801064ee:	e9 b6 f5 ff ff       	jmp    80105aa9 <alltraps>

801064f3 <vector149>:
801064f3:	6a 00                	push   $0x0
801064f5:	68 95 00 00 00       	push   $0x95
801064fa:	e9 aa f5 ff ff       	jmp    80105aa9 <alltraps>

801064ff <vector150>:
801064ff:	6a 00                	push   $0x0
80106501:	68 96 00 00 00       	push   $0x96
80106506:	e9 9e f5 ff ff       	jmp    80105aa9 <alltraps>

8010650b <vector151>:
8010650b:	6a 00                	push   $0x0
8010650d:	68 97 00 00 00       	push   $0x97
80106512:	e9 92 f5 ff ff       	jmp    80105aa9 <alltraps>

80106517 <vector152>:
80106517:	6a 00                	push   $0x0
80106519:	68 98 00 00 00       	push   $0x98
8010651e:	e9 86 f5 ff ff       	jmp    80105aa9 <alltraps>

80106523 <vector153>:
80106523:	6a 00                	push   $0x0
80106525:	68 99 00 00 00       	push   $0x99
8010652a:	e9 7a f5 ff ff       	jmp    80105aa9 <alltraps>

8010652f <vector154>:
8010652f:	6a 00                	push   $0x0
80106531:	68 9a 00 00 00       	push   $0x9a
80106536:	e9 6e f5 ff ff       	jmp    80105aa9 <alltraps>

8010653b <vector155>:
8010653b:	6a 00                	push   $0x0
8010653d:	68 9b 00 00 00       	push   $0x9b
80106542:	e9 62 f5 ff ff       	jmp    80105aa9 <alltraps>

80106547 <vector156>:
80106547:	6a 00                	push   $0x0
80106549:	68 9c 00 00 00       	push   $0x9c
8010654e:	e9 56 f5 ff ff       	jmp    80105aa9 <alltraps>

80106553 <vector157>:
80106553:	6a 00                	push   $0x0
80106555:	68 9d 00 00 00       	push   $0x9d
8010655a:	e9 4a f5 ff ff       	jmp    80105aa9 <alltraps>

8010655f <vector158>:
8010655f:	6a 00                	push   $0x0
80106561:	68 9e 00 00 00       	push   $0x9e
80106566:	e9 3e f5 ff ff       	jmp    80105aa9 <alltraps>

8010656b <vector159>:
8010656b:	6a 00                	push   $0x0
8010656d:	68 9f 00 00 00       	push   $0x9f
80106572:	e9 32 f5 ff ff       	jmp    80105aa9 <alltraps>

80106577 <vector160>:
80106577:	6a 00                	push   $0x0
80106579:	68 a0 00 00 00       	push   $0xa0
8010657e:	e9 26 f5 ff ff       	jmp    80105aa9 <alltraps>

80106583 <vector161>:
80106583:	6a 00                	push   $0x0
80106585:	68 a1 00 00 00       	push   $0xa1
8010658a:	e9 1a f5 ff ff       	jmp    80105aa9 <alltraps>

8010658f <vector162>:
8010658f:	6a 00                	push   $0x0
80106591:	68 a2 00 00 00       	push   $0xa2
80106596:	e9 0e f5 ff ff       	jmp    80105aa9 <alltraps>

8010659b <vector163>:
8010659b:	6a 00                	push   $0x0
8010659d:	68 a3 00 00 00       	push   $0xa3
801065a2:	e9 02 f5 ff ff       	jmp    80105aa9 <alltraps>

801065a7 <vector164>:
801065a7:	6a 00                	push   $0x0
801065a9:	68 a4 00 00 00       	push   $0xa4
801065ae:	e9 f6 f4 ff ff       	jmp    80105aa9 <alltraps>

801065b3 <vector165>:
801065b3:	6a 00                	push   $0x0
801065b5:	68 a5 00 00 00       	push   $0xa5
801065ba:	e9 ea f4 ff ff       	jmp    80105aa9 <alltraps>

801065bf <vector166>:
801065bf:	6a 00                	push   $0x0
801065c1:	68 a6 00 00 00       	push   $0xa6
801065c6:	e9 de f4 ff ff       	jmp    80105aa9 <alltraps>

801065cb <vector167>:
801065cb:	6a 00                	push   $0x0
801065cd:	68 a7 00 00 00       	push   $0xa7
801065d2:	e9 d2 f4 ff ff       	jmp    80105aa9 <alltraps>

801065d7 <vector168>:
801065d7:	6a 00                	push   $0x0
801065d9:	68 a8 00 00 00       	push   $0xa8
801065de:	e9 c6 f4 ff ff       	jmp    80105aa9 <alltraps>

801065e3 <vector169>:
801065e3:	6a 00                	push   $0x0
801065e5:	68 a9 00 00 00       	push   $0xa9
801065ea:	e9 ba f4 ff ff       	jmp    80105aa9 <alltraps>

801065ef <vector170>:
801065ef:	6a 00                	push   $0x0
801065f1:	68 aa 00 00 00       	push   $0xaa
801065f6:	e9 ae f4 ff ff       	jmp    80105aa9 <alltraps>

801065fb <vector171>:
801065fb:	6a 00                	push   $0x0
801065fd:	68 ab 00 00 00       	push   $0xab
80106602:	e9 a2 f4 ff ff       	jmp    80105aa9 <alltraps>

80106607 <vector172>:
80106607:	6a 00                	push   $0x0
80106609:	68 ac 00 00 00       	push   $0xac
8010660e:	e9 96 f4 ff ff       	jmp    80105aa9 <alltraps>

80106613 <vector173>:
80106613:	6a 00                	push   $0x0
80106615:	68 ad 00 00 00       	push   $0xad
8010661a:	e9 8a f4 ff ff       	jmp    80105aa9 <alltraps>

8010661f <vector174>:
8010661f:	6a 00                	push   $0x0
80106621:	68 ae 00 00 00       	push   $0xae
80106626:	e9 7e f4 ff ff       	jmp    80105aa9 <alltraps>

8010662b <vector175>:
8010662b:	6a 00                	push   $0x0
8010662d:	68 af 00 00 00       	push   $0xaf
80106632:	e9 72 f4 ff ff       	jmp    80105aa9 <alltraps>

80106637 <vector176>:
80106637:	6a 00                	push   $0x0
80106639:	68 b0 00 00 00       	push   $0xb0
8010663e:	e9 66 f4 ff ff       	jmp    80105aa9 <alltraps>

80106643 <vector177>:
80106643:	6a 00                	push   $0x0
80106645:	68 b1 00 00 00       	push   $0xb1
8010664a:	e9 5a f4 ff ff       	jmp    80105aa9 <alltraps>

8010664f <vector178>:
8010664f:	6a 00                	push   $0x0
80106651:	68 b2 00 00 00       	push   $0xb2
80106656:	e9 4e f4 ff ff       	jmp    80105aa9 <alltraps>

8010665b <vector179>:
8010665b:	6a 00                	push   $0x0
8010665d:	68 b3 00 00 00       	push   $0xb3
80106662:	e9 42 f4 ff ff       	jmp    80105aa9 <alltraps>

80106667 <vector180>:
80106667:	6a 00                	push   $0x0
80106669:	68 b4 00 00 00       	push   $0xb4
8010666e:	e9 36 f4 ff ff       	jmp    80105aa9 <alltraps>

80106673 <vector181>:
80106673:	6a 00                	push   $0x0
80106675:	68 b5 00 00 00       	push   $0xb5
8010667a:	e9 2a f4 ff ff       	jmp    80105aa9 <alltraps>

8010667f <vector182>:
8010667f:	6a 00                	push   $0x0
80106681:	68 b6 00 00 00       	push   $0xb6
80106686:	e9 1e f4 ff ff       	jmp    80105aa9 <alltraps>

8010668b <vector183>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 b7 00 00 00       	push   $0xb7
80106692:	e9 12 f4 ff ff       	jmp    80105aa9 <alltraps>

80106697 <vector184>:
80106697:	6a 00                	push   $0x0
80106699:	68 b8 00 00 00       	push   $0xb8
8010669e:	e9 06 f4 ff ff       	jmp    80105aa9 <alltraps>

801066a3 <vector185>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 b9 00 00 00       	push   $0xb9
801066aa:	e9 fa f3 ff ff       	jmp    80105aa9 <alltraps>

801066af <vector186>:
801066af:	6a 00                	push   $0x0
801066b1:	68 ba 00 00 00       	push   $0xba
801066b6:	e9 ee f3 ff ff       	jmp    80105aa9 <alltraps>

801066bb <vector187>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 bb 00 00 00       	push   $0xbb
801066c2:	e9 e2 f3 ff ff       	jmp    80105aa9 <alltraps>

801066c7 <vector188>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 bc 00 00 00       	push   $0xbc
801066ce:	e9 d6 f3 ff ff       	jmp    80105aa9 <alltraps>

801066d3 <vector189>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 bd 00 00 00       	push   $0xbd
801066da:	e9 ca f3 ff ff       	jmp    80105aa9 <alltraps>

801066df <vector190>:
801066df:	6a 00                	push   $0x0
801066e1:	68 be 00 00 00       	push   $0xbe
801066e6:	e9 be f3 ff ff       	jmp    80105aa9 <alltraps>

801066eb <vector191>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 bf 00 00 00       	push   $0xbf
801066f2:	e9 b2 f3 ff ff       	jmp    80105aa9 <alltraps>

801066f7 <vector192>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 c0 00 00 00       	push   $0xc0
801066fe:	e9 a6 f3 ff ff       	jmp    80105aa9 <alltraps>

80106703 <vector193>:
80106703:	6a 00                	push   $0x0
80106705:	68 c1 00 00 00       	push   $0xc1
8010670a:	e9 9a f3 ff ff       	jmp    80105aa9 <alltraps>

8010670f <vector194>:
8010670f:	6a 00                	push   $0x0
80106711:	68 c2 00 00 00       	push   $0xc2
80106716:	e9 8e f3 ff ff       	jmp    80105aa9 <alltraps>

8010671b <vector195>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 c3 00 00 00       	push   $0xc3
80106722:	e9 82 f3 ff ff       	jmp    80105aa9 <alltraps>

80106727 <vector196>:
80106727:	6a 00                	push   $0x0
80106729:	68 c4 00 00 00       	push   $0xc4
8010672e:	e9 76 f3 ff ff       	jmp    80105aa9 <alltraps>

80106733 <vector197>:
80106733:	6a 00                	push   $0x0
80106735:	68 c5 00 00 00       	push   $0xc5
8010673a:	e9 6a f3 ff ff       	jmp    80105aa9 <alltraps>

8010673f <vector198>:
8010673f:	6a 00                	push   $0x0
80106741:	68 c6 00 00 00       	push   $0xc6
80106746:	e9 5e f3 ff ff       	jmp    80105aa9 <alltraps>

8010674b <vector199>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 c7 00 00 00       	push   $0xc7
80106752:	e9 52 f3 ff ff       	jmp    80105aa9 <alltraps>

80106757 <vector200>:
80106757:	6a 00                	push   $0x0
80106759:	68 c8 00 00 00       	push   $0xc8
8010675e:	e9 46 f3 ff ff       	jmp    80105aa9 <alltraps>

80106763 <vector201>:
80106763:	6a 00                	push   $0x0
80106765:	68 c9 00 00 00       	push   $0xc9
8010676a:	e9 3a f3 ff ff       	jmp    80105aa9 <alltraps>

8010676f <vector202>:
8010676f:	6a 00                	push   $0x0
80106771:	68 ca 00 00 00       	push   $0xca
80106776:	e9 2e f3 ff ff       	jmp    80105aa9 <alltraps>

8010677b <vector203>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 cb 00 00 00       	push   $0xcb
80106782:	e9 22 f3 ff ff       	jmp    80105aa9 <alltraps>

80106787 <vector204>:
80106787:	6a 00                	push   $0x0
80106789:	68 cc 00 00 00       	push   $0xcc
8010678e:	e9 16 f3 ff ff       	jmp    80105aa9 <alltraps>

80106793 <vector205>:
80106793:	6a 00                	push   $0x0
80106795:	68 cd 00 00 00       	push   $0xcd
8010679a:	e9 0a f3 ff ff       	jmp    80105aa9 <alltraps>

8010679f <vector206>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 ce 00 00 00       	push   $0xce
801067a6:	e9 fe f2 ff ff       	jmp    80105aa9 <alltraps>

801067ab <vector207>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 cf 00 00 00       	push   $0xcf
801067b2:	e9 f2 f2 ff ff       	jmp    80105aa9 <alltraps>

801067b7 <vector208>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 d0 00 00 00       	push   $0xd0
801067be:	e9 e6 f2 ff ff       	jmp    80105aa9 <alltraps>

801067c3 <vector209>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 d1 00 00 00       	push   $0xd1
801067ca:	e9 da f2 ff ff       	jmp    80105aa9 <alltraps>

801067cf <vector210>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 d2 00 00 00       	push   $0xd2
801067d6:	e9 ce f2 ff ff       	jmp    80105aa9 <alltraps>

801067db <vector211>:
801067db:	6a 00                	push   $0x0
801067dd:	68 d3 00 00 00       	push   $0xd3
801067e2:	e9 c2 f2 ff ff       	jmp    80105aa9 <alltraps>

801067e7 <vector212>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 d4 00 00 00       	push   $0xd4
801067ee:	e9 b6 f2 ff ff       	jmp    80105aa9 <alltraps>

801067f3 <vector213>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 d5 00 00 00       	push   $0xd5
801067fa:	e9 aa f2 ff ff       	jmp    80105aa9 <alltraps>

801067ff <vector214>:
801067ff:	6a 00                	push   $0x0
80106801:	68 d6 00 00 00       	push   $0xd6
80106806:	e9 9e f2 ff ff       	jmp    80105aa9 <alltraps>

8010680b <vector215>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 d7 00 00 00       	push   $0xd7
80106812:	e9 92 f2 ff ff       	jmp    80105aa9 <alltraps>

80106817 <vector216>:
80106817:	6a 00                	push   $0x0
80106819:	68 d8 00 00 00       	push   $0xd8
8010681e:	e9 86 f2 ff ff       	jmp    80105aa9 <alltraps>

80106823 <vector217>:
80106823:	6a 00                	push   $0x0
80106825:	68 d9 00 00 00       	push   $0xd9
8010682a:	e9 7a f2 ff ff       	jmp    80105aa9 <alltraps>

8010682f <vector218>:
8010682f:	6a 00                	push   $0x0
80106831:	68 da 00 00 00       	push   $0xda
80106836:	e9 6e f2 ff ff       	jmp    80105aa9 <alltraps>

8010683b <vector219>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 db 00 00 00       	push   $0xdb
80106842:	e9 62 f2 ff ff       	jmp    80105aa9 <alltraps>

80106847 <vector220>:
80106847:	6a 00                	push   $0x0
80106849:	68 dc 00 00 00       	push   $0xdc
8010684e:	e9 56 f2 ff ff       	jmp    80105aa9 <alltraps>

80106853 <vector221>:
80106853:	6a 00                	push   $0x0
80106855:	68 dd 00 00 00       	push   $0xdd
8010685a:	e9 4a f2 ff ff       	jmp    80105aa9 <alltraps>

8010685f <vector222>:
8010685f:	6a 00                	push   $0x0
80106861:	68 de 00 00 00       	push   $0xde
80106866:	e9 3e f2 ff ff       	jmp    80105aa9 <alltraps>

8010686b <vector223>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 df 00 00 00       	push   $0xdf
80106872:	e9 32 f2 ff ff       	jmp    80105aa9 <alltraps>

80106877 <vector224>:
80106877:	6a 00                	push   $0x0
80106879:	68 e0 00 00 00       	push   $0xe0
8010687e:	e9 26 f2 ff ff       	jmp    80105aa9 <alltraps>

80106883 <vector225>:
80106883:	6a 00                	push   $0x0
80106885:	68 e1 00 00 00       	push   $0xe1
8010688a:	e9 1a f2 ff ff       	jmp    80105aa9 <alltraps>

8010688f <vector226>:
8010688f:	6a 00                	push   $0x0
80106891:	68 e2 00 00 00       	push   $0xe2
80106896:	e9 0e f2 ff ff       	jmp    80105aa9 <alltraps>

8010689b <vector227>:
8010689b:	6a 00                	push   $0x0
8010689d:	68 e3 00 00 00       	push   $0xe3
801068a2:	e9 02 f2 ff ff       	jmp    80105aa9 <alltraps>

801068a7 <vector228>:
801068a7:	6a 00                	push   $0x0
801068a9:	68 e4 00 00 00       	push   $0xe4
801068ae:	e9 f6 f1 ff ff       	jmp    80105aa9 <alltraps>

801068b3 <vector229>:
801068b3:	6a 00                	push   $0x0
801068b5:	68 e5 00 00 00       	push   $0xe5
801068ba:	e9 ea f1 ff ff       	jmp    80105aa9 <alltraps>

801068bf <vector230>:
801068bf:	6a 00                	push   $0x0
801068c1:	68 e6 00 00 00       	push   $0xe6
801068c6:	e9 de f1 ff ff       	jmp    80105aa9 <alltraps>

801068cb <vector231>:
801068cb:	6a 00                	push   $0x0
801068cd:	68 e7 00 00 00       	push   $0xe7
801068d2:	e9 d2 f1 ff ff       	jmp    80105aa9 <alltraps>

801068d7 <vector232>:
801068d7:	6a 00                	push   $0x0
801068d9:	68 e8 00 00 00       	push   $0xe8
801068de:	e9 c6 f1 ff ff       	jmp    80105aa9 <alltraps>

801068e3 <vector233>:
801068e3:	6a 00                	push   $0x0
801068e5:	68 e9 00 00 00       	push   $0xe9
801068ea:	e9 ba f1 ff ff       	jmp    80105aa9 <alltraps>

801068ef <vector234>:
801068ef:	6a 00                	push   $0x0
801068f1:	68 ea 00 00 00       	push   $0xea
801068f6:	e9 ae f1 ff ff       	jmp    80105aa9 <alltraps>

801068fb <vector235>:
801068fb:	6a 00                	push   $0x0
801068fd:	68 eb 00 00 00       	push   $0xeb
80106902:	e9 a2 f1 ff ff       	jmp    80105aa9 <alltraps>

80106907 <vector236>:
80106907:	6a 00                	push   $0x0
80106909:	68 ec 00 00 00       	push   $0xec
8010690e:	e9 96 f1 ff ff       	jmp    80105aa9 <alltraps>

80106913 <vector237>:
80106913:	6a 00                	push   $0x0
80106915:	68 ed 00 00 00       	push   $0xed
8010691a:	e9 8a f1 ff ff       	jmp    80105aa9 <alltraps>

8010691f <vector238>:
8010691f:	6a 00                	push   $0x0
80106921:	68 ee 00 00 00       	push   $0xee
80106926:	e9 7e f1 ff ff       	jmp    80105aa9 <alltraps>

8010692b <vector239>:
8010692b:	6a 00                	push   $0x0
8010692d:	68 ef 00 00 00       	push   $0xef
80106932:	e9 72 f1 ff ff       	jmp    80105aa9 <alltraps>

80106937 <vector240>:
80106937:	6a 00                	push   $0x0
80106939:	68 f0 00 00 00       	push   $0xf0
8010693e:	e9 66 f1 ff ff       	jmp    80105aa9 <alltraps>

80106943 <vector241>:
80106943:	6a 00                	push   $0x0
80106945:	68 f1 00 00 00       	push   $0xf1
8010694a:	e9 5a f1 ff ff       	jmp    80105aa9 <alltraps>

8010694f <vector242>:
8010694f:	6a 00                	push   $0x0
80106951:	68 f2 00 00 00       	push   $0xf2
80106956:	e9 4e f1 ff ff       	jmp    80105aa9 <alltraps>

8010695b <vector243>:
8010695b:	6a 00                	push   $0x0
8010695d:	68 f3 00 00 00       	push   $0xf3
80106962:	e9 42 f1 ff ff       	jmp    80105aa9 <alltraps>

80106967 <vector244>:
80106967:	6a 00                	push   $0x0
80106969:	68 f4 00 00 00       	push   $0xf4
8010696e:	e9 36 f1 ff ff       	jmp    80105aa9 <alltraps>

80106973 <vector245>:
80106973:	6a 00                	push   $0x0
80106975:	68 f5 00 00 00       	push   $0xf5
8010697a:	e9 2a f1 ff ff       	jmp    80105aa9 <alltraps>

8010697f <vector246>:
8010697f:	6a 00                	push   $0x0
80106981:	68 f6 00 00 00       	push   $0xf6
80106986:	e9 1e f1 ff ff       	jmp    80105aa9 <alltraps>

8010698b <vector247>:
8010698b:	6a 00                	push   $0x0
8010698d:	68 f7 00 00 00       	push   $0xf7
80106992:	e9 12 f1 ff ff       	jmp    80105aa9 <alltraps>

80106997 <vector248>:
80106997:	6a 00                	push   $0x0
80106999:	68 f8 00 00 00       	push   $0xf8
8010699e:	e9 06 f1 ff ff       	jmp    80105aa9 <alltraps>

801069a3 <vector249>:
801069a3:	6a 00                	push   $0x0
801069a5:	68 f9 00 00 00       	push   $0xf9
801069aa:	e9 fa f0 ff ff       	jmp    80105aa9 <alltraps>

801069af <vector250>:
801069af:	6a 00                	push   $0x0
801069b1:	68 fa 00 00 00       	push   $0xfa
801069b6:	e9 ee f0 ff ff       	jmp    80105aa9 <alltraps>

801069bb <vector251>:
801069bb:	6a 00                	push   $0x0
801069bd:	68 fb 00 00 00       	push   $0xfb
801069c2:	e9 e2 f0 ff ff       	jmp    80105aa9 <alltraps>

801069c7 <vector252>:
801069c7:	6a 00                	push   $0x0
801069c9:	68 fc 00 00 00       	push   $0xfc
801069ce:	e9 d6 f0 ff ff       	jmp    80105aa9 <alltraps>

801069d3 <vector253>:
801069d3:	6a 00                	push   $0x0
801069d5:	68 fd 00 00 00       	push   $0xfd
801069da:	e9 ca f0 ff ff       	jmp    80105aa9 <alltraps>

801069df <vector254>:
801069df:	6a 00                	push   $0x0
801069e1:	68 fe 00 00 00       	push   $0xfe
801069e6:	e9 be f0 ff ff       	jmp    80105aa9 <alltraps>

801069eb <vector255>:
801069eb:	6a 00                	push   $0x0
801069ed:	68 ff 00 00 00       	push   $0xff
801069f2:	e9 b2 f0 ff ff       	jmp    80105aa9 <alltraps>
801069f7:	66 90                	xchg   %ax,%ax
801069f9:	66 90                	xchg   %ax,%ax
801069fb:	66 90                	xchg   %ax,%ax
801069fd:	66 90                	xchg   %ax,%ax
801069ff:	90                   	nop

80106a00 <walkpgdir>:
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	57                   	push   %edi
80106a04:	56                   	push   %esi
80106a05:	53                   	push   %ebx
80106a06:	89 d3                	mov    %edx,%ebx
80106a08:	89 d7                	mov    %edx,%edi
80106a0a:	c1 eb 16             	shr    $0x16,%ebx
80106a0d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
80106a10:	83 ec 0c             	sub    $0xc,%esp
80106a13:	8b 06                	mov    (%esi),%eax
80106a15:	a8 01                	test   $0x1,%al
80106a17:	74 27                	je     80106a40 <walkpgdir+0x40>
80106a19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a1e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80106a24:	c1 ef 0a             	shr    $0xa,%edi
80106a27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a2a:	89 fa                	mov    %edi,%edx
80106a2c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106a32:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80106a35:	5b                   	pop    %ebx
80106a36:	5e                   	pop    %esi
80106a37:	5f                   	pop    %edi
80106a38:	5d                   	pop    %ebp
80106a39:	c3                   	ret    
80106a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a40:	85 c9                	test   %ecx,%ecx
80106a42:	74 2c                	je     80106a70 <walkpgdir+0x70>
80106a44:	e8 87 bd ff ff       	call   801027d0 <kalloc>
80106a49:	85 c0                	test   %eax,%eax
80106a4b:	89 c3                	mov    %eax,%ebx
80106a4d:	74 21                	je     80106a70 <walkpgdir+0x70>
80106a4f:	83 ec 04             	sub    $0x4,%esp
80106a52:	68 00 10 00 00       	push   $0x1000
80106a57:	6a 00                	push   $0x0
80106a59:	50                   	push   %eax
80106a5a:	e8 21 de ff ff       	call   80104880 <memset>
80106a5f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a65:	83 c4 10             	add    $0x10,%esp
80106a68:	83 c8 07             	or     $0x7,%eax
80106a6b:	89 06                	mov    %eax,(%esi)
80106a6d:	eb b5                	jmp    80106a24 <walkpgdir+0x24>
80106a6f:	90                   	nop
80106a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a73:	31 c0                	xor    %eax,%eax
80106a75:	5b                   	pop    %ebx
80106a76:	5e                   	pop    %esi
80106a77:	5f                   	pop    %edi
80106a78:	5d                   	pop    %ebp
80106a79:	c3                   	ret    
80106a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a80 <mappages>:
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	57                   	push   %edi
80106a84:	56                   	push   %esi
80106a85:	53                   	push   %ebx
80106a86:	89 d3                	mov    %edx,%ebx
80106a88:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106a8e:	83 ec 1c             	sub    $0x1c,%esp
80106a91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a94:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106a98:	8b 7d 08             	mov    0x8(%ebp),%edi
80106a9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106aa0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106aa6:	29 df                	sub    %ebx,%edi
80106aa8:	83 c8 01             	or     $0x1,%eax
80106aab:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106aae:	eb 15                	jmp    80106ac5 <mappages+0x45>
80106ab0:	f6 00 01             	testb  $0x1,(%eax)
80106ab3:	75 45                	jne    80106afa <mappages+0x7a>
80106ab5:	0b 75 dc             	or     -0x24(%ebp),%esi
80106ab8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106abb:	89 30                	mov    %esi,(%eax)
80106abd:	74 31                	je     80106af0 <mappages+0x70>
80106abf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ac5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ac8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106acd:	89 da                	mov    %ebx,%edx
80106acf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106ad2:	e8 29 ff ff ff       	call   80106a00 <walkpgdir>
80106ad7:	85 c0                	test   %eax,%eax
80106ad9:	75 d5                	jne    80106ab0 <mappages+0x30>
80106adb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ade:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ae3:	5b                   	pop    %ebx
80106ae4:	5e                   	pop    %esi
80106ae5:	5f                   	pop    %edi
80106ae6:	5d                   	pop    %ebp
80106ae7:	c3                   	ret    
80106ae8:	90                   	nop
80106ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106af0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106af3:	31 c0                	xor    %eax,%eax
80106af5:	5b                   	pop    %ebx
80106af6:	5e                   	pop    %esi
80106af7:	5f                   	pop    %edi
80106af8:	5d                   	pop    %ebp
80106af9:	c3                   	ret    
80106afa:	83 ec 0c             	sub    $0xc,%esp
80106afd:	68 dc 7c 10 80       	push   $0x80107cdc
80106b02:	e8 89 98 ff ff       	call   80100390 <panic>
80106b07:	89 f6                	mov    %esi,%esi
80106b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b10 <deallocuvm.part.0>:
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	57                   	push   %edi
80106b14:	56                   	push   %esi
80106b15:	53                   	push   %ebx
80106b16:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106b1c:	89 c7                	mov    %eax,%edi
80106b1e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106b24:	83 ec 1c             	sub    $0x1c,%esp
80106b27:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106b2a:	39 d3                	cmp    %edx,%ebx
80106b2c:	73 66                	jae    80106b94 <deallocuvm.part.0+0x84>
80106b2e:	89 d6                	mov    %edx,%esi
80106b30:	eb 3d                	jmp    80106b6f <deallocuvm.part.0+0x5f>
80106b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b38:	8b 10                	mov    (%eax),%edx
80106b3a:	f6 c2 01             	test   $0x1,%dl
80106b3d:	74 26                	je     80106b65 <deallocuvm.part.0+0x55>
80106b3f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106b45:	74 58                	je     80106b9f <deallocuvm.part.0+0x8f>
80106b47:	83 ec 0c             	sub    $0xc,%esp
80106b4a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106b50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b53:	52                   	push   %edx
80106b54:	e8 c7 ba ff ff       	call   80102620 <kfree>
80106b59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b5c:	83 c4 10             	add    $0x10,%esp
80106b5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106b65:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b6b:	39 f3                	cmp    %esi,%ebx
80106b6d:	73 25                	jae    80106b94 <deallocuvm.part.0+0x84>
80106b6f:	31 c9                	xor    %ecx,%ecx
80106b71:	89 da                	mov    %ebx,%edx
80106b73:	89 f8                	mov    %edi,%eax
80106b75:	e8 86 fe ff ff       	call   80106a00 <walkpgdir>
80106b7a:	85 c0                	test   %eax,%eax
80106b7c:	75 ba                	jne    80106b38 <deallocuvm.part.0+0x28>
80106b7e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106b84:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
80106b8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b90:	39 f3                	cmp    %esi,%ebx
80106b92:	72 db                	jb     80106b6f <deallocuvm.part.0+0x5f>
80106b94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b9a:	5b                   	pop    %ebx
80106b9b:	5e                   	pop    %esi
80106b9c:	5f                   	pop    %edi
80106b9d:	5d                   	pop    %ebp
80106b9e:	c3                   	ret    
80106b9f:	83 ec 0c             	sub    $0xc,%esp
80106ba2:	68 a6 75 10 80       	push   $0x801075a6
80106ba7:	e8 e4 97 ff ff       	call   80100390 <panic>
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bb0 <seginit>:
80106bb0:	55                   	push   %ebp
80106bb1:	89 e5                	mov    %esp,%ebp
80106bb3:	83 ec 18             	sub    $0x18,%esp
80106bb6:	e8 15 cf ff ff       	call   80103ad0 <cpuid>
80106bbb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106bc1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106bc6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106bca:	c7 80 b8 2a 11 80 ff 	movl   $0xffff,-0x7feed548(%eax)
80106bd1:	ff 00 00 
80106bd4:	c7 80 bc 2a 11 80 00 	movl   $0xcf9a00,-0x7feed544(%eax)
80106bdb:	9a cf 00 
80106bde:	c7 80 c0 2a 11 80 ff 	movl   $0xffff,-0x7feed540(%eax)
80106be5:	ff 00 00 
80106be8:	c7 80 c4 2a 11 80 00 	movl   $0xcf9200,-0x7feed53c(%eax)
80106bef:	92 cf 00 
80106bf2:	c7 80 c8 2a 11 80 ff 	movl   $0xffff,-0x7feed538(%eax)
80106bf9:	ff 00 00 
80106bfc:	c7 80 cc 2a 11 80 00 	movl   $0xcffa00,-0x7feed534(%eax)
80106c03:	fa cf 00 
80106c06:	c7 80 d0 2a 11 80 ff 	movl   $0xffff,-0x7feed530(%eax)
80106c0d:	ff 00 00 
80106c10:	c7 80 d4 2a 11 80 00 	movl   $0xcff200,-0x7feed52c(%eax)
80106c17:	f2 cf 00 
80106c1a:	05 b0 2a 11 80       	add    $0x80112ab0,%eax
80106c1f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80106c23:	c1 e8 10             	shr    $0x10,%eax
80106c26:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80106c2a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c2d:	0f 01 10             	lgdtl  (%eax)
80106c30:	c9                   	leave  
80106c31:	c3                   	ret    
80106c32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c40 <switchkvm>:
80106c40:	a1 64 57 11 80       	mov    0x80115764,%eax
80106c45:	55                   	push   %ebp
80106c46:	89 e5                	mov    %esp,%ebp
80106c48:	05 00 00 00 80       	add    $0x80000000,%eax
80106c4d:	0f 22 d8             	mov    %eax,%cr3
80106c50:	5d                   	pop    %ebp
80106c51:	c3                   	ret    
80106c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c60 <switchuvm>:
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 1c             	sub    $0x1c,%esp
80106c69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106c6c:	85 db                	test   %ebx,%ebx
80106c6e:	0f 84 cb 00 00 00    	je     80106d3f <switchuvm+0xdf>
80106c74:	8b 43 08             	mov    0x8(%ebx),%eax
80106c77:	85 c0                	test   %eax,%eax
80106c79:	0f 84 da 00 00 00    	je     80106d59 <switchuvm+0xf9>
80106c7f:	8b 43 04             	mov    0x4(%ebx),%eax
80106c82:	85 c0                	test   %eax,%eax
80106c84:	0f 84 c2 00 00 00    	je     80106d4c <switchuvm+0xec>
80106c8a:	e8 11 da ff ff       	call   801046a0 <pushcli>
80106c8f:	e8 bc cd ff ff       	call   80103a50 <mycpu>
80106c94:	89 c6                	mov    %eax,%esi
80106c96:	e8 b5 cd ff ff       	call   80103a50 <mycpu>
80106c9b:	89 c7                	mov    %eax,%edi
80106c9d:	e8 ae cd ff ff       	call   80103a50 <mycpu>
80106ca2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ca5:	83 c7 08             	add    $0x8,%edi
80106ca8:	e8 a3 cd ff ff       	call   80103a50 <mycpu>
80106cad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cb0:	83 c0 08             	add    $0x8,%eax
80106cb3:	ba 67 00 00 00       	mov    $0x67,%edx
80106cb8:	c1 e8 18             	shr    $0x18,%eax
80106cbb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106cc2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106cc9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
80106ccf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106cd4:	83 c1 08             	add    $0x8,%ecx
80106cd7:	c1 e9 10             	shr    $0x10,%ecx
80106cda:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106ce0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106ce5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80106cec:	be 10 00 00 00       	mov    $0x10,%esi
80106cf1:	e8 5a cd ff ff       	call   80103a50 <mycpu>
80106cf6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106cfd:	e8 4e cd ff ff       	call   80103a50 <mycpu>
80106d02:	66 89 70 10          	mov    %si,0x10(%eax)
80106d06:	8b 73 08             	mov    0x8(%ebx),%esi
80106d09:	e8 42 cd ff ff       	call   80103a50 <mycpu>
80106d0e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d14:	89 70 0c             	mov    %esi,0xc(%eax)
80106d17:	e8 34 cd ff ff       	call   80103a50 <mycpu>
80106d1c:	66 89 78 6e          	mov    %di,0x6e(%eax)
80106d20:	b8 28 00 00 00       	mov    $0x28,%eax
80106d25:	0f 00 d8             	ltr    %ax
80106d28:	8b 43 04             	mov    0x4(%ebx),%eax
80106d2b:	05 00 00 00 80       	add    $0x80000000,%eax
80106d30:	0f 22 d8             	mov    %eax,%cr3
80106d33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d36:	5b                   	pop    %ebx
80106d37:	5e                   	pop    %esi
80106d38:	5f                   	pop    %edi
80106d39:	5d                   	pop    %ebp
80106d3a:	e9 a1 d9 ff ff       	jmp    801046e0 <popcli>
80106d3f:	83 ec 0c             	sub    $0xc,%esp
80106d42:	68 e2 7c 10 80       	push   $0x80107ce2
80106d47:	e8 44 96 ff ff       	call   80100390 <panic>
80106d4c:	83 ec 0c             	sub    $0xc,%esp
80106d4f:	68 0d 7d 10 80       	push   $0x80107d0d
80106d54:	e8 37 96 ff ff       	call   80100390 <panic>
80106d59:	83 ec 0c             	sub    $0xc,%esp
80106d5c:	68 f8 7c 10 80       	push   $0x80107cf8
80106d61:	e8 2a 96 ff ff       	call   80100390 <panic>
80106d66:	8d 76 00             	lea    0x0(%esi),%esi
80106d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d70 <inituvm>:
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 1c             	sub    $0x1c,%esp
80106d79:	8b 75 10             	mov    0x10(%ebp),%esi
80106d7c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d7f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106d82:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d8b:	77 49                	ja     80106dd6 <inituvm+0x66>
80106d8d:	e8 3e ba ff ff       	call   801027d0 <kalloc>
80106d92:	83 ec 04             	sub    $0x4,%esp
80106d95:	89 c3                	mov    %eax,%ebx
80106d97:	68 00 10 00 00       	push   $0x1000
80106d9c:	6a 00                	push   $0x0
80106d9e:	50                   	push   %eax
80106d9f:	e8 dc da ff ff       	call   80104880 <memset>
80106da4:	58                   	pop    %eax
80106da5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dab:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106db0:	5a                   	pop    %edx
80106db1:	6a 06                	push   $0x6
80106db3:	50                   	push   %eax
80106db4:	31 d2                	xor    %edx,%edx
80106db6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106db9:	e8 c2 fc ff ff       	call   80106a80 <mappages>
80106dbe:	89 75 10             	mov    %esi,0x10(%ebp)
80106dc1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106dc4:	83 c4 10             	add    $0x10,%esp
80106dc7:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106dca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dcd:	5b                   	pop    %ebx
80106dce:	5e                   	pop    %esi
80106dcf:	5f                   	pop    %edi
80106dd0:	5d                   	pop    %ebp
80106dd1:	e9 5a db ff ff       	jmp    80104930 <memmove>
80106dd6:	83 ec 0c             	sub    $0xc,%esp
80106dd9:	68 21 7d 10 80       	push   $0x80107d21
80106dde:	e8 ad 95 ff ff       	call   80100390 <panic>
80106de3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <loaduvm>:
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	57                   	push   %edi
80106df4:	56                   	push   %esi
80106df5:	53                   	push   %ebx
80106df6:	83 ec 0c             	sub    $0xc,%esp
80106df9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106e00:	0f 85 91 00 00 00    	jne    80106e97 <loaduvm+0xa7>
80106e06:	8b 75 18             	mov    0x18(%ebp),%esi
80106e09:	31 db                	xor    %ebx,%ebx
80106e0b:	85 f6                	test   %esi,%esi
80106e0d:	75 1a                	jne    80106e29 <loaduvm+0x39>
80106e0f:	eb 6f                	jmp    80106e80 <loaduvm+0x90>
80106e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e18:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e1e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106e24:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106e27:	76 57                	jbe    80106e80 <loaduvm+0x90>
80106e29:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e2f:	31 c9                	xor    %ecx,%ecx
80106e31:	01 da                	add    %ebx,%edx
80106e33:	e8 c8 fb ff ff       	call   80106a00 <walkpgdir>
80106e38:	85 c0                	test   %eax,%eax
80106e3a:	74 4e                	je     80106e8a <loaduvm+0x9a>
80106e3c:	8b 00                	mov    (%eax),%eax
80106e3e:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106e41:	bf 00 10 00 00       	mov    $0x1000,%edi
80106e46:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e4b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e51:	0f 46 fe             	cmovbe %esi,%edi
80106e54:	01 d9                	add    %ebx,%ecx
80106e56:	05 00 00 00 80       	add    $0x80000000,%eax
80106e5b:	57                   	push   %edi
80106e5c:	51                   	push   %ecx
80106e5d:	50                   	push   %eax
80106e5e:	ff 75 10             	pushl  0x10(%ebp)
80106e61:	e8 0a ae ff ff       	call   80101c70 <readi>
80106e66:	83 c4 10             	add    $0x10,%esp
80106e69:	39 f8                	cmp    %edi,%eax
80106e6b:	74 ab                	je     80106e18 <loaduvm+0x28>
80106e6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e75:	5b                   	pop    %ebx
80106e76:	5e                   	pop    %esi
80106e77:	5f                   	pop    %edi
80106e78:	5d                   	pop    %ebp
80106e79:	c3                   	ret    
80106e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e83:	31 c0                	xor    %eax,%eax
80106e85:	5b                   	pop    %ebx
80106e86:	5e                   	pop    %esi
80106e87:	5f                   	pop    %edi
80106e88:	5d                   	pop    %ebp
80106e89:	c3                   	ret    
80106e8a:	83 ec 0c             	sub    $0xc,%esp
80106e8d:	68 3b 7d 10 80       	push   $0x80107d3b
80106e92:	e8 f9 94 ff ff       	call   80100390 <panic>
80106e97:	83 ec 0c             	sub    $0xc,%esp
80106e9a:	68 dc 7d 10 80       	push   $0x80107ddc
80106e9f:	e8 ec 94 ff ff       	call   80100390 <panic>
80106ea4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106eb0 <allocuvm>:
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	57                   	push   %edi
80106eb4:	56                   	push   %esi
80106eb5:	53                   	push   %ebx
80106eb6:	83 ec 1c             	sub    $0x1c,%esp
80106eb9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106ebc:	85 ff                	test   %edi,%edi
80106ebe:	0f 88 8e 00 00 00    	js     80106f52 <allocuvm+0xa2>
80106ec4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ec7:	0f 82 93 00 00 00    	jb     80106f60 <allocuvm+0xb0>
80106ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ed0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106ed6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106edc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106edf:	0f 86 7e 00 00 00    	jbe    80106f63 <allocuvm+0xb3>
80106ee5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106ee8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106eeb:	eb 42                	jmp    80106f2f <allocuvm+0x7f>
80106eed:	8d 76 00             	lea    0x0(%esi),%esi
80106ef0:	83 ec 04             	sub    $0x4,%esp
80106ef3:	68 00 10 00 00       	push   $0x1000
80106ef8:	6a 00                	push   $0x0
80106efa:	50                   	push   %eax
80106efb:	e8 80 d9 ff ff       	call   80104880 <memset>
80106f00:	58                   	pop    %eax
80106f01:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f07:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f0c:	5a                   	pop    %edx
80106f0d:	6a 06                	push   $0x6
80106f0f:	50                   	push   %eax
80106f10:	89 da                	mov    %ebx,%edx
80106f12:	89 f8                	mov    %edi,%eax
80106f14:	e8 67 fb ff ff       	call   80106a80 <mappages>
80106f19:	83 c4 10             	add    $0x10,%esp
80106f1c:	85 c0                	test   %eax,%eax
80106f1e:	78 50                	js     80106f70 <allocuvm+0xc0>
80106f20:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f26:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106f29:	0f 86 81 00 00 00    	jbe    80106fb0 <allocuvm+0x100>
80106f2f:	e8 9c b8 ff ff       	call   801027d0 <kalloc>
80106f34:	85 c0                	test   %eax,%eax
80106f36:	89 c6                	mov    %eax,%esi
80106f38:	75 b6                	jne    80106ef0 <allocuvm+0x40>
80106f3a:	83 ec 0c             	sub    $0xc,%esp
80106f3d:	68 59 7d 10 80       	push   $0x80107d59
80106f42:	e8 19 97 ff ff       	call   80100660 <cprintf>
80106f47:	83 c4 10             	add    $0x10,%esp
80106f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f4d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f50:	77 6e                	ja     80106fc0 <allocuvm+0x110>
80106f52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f55:	31 ff                	xor    %edi,%edi
80106f57:	89 f8                	mov    %edi,%eax
80106f59:	5b                   	pop    %ebx
80106f5a:	5e                   	pop    %esi
80106f5b:	5f                   	pop    %edi
80106f5c:	5d                   	pop    %ebp
80106f5d:	c3                   	ret    
80106f5e:	66 90                	xchg   %ax,%ax
80106f60:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106f63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f66:	89 f8                	mov    %edi,%eax
80106f68:	5b                   	pop    %ebx
80106f69:	5e                   	pop    %esi
80106f6a:	5f                   	pop    %edi
80106f6b:	5d                   	pop    %ebp
80106f6c:	c3                   	ret    
80106f6d:	8d 76 00             	lea    0x0(%esi),%esi
80106f70:	83 ec 0c             	sub    $0xc,%esp
80106f73:	68 71 7d 10 80       	push   $0x80107d71
80106f78:	e8 e3 96 ff ff       	call   80100660 <cprintf>
80106f7d:	83 c4 10             	add    $0x10,%esp
80106f80:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f83:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f86:	76 0d                	jbe    80106f95 <allocuvm+0xe5>
80106f88:	89 c1                	mov    %eax,%ecx
80106f8a:	8b 55 10             	mov    0x10(%ebp),%edx
80106f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80106f90:	e8 7b fb ff ff       	call   80106b10 <deallocuvm.part.0>
80106f95:	83 ec 0c             	sub    $0xc,%esp
80106f98:	31 ff                	xor    %edi,%edi
80106f9a:	56                   	push   %esi
80106f9b:	e8 80 b6 ff ff       	call   80102620 <kfree>
80106fa0:	83 c4 10             	add    $0x10,%esp
80106fa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fa6:	89 f8                	mov    %edi,%eax
80106fa8:	5b                   	pop    %ebx
80106fa9:	5e                   	pop    %esi
80106faa:	5f                   	pop    %edi
80106fab:	5d                   	pop    %ebp
80106fac:	c3                   	ret    
80106fad:	8d 76 00             	lea    0x0(%esi),%esi
80106fb0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106fb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fb6:	5b                   	pop    %ebx
80106fb7:	89 f8                	mov    %edi,%eax
80106fb9:	5e                   	pop    %esi
80106fba:	5f                   	pop    %edi
80106fbb:	5d                   	pop    %ebp
80106fbc:	c3                   	ret    
80106fbd:	8d 76 00             	lea    0x0(%esi),%esi
80106fc0:	89 c1                	mov    %eax,%ecx
80106fc2:	8b 55 10             	mov    0x10(%ebp),%edx
80106fc5:	8b 45 08             	mov    0x8(%ebp),%eax
80106fc8:	31 ff                	xor    %edi,%edi
80106fca:	e8 41 fb ff ff       	call   80106b10 <deallocuvm.part.0>
80106fcf:	eb 92                	jmp    80106f63 <allocuvm+0xb3>
80106fd1:	eb 0d                	jmp    80106fe0 <deallocuvm>
80106fd3:	90                   	nop
80106fd4:	90                   	nop
80106fd5:	90                   	nop
80106fd6:	90                   	nop
80106fd7:	90                   	nop
80106fd8:	90                   	nop
80106fd9:	90                   	nop
80106fda:	90                   	nop
80106fdb:	90                   	nop
80106fdc:	90                   	nop
80106fdd:	90                   	nop
80106fde:	90                   	nop
80106fdf:	90                   	nop

80106fe0 <deallocuvm>:
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fe6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106fe9:	8b 45 08             	mov    0x8(%ebp),%eax
80106fec:	39 d1                	cmp    %edx,%ecx
80106fee:	73 10                	jae    80107000 <deallocuvm+0x20>
80106ff0:	5d                   	pop    %ebp
80106ff1:	e9 1a fb ff ff       	jmp    80106b10 <deallocuvm.part.0>
80106ff6:	8d 76 00             	lea    0x0(%esi),%esi
80106ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107000:	89 d0                	mov    %edx,%eax
80107002:	5d                   	pop    %ebp
80107003:	c3                   	ret    
80107004:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010700a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107010 <freevm>:
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 0c             	sub    $0xc,%esp
80107019:	8b 75 08             	mov    0x8(%ebp),%esi
8010701c:	85 f6                	test   %esi,%esi
8010701e:	74 59                	je     80107079 <freevm+0x69>
80107020:	31 c9                	xor    %ecx,%ecx
80107022:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107027:	89 f0                	mov    %esi,%eax
80107029:	e8 e2 fa ff ff       	call   80106b10 <deallocuvm.part.0>
8010702e:	89 f3                	mov    %esi,%ebx
80107030:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107036:	eb 0f                	jmp    80107047 <freevm+0x37>
80107038:	90                   	nop
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107040:	83 c3 04             	add    $0x4,%ebx
80107043:	39 fb                	cmp    %edi,%ebx
80107045:	74 23                	je     8010706a <freevm+0x5a>
80107047:	8b 03                	mov    (%ebx),%eax
80107049:	a8 01                	test   $0x1,%al
8010704b:	74 f3                	je     80107040 <freevm+0x30>
8010704d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107052:	83 ec 0c             	sub    $0xc,%esp
80107055:	83 c3 04             	add    $0x4,%ebx
80107058:	05 00 00 00 80       	add    $0x80000000,%eax
8010705d:	50                   	push   %eax
8010705e:	e8 bd b5 ff ff       	call   80102620 <kfree>
80107063:	83 c4 10             	add    $0x10,%esp
80107066:	39 fb                	cmp    %edi,%ebx
80107068:	75 dd                	jne    80107047 <freevm+0x37>
8010706a:	89 75 08             	mov    %esi,0x8(%ebp)
8010706d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107070:	5b                   	pop    %ebx
80107071:	5e                   	pop    %esi
80107072:	5f                   	pop    %edi
80107073:	5d                   	pop    %ebp
80107074:	e9 a7 b5 ff ff       	jmp    80102620 <kfree>
80107079:	83 ec 0c             	sub    $0xc,%esp
8010707c:	68 8d 7d 10 80       	push   $0x80107d8d
80107081:	e8 0a 93 ff ff       	call   80100390 <panic>
80107086:	8d 76 00             	lea    0x0(%esi),%esi
80107089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107090 <setupkvm>:
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	56                   	push   %esi
80107094:	53                   	push   %ebx
80107095:	e8 36 b7 ff ff       	call   801027d0 <kalloc>
8010709a:	85 c0                	test   %eax,%eax
8010709c:	89 c6                	mov    %eax,%esi
8010709e:	74 42                	je     801070e2 <setupkvm+0x52>
801070a0:	83 ec 04             	sub    $0x4,%esp
801070a3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
801070a8:	68 00 10 00 00       	push   $0x1000
801070ad:	6a 00                	push   $0x0
801070af:	50                   	push   %eax
801070b0:	e8 cb d7 ff ff       	call   80104880 <memset>
801070b5:	83 c4 10             	add    $0x10,%esp
801070b8:	8b 43 04             	mov    0x4(%ebx),%eax
801070bb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801070be:	83 ec 08             	sub    $0x8,%esp
801070c1:	8b 13                	mov    (%ebx),%edx
801070c3:	ff 73 0c             	pushl  0xc(%ebx)
801070c6:	50                   	push   %eax
801070c7:	29 c1                	sub    %eax,%ecx
801070c9:	89 f0                	mov    %esi,%eax
801070cb:	e8 b0 f9 ff ff       	call   80106a80 <mappages>
801070d0:	83 c4 10             	add    $0x10,%esp
801070d3:	85 c0                	test   %eax,%eax
801070d5:	78 19                	js     801070f0 <setupkvm+0x60>
801070d7:	83 c3 10             	add    $0x10,%ebx
801070da:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801070e0:	75 d6                	jne    801070b8 <setupkvm+0x28>
801070e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801070e5:	89 f0                	mov    %esi,%eax
801070e7:	5b                   	pop    %ebx
801070e8:	5e                   	pop    %esi
801070e9:	5d                   	pop    %ebp
801070ea:	c3                   	ret    
801070eb:	90                   	nop
801070ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070f0:	83 ec 0c             	sub    $0xc,%esp
801070f3:	56                   	push   %esi
801070f4:	31 f6                	xor    %esi,%esi
801070f6:	e8 15 ff ff ff       	call   80107010 <freevm>
801070fb:	83 c4 10             	add    $0x10,%esp
801070fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107101:	89 f0                	mov    %esi,%eax
80107103:	5b                   	pop    %ebx
80107104:	5e                   	pop    %esi
80107105:	5d                   	pop    %ebp
80107106:	c3                   	ret    
80107107:	89 f6                	mov    %esi,%esi
80107109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107110 <kvmalloc>:
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	83 ec 08             	sub    $0x8,%esp
80107116:	e8 75 ff ff ff       	call   80107090 <setupkvm>
8010711b:	a3 64 57 11 80       	mov    %eax,0x80115764
80107120:	05 00 00 00 80       	add    $0x80000000,%eax
80107125:	0f 22 d8             	mov    %eax,%cr3
80107128:	c9                   	leave  
80107129:	c3                   	ret    
8010712a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107130 <clearpteu>:
80107130:	55                   	push   %ebp
80107131:	31 c9                	xor    %ecx,%ecx
80107133:	89 e5                	mov    %esp,%ebp
80107135:	83 ec 08             	sub    $0x8,%esp
80107138:	8b 55 0c             	mov    0xc(%ebp),%edx
8010713b:	8b 45 08             	mov    0x8(%ebp),%eax
8010713e:	e8 bd f8 ff ff       	call   80106a00 <walkpgdir>
80107143:	85 c0                	test   %eax,%eax
80107145:	74 05                	je     8010714c <clearpteu+0x1c>
80107147:	83 20 fb             	andl   $0xfffffffb,(%eax)
8010714a:	c9                   	leave  
8010714b:	c3                   	ret    
8010714c:	83 ec 0c             	sub    $0xc,%esp
8010714f:	68 9e 7d 10 80       	push   $0x80107d9e
80107154:	e8 37 92 ff ff       	call   80100390 <panic>
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107160 <copyuvm>:
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 1c             	sub    $0x1c,%esp
80107169:	e8 22 ff ff ff       	call   80107090 <setupkvm>
8010716e:	85 c0                	test   %eax,%eax
80107170:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107173:	0f 84 9f 00 00 00    	je     80107218 <copyuvm+0xb8>
80107179:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010717c:	85 c9                	test   %ecx,%ecx
8010717e:	0f 84 94 00 00 00    	je     80107218 <copyuvm+0xb8>
80107184:	31 ff                	xor    %edi,%edi
80107186:	eb 4a                	jmp    801071d2 <copyuvm+0x72>
80107188:	90                   	nop
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107190:	83 ec 04             	sub    $0x4,%esp
80107193:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107199:	68 00 10 00 00       	push   $0x1000
8010719e:	53                   	push   %ebx
8010719f:	50                   	push   %eax
801071a0:	e8 8b d7 ff ff       	call   80104930 <memmove>
801071a5:	58                   	pop    %eax
801071a6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801071ac:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071b1:	5a                   	pop    %edx
801071b2:	ff 75 e4             	pushl  -0x1c(%ebp)
801071b5:	50                   	push   %eax
801071b6:	89 fa                	mov    %edi,%edx
801071b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071bb:	e8 c0 f8 ff ff       	call   80106a80 <mappages>
801071c0:	83 c4 10             	add    $0x10,%esp
801071c3:	85 c0                	test   %eax,%eax
801071c5:	78 61                	js     80107228 <copyuvm+0xc8>
801071c7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801071cd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801071d0:	76 46                	jbe    80107218 <copyuvm+0xb8>
801071d2:	8b 45 08             	mov    0x8(%ebp),%eax
801071d5:	31 c9                	xor    %ecx,%ecx
801071d7:	89 fa                	mov    %edi,%edx
801071d9:	e8 22 f8 ff ff       	call   80106a00 <walkpgdir>
801071de:	85 c0                	test   %eax,%eax
801071e0:	74 61                	je     80107243 <copyuvm+0xe3>
801071e2:	8b 00                	mov    (%eax),%eax
801071e4:	a8 01                	test   $0x1,%al
801071e6:	74 4e                	je     80107236 <copyuvm+0xd6>
801071e8:	89 c3                	mov    %eax,%ebx
801071ea:	25 ff 0f 00 00       	and    $0xfff,%eax
801071ef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801071f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071f8:	e8 d3 b5 ff ff       	call   801027d0 <kalloc>
801071fd:	85 c0                	test   %eax,%eax
801071ff:	89 c6                	mov    %eax,%esi
80107201:	75 8d                	jne    80107190 <copyuvm+0x30>
80107203:	83 ec 0c             	sub    $0xc,%esp
80107206:	ff 75 e0             	pushl  -0x20(%ebp)
80107209:	e8 02 fe ff ff       	call   80107010 <freevm>
8010720e:	83 c4 10             	add    $0x10,%esp
80107211:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107218:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010721b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010721e:	5b                   	pop    %ebx
8010721f:	5e                   	pop    %esi
80107220:	5f                   	pop    %edi
80107221:	5d                   	pop    %ebp
80107222:	c3                   	ret    
80107223:	90                   	nop
80107224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107228:	83 ec 0c             	sub    $0xc,%esp
8010722b:	56                   	push   %esi
8010722c:	e8 ef b3 ff ff       	call   80102620 <kfree>
80107231:	83 c4 10             	add    $0x10,%esp
80107234:	eb cd                	jmp    80107203 <copyuvm+0xa3>
80107236:	83 ec 0c             	sub    $0xc,%esp
80107239:	68 c2 7d 10 80       	push   $0x80107dc2
8010723e:	e8 4d 91 ff ff       	call   80100390 <panic>
80107243:	83 ec 0c             	sub    $0xc,%esp
80107246:	68 a8 7d 10 80       	push   $0x80107da8
8010724b:	e8 40 91 ff ff       	call   80100390 <panic>

80107250 <uva2ka>:
80107250:	55                   	push   %ebp
80107251:	31 c9                	xor    %ecx,%ecx
80107253:	89 e5                	mov    %esp,%ebp
80107255:	83 ec 08             	sub    $0x8,%esp
80107258:	8b 55 0c             	mov    0xc(%ebp),%edx
8010725b:	8b 45 08             	mov    0x8(%ebp),%eax
8010725e:	e8 9d f7 ff ff       	call   80106a00 <walkpgdir>
80107263:	8b 00                	mov    (%eax),%eax
80107265:	c9                   	leave  
80107266:	89 c2                	mov    %eax,%edx
80107268:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010726d:	83 e2 05             	and    $0x5,%edx
80107270:	05 00 00 00 80       	add    $0x80000000,%eax
80107275:	83 fa 05             	cmp    $0x5,%edx
80107278:	ba 00 00 00 00       	mov    $0x0,%edx
8010727d:	0f 45 c2             	cmovne %edx,%eax
80107280:	c3                   	ret    
80107281:	eb 0d                	jmp    80107290 <copyout>
80107283:	90                   	nop
80107284:	90                   	nop
80107285:	90                   	nop
80107286:	90                   	nop
80107287:	90                   	nop
80107288:	90                   	nop
80107289:	90                   	nop
8010728a:	90                   	nop
8010728b:	90                   	nop
8010728c:	90                   	nop
8010728d:	90                   	nop
8010728e:	90                   	nop
8010728f:	90                   	nop

80107290 <copyout>:
80107290:	55                   	push   %ebp
80107291:	89 e5                	mov    %esp,%ebp
80107293:	57                   	push   %edi
80107294:	56                   	push   %esi
80107295:	53                   	push   %ebx
80107296:	83 ec 1c             	sub    $0x1c,%esp
80107299:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010729c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010729f:	8b 7d 10             	mov    0x10(%ebp),%edi
801072a2:	85 db                	test   %ebx,%ebx
801072a4:	75 40                	jne    801072e6 <copyout+0x56>
801072a6:	eb 70                	jmp    80107318 <copyout+0x88>
801072a8:	90                   	nop
801072a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072b3:	89 f1                	mov    %esi,%ecx
801072b5:	29 d1                	sub    %edx,%ecx
801072b7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801072bd:	39 d9                	cmp    %ebx,%ecx
801072bf:	0f 47 cb             	cmova  %ebx,%ecx
801072c2:	29 f2                	sub    %esi,%edx
801072c4:	83 ec 04             	sub    $0x4,%esp
801072c7:	01 d0                	add    %edx,%eax
801072c9:	51                   	push   %ecx
801072ca:	57                   	push   %edi
801072cb:	50                   	push   %eax
801072cc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801072cf:	e8 5c d6 ff ff       	call   80104930 <memmove>
801072d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801072d7:	83 c4 10             	add    $0x10,%esp
801072da:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
801072e0:	01 cf                	add    %ecx,%edi
801072e2:	29 cb                	sub    %ecx,%ebx
801072e4:	74 32                	je     80107318 <copyout+0x88>
801072e6:	89 d6                	mov    %edx,%esi
801072e8:	83 ec 08             	sub    $0x8,%esp
801072eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801072ee:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801072f4:	56                   	push   %esi
801072f5:	ff 75 08             	pushl  0x8(%ebp)
801072f8:	e8 53 ff ff ff       	call   80107250 <uva2ka>
801072fd:	83 c4 10             	add    $0x10,%esp
80107300:	85 c0                	test   %eax,%eax
80107302:	75 ac                	jne    801072b0 <copyout+0x20>
80107304:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010730c:	5b                   	pop    %ebx
8010730d:	5e                   	pop    %esi
8010730e:	5f                   	pop    %edi
8010730f:	5d                   	pop    %ebp
80107310:	c3                   	ret    
80107311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107318:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010731b:	31 c0                	xor    %eax,%eax
8010731d:	5b                   	pop    %ebx
8010731e:	5e                   	pop    %esi
8010731f:	5f                   	pop    %edi
80107320:	5d                   	pop    %ebp
80107321:	c3                   	ret    
