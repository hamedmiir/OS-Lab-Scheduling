
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
8010004c:	68 e0 7c 10 80       	push   $0x80107ce0
80100051:	68 00 c6 10 80       	push   $0x8010c600
80100056:	e8 a5 4e 00 00       	call   80104f00 <initlock>
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
80100092:	68 e7 7c 10 80       	push   $0x80107ce7
80100097:	50                   	push   %eax
80100098:	e8 33 4d 00 00       	call   80104dd0 <initsleeplock>
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
801000e4:	e8 57 4f 00 00       	call   80105040 <acquire>
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
80100162:	e8 99 4f 00 00       	call   80105100 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 9e 4c 00 00       	call   80104e10 <acquiresleep>
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
80100193:	68 ee 7c 10 80       	push   $0x80107cee
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
801001ae:	e8 fd 4c 00 00       	call   80104eb0 <holdingsleep>
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
801001cc:	68 ff 7c 10 80       	push   $0x80107cff
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
801001ef:	e8 bc 4c 00 00       	call   80104eb0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 6c 4c 00 00       	call   80104e70 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010020b:	e8 30 4e 00 00       	call   80105040 <acquire>
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
8010025c:	e9 9f 4e 00 00       	jmp    80105100 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 7d 10 80       	push   $0x80107d06
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
8010028c:	e8 af 4d 00 00       	call   80105040 <acquire>
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
801002c5:	e8 b6 3d 00 00       	call   80104080 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 e0 0f 11 80    	mov    0x80110fe0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 e4 0f 11 80    	cmp    0x80110fe4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 a0 38 00 00       	call   80103b80 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 60 b5 10 80       	push   $0x8010b560
801002ef:	e8 0c 4e 00 00       	call   80105100 <release>
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
8010034d:	e8 ae 4d 00 00       	call   80105100 <release>
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
801003b2:	68 0d 7d 10 80       	push   $0x80107d0d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 1f 88 10 80 	movl   $0x8010881f,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 43 4b 00 00       	call   80104f20 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 21 7d 10 80       	push   $0x80107d21
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
8010043a:	e8 a1 64 00 00       	call   801068e0 <uartputc>
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
801004ec:	e8 ef 63 00 00       	call   801068e0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 e3 63 00 00       	call   801068e0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 d7 63 00 00       	call   801068e0 <uartputc>
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
80100524:	e8 d7 4c 00 00       	call   80105200 <memmove>
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
80100541:	e8 0a 4c 00 00       	call   80105150 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 25 7d 10 80       	push   $0x80107d25
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
801005b1:	0f b6 92 50 7d 10 80 	movzbl -0x7fef82b0(%edx),%edx
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
8010061b:	e8 20 4a 00 00       	call   80105040 <acquire>
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
80100647:	e8 b4 4a 00 00       	call   80105100 <release>
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
8010071f:	e8 dc 49 00 00       	call   80105100 <release>
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
801007d0:	ba 38 7d 10 80       	mov    $0x80107d38,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 60 b5 10 80       	push   $0x8010b560
801007f0:	e8 4b 48 00 00       	call   80105040 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 3f 7d 10 80       	push   $0x80107d3f
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
80100850:	e8 fb 48 00 00       	call   80105150 <memset>
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
80100af3:	e8 48 45 00 00       	call   80105040 <acquire>
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
80100bc8:	e8 33 45 00 00       	call   80105100 <release>
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
80100c57:	e9 c4 36 00 00       	jmp    80104320 <procdump>
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
80100cc6:	68 48 7d 10 80       	push   $0x80107d48
80100ccb:	68 60 b5 10 80       	push   $0x8010b560
80100cd0:	e8 2b 42 00 00       	call   80104f00 <initlock>

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
80100d1c:	e8 5f 2e 00 00       	call   80103b80 <myproc>
80100d21:	89 c6                	mov    %eax,%esi

  begin_op();
80100d23:	e8 e8 21 00 00       	call   80102f10 <begin_op>
  //For testing priority

  find_and_set_sched_queue(LOTTERY, curproc->pid);
80100d28:	83 ec 08             	sub    $0x8,%esp
80100d2b:	ff 76 10             	pushl  0x10(%esi)
80100d2e:	6a 02                	push   $0x2
80100d30:	e8 db 39 00 00       	call   80104710 <find_and_set_sched_queue>
  find_and_set_lottery_ticket(500, curproc->pid);
80100d35:	59                   	pop    %ecx
80100d36:	5b                   	pop    %ebx
80100d37:	ff 76 10             	pushl  0x10(%esi)
80100d3a:	68 f4 01 00 00       	push   $0x1f4
80100d3f:	e8 9c 39 00 00       	call   801046e0 <find_and_set_lottery_ticket>
  find_and_set_burst_time(0, curproc->pid);
80100d44:	5f                   	pop    %edi
80100d45:	58                   	pop    %eax
80100d46:	ff 76 10             	pushl  0x10(%esi)
80100d49:	6a 00                	push   $0x0
80100d4b:	e8 f0 39 00 00       	call   80104740 <find_and_set_burst_time>

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
80100dbc:	e8 6f 6c 00 00       	call   80107a30 <setupkvm>
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
80100e26:	e8 25 6a 00 00       	call   80107850 <allocuvm>
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
80100e58:	e8 33 69 00 00       	call   80107790 <loaduvm>
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
80100ea2:	e8 09 6b 00 00       	call   801079b0 <freevm>
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
80100eef:	e8 5c 69 00 00       	call   80107850 <allocuvm>
80100ef4:	83 c4 10             	add    $0x10,%esp
80100ef7:	85 c0                	test   %eax,%eax
80100ef9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100eff:	75 3a                	jne    80100f3b <exec+0x22b>
    freevm(pgdir);
80100f01:	83 ec 0c             	sub    $0xc,%esp
80100f04:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f0a:	e8 a1 6a 00 00       	call   801079b0 <freevm>
80100f0f:	83 c4 10             	add    $0x10,%esp
  return -1;
80100f12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f17:	e9 82 fe ff ff       	jmp    80100d9e <exec+0x8e>
    end_op();
80100f1c:	e8 5f 20 00 00       	call   80102f80 <end_op>
    cprintf("exec: fail\n");
80100f21:	83 ec 0c             	sub    $0xc,%esp
80100f24:	68 61 7d 10 80       	push   $0x80107d61
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
80100f4f:	e8 7c 6b 00 00       	call   80107ad0 <clearpteu>
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
80100f81:	e8 ea 43 00 00       	call   80105370 <strlen>
80100f86:	f7 d0                	not    %eax
80100f88:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f8d:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f8e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f91:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f94:	e8 d7 43 00 00       	call   80105370 <strlen>
80100f99:	83 c0 01             	add    $0x1,%eax
80100f9c:	50                   	push   %eax
80100f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fa0:	ff 34 b8             	pushl  (%eax,%edi,4)
80100fa3:	53                   	push   %ebx
80100fa4:	56                   	push   %esi
80100fa5:	e8 86 6c 00 00       	call   80107c30 <copyout>
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
8010100f:	e8 1c 6c 00 00       	call   80107c30 <copyout>
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
8010104a:	e8 e1 42 00 00       	call   80105330 <safestrcpy>
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
8010107e:	e8 7d 65 00 00       	call   80107600 <switchuvm>
  freevm(oldpgdir);
80101083:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80101089:	89 04 24             	mov    %eax,(%esp)
8010108c:	e8 1f 69 00 00       	call   801079b0 <freevm>
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
801010c6:	68 6d 7d 10 80       	push   $0x80107d6d
801010cb:	68 80 12 11 80       	push   $0x80111280
801010d0:	e8 2b 3e 00 00       	call   80104f00 <initlock>
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
801010f1:	e8 4a 3f 00 00       	call   80105040 <acquire>
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
80101121:	e8 da 3f 00 00       	call   80105100 <release>
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
8010113a:	e8 c1 3f 00 00       	call   80105100 <release>
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
8010115f:	e8 dc 3e 00 00       	call   80105040 <acquire>
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
8010117c:	e8 7f 3f 00 00       	call   80105100 <release>
  return f;
}
80101181:	89 d8                	mov    %ebx,%eax
80101183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101186:	c9                   	leave  
80101187:	c3                   	ret    
    panic("filedup");
80101188:	83 ec 0c             	sub    $0xc,%esp
8010118b:	68 74 7d 10 80       	push   $0x80107d74
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
801011b1:	e8 8a 3e 00 00       	call   80105040 <acquire>
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
801011dc:	e9 1f 3f 00 00       	jmp    80105100 <release>
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
80101208:	e8 f3 3e 00 00       	call   80105100 <release>
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
80101262:	68 7c 7d 10 80       	push   $0x80107d7c
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
80101342:	68 86 7d 10 80       	push   $0x80107d86
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
80101455:	68 8f 7d 10 80       	push   $0x80107d8f
8010145a:	e8 31 ef ff ff       	call   80100390 <panic>
  panic("filewrite");
8010145f:	83 ec 0c             	sub    $0xc,%esp
80101462:	68 95 7d 10 80       	push   $0x80107d95
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
80101514:	68 9f 7d 10 80       	push   $0x80107d9f
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
80101555:	e8 f6 3b 00 00       	call   80105150 <memset>
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
8010159a:	e8 a1 3a 00 00       	call   80105040 <acquire>
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
801015ff:	e8 fc 3a 00 00       	call   80105100 <release>

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
8010162d:	e8 ce 3a 00 00       	call   80105100 <release>
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
80101642:	68 b5 7d 10 80       	push   $0x80107db5
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
80101717:	68 c5 7d 10 80       	push   $0x80107dc5
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
80101751:	e8 aa 3a 00 00       	call   80105200 <memmove>
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
801017e4:	68 d8 7d 10 80       	push   $0x80107dd8
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
801017fc:	68 eb 7d 10 80       	push   $0x80107deb
80101801:	68 a0 1c 11 80       	push   $0x80111ca0
80101806:	e8 f5 36 00 00       	call   80104f00 <initlock>
8010180b:	83 c4 10             	add    $0x10,%esp
8010180e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101810:	83 ec 08             	sub    $0x8,%esp
80101813:	68 f2 7d 10 80       	push   $0x80107df2
80101818:	53                   	push   %ebx
80101819:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010181f:	e8 ac 35 00 00       	call   80104dd0 <initsleeplock>
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
80101869:	68 58 7e 10 80       	push   $0x80107e58
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
801018fe:	e8 4d 38 00 00       	call   80105150 <memset>
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
80101933:	68 f8 7d 10 80       	push   $0x80107df8
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
801019a1:	e8 5a 38 00 00       	call   80105200 <memmove>
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
801019cf:	e8 6c 36 00 00       	call   80105040 <acquire>
  ip->ref++;
801019d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019d8:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
801019df:	e8 1c 37 00 00       	call   80105100 <release>
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
80101a12:	e8 f9 33 00 00       	call   80104e10 <acquiresleep>
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
80101a88:	e8 73 37 00 00       	call   80105200 <memmove>
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
80101aad:	68 10 7e 10 80       	push   $0x80107e10
80101ab2:	e8 d9 e8 ff ff       	call   80100390 <panic>
    panic("ilock");
80101ab7:	83 ec 0c             	sub    $0xc,%esp
80101aba:	68 0a 7e 10 80       	push   $0x80107e0a
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
80101ae3:	e8 c8 33 00 00       	call   80104eb0 <holdingsleep>
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
80101aff:	e9 6c 33 00 00       	jmp    80104e70 <releasesleep>
    panic("iunlock");
80101b04:	83 ec 0c             	sub    $0xc,%esp
80101b07:	68 1f 7e 10 80       	push   $0x80107e1f
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
80101b30:	e8 db 32 00 00       	call   80104e10 <acquiresleep>
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
80101b4a:	e8 21 33 00 00       	call   80104e70 <releasesleep>
  acquire(&icache.lock);
80101b4f:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b56:	e8 e5 34 00 00       	call   80105040 <acquire>
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
80101b70:	e9 8b 35 00 00       	jmp    80105100 <release>
80101b75:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101b78:	83 ec 0c             	sub    $0xc,%esp
80101b7b:	68 a0 1c 11 80       	push   $0x80111ca0
80101b80:	e8 bb 34 00 00       	call   80105040 <acquire>
    int r = ip->ref;
80101b85:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101b88:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b8f:	e8 6c 35 00 00       	call   80105100 <release>
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
80101d77:	e8 84 34 00 00       	call   80105200 <memmove>
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
80101e73:	e8 88 33 00 00       	call   80105200 <memmove>
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
80101f0e:	e8 5d 33 00 00       	call   80105270 <strncmp>
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
80101f6d:	e8 fe 32 00 00       	call   80105270 <strncmp>
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
80101fb2:	68 39 7e 10 80       	push   $0x80107e39
80101fb7:	e8 d4 e3 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101fbc:	83 ec 0c             	sub    $0xc,%esp
80101fbf:	68 27 7e 10 80       	push   $0x80107e27
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
80101fe9:	e8 92 1b 00 00       	call   80103b80 <myproc>
  acquire(&icache.lock);
80101fee:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ff1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ff4:	68 a0 1c 11 80       	push   $0x80111ca0
80101ff9:	e8 42 30 00 00       	call   80105040 <acquire>
  ip->ref++;
80101ffe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102002:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80102009:	e8 f2 30 00 00       	call   80105100 <release>
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
80102065:	e8 96 31 00 00       	call   80105200 <memmove>
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
801020f8:	e8 03 31 00 00       	call   80105200 <memmove>
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
801021ed:	e8 de 30 00 00       	call   801052d0 <strncpy>
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
8010222b:	68 48 7e 10 80       	push   $0x80107e48
80102230:	e8 5b e1 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102235:	83 ec 0c             	sub    $0xc,%esp
80102238:	68 da 85 10 80       	push   $0x801085da
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
8010234b:	68 b4 7e 10 80       	push   $0x80107eb4
80102350:	e8 3b e0 ff ff       	call   80100390 <panic>
    panic("idestart");
80102355:	83 ec 0c             	sub    $0xc,%esp
80102358:	68 ab 7e 10 80       	push   $0x80107eab
8010235d:	e8 2e e0 ff ff       	call   80100390 <panic>
80102362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102370 <ideinit>:
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102376:	68 c6 7e 10 80       	push   $0x80107ec6
8010237b:	68 c0 b5 10 80       	push   $0x8010b5c0
80102380:	e8 7b 2b 00 00       	call   80104f00 <initlock>
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
801023fe:	e8 3d 2c 00 00       	call   80105040 <acquire>

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
80102461:	e8 da 1d 00 00       	call   80104240 <wakeup>

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
8010247f:	e8 7c 2c 00 00       	call   80105100 <release>

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
8010249e:	e8 0d 2a 00 00       	call   80104eb0 <holdingsleep>
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
801024d8:	e8 63 2b 00 00       	call   80105040 <acquire>

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
80102529:	e8 52 1b 00 00       	call   80104080 <sleep>
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
80102546:	e9 b5 2b 00 00       	jmp    80105100 <release>
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
8010256a:	68 e0 7e 10 80       	push   $0x80107ee0
8010256f:	e8 1c de ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102574:	83 ec 0c             	sub    $0xc,%esp
80102577:	68 ca 7e 10 80       	push   $0x80107eca
8010257c:	e8 0f de ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102581:	83 ec 0c             	sub    $0xc,%esp
80102584:	68 f5 7e 10 80       	push   $0x80107ef5
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
801025d7:	68 14 7f 10 80       	push   $0x80107f14
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
80102692:	81 fb 88 6c 11 80    	cmp    $0x80116c88,%ebx
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
801026b2:	e8 99 2a 00 00       	call   80105150 <memset>

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
801026eb:	e9 10 2a 00 00       	jmp    80105100 <release>
    acquire(&kmem.lock);
801026f0:	83 ec 0c             	sub    $0xc,%esp
801026f3:	68 00 39 11 80       	push   $0x80113900
801026f8:	e8 43 29 00 00       	call   80105040 <acquire>
801026fd:	83 c4 10             	add    $0x10,%esp
80102700:	eb c2                	jmp    801026c4 <kfree+0x44>
    panic("kfree");
80102702:	83 ec 0c             	sub    $0xc,%esp
80102705:	68 46 7f 10 80       	push   $0x80107f46
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
8010276b:	68 4c 7f 10 80       	push   $0x80107f4c
80102770:	68 00 39 11 80       	push   $0x80113900
80102775:	e8 86 27 00 00       	call   80104f00 <initlock>
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
80102863:	e8 d8 27 00 00       	call   80105040 <acquire>
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
80102891:	e8 6a 28 00 00       	call   80105100 <release>
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
801028e3:	0f b6 82 80 80 10 80 	movzbl -0x7fef7f80(%edx),%eax
801028ea:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801028ec:	0f b6 82 80 7f 10 80 	movzbl -0x7fef8080(%edx),%eax
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
80102903:	8b 04 85 60 7f 10 80 	mov    -0x7fef80a0(,%eax,4),%eax
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
80102928:	0f b6 82 80 80 10 80 	movzbl -0x7fef7f80(%edx),%eax
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
80102ca7:	e8 f4 24 00 00       	call   801051a0 <memcmp>
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
80102dd4:	e8 27 24 00 00       	call   80105200 <memmove>
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
80102e7a:	68 80 81 10 80       	push   $0x80108180
80102e7f:	68 40 39 11 80       	push   $0x80113940
80102e84:	e8 77 20 00 00       	call   80104f00 <initlock>
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
80102f1b:	e8 20 21 00 00       	call   80105040 <acquire>
80102f20:	83 c4 10             	add    $0x10,%esp
80102f23:	eb 18                	jmp    80102f3d <begin_op+0x2d>
80102f25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f28:	83 ec 08             	sub    $0x8,%esp
80102f2b:	68 40 39 11 80       	push   $0x80113940
80102f30:	68 40 39 11 80       	push   $0x80113940
80102f35:	e8 46 11 00 00       	call   80104080 <sleep>
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
80102f6c:	e8 8f 21 00 00       	call   80105100 <release>
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
80102f8e:	e8 ad 20 00 00       	call   80105040 <acquire>
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
80102fcc:	e8 2f 21 00 00       	call   80105100 <release>
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
80103026:	e8 d5 21 00 00       	call   80105200 <memmove>
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
8010306f:	e8 cc 1f 00 00       	call   80105040 <acquire>
    wakeup(&log);
80103074:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
    log.committing = 0;
8010307b:	c7 05 80 39 11 80 00 	movl   $0x0,0x80113980
80103082:	00 00 00 
    wakeup(&log);
80103085:	e8 b6 11 00 00       	call   80104240 <wakeup>
    release(&log.lock);
8010308a:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103091:	e8 6a 20 00 00       	call   80105100 <release>
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
801030b0:	e8 8b 11 00 00       	call   80104240 <wakeup>
  release(&log.lock);
801030b5:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
801030bc:	e8 3f 20 00 00       	call   80105100 <release>
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
801030cf:	68 84 81 10 80       	push   $0x80108184
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
8010311e:	e8 1d 1f 00 00       	call   80105040 <acquire>
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
8010316d:	e9 8e 1f 00 00       	jmp    80105100 <release>
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
80103199:	68 93 81 10 80       	push   $0x80108193
8010319e:	e8 ed d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801031a3:	83 ec 0c             	sub    $0xc,%esp
801031a6:	68 a9 81 10 80       	push   $0x801081a9
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
801031b7:	e8 a4 09 00 00       	call   80103b60 <cpuid>
801031bc:	89 c3                	mov    %eax,%ebx
801031be:	e8 9d 09 00 00       	call   80103b60 <cpuid>
801031c3:	83 ec 04             	sub    $0x4,%esp
801031c6:	53                   	push   %ebx
801031c7:	50                   	push   %eax
801031c8:	68 c4 81 10 80       	push   $0x801081c4
801031cd:	e8 8e d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
801031d2:	e8 19 33 00 00       	call   801064f0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031d7:	e8 04 09 00 00       	call   80103ae0 <mycpu>
801031dc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031de:	b8 01 00 00 00       	mov    $0x1,%eax
801031e3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801031ea:	e8 41 1b 00 00       	call   80104d30 <scheduler>
801031ef:	90                   	nop

801031f0 <mpenter>:
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801031f6:	e8 e5 43 00 00       	call   801075e0 <switchkvm>
  seginit();
801031fb:	e8 50 43 00 00       	call   80107550 <seginit>
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
80103227:	68 88 6c 11 80       	push   $0x80116c88
8010322c:	e8 2f f5 ff ff       	call   80102760 <kinit1>
  kvmalloc();      // kernel page table
80103231:	e8 7a 48 00 00       	call   80107ab0 <kvmalloc>
  mpinit();        // detect other processors
80103236:	e8 75 01 00 00       	call   801033b0 <mpinit>
  lapicinit();     // interrupt controller
8010323b:	e8 60 f7 ff ff       	call   801029a0 <lapicinit>
  seginit();       // segment descriptors
80103240:	e8 0b 43 00 00       	call   80107550 <seginit>
  picinit();       // disable pic
80103245:	e8 46 03 00 00       	call   80103590 <picinit>
  ioapicinit();    // another interrupt controller
8010324a:	e8 41 f3 ff ff       	call   80102590 <ioapicinit>
  consoleinit();   // console hardware
8010324f:	e8 6c da ff ff       	call   80100cc0 <consoleinit>
  uartinit();      // serial port
80103254:	e8 c7 35 00 00       	call   80106820 <uartinit>
  pinit();         // process table
80103259:	e8 62 08 00 00       	call   80103ac0 <pinit>
  tvinit();        // trap vectors
8010325e:	e8 0d 32 00 00       	call   80106470 <tvinit>
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
80103284:	e8 77 1f 00 00       	call   80105200 <memmove>

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
801032b0:	e8 2b 08 00 00       	call   80103ae0 <mycpu>
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
80103325:	e8 86 08 00 00       	call   80103bb0 <userinit>
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
8010335e:	68 d8 81 10 80       	push   $0x801081d8
80103363:	56                   	push   %esi
80103364:	e8 37 1e 00 00       	call   801051a0 <memcmp>
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
8010341c:	68 f5 81 10 80       	push   $0x801081f5
80103421:	56                   	push   %esi
80103422:	e8 79 1d 00 00       	call   801051a0 <memcmp>
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
801034b0:	ff 24 95 1c 82 10 80 	jmp    *-0x7fef7de4(,%edx,4)
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
80103563:	68 dd 81 10 80       	push   $0x801081dd
80103568:	e8 23 ce ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010356d:	83 ec 0c             	sub    $0xc,%esp
80103570:	68 fc 81 10 80       	push   $0x801081fc
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
8010366b:	68 30 82 10 80       	push   $0x80108230
80103670:	50                   	push   %eax
80103671:	e8 8a 18 00 00       	call   80104f00 <initlock>
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
801036cf:	e8 6c 19 00 00       	call   80105040 <acquire>
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
801036ef:	e8 4c 0b 00 00       	call   80104240 <wakeup>
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
80103714:	e9 e7 19 00 00       	jmp    80105100 <release>
80103719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103720:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103726:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103729:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103730:	00 00 00 
    wakeup(&p->nwrite);
80103733:	50                   	push   %eax
80103734:	e8 07 0b 00 00       	call   80104240 <wakeup>
80103739:	83 c4 10             	add    $0x10,%esp
8010373c:	eb b9                	jmp    801036f7 <pipeclose+0x37>
8010373e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103740:	83 ec 0c             	sub    $0xc,%esp
80103743:	53                   	push   %ebx
80103744:	e8 b7 19 00 00       	call   80105100 <release>
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
8010376d:	e8 ce 18 00 00       	call   80105040 <acquire>
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
801037c4:	e8 77 0a 00 00       	call   80104240 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037c9:	5a                   	pop    %edx
801037ca:	59                   	pop    %ecx
801037cb:	53                   	push   %ebx
801037cc:	56                   	push   %esi
801037cd:	e8 ae 08 00 00       	call   80104080 <sleep>
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
801037f4:	e8 87 03 00 00       	call   80103b80 <myproc>
801037f9:	8b 40 24             	mov    0x24(%eax),%eax
801037fc:	85 c0                	test   %eax,%eax
801037fe:	74 c0                	je     801037c0 <pipewrite+0x60>
        release(&p->lock);
80103800:	83 ec 0c             	sub    $0xc,%esp
80103803:	53                   	push   %ebx
80103804:	e8 f7 18 00 00       	call   80105100 <release>
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
80103853:	e8 e8 09 00 00       	call   80104240 <wakeup>
  release(&p->lock);
80103858:	89 1c 24             	mov    %ebx,(%esp)
8010385b:	e8 a0 18 00 00       	call   80105100 <release>
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
80103880:	e8 bb 17 00 00       	call   80105040 <acquire>
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
801038b5:	e8 c6 07 00 00       	call   80104080 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038ba:	83 c4 10             	add    $0x10,%esp
801038bd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801038c3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801038c9:	75 35                	jne    80103900 <piperead+0x90>
801038cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801038d1:	85 d2                	test   %edx,%edx
801038d3:	0f 84 8f 00 00 00    	je     80103968 <piperead+0xf8>
    if(myproc()->killed){
801038d9:	e8 a2 02 00 00       	call   80103b80 <myproc>
801038de:	8b 48 24             	mov    0x24(%eax),%ecx
801038e1:	85 c9                	test   %ecx,%ecx
801038e3:	74 cb                	je     801038b0 <piperead+0x40>
      release(&p->lock);
801038e5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038ed:	56                   	push   %esi
801038ee:	e8 0d 18 00 00       	call   80105100 <release>
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
80103947:	e8 f4 08 00 00       	call   80104240 <wakeup>
  release(&p->lock);
8010394c:	89 34 24             	mov    %esi,(%esp)
8010394f:	e8 ac 17 00 00       	call   80105100 <release>
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
80103981:	e8 ba 16 00 00       	call   80105040 <acquire>
80103986:	83 c4 10             	add    $0x10,%esp
80103989:	eb 17                	jmp    801039a2 <allocproc+0x32>
8010398b:	90                   	nop
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103990:	81 c3 90 00 00 00    	add    $0x90,%ebx
80103996:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
8010399c:	0f 83 9e 00 00 00    	jae    80103a40 <allocproc+0xd0>
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
801039c9:	e8 32 17 00 00       	call   80105100 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801039ce:	e8 5d ee ff ff       	call   80102830 <kalloc>
801039d3:	83 c4 10             	add    $0x10,%esp
801039d6:	85 c0                	test   %eax,%eax
801039d8:	89 43 08             	mov    %eax,0x8(%ebx)
801039db:	74 7c                	je     80103a59 <allocproc+0xe9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801039dd:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801039e3:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801039e6:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801039eb:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801039ee:	c7 40 14 61 64 10 80 	movl   $0x80106461,0x14(%eax)
  p->context = (struct context*)sp;
801039f5:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801039f8:	6a 14                	push   $0x14
801039fa:	6a 00                	push   $0x0
801039fc:	50                   	push   %eax
801039fd:	e8 4e 17 00 00       	call   80105150 <memset>
  p->context->eip = (uint)forkret;
80103a02:	8b 43 1c             	mov    0x1c(%ebx),%eax

  p->process_count = process_number;
  process_number++;
  p->lottery_ticket = 50;
  p->schedQueue = LOTTERY;
  return p;
80103a05:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a08:	c7 40 10 70 3a 10 80 	movl   $0x80103a70,0x10(%eax)
  p->process_count = process_number;
80103a0f:	a1 e0 3f 11 80       	mov    0x80113fe0,%eax
  p->lottery_ticket = 50;
80103a14:	c7 43 7c 32 00 00 00 	movl   $0x32,0x7c(%ebx)
  p->schedQueue = LOTTERY;
80103a1b:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103a22:	00 00 00 
  p->process_count = process_number;
80103a25:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  process_number++;
80103a2b:	83 c0 01             	add    $0x1,%eax
80103a2e:	a3 e0 3f 11 80       	mov    %eax,0x80113fe0
}
80103a33:	89 d8                	mov    %ebx,%eax
80103a35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a38:	c9                   	leave  
80103a39:	c3                   	ret    
80103a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103a40:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103a43:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103a45:	68 00 40 11 80       	push   $0x80114000
80103a4a:	e8 b1 16 00 00       	call   80105100 <release>
}
80103a4f:	89 d8                	mov    %ebx,%eax
  return 0;
80103a51:	83 c4 10             	add    $0x10,%esp
}
80103a54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a57:	c9                   	leave  
80103a58:	c3                   	ret    
    p->state = UNUSED;
80103a59:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103a60:	31 db                	xor    %ebx,%ebx
80103a62:	eb cf                	jmp    80103a33 <allocproc+0xc3>
80103a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103a70 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a76:	68 00 40 11 80       	push   $0x80114000
80103a7b:	e8 80 16 00 00       	call   80105100 <release>

  if (first) {
80103a80:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103a85:	83 c4 10             	add    $0x10,%esp
80103a88:	85 c0                	test   %eax,%eax
80103a8a:	75 04                	jne    80103a90 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103a8c:	c9                   	leave  
80103a8d:	c3                   	ret    
80103a8e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103a90:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103a93:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103a9a:	00 00 00 
    iinit(ROOTDEV);
80103a9d:	6a 01                	push   $0x1
80103a9f:	e8 4c dd ff ff       	call   801017f0 <iinit>
    initlog(ROOTDEV);
80103aa4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103aab:	e8 c0 f3 ff ff       	call   80102e70 <initlog>
80103ab0:	83 c4 10             	add    $0x10,%esp
}
80103ab3:	c9                   	leave  
80103ab4:	c3                   	ret    
80103ab5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ac0 <pinit>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ac6:	68 35 82 10 80       	push   $0x80108235
80103acb:	68 00 40 11 80       	push   $0x80114000
80103ad0:	e8 2b 14 00 00       	call   80104f00 <initlock>
}
80103ad5:	83 c4 10             	add    $0x10,%esp
80103ad8:	c9                   	leave  
80103ad9:	c3                   	ret    
80103ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ae0 <mycpu>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	56                   	push   %esi
80103ae4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ae5:	9c                   	pushf  
80103ae6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ae7:	f6 c4 02             	test   $0x2,%ah
80103aea:	75 5e                	jne    80103b4a <mycpu+0x6a>
  apicid = lapicid();
80103aec:	e8 af ef ff ff       	call   80102aa0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103af1:	8b 35 c0 3f 11 80    	mov    0x80113fc0,%esi
80103af7:	85 f6                	test   %esi,%esi
80103af9:	7e 42                	jle    80103b3d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103afb:	0f b6 15 40 3a 11 80 	movzbl 0x80113a40,%edx
80103b02:	39 d0                	cmp    %edx,%eax
80103b04:	74 30                	je     80103b36 <mycpu+0x56>
80103b06:	b9 f0 3a 11 80       	mov    $0x80113af0,%ecx
  for (i = 0; i < ncpu; ++i) {
80103b0b:	31 d2                	xor    %edx,%edx
80103b0d:	8d 76 00             	lea    0x0(%esi),%esi
80103b10:	83 c2 01             	add    $0x1,%edx
80103b13:	39 f2                	cmp    %esi,%edx
80103b15:	74 26                	je     80103b3d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103b17:	0f b6 19             	movzbl (%ecx),%ebx
80103b1a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103b20:	39 c3                	cmp    %eax,%ebx
80103b22:	75 ec                	jne    80103b10 <mycpu+0x30>
80103b24:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103b2a:	05 40 3a 11 80       	add    $0x80113a40,%eax
}
80103b2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b32:	5b                   	pop    %ebx
80103b33:	5e                   	pop    %esi
80103b34:	5d                   	pop    %ebp
80103b35:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103b36:	b8 40 3a 11 80       	mov    $0x80113a40,%eax
      return &cpus[i];
80103b3b:	eb f2                	jmp    80103b2f <mycpu+0x4f>
  panic("unknown apicid\n");
80103b3d:	83 ec 0c             	sub    $0xc,%esp
80103b40:	68 3c 82 10 80       	push   $0x8010823c
80103b45:	e8 46 c8 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b4a:	83 ec 0c             	sub    $0xc,%esp
80103b4d:	68 1c 84 10 80       	push   $0x8010841c
80103b52:	e8 39 c8 ff ff       	call   80100390 <panic>
80103b57:	89 f6                	mov    %esi,%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b60 <cpuid>:
cpuid() {
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b66:	e8 75 ff ff ff       	call   80103ae0 <mycpu>
80103b6b:	2d 40 3a 11 80       	sub    $0x80113a40,%eax
}
80103b70:	c9                   	leave  
  return mycpu()-cpus;
80103b71:	c1 f8 04             	sar    $0x4,%eax
80103b74:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b7a:	c3                   	ret    
80103b7b:	90                   	nop
80103b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b80 <myproc>:
myproc(void) {
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	53                   	push   %ebx
80103b84:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103b87:	e8 e4 13 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80103b8c:	e8 4f ff ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103b91:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b97:	e8 14 14 00 00       	call   80104fb0 <popcli>
}
80103b9c:	83 c4 04             	add    $0x4,%esp
80103b9f:	89 d8                	mov    %ebx,%eax
80103ba1:	5b                   	pop    %ebx
80103ba2:	5d                   	pop    %ebp
80103ba3:	c3                   	ret    
80103ba4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103baa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103bb0 <userinit>:
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	53                   	push   %ebx
80103bb4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103bb7:	e8 b4 fd ff ff       	call   80103970 <allocproc>
80103bbc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103bbe:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if((p->pgdir = setupkvm()) == 0)
80103bc3:	e8 68 3e 00 00       	call   80107a30 <setupkvm>
80103bc8:	85 c0                	test   %eax,%eax
80103bca:	89 43 04             	mov    %eax,0x4(%ebx)
80103bcd:	0f 84 bd 00 00 00    	je     80103c90 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bd3:	83 ec 04             	sub    $0x4,%esp
80103bd6:	68 2c 00 00 00       	push   $0x2c
80103bdb:	68 60 b4 10 80       	push   $0x8010b460
80103be0:	50                   	push   %eax
80103be1:	e8 2a 3b 00 00       	call   80107710 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103be6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103be9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103bef:	6a 4c                	push   $0x4c
80103bf1:	6a 00                	push   $0x0
80103bf3:	ff 73 18             	pushl  0x18(%ebx)
80103bf6:	e8 55 15 00 00       	call   80105150 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bfb:	8b 43 18             	mov    0x18(%ebx),%eax
80103bfe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c03:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c08:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c0b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c12:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c16:	8b 43 18             	mov    0x18(%ebx),%eax
80103c19:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c1d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c21:	8b 43 18             	mov    0x18(%ebx),%eax
80103c24:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c28:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c2c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c2f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c36:	8b 43 18             	mov    0x18(%ebx),%eax
80103c39:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c40:	8b 43 18             	mov    0x18(%ebx),%eax
80103c43:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c4a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c4d:	6a 10                	push   $0x10
80103c4f:	68 65 82 10 80       	push   $0x80108265
80103c54:	50                   	push   %eax
80103c55:	e8 d6 16 00 00       	call   80105330 <safestrcpy>
  p->cwd = namei("/");
80103c5a:	c7 04 24 6e 82 10 80 	movl   $0x8010826e,(%esp)
80103c61:	e8 ea e5 ff ff       	call   80102250 <namei>
80103c66:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c69:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103c70:	e8 cb 13 00 00       	call   80105040 <acquire>
  p->state = RUNNABLE;
80103c75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c7c:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103c83:	e8 78 14 00 00       	call   80105100 <release>
}
80103c88:	83 c4 10             	add    $0x10,%esp
80103c8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c8e:	c9                   	leave  
80103c8f:	c3                   	ret    
    panic("userinit: out of memory?");
80103c90:	83 ec 0c             	sub    $0xc,%esp
80103c93:	68 4c 82 10 80       	push   $0x8010824c
80103c98:	e8 f3 c6 ff ff       	call   80100390 <panic>
80103c9d:	8d 76 00             	lea    0x0(%esi),%esi

80103ca0 <growproc>:
{
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	56                   	push   %esi
80103ca4:	53                   	push   %ebx
80103ca5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ca8:	e8 c3 12 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80103cad:	e8 2e fe ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103cb2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cb8:	e8 f3 12 00 00       	call   80104fb0 <popcli>
  if(n > 0){
80103cbd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103cc0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103cc2:	7f 1c                	jg     80103ce0 <growproc+0x40>
  } else if(n < 0){
80103cc4:	75 3a                	jne    80103d00 <growproc+0x60>
  switchuvm(curproc);
80103cc6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103cc9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103ccb:	53                   	push   %ebx
80103ccc:	e8 2f 39 00 00       	call   80107600 <switchuvm>
  return 0;
80103cd1:	83 c4 10             	add    $0x10,%esp
80103cd4:	31 c0                	xor    %eax,%eax
}
80103cd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cd9:	5b                   	pop    %ebx
80103cda:	5e                   	pop    %esi
80103cdb:	5d                   	pop    %ebp
80103cdc:	c3                   	ret    
80103cdd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ce0:	83 ec 04             	sub    $0x4,%esp
80103ce3:	01 c6                	add    %eax,%esi
80103ce5:	56                   	push   %esi
80103ce6:	50                   	push   %eax
80103ce7:	ff 73 04             	pushl  0x4(%ebx)
80103cea:	e8 61 3b 00 00       	call   80107850 <allocuvm>
80103cef:	83 c4 10             	add    $0x10,%esp
80103cf2:	85 c0                	test   %eax,%eax
80103cf4:	75 d0                	jne    80103cc6 <growproc+0x26>
      return -1;
80103cf6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cfb:	eb d9                	jmp    80103cd6 <growproc+0x36>
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d00:	83 ec 04             	sub    $0x4,%esp
80103d03:	01 c6                	add    %eax,%esi
80103d05:	56                   	push   %esi
80103d06:	50                   	push   %eax
80103d07:	ff 73 04             	pushl  0x4(%ebx)
80103d0a:	e8 71 3c 00 00       	call   80107980 <deallocuvm>
80103d0f:	83 c4 10             	add    $0x10,%esp
80103d12:	85 c0                	test   %eax,%eax
80103d14:	75 b0                	jne    80103cc6 <growproc+0x26>
80103d16:	eb de                	jmp    80103cf6 <growproc+0x56>
80103d18:	90                   	nop
80103d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d20 <fork>:
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	57                   	push   %edi
80103d24:	56                   	push   %esi
80103d25:	53                   	push   %ebx
80103d26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d29:	e8 42 12 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80103d2e:	e8 ad fd ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103d33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d39:	e8 72 12 00 00       	call   80104fb0 <popcli>
  if((np = allocproc()) == 0){
80103d3e:	e8 2d fc ff ff       	call   80103970 <allocproc>
80103d43:	85 c0                	test   %eax,%eax
80103d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d48:	0f 84 b7 00 00 00    	je     80103e05 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d4e:	83 ec 08             	sub    $0x8,%esp
80103d51:	ff 33                	pushl  (%ebx)
80103d53:	ff 73 04             	pushl  0x4(%ebx)
80103d56:	89 c7                	mov    %eax,%edi
80103d58:	e8 a3 3d 00 00       	call   80107b00 <copyuvm>
80103d5d:	83 c4 10             	add    $0x10,%esp
80103d60:	85 c0                	test   %eax,%eax
80103d62:	89 47 04             	mov    %eax,0x4(%edi)
80103d65:	0f 84 a1 00 00 00    	je     80103e0c <fork+0xec>
  np->sz = curproc->sz;
80103d6b:	8b 03                	mov    (%ebx),%eax
80103d6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d70:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103d72:	89 59 14             	mov    %ebx,0x14(%ecx)
80103d75:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103d77:	8b 79 18             	mov    0x18(%ecx),%edi
80103d7a:	8b 73 18             	mov    0x18(%ebx),%esi
80103d7d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103d82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103d84:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103d86:	8b 40 18             	mov    0x18(%eax),%eax
80103d89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103d90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d94:	85 c0                	test   %eax,%eax
80103d96:	74 13                	je     80103dab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d98:	83 ec 0c             	sub    $0xc,%esp
80103d9b:	50                   	push   %eax
80103d9c:	e8 af d3 ff ff       	call   80101150 <filedup>
80103da1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103da4:	83 c4 10             	add    $0x10,%esp
80103da7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103dab:	83 c6 01             	add    $0x1,%esi
80103dae:	83 fe 10             	cmp    $0x10,%esi
80103db1:	75 dd                	jne    80103d90 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103db3:	83 ec 0c             	sub    $0xc,%esp
80103db6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103db9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103dbc:	e8 ff db ff ff       	call   801019c0 <idup>
80103dc1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dc4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103dc7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103dcd:	6a 10                	push   $0x10
80103dcf:	53                   	push   %ebx
80103dd0:	50                   	push   %eax
80103dd1:	e8 5a 15 00 00       	call   80105330 <safestrcpy>
  pid = np->pid;
80103dd6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103dd9:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103de0:	e8 5b 12 00 00       	call   80105040 <acquire>
  np->state = RUNNABLE;
80103de5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103dec:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103df3:	e8 08 13 00 00       	call   80105100 <release>
  return pid;
80103df8:	83 c4 10             	add    $0x10,%esp
}
80103dfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dfe:	89 d8                	mov    %ebx,%eax
80103e00:	5b                   	pop    %ebx
80103e01:	5e                   	pop    %esi
80103e02:	5f                   	pop    %edi
80103e03:	5d                   	pop    %ebp
80103e04:	c3                   	ret    
    return -1;
80103e05:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e0a:	eb ef                	jmp    80103dfb <fork+0xdb>
    kfree(np->kstack);
80103e0c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103e0f:	83 ec 0c             	sub    $0xc,%esp
80103e12:	ff 73 08             	pushl  0x8(%ebx)
80103e15:	e8 66 e8 ff ff       	call   80102680 <kfree>
    np->kstack = 0;
80103e1a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103e21:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103e28:	83 c4 10             	add    $0x10,%esp
80103e2b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e30:	eb c9                	jmp    80103dfb <fork+0xdb>
80103e32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e40 <sched>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	56                   	push   %esi
80103e44:	53                   	push   %ebx
  pushcli();
80103e45:	e8 26 11 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80103e4a:	e8 91 fc ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103e4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e55:	e8 56 11 00 00       	call   80104fb0 <popcli>
  if(!holding(&ptable.lock))
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 00 40 11 80       	push   $0x80114000
80103e62:	e8 a9 11 00 00       	call   80105010 <holding>
80103e67:	83 c4 10             	add    $0x10,%esp
80103e6a:	85 c0                	test   %eax,%eax
80103e6c:	74 4f                	je     80103ebd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103e6e:	e8 6d fc ff ff       	call   80103ae0 <mycpu>
80103e73:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e7a:	75 68                	jne    80103ee4 <sched+0xa4>
  if(p->state == RUNNING)
80103e7c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e80:	74 55                	je     80103ed7 <sched+0x97>
80103e82:	9c                   	pushf  
80103e83:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e84:	f6 c4 02             	test   $0x2,%ah
80103e87:	75 41                	jne    80103eca <sched+0x8a>
  intena = mycpu()->intena;
80103e89:	e8 52 fc ff ff       	call   80103ae0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e8e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e91:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e97:	e8 44 fc ff ff       	call   80103ae0 <mycpu>
80103e9c:	83 ec 08             	sub    $0x8,%esp
80103e9f:	ff 70 04             	pushl  0x4(%eax)
80103ea2:	53                   	push   %ebx
80103ea3:	e8 e3 14 00 00       	call   8010538b <swtch>
  mycpu()->intena = intena;
80103ea8:	e8 33 fc ff ff       	call   80103ae0 <mycpu>
}
80103ead:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103eb0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103eb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103eb9:	5b                   	pop    %ebx
80103eba:	5e                   	pop    %esi
80103ebb:	5d                   	pop    %ebp
80103ebc:	c3                   	ret    
    panic("sched ptable.lock");
80103ebd:	83 ec 0c             	sub    $0xc,%esp
80103ec0:	68 70 82 10 80       	push   $0x80108270
80103ec5:	e8 c6 c4 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103eca:	83 ec 0c             	sub    $0xc,%esp
80103ecd:	68 9c 82 10 80       	push   $0x8010829c
80103ed2:	e8 b9 c4 ff ff       	call   80100390 <panic>
    panic("sched running");
80103ed7:	83 ec 0c             	sub    $0xc,%esp
80103eda:	68 8e 82 10 80       	push   $0x8010828e
80103edf:	e8 ac c4 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103ee4:	83 ec 0c             	sub    $0xc,%esp
80103ee7:	68 82 82 10 80       	push   $0x80108282
80103eec:	e8 9f c4 ff ff       	call   80100390 <panic>
80103ef1:	eb 0d                	jmp    80103f00 <exit>
80103ef3:	90                   	nop
80103ef4:	90                   	nop
80103ef5:	90                   	nop
80103ef6:	90                   	nop
80103ef7:	90                   	nop
80103ef8:	90                   	nop
80103ef9:	90                   	nop
80103efa:	90                   	nop
80103efb:	90                   	nop
80103efc:	90                   	nop
80103efd:	90                   	nop
80103efe:	90                   	nop
80103eff:	90                   	nop

80103f00 <exit>:
{
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	57                   	push   %edi
80103f04:	56                   	push   %esi
80103f05:	53                   	push   %ebx
80103f06:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103f09:	e8 62 10 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80103f0e:	e8 cd fb ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103f13:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f19:	e8 92 10 00 00       	call   80104fb0 <popcli>
  if(curproc == initproc)
80103f1e:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80103f24:	8d 5e 28             	lea    0x28(%esi),%ebx
80103f27:	8d 7e 68             	lea    0x68(%esi),%edi
80103f2a:	0f 84 f1 00 00 00    	je     80104021 <exit+0x121>
    if(curproc->ofile[fd]){
80103f30:	8b 03                	mov    (%ebx),%eax
80103f32:	85 c0                	test   %eax,%eax
80103f34:	74 12                	je     80103f48 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103f36:	83 ec 0c             	sub    $0xc,%esp
80103f39:	50                   	push   %eax
80103f3a:	e8 61 d2 ff ff       	call   801011a0 <fileclose>
      curproc->ofile[fd] = 0;
80103f3f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103f45:	83 c4 10             	add    $0x10,%esp
80103f48:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103f4b:	39 fb                	cmp    %edi,%ebx
80103f4d:	75 e1                	jne    80103f30 <exit+0x30>
  begin_op();
80103f4f:	e8 bc ef ff ff       	call   80102f10 <begin_op>
  iput(curproc->cwd);
80103f54:	83 ec 0c             	sub    $0xc,%esp
80103f57:	ff 76 68             	pushl  0x68(%esi)
80103f5a:	e8 c1 db ff ff       	call   80101b20 <iput>
  end_op();
80103f5f:	e8 1c f0 ff ff       	call   80102f80 <end_op>
  curproc->cwd = 0;
80103f64:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103f6b:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80103f72:	e8 c9 10 00 00       	call   80105040 <acquire>
  wakeup1(curproc->parent);
80103f77:	8b 56 14             	mov    0x14(%esi),%edx
80103f7a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f7d:	b8 34 40 11 80       	mov    $0x80114034,%eax
80103f82:	eb 10                	jmp    80103f94 <exit+0x94>
80103f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f88:	05 90 00 00 00       	add    $0x90,%eax
80103f8d:	3d 34 64 11 80       	cmp    $0x80116434,%eax
80103f92:	73 1e                	jae    80103fb2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103f94:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f98:	75 ee                	jne    80103f88 <exit+0x88>
80103f9a:	3b 50 20             	cmp    0x20(%eax),%edx
80103f9d:	75 e9                	jne    80103f88 <exit+0x88>
      p->state = RUNNABLE;
80103f9f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fa6:	05 90 00 00 00       	add    $0x90,%eax
80103fab:	3d 34 64 11 80       	cmp    $0x80116434,%eax
80103fb0:	72 e2                	jb     80103f94 <exit+0x94>
      p->parent = initproc;
80103fb2:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb8:	ba 34 40 11 80       	mov    $0x80114034,%edx
80103fbd:	eb 0f                	jmp    80103fce <exit+0xce>
80103fbf:	90                   	nop
80103fc0:	81 c2 90 00 00 00    	add    $0x90,%edx
80103fc6:	81 fa 34 64 11 80    	cmp    $0x80116434,%edx
80103fcc:	73 3a                	jae    80104008 <exit+0x108>
    if(p->parent == curproc){
80103fce:	39 72 14             	cmp    %esi,0x14(%edx)
80103fd1:	75 ed                	jne    80103fc0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103fd3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103fd7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103fda:	75 e4                	jne    80103fc0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fdc:	b8 34 40 11 80       	mov    $0x80114034,%eax
80103fe1:	eb 11                	jmp    80103ff4 <exit+0xf4>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fe8:	05 90 00 00 00       	add    $0x90,%eax
80103fed:	3d 34 64 11 80       	cmp    $0x80116434,%eax
80103ff2:	73 cc                	jae    80103fc0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103ff4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ff8:	75 ee                	jne    80103fe8 <exit+0xe8>
80103ffa:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ffd:	75 e9                	jne    80103fe8 <exit+0xe8>
      p->state = RUNNABLE;
80103fff:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104006:	eb e0                	jmp    80103fe8 <exit+0xe8>
  curproc->state = ZOMBIE;
80104008:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010400f:	e8 2c fe ff ff       	call   80103e40 <sched>
  panic("zombie exit");
80104014:	83 ec 0c             	sub    $0xc,%esp
80104017:	68 bd 82 10 80       	push   $0x801082bd
8010401c:	e8 6f c3 ff ff       	call   80100390 <panic>
    panic("init exiting");
80104021:	83 ec 0c             	sub    $0xc,%esp
80104024:	68 b0 82 10 80       	push   $0x801082b0
80104029:	e8 62 c3 ff ff       	call   80100390 <panic>
8010402e:	66 90                	xchg   %ax,%ax

80104030 <yield>:
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	53                   	push   %ebx
80104034:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104037:	68 00 40 11 80       	push   $0x80114000
8010403c:	e8 ff 0f 00 00       	call   80105040 <acquire>
  pushcli();
80104041:	e8 2a 0f 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80104046:	e8 95 fa ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
8010404b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104051:	e8 5a 0f 00 00       	call   80104fb0 <popcli>
  myproc()->state = RUNNABLE;
80104056:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010405d:	e8 de fd ff ff       	call   80103e40 <sched>
  release(&ptable.lock);
80104062:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80104069:	e8 92 10 00 00       	call   80105100 <release>
}
8010406e:	83 c4 10             	add    $0x10,%esp
80104071:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104074:	c9                   	leave  
80104075:	c3                   	ret    
80104076:	8d 76 00             	lea    0x0(%esi),%esi
80104079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104080 <sleep>:
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	57                   	push   %edi
80104084:	56                   	push   %esi
80104085:	53                   	push   %ebx
80104086:	83 ec 0c             	sub    $0xc,%esp
80104089:	8b 7d 08             	mov    0x8(%ebp),%edi
8010408c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010408f:	e8 dc 0e 00 00       	call   80104f70 <pushcli>
  c = mycpu();
80104094:	e8 47 fa ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80104099:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010409f:	e8 0c 0f 00 00       	call   80104fb0 <popcli>
  if(p == 0)
801040a4:	85 db                	test   %ebx,%ebx
801040a6:	0f 84 87 00 00 00    	je     80104133 <sleep+0xb3>
  if(lk == 0)
801040ac:	85 f6                	test   %esi,%esi
801040ae:	74 76                	je     80104126 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801040b0:	81 fe 00 40 11 80    	cmp    $0x80114000,%esi
801040b6:	74 50                	je     80104108 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801040b8:	83 ec 0c             	sub    $0xc,%esp
801040bb:	68 00 40 11 80       	push   $0x80114000
801040c0:	e8 7b 0f 00 00       	call   80105040 <acquire>
    release(lk);
801040c5:	89 34 24             	mov    %esi,(%esp)
801040c8:	e8 33 10 00 00       	call   80105100 <release>
  p->chan = chan;
801040cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040d7:	e8 64 fd ff ff       	call   80103e40 <sched>
  p->chan = 0;
801040dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801040e3:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
801040ea:	e8 11 10 00 00       	call   80105100 <release>
    acquire(lk);
801040ef:	89 75 08             	mov    %esi,0x8(%ebp)
801040f2:	83 c4 10             	add    $0x10,%esp
}
801040f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040f8:	5b                   	pop    %ebx
801040f9:	5e                   	pop    %esi
801040fa:	5f                   	pop    %edi
801040fb:	5d                   	pop    %ebp
    acquire(lk);
801040fc:	e9 3f 0f 00 00       	jmp    80105040 <acquire>
80104101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104108:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010410b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104112:	e8 29 fd ff ff       	call   80103e40 <sched>
  p->chan = 0;
80104117:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010411e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104121:	5b                   	pop    %ebx
80104122:	5e                   	pop    %esi
80104123:	5f                   	pop    %edi
80104124:	5d                   	pop    %ebp
80104125:	c3                   	ret    
    panic("sleep without lk");
80104126:	83 ec 0c             	sub    $0xc,%esp
80104129:	68 cf 82 10 80       	push   $0x801082cf
8010412e:	e8 5d c2 ff ff       	call   80100390 <panic>
    panic("sleep");
80104133:	83 ec 0c             	sub    $0xc,%esp
80104136:	68 c9 82 10 80       	push   $0x801082c9
8010413b:	e8 50 c2 ff ff       	call   80100390 <panic>

80104140 <wait>:
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	56                   	push   %esi
80104144:	53                   	push   %ebx
  pushcli();
80104145:	e8 26 0e 00 00       	call   80104f70 <pushcli>
  c = mycpu();
8010414a:	e8 91 f9 ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
8010414f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104155:	e8 56 0e 00 00       	call   80104fb0 <popcli>
  acquire(&ptable.lock);
8010415a:	83 ec 0c             	sub    $0xc,%esp
8010415d:	68 00 40 11 80       	push   $0x80114000
80104162:	e8 d9 0e 00 00       	call   80105040 <acquire>
80104167:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010416a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010416c:	bb 34 40 11 80       	mov    $0x80114034,%ebx
80104171:	eb 13                	jmp    80104186 <wait+0x46>
80104173:	90                   	nop
80104174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104178:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010417e:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
80104184:	73 1e                	jae    801041a4 <wait+0x64>
      if(p->parent != curproc)
80104186:	39 73 14             	cmp    %esi,0x14(%ebx)
80104189:	75 ed                	jne    80104178 <wait+0x38>
      if(p->state == ZOMBIE){
8010418b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010418f:	74 37                	je     801041c8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104191:	81 c3 90 00 00 00    	add    $0x90,%ebx
      havekids = 1;
80104197:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010419c:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
801041a2:	72 e2                	jb     80104186 <wait+0x46>
    if(!havekids || curproc->killed){
801041a4:	85 c0                	test   %eax,%eax
801041a6:	74 76                	je     8010421e <wait+0xde>
801041a8:	8b 46 24             	mov    0x24(%esi),%eax
801041ab:	85 c0                	test   %eax,%eax
801041ad:	75 6f                	jne    8010421e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801041af:	83 ec 08             	sub    $0x8,%esp
801041b2:	68 00 40 11 80       	push   $0x80114000
801041b7:	56                   	push   %esi
801041b8:	e8 c3 fe ff ff       	call   80104080 <sleep>
    havekids = 0;
801041bd:	83 c4 10             	add    $0x10,%esp
801041c0:	eb a8                	jmp    8010416a <wait+0x2a>
801041c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
801041c8:	83 ec 0c             	sub    $0xc,%esp
801041cb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801041ce:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041d1:	e8 aa e4 ff ff       	call   80102680 <kfree>
        freevm(p->pgdir);
801041d6:	5a                   	pop    %edx
801041d7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801041da:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801041e1:	e8 ca 37 00 00       	call   801079b0 <freevm>
        release(&ptable.lock);
801041e6:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
        p->pid = 0;
801041ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041f4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801041fb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801041ff:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104206:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010420d:	e8 ee 0e 00 00       	call   80105100 <release>
        return pid;
80104212:	83 c4 10             	add    $0x10,%esp
}
80104215:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104218:	89 f0                	mov    %esi,%eax
8010421a:	5b                   	pop    %ebx
8010421b:	5e                   	pop    %esi
8010421c:	5d                   	pop    %ebp
8010421d:	c3                   	ret    
      release(&ptable.lock);
8010421e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104221:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104226:	68 00 40 11 80       	push   $0x80114000
8010422b:	e8 d0 0e 00 00       	call   80105100 <release>
      return -1;
80104230:	83 c4 10             	add    $0x10,%esp
80104233:	eb e0                	jmp    80104215 <wait+0xd5>
80104235:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
8010424a:	68 00 40 11 80       	push   $0x80114000
8010424f:	e8 ec 0d 00 00       	call   80105040 <acquire>
80104254:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104257:	b8 34 40 11 80       	mov    $0x80114034,%eax
8010425c:	eb 0e                	jmp    8010426c <wakeup+0x2c>
8010425e:	66 90                	xchg   %ax,%ax
80104260:	05 90 00 00 00       	add    $0x90,%eax
80104265:	3d 34 64 11 80       	cmp    $0x80116434,%eax
8010426a:	73 1e                	jae    8010428a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010426c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104270:	75 ee                	jne    80104260 <wakeup+0x20>
80104272:	3b 58 20             	cmp    0x20(%eax),%ebx
80104275:	75 e9                	jne    80104260 <wakeup+0x20>
      p->state = RUNNABLE;
80104277:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010427e:	05 90 00 00 00       	add    $0x90,%eax
80104283:	3d 34 64 11 80       	cmp    $0x80116434,%eax
80104288:	72 e2                	jb     8010426c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010428a:	c7 45 08 00 40 11 80 	movl   $0x80114000,0x8(%ebp)
}
80104291:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104294:	c9                   	leave  
  release(&ptable.lock);
80104295:	e9 66 0e 00 00       	jmp    80105100 <release>
8010429a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801042aa:	68 00 40 11 80       	push   $0x80114000
801042af:	e8 8c 0d 00 00       	call   80105040 <acquire>
801042b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b7:	b8 34 40 11 80       	mov    $0x80114034,%eax
801042bc:	eb 0e                	jmp    801042cc <kill+0x2c>
801042be:	66 90                	xchg   %ax,%ax
801042c0:	05 90 00 00 00       	add    $0x90,%eax
801042c5:	3d 34 64 11 80       	cmp    $0x80116434,%eax
801042ca:	73 34                	jae    80104300 <kill+0x60>
    if(p->pid == pid){
801042cc:	39 58 10             	cmp    %ebx,0x10(%eax)
801042cf:	75 ef                	jne    801042c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801042d1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801042d5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801042dc:	75 07                	jne    801042e5 <kill+0x45>
        p->state = RUNNABLE;
801042de:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801042e5:	83 ec 0c             	sub    $0xc,%esp
801042e8:	68 00 40 11 80       	push   $0x80114000
801042ed:	e8 0e 0e 00 00       	call   80105100 <release>
      return 0;
801042f2:	83 c4 10             	add    $0x10,%esp
801042f5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801042f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042fa:	c9                   	leave  
801042fb:	c3                   	ret    
801042fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104300:	83 ec 0c             	sub    $0xc,%esp
80104303:	68 00 40 11 80       	push   $0x80114000
80104308:	e8 f3 0d 00 00       	call   80105100 <release>
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
80104329:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
8010432e:	83 ec 3c             	sub    $0x3c,%esp
80104331:	eb 27                	jmp    8010435a <procdump+0x3a>
80104333:	90                   	nop
80104334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 1f 88 10 80       	push   $0x8010881f
80104340:	e8 1b c3 ff ff       	call   80100660 <cprintf>
80104345:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104348:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010434e:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
80104354:	0f 83 86 00 00 00    	jae    801043e0 <procdump+0xc0>
    if(p->state == UNUSED)
8010435a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010435d:	85 c0                	test   %eax,%eax
8010435f:	74 e7                	je     80104348 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104361:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104364:	ba e0 82 10 80       	mov    $0x801082e0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104369:	77 11                	ja     8010437c <procdump+0x5c>
8010436b:	8b 14 85 d0 84 10 80 	mov    -0x7fef7b30(,%eax,4),%edx
      state = "???";
80104372:	b8 e0 82 10 80       	mov    $0x801082e0,%eax
80104377:	85 d2                	test   %edx,%edx
80104379:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010437c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010437f:	50                   	push   %eax
80104380:	52                   	push   %edx
80104381:	ff 73 10             	pushl  0x10(%ebx)
80104384:	68 e4 82 10 80       	push   $0x801082e4
80104389:	e8 d2 c2 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010438e:	83 c4 10             	add    $0x10,%esp
80104391:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104395:	75 a1                	jne    80104338 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104397:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010439a:	83 ec 08             	sub    $0x8,%esp
8010439d:	8d 7d c0             	lea    -0x40(%ebp),%edi
801043a0:	50                   	push   %eax
801043a1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801043a4:	8b 40 0c             	mov    0xc(%eax),%eax
801043a7:	83 c0 08             	add    $0x8,%eax
801043aa:	50                   	push   %eax
801043ab:	e8 70 0b 00 00       	call   80104f20 <getcallerpcs>
801043b0:	83 c4 10             	add    $0x10,%esp
801043b3:	90                   	nop
801043b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801043b8:	8b 17                	mov    (%edi),%edx
801043ba:	85 d2                	test   %edx,%edx
801043bc:	0f 84 76 ff ff ff    	je     80104338 <procdump+0x18>
        cprintf(" %p", pc[i]);
801043c2:	83 ec 08             	sub    $0x8,%esp
801043c5:	83 c7 04             	add    $0x4,%edi
801043c8:	52                   	push   %edx
801043c9:	68 21 7d 10 80       	push   $0x80107d21
801043ce:	e8 8d c2 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801043d3:	83 c4 10             	add    $0x10,%esp
801043d6:	39 fe                	cmp    %edi,%esi
801043d8:	75 de                	jne    801043b8 <procdump+0x98>
801043da:	e9 59 ff ff ff       	jmp    80104338 <procdump+0x18>
801043df:	90                   	nop
  }
}
801043e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043e3:	5b                   	pop    %ebx
801043e4:	5e                   	pop    %esi
801043e5:	5f                   	pop    %edi
801043e6:	5d                   	pop    %ebp
801043e7:	c3                   	ret    
801043e8:	90                   	nop
801043e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043f0 <printProcess>:

void
printProcess(struct proc* p)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	53                   	push   %ebx
801043f4:	83 ec 0c             	sub    $0xc,%esp
801043f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cprintf("name : %s\n", p->name);
801043fa:	8d 43 6c             	lea    0x6c(%ebx),%eax
801043fd:	50                   	push   %eax
801043fe:	68 ed 82 10 80       	push   $0x801082ed
80104403:	e8 58 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PID : %d\n",p->pid);
80104408:	58                   	pop    %eax
80104409:	5a                   	pop    %edx
8010440a:	ff 73 10             	pushl  0x10(%ebx)
8010440d:	68 f9 82 10 80       	push   $0x801082f9
80104412:	e8 49 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PPID : %d\n",p->parent->pid);
80104417:	59                   	pop    %ecx
80104418:	58                   	pop    %eax
80104419:	8b 43 14             	mov    0x14(%ebx),%eax
8010441c:	ff 70 10             	pushl  0x10(%eax)
8010441f:	68 f8 82 10 80       	push   $0x801082f8
80104424:	e8 37 c2 ff ff       	call   80100660 <cprintf>
  switch (p->state)
80104429:	83 c4 10             	add    $0x10,%esp
8010442c:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104430:	77 6e                	ja     801044a0 <printProcess+0xb0>
80104432:	8b 43 0c             	mov    0xc(%ebx),%eax
80104435:	ff 24 85 b8 84 10 80 	jmp    *-0x7fef7b48(,%eax,4)
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    case 3:
      cprintf("state : RUNNABLE\n");
      break;
    case 4:
      cprintf("state : RUNNING\n");
80104440:	c7 45 08 47 83 10 80 	movl   $0x80108347,0x8(%ebp)
      break;
    case 5:
      cprintf("state : ZOMBIE\n");
      break;
  }
}
80104447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010444a:	c9                   	leave  
      cprintf("state : RUNNING\n");
8010444b:	e9 10 c2 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : ZOMBIE\n");
80104450:	c7 45 08 58 83 10 80 	movl   $0x80108358,0x8(%ebp)
}
80104457:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010445a:	c9                   	leave  
      cprintf("state : ZOMBIE\n");
8010445b:	e9 00 c2 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : UNUSED\n");
80104460:	c7 45 08 03 83 10 80 	movl   $0x80108303,0x8(%ebp)
}
80104467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010446a:	c9                   	leave  
      cprintf("state : UNUSED\n");
8010446b:	e9 f0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : EMBRYO\n");
80104470:	c7 45 08 13 83 10 80 	movl   $0x80108313,0x8(%ebp)
}
80104477:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010447a:	c9                   	leave  
      cprintf("state : EMBRYO\n");
8010447b:	e9 e0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : SLEEPING\n");
80104480:	c7 45 08 23 83 10 80 	movl   $0x80108323,0x8(%ebp)
}
80104487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010448a:	c9                   	leave  
      cprintf("state : SLEEPING\n");
8010448b:	e9 d0 c1 ff ff       	jmp    80100660 <cprintf>
      cprintf("state : RUNNABLE\n");
80104490:	c7 45 08 35 83 10 80 	movl   $0x80108335,0x8(%ebp)
}
80104497:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010449a:	c9                   	leave  
      cprintf("state : RUNNABLE\n");
8010449b:	e9 c0 c1 ff ff       	jmp    80100660 <cprintf>
}
801044a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044a3:	c9                   	leave  
801044a4:	c3                   	ret    
801044a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044b0 <getprocs>:

int
getprocs(void)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	53                   	push   %ebx
  struct proc* p;
  cprintf("\n-----------------------------\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044b4:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
801044b9:	83 ec 10             	sub    $0x10,%esp
  cprintf("\n-----------------------------\n");
801044bc:	68 44 84 10 80       	push   $0x80108444
801044c1:	e8 9a c1 ff ff       	call   80100660 <cprintf>
801044c6:	83 c4 10             	add    $0x10,%esp
801044c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  { if (p->pid == 0)
801044d0:	8b 43 10             	mov    0x10(%ebx),%eax
801044d3:	85 c0                	test   %eax,%eax
801044d5:	74 18                	je     801044ef <getprocs+0x3f>
        continue;    
    printProcess(p);
801044d7:	83 ec 0c             	sub    $0xc,%esp
801044da:	53                   	push   %ebx
801044db:	e8 10 ff ff ff       	call   801043f0 <printProcess>
    cprintf("\n-----------------------------\n");
801044e0:	c7 04 24 44 84 10 80 	movl   $0x80108444,(%esp)
801044e7:	e8 74 c1 ff ff       	call   80100660 <cprintf>
801044ec:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044ef:	81 c3 90 00 00 00    	add    $0x90,%ebx
801044f5:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
801044fb:	72 d3                	jb     801044d0 <getprocs+0x20>
  }
  return 23;
}
801044fd:	b8 17 00 00 00       	mov    $0x17,%eax
80104502:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104505:	c9                   	leave  
80104506:	c3                   	ret    
80104507:	89 f6                	mov    %esi,%esi
80104509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104510 <generate_random>:

int generate_random(int toMod)
{
  int random;
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
80104510:	a1 80 6c 11 80       	mov    0x80116c80,%eax
{
80104515:	55                   	push   %ebp
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
80104516:	31 d2                	xor    %edx,%edx
{
80104518:	89 e5                	mov    %esp,%ebp
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010451a:	0f af c0             	imul   %eax,%eax
8010451d:	0f af c0             	imul   %eax,%eax
80104520:	05 4e 61 bc 00       	add    $0xbc614e,%eax
80104525:	f7 75 08             	divl   0x8(%ebp)
  return random;
}
80104528:	5d                   	pop    %ebp
80104529:	89 d0                	mov    %edx,%eax
8010452b:	c3                   	ret    
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104530 <lotterySched>:

struct proc*
lotterySched(void){
80104530:	55                   	push   %ebp
  int sum_lotteries = 1;
  int random_ticket = 0;
  int isLotterySelected = 0;
  struct proc *highLottery_ticket = 0; //process with highest lottery ticket
  
  sum_lotteries = 1;
80104531:	b9 01 00 00 00       	mov    $0x1,%ecx
  isLotterySelected = 0;
  // Loop over process table looking for process to run.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104536:	b8 34 40 11 80       	mov    $0x80114034,%eax
lotterySched(void){
8010453b:	89 e5                	mov    %esp,%ebp
8010453d:	57                   	push   %edi
8010453e:	56                   	push   %esi
8010453f:	53                   	push   %ebx
    if(p->state != RUNNABLE || p->schedQueue != LOTTERY)
80104540:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104544:	75 0c                	jne    80104552 <lotterySched+0x22>
80104546:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
8010454d:	75 03                	jne    80104552 <lotterySched+0x22>
      continue;
    sum_lotteries += p->lottery_ticket;
8010454f:	03 48 7c             	add    0x7c(%eax),%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104552:	05 90 00 00 00       	add    $0x90,%eax
80104557:	3d 34 64 11 80       	cmp    $0x80116434,%eax
8010455c:	72 e2                	jb     80104540 <lotterySched+0x10>
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010455e:	a1 80 6c 11 80       	mov    0x80116c80,%eax
80104563:	31 d2                	xor    %edx,%edx
  struct proc *highLottery_ticket = 0; //process with highest lottery ticket
80104565:	31 f6                	xor    %esi,%esi
  isLotterySelected = 0;
80104567:	31 db                	xor    %ebx,%ebx
80104569:	bf 02 00 00 00       	mov    $0x2,%edi
  random = (12345678 + ticks*ticks*ticks*ticks) % toMod;
8010456e:	0f af c0             	imul   %eax,%eax
80104571:	0f af c0             	imul   %eax,%eax
80104574:	05 4e 61 bc 00       	add    $0xbc614e,%eax
80104579:	f7 f1                	div    %ecx
  }

  random_ticket = generate_random(sum_lotteries);
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010457b:	b9 34 40 11 80       	mov    $0x80114034,%ecx
80104580:	eb 2c                	jmp    801045ae <lotterySched+0x7e>
80104582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104588:	83 fb 01             	cmp    $0x1,%ebx
8010458b:	0f 94 c0             	sete   %al
      highLottery_ticket = p;
      isLotterySelected = 1;
      
    }

    if(random_ticket <= 0 && isLotterySelected == 1)
8010458e:	85 d2                	test   %edx,%edx
80104590:	7f 0e                	jg     801045a0 <lotterySched+0x70>
80104592:	84 c0                	test   %al,%al
80104594:	0f 45 f1             	cmovne %ecx,%esi
80104597:	0f 45 df             	cmovne %edi,%ebx
8010459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045a0:	81 c1 90 00 00 00    	add    $0x90,%ecx
801045a6:	81 f9 34 64 11 80    	cmp    $0x80116434,%ecx
801045ac:	73 2a                	jae    801045d8 <lotterySched+0xa8>
    if(p->state != RUNNABLE || p->schedQueue != LOTTERY)
801045ae:	83 79 0c 03          	cmpl   $0x3,0xc(%ecx)
801045b2:	75 ec                	jne    801045a0 <lotterySched+0x70>
801045b4:	83 b9 80 00 00 00 02 	cmpl   $0x2,0x80(%ecx)
801045bb:	75 e3                	jne    801045a0 <lotterySched+0x70>
    random_ticket -= p->lottery_ticket;
801045bd:	2b 51 7c             	sub    0x7c(%ecx),%edx
    if(!isLotterySelected) {
801045c0:	85 db                	test   %ebx,%ebx
801045c2:	75 c4                	jne    80104588 <lotterySched+0x58>
801045c4:	89 ce                	mov    %ecx,%esi
801045c6:	b8 01 00 00 00       	mov    $0x1,%eax
      isLotterySelected = 1;
801045cb:	bb 01 00 00 00       	mov    $0x1,%ebx
801045d0:	eb bc                	jmp    8010458e <lotterySched+0x5e>
801045d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
    if(isLotterySelected != 0) {
      return highLottery_ticket;
    }
    return 0;  
801045d8:	85 db                	test   %ebx,%ebx
801045da:	b8 00 00 00 00       	mov    $0x0,%eax
801045df:	0f 44 f0             	cmove  %eax,%esi
}
801045e2:	5b                   	pop    %ebx
801045e3:	89 f0                	mov    %esi,%eax
801045e5:	5e                   	pop    %esi
801045e6:	5f                   	pop    %edi
801045e7:	5d                   	pop    %ebp
801045e8:	c3                   	ret    
801045e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801045f0 <prioritySched>:


struct proc*
prioritySched(void)
{
801045f0:	55                   	push   %ebp
  struct proc *p;
  
 
  int priorityProcessSelected = 0;
  struct proc *highPriority = 0; //process with highest priority
801045f1:	31 c0                	xor    %eax,%eax
  // Enable interrupts on this processor.
  priorityProcessSelected = 0;
801045f3:	31 c9                	xor    %ecx,%ecx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045f5:	ba 34 40 11 80       	mov    $0x80114034,%edx
{
801045fa:	89 e5                	mov    %esp,%ebp
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state != RUNNABLE || p->schedQueue != PRIORITY)
80104600:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80104604:	75 22                	jne    80104628 <prioritySched+0x38>
80104606:	83 ba 80 00 00 00 00 	cmpl   $0x0,0x80(%edx)
8010460d:	75 19                	jne    80104628 <prioritySched+0x38>
      continue;

    if(!priorityProcessSelected)
8010460f:	85 c9                	test   %ecx,%ecx
    {
      highPriority = p;
      priorityProcessSelected = 1;
    }
    if(highPriority->priority > p->priority )
80104611:	8b 8a 84 00 00 00    	mov    0x84(%edx),%ecx
    if(!priorityProcessSelected)
80104617:	0f 44 c2             	cmove  %edx,%eax
    if(highPriority->priority > p->priority )
8010461a:	39 88 84 00 00 00    	cmp    %ecx,0x84(%eax)
80104620:	b9 01 00 00 00       	mov    $0x1,%ecx
80104625:	0f 4f c2             	cmovg  %edx,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104628:	81 c2 90 00 00 00    	add    $0x90,%edx
8010462e:	81 fa 34 64 11 80    	cmp    $0x80116434,%edx
80104634:	72 ca                	jb     80104600 <prioritySched+0x10>
  {
    
    return highPriority;
  }
  
  return 0;
80104636:	85 c9                	test   %ecx,%ecx
80104638:	ba 00 00 00 00       	mov    $0x0,%edx
8010463d:	0f 44 c2             	cmove  %edx,%eax

}
80104640:	5d                   	pop    %ebp
80104641:	c3                   	ret    
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <SJFSched>:

// scheduling algorithm
struct proc*
SJFSched(void)
{
80104650:	55                   	push   %ebp
  struct proc *p;
 
  int shortestProcessSelected = 0;
  struct proc *shortestTime = 0; //process that come earlier
80104651:	31 c0                	xor    %eax,%eax
  
  
    shortestProcessSelected = 0;
80104653:	31 c9                	xor    %ecx,%ecx

      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104655:	ba 34 40 11 80       	mov    $0x80114034,%edx
{
8010465a:	89 e5                	mov    %esp,%ebp
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->state != RUNNABLE || p->schedQueue != SJF)
80104660:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80104664:	75 22                	jne    80104688 <SJFSched+0x38>
80104666:	83 ba 80 00 00 00 01 	cmpl   $0x1,0x80(%edx)
8010466d:	75 19                	jne    80104688 <SJFSched+0x38>
          continue;
        if(!shortestProcessSelected){
8010466f:	85 c9                	test   %ecx,%ecx
          shortestTime = p;
          shortestProcessSelected = 1;
        }
        if(shortestTime->burst_time > p->burst_time)
80104671:	8b 8a 88 00 00 00    	mov    0x88(%edx),%ecx
        if(!shortestProcessSelected){
80104677:	0f 44 c2             	cmove  %edx,%eax
        if(shortestTime->burst_time > p->burst_time)
8010467a:	39 88 88 00 00 00    	cmp    %ecx,0x88(%eax)
80104680:	b9 01 00 00 00       	mov    $0x1,%ecx
80104685:	0f 4f c2             	cmovg  %edx,%eax
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104688:	81 c2 90 00 00 00    	add    $0x90,%edx
8010468e:	81 fa 34 64 11 80    	cmp    $0x80116434,%edx
80104694:	72 ca                	jb     80104660 <SJFSched+0x10>
    }
    if(shortestProcessSelected)
    {
      return shortestTime;
    }
  return 0;
80104696:	85 c9                	test   %ecx,%ecx
80104698:	ba 00 00 00 00       	mov    $0x0,%edx
8010469d:	0f 44 c2             	cmove  %edx,%eax
}
801046a0:	5d                   	pop    %ebp
801046a1:	c3                   	ret    
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <find_and_set_priority>:

void find_and_set_priority(int priority , int pid)
{
801046b0:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046b1:	b8 34 40 11 80       	mov    $0x80114034,%eax
{
801046b6:	89 e5                	mov    %esp,%ebp
801046b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801046bb:	eb 0f                	jmp    801046cc <find_and_set_priority+0x1c>
801046bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046c0:	05 90 00 00 00       	add    $0x90,%eax
801046c5:	3d 34 64 11 80       	cmp    $0x80116434,%eax
801046ca:	73 0e                	jae    801046da <find_and_set_priority+0x2a>
    if(pid == p->pid)
801046cc:	39 50 10             	cmp    %edx,0x10(%eax)
801046cf:	75 ef                	jne    801046c0 <find_and_set_priority+0x10>
    {
      p -> priority = priority;
801046d1:	8b 55 08             	mov    0x8(%ebp),%edx
801046d4:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
      break;
    }
  }
}
801046da:	5d                   	pop    %ebp
801046db:	c3                   	ret    
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <find_and_set_lottery_ticket>:

void find_and_set_lottery_ticket(int lottery_ticket , int pid){
801046e0:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e1:	b8 34 40 11 80       	mov    $0x80114034,%eax
void find_and_set_lottery_ticket(int lottery_ticket , int pid){
801046e6:	89 e5                	mov    %esp,%ebp
801046e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801046eb:	eb 0f                	jmp    801046fc <find_and_set_lottery_ticket+0x1c>
801046ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f0:	05 90 00 00 00       	add    $0x90,%eax
801046f5:	3d 34 64 11 80       	cmp    $0x80116434,%eax
801046fa:	73 0b                	jae    80104707 <find_and_set_lottery_ticket+0x27>
    if(pid == p->pid)
801046fc:	39 50 10             	cmp    %edx,0x10(%eax)
801046ff:	75 ef                	jne    801046f0 <find_and_set_lottery_ticket+0x10>
    {
      p -> lottery_ticket = lottery_ticket;
80104701:	8b 55 08             	mov    0x8(%ebp),%edx
80104704:	89 50 7c             	mov    %edx,0x7c(%eax)
      break;
    }
  }
}
80104707:	5d                   	pop    %ebp
80104708:	c3                   	ret    
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104710 <find_and_set_sched_queue>:

void 
find_and_set_sched_queue(int qeue_number, int pid)
{
80104710:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104711:	b8 34 40 11 80       	mov    $0x80114034,%eax
{
80104716:	89 e5                	mov    %esp,%ebp
80104718:	8b 55 0c             	mov    0xc(%ebp),%edx
8010471b:	eb 0f                	jmp    8010472c <find_and_set_sched_queue+0x1c>
8010471d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104720:	05 90 00 00 00       	add    $0x90,%eax
80104725:	3d 34 64 11 80       	cmp    $0x80116434,%eax
8010472a:	73 0e                	jae    8010473a <find_and_set_sched_queue+0x2a>
    if(pid == p->pid)
8010472c:	39 50 10             	cmp    %edx,0x10(%eax)
8010472f:	75 ef                	jne    80104720 <find_and_set_sched_queue+0x10>
    {
      p -> schedQueue = qeue_number;
80104731:	8b 55 08             	mov    0x8(%ebp),%edx
80104734:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      break;
    }
  }
}
8010473a:	5d                   	pop    %ebp
8010473b:	c3                   	ret    
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <find_and_set_burst_time>:

void 
find_and_set_burst_time(int burst_time, int pid)
{
80104740:	55                   	push   %ebp
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104741:	b8 34 40 11 80       	mov    $0x80114034,%eax
{
80104746:	89 e5                	mov    %esp,%ebp
80104748:	8b 55 0c             	mov    0xc(%ebp),%edx
8010474b:	eb 0f                	jmp    8010475c <find_and_set_burst_time+0x1c>
8010474d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104750:	05 90 00 00 00       	add    $0x90,%eax
80104755:	3d 34 64 11 80       	cmp    $0x80116434,%eax
8010475a:	73 0e                	jae    8010476a <find_and_set_burst_time+0x2a>
    if(pid == p->pid)
8010475c:	39 50 10             	cmp    %edx,0x10(%eax)
8010475f:	75 ef                	jne    80104750 <find_and_set_burst_time+0x10>
    {
      p -> burst_time = burst_time;
80104761:	8b 55 08             	mov    0x8(%ebp),%edx
80104764:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      break;
    }
  }
}
8010476a:	5d                   	pop    %ebp
8010476b:	c3                   	ret    
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104770 <print_state>:

char* print_state(int state){
80104770:	55                   	push   %ebp
  if(state == 0){
    return "UNUSED";
80104771:	b8 68 83 10 80       	mov    $0x80108368,%eax
char* print_state(int state){
80104776:	89 e5                	mov    %esp,%ebp
80104778:	8b 55 08             	mov    0x8(%ebp),%edx
  if(state == 0){
8010477b:	85 d2                	test   %edx,%edx
8010477d:	74 38                	je     801047b7 <print_state+0x47>
  }else if(state == 1){
8010477f:	83 fa 01             	cmp    $0x1,%edx
    return "EMBRYO";
80104782:	b8 6f 83 10 80       	mov    $0x8010836f,%eax
  }else if(state == 1){
80104787:	74 2e                	je     801047b7 <print_state+0x47>
  }else if(state == 2){
80104789:	83 fa 02             	cmp    $0x2,%edx
    return "SLEEPING";
8010478c:	b8 76 83 10 80       	mov    $0x80108376,%eax
  }else if(state == 2){
80104791:	74 24                	je     801047b7 <print_state+0x47>
  }else if(state == 3){
80104793:	83 fa 03             	cmp    $0x3,%edx
    return "RUNNABLE";
80104796:	b8 7f 83 10 80       	mov    $0x8010837f,%eax
  }else if(state == 3){
8010479b:	74 1a                	je     801047b7 <print_state+0x47>
  }else if(state == 4){
8010479d:	83 fa 04             	cmp    $0x4,%edx
    return "RUNNING";
801047a0:	b8 8f 83 10 80       	mov    $0x8010838f,%eax
  }else if(state == 4){
801047a5:	74 10                	je     801047b7 <print_state+0x47>
  }else if(state == 5){
    return "ZOMBIE";
  }else{
    return "";
801047a7:	83 fa 05             	cmp    $0x5,%edx
801047aa:	b8 88 83 10 80       	mov    $0x80108388,%eax
801047af:	ba 20 88 10 80       	mov    $0x80108820,%edx
801047b4:	0f 45 c2             	cmovne %edx,%eax
  }
}
801047b7:	5d                   	pop    %ebp
801047b8:	c3                   	ret    
801047b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047c0 <int_size>:

int int_size(int i){
801047c0:	55                   	push   %ebp
    if( i >= 1000000000) return 10;
801047c1:	b8 0a 00 00 00       	mov    $0xa,%eax
int int_size(int i){
801047c6:	89 e5                	mov    %esp,%ebp
801047c8:	8b 55 08             	mov    0x8(%ebp),%edx
    if( i >= 1000000000) return 10;
801047cb:	81 fa ff c9 9a 3b    	cmp    $0x3b9ac9ff,%edx
801047d1:	7f 63                	jg     80104836 <int_size+0x76>
    if( i >= 100000000)  return 9;
801047d3:	81 fa ff e0 f5 05    	cmp    $0x5f5e0ff,%edx
801047d9:	b8 09 00 00 00       	mov    $0x9,%eax
801047de:	7f 56                	jg     80104836 <int_size+0x76>
    if( i >= 10000000)   return 8;
801047e0:	81 fa 7f 96 98 00    	cmp    $0x98967f,%edx
801047e6:	b8 08 00 00 00       	mov    $0x8,%eax
801047eb:	7f 49                	jg     80104836 <int_size+0x76>
    if( i >= 1000000)    return 7;
801047ed:	81 fa 3f 42 0f 00    	cmp    $0xf423f,%edx
801047f3:	b8 07 00 00 00       	mov    $0x7,%eax
801047f8:	7f 3c                	jg     80104836 <int_size+0x76>
    if( i >= 100000)     return 6;
801047fa:	81 fa 9f 86 01 00    	cmp    $0x1869f,%edx
80104800:	b8 06 00 00 00       	mov    $0x6,%eax
80104805:	7f 2f                	jg     80104836 <int_size+0x76>
    if( i >= 10000)      return 5;
80104807:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
8010480d:	b8 05 00 00 00       	mov    $0x5,%eax
80104812:	7f 22                	jg     80104836 <int_size+0x76>
    if( i >= 1000)       return 4;
80104814:	81 fa e7 03 00 00    	cmp    $0x3e7,%edx
8010481a:	b8 04 00 00 00       	mov    $0x4,%eax
8010481f:	7f 15                	jg     80104836 <int_size+0x76>
    if( i >= 100)        return 3;
80104821:	83 fa 63             	cmp    $0x63,%edx
80104824:	b8 03 00 00 00       	mov    $0x3,%eax
80104829:	7f 0b                	jg     80104836 <int_size+0x76>
    if( i >= 10)         return 2;
                        return 1;
8010482b:	31 c0                	xor    %eax,%eax
8010482d:	83 fa 09             	cmp    $0x9,%edx
80104830:	0f 9f c0             	setg   %al
80104833:	83 c0 01             	add    $0x1,%eax
}
80104836:	5d                   	pop    %ebp
80104837:	c3                   	ret    
80104838:	90                   	nop
80104839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104840 <find_queue_name>:

char* find_queue_name(int queue){
80104840:	55                   	push   %ebp
  if(queue == 3){
    return "PRIORITY";
80104841:	b8 97 83 10 80       	mov    $0x80108397,%eax
char* find_queue_name(int queue){
80104846:	89 e5                	mov    %esp,%ebp
80104848:	8b 55 08             	mov    0x8(%ebp),%edx
  if(queue == 3){
8010484b:	83 fa 03             	cmp    $0x3,%edx
8010484e:	74 1a                	je     8010486a <find_queue_name+0x2a>
  }else if(queue == 2){
80104850:	83 fa 02             	cmp    $0x2,%edx
    return "SJF";
80104853:	b8 a8 83 10 80       	mov    $0x801083a8,%eax
  }else if(queue == 2){
80104858:	74 10                	je     8010486a <find_queue_name+0x2a>
  }else if(queue == 1){
    return "LOTTERY";
  }else{
    return "";
8010485a:	83 fa 01             	cmp    $0x1,%edx
8010485d:	b8 a0 83 10 80       	mov    $0x801083a0,%eax
80104862:	ba 20 88 10 80       	mov    $0x80108820,%edx
80104867:	0f 45 c2             	cmovne %edx,%eax
  }
}
8010486a:	5d                   	pop    %ebp
8010486b:	c3                   	ret    
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104870 <show_all_processes_scheduling>:

void
show_all_processes_scheduling()
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	56                   	push   %esi
80104875:	53                   	push   %ebx
  struct proc *p;
  int name_spaces = 0;
80104876:	31 ff                	xor    %edi,%edi
  int i = 0 ;
  char* state;
  char* queue_name;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104878:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
8010487d:	83 ec 1c             	sub    $0x1c,%esp
80104880:	eb 14                	jmp    80104896 <show_all_processes_scheduling+0x26>
80104882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104888:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010488e:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
80104894:	73 36                	jae    801048cc <show_all_processes_scheduling+0x5c>
    if(p->pid == 0)
80104896:	8b 73 10             	mov    0x10(%ebx),%esi
80104899:	85 f6                	test   %esi,%esi
8010489b:	74 eb                	je     80104888 <show_all_processes_scheduling+0x18>
8010489d:	8d 73 6c             	lea    0x6c(%ebx),%esi
      continue;
    if( name_spaces < strlen(p->name))
801048a0:	83 ec 0c             	sub    $0xc,%esp
801048a3:	56                   	push   %esi
801048a4:	e8 c7 0a 00 00       	call   80105370 <strlen>
801048a9:	83 c4 10             	add    $0x10,%esp
801048ac:	39 f8                	cmp    %edi,%eax
801048ae:	7e d8                	jle    80104888 <show_all_processes_scheduling+0x18>
      name_spaces = strlen(p->name);
801048b0:	83 ec 0c             	sub    $0xc,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048b3:	81 c3 90 00 00 00    	add    $0x90,%ebx
      name_spaces = strlen(p->name);
801048b9:	56                   	push   %esi
801048ba:	e8 b1 0a 00 00       	call   80105370 <strlen>
801048bf:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048c2:	81 fb 34 64 11 80    	cmp    $0x80116434,%ebx
      name_spaces = strlen(p->name);
801048c8:	89 c7                	mov    %eax,%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048ca:	72 ca                	jb     80104896 <show_all_processes_scheduling+0x26>
  }

  cprintf("name");
801048cc:	83 ec 0c             	sub    $0xc,%esp
801048cf:	89 7d e0             	mov    %edi,-0x20(%ebp)
801048d2:	89 fe                	mov    %edi,%esi
801048d4:	68 ac 83 10 80       	push   $0x801083ac
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
801048d9:	31 db                	xor    %ebx,%ebx
  cprintf("name");
801048db:	e8 80 bd ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
801048e0:	83 c4 10             	add    $0x10,%esp
801048e3:	eb 16                	jmp    801048fb <show_all_processes_scheduling+0x8b>
801048e5:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf(" ");
801048e8:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
801048eb:	83 c3 01             	add    $0x1,%ebx
    cprintf(" ");
801048ee:	68 11 84 10 80       	push   $0x80108411
801048f3:	e8 68 bd ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < name_spaces - strlen("name") + 3 ; i++)
801048f8:	83 c4 10             	add    $0x10,%esp
801048fb:	83 ec 0c             	sub    $0xc,%esp
801048fe:	68 ac 83 10 80       	push   $0x801083ac
80104903:	e8 68 0a 00 00       	call   80105370 <strlen>
80104908:	89 f1                	mov    %esi,%ecx
8010490a:	83 c4 10             	add    $0x10,%esp
8010490d:	29 c1                	sub    %eax,%ecx
8010490f:	89 c8                	mov    %ecx,%eax
80104911:	83 c0 02             	add    $0x2,%eax
80104914:	39 d8                	cmp    %ebx,%eax
80104916:	7d d0                	jge    801048e8 <show_all_processes_scheduling+0x78>
  
  cprintf("pid");
80104918:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0 ; i < 4; i++)
    cprintf(" ");
  cprintf("state");
8010491b:	bb 06 00 00 00       	mov    $0x6,%ebx
  cprintf("pid");
80104920:	68 b1 83 10 80       	push   $0x801083b1
80104925:	e8 36 bd ff ff       	call   80100660 <cprintf>
    cprintf(" ");
8010492a:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104931:	e8 2a bd ff ff       	call   80100660 <cprintf>
80104936:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
8010493d:	e8 1e bd ff ff       	call   80100660 <cprintf>
80104942:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104949:	e8 12 bd ff ff       	call   80100660 <cprintf>
8010494e:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104955:	e8 06 bd ff ff       	call   80100660 <cprintf>
  cprintf("state");
8010495a:	c7 04 24 b5 83 10 80 	movl   $0x801083b5,(%esp)
80104961:	e8 fa bc ff ff       	call   80100660 <cprintf>
80104966:	83 c4 10             	add    $0x10,%esp
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0 ; i < 6; i++)
    cprintf(" ");
80104970:	83 ec 0c             	sub    $0xc,%esp
80104973:	68 11 84 10 80       	push   $0x80108411
80104978:	e8 e3 bc ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < 6; i++)
8010497d:	83 c4 10             	add    $0x10,%esp
80104980:	83 eb 01             	sub    $0x1,%ebx
80104983:	75 eb                	jne    80104970 <show_all_processes_scheduling+0x100>
  cprintf("queue");
80104985:	83 ec 0c             	sub    $0xc,%esp
  cprintf("burstTime");
  for(i = 0 ; i < 3; i++)
    cprintf(" ");
  cprintf("number\n");
  cprintf("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104988:	bf 34 40 11 80       	mov    $0x80114034,%edi
  cprintf("queue");
8010498d:	68 bb 83 10 80       	push   $0x801083bb
80104992:	e8 c9 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104997:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
8010499e:	e8 bd bc ff ff       	call   80100660 <cprintf>
801049a3:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049aa:	e8 b1 bc ff ff       	call   80100660 <cprintf>
801049af:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049b6:	e8 a5 bc ff ff       	call   80100660 <cprintf>
801049bb:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049c2:	e8 99 bc ff ff       	call   80100660 <cprintf>
801049c7:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049ce:	e8 8d bc ff ff       	call   80100660 <cprintf>
  cprintf("priority");
801049d3:	c7 04 24 c1 83 10 80 	movl   $0x801083c1,(%esp)
801049da:	e8 81 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
801049df:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049e6:	e8 75 bc ff ff       	call   80100660 <cprintf>
801049eb:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049f2:	e8 69 bc ff ff       	call   80100660 <cprintf>
801049f7:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
801049fe:	e8 5d bc ff ff       	call   80100660 <cprintf>
  cprintf("lottery");
80104a03:	c7 04 24 ca 83 10 80 	movl   $0x801083ca,(%esp)
80104a0a:	e8 51 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a0f:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104a16:	e8 45 bc ff ff       	call   80100660 <cprintf>
80104a1b:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104a22:	e8 39 bc ff ff       	call   80100660 <cprintf>
80104a27:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104a2e:	e8 2d bc ff ff       	call   80100660 <cprintf>
  cprintf("burstTime");
80104a33:	c7 04 24 d2 83 10 80 	movl   $0x801083d2,(%esp)
80104a3a:	e8 21 bc ff ff       	call   80100660 <cprintf>
    cprintf(" ");
80104a3f:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104a46:	e8 15 bc ff ff       	call   80100660 <cprintf>
80104a4b:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104a52:	e8 09 bc ff ff       	call   80100660 <cprintf>
80104a57:	c7 04 24 11 84 10 80 	movl   $0x80108411,(%esp)
80104a5e:	e8 fd bb ff ff       	call   80100660 <cprintf>
  cprintf("number\n");
80104a63:	c7 04 24 dc 83 10 80 	movl   $0x801083dc,(%esp)
80104a6a:	e8 f1 bb ff ff       	call   80100660 <cprintf>
  cprintf("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n");
80104a6f:	c7 04 24 64 84 10 80 	movl   $0x80108464,(%esp)
80104a76:	e8 e5 bb ff ff       	call   80100660 <cprintf>
80104a7b:	83 c4 10             	add    $0x10,%esp
80104a7e:	eb 12                	jmp    80104a92 <show_all_processes_scheduling+0x222>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a80:	81 c7 90 00 00 00    	add    $0x90,%edi
80104a86:	81 ff 34 64 11 80    	cmp    $0x80116434,%edi
80104a8c:	0f 83 8e 02 00 00    	jae    80104d20 <show_all_processes_scheduling+0x4b0>
    if(p->pid == 0)
80104a92:	8b 5f 10             	mov    0x10(%edi),%ebx
80104a95:	85 db                	test   %ebx,%ebx
80104a97:	74 e7                	je     80104a80 <show_all_processes_scheduling+0x210>
80104a99:	8d 77 6c             	lea    0x6c(%edi),%esi
      continue;
    cprintf("%s", p->name);
80104a9c:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104a9f:	31 db                	xor    %ebx,%ebx
    cprintf("%s", p->name);
80104aa1:	56                   	push   %esi
80104aa2:	68 ea 82 10 80       	push   $0x801082ea
80104aa7:	e8 b4 bb ff ff       	call   80100660 <cprintf>
80104aac:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104aaf:	83 c4 10             	add    $0x10,%esp
80104ab2:	8b 7d e0             	mov    -0x20(%ebp),%edi
80104ab5:	eb 1c                	jmp    80104ad3 <show_all_processes_scheduling+0x263>
80104ab7:	89 f6                	mov    %esi,%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      cprintf(" ");
80104ac0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104ac3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104ac6:	68 11 84 10 80       	push   $0x80108411
80104acb:	e8 90 bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < name_spaces - strlen(p->name) + 4 ; i++)
80104ad0:	83 c4 10             	add    $0x10,%esp
80104ad3:	83 ec 0c             	sub    $0xc,%esp
80104ad6:	56                   	push   %esi
80104ad7:	e8 94 08 00 00       	call   80105370 <strlen>
80104adc:	89 fa                	mov    %edi,%edx
80104ade:	83 c4 10             	add    $0x10,%esp
80104ae1:	29 c2                	sub    %eax,%edx
80104ae3:	89 d0                	mov    %edx,%eax
80104ae5:	83 c0 03             	add    $0x3,%eax
80104ae8:	39 d8                	cmp    %ebx,%eax
80104aea:	7d d4                	jge    80104ac0 <show_all_processes_scheduling+0x250>
80104aec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    cprintf("%d", p->pid);
80104aef:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104af2:	31 db                	xor    %ebx,%ebx
    cprintf("%d", p->pid);
80104af4:	ff 77 10             	pushl  0x10(%edi)
80104af7:	68 e4 83 10 80       	push   $0x801083e4
80104afc:	e8 5f bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b01:	83 c4 10             	add    $0x10,%esp
80104b04:	eb 1d                	jmp    80104b23 <show_all_processes_scheduling+0x2b3>
80104b06:	8d 76 00             	lea    0x0(%esi),%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      cprintf(" ");
80104b10:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b13:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104b16:	68 11 84 10 80       	push   $0x80108411
80104b1b:	e8 40 bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 6 - int_size(p->pid); i++)
80104b20:	83 c4 10             	add    $0x10,%esp
80104b23:	83 ec 0c             	sub    $0xc,%esp
80104b26:	ff 77 10             	pushl  0x10(%edi)
80104b29:	e8 92 fc ff ff       	call   801047c0 <int_size>
80104b2e:	b9 06 00 00 00       	mov    $0x6,%ecx
80104b33:	83 c4 10             	add    $0x10,%esp
80104b36:	29 c1                	sub    %eax,%ecx
80104b38:	39 d9                	cmp    %ebx,%ecx
80104b3a:	7f d4                	jg     80104b10 <show_all_processes_scheduling+0x2a0>
    state = print_state(p->state);
80104b3c:	83 ec 0c             	sub    $0xc,%esp
80104b3f:	ff 77 0c             	pushl  0xc(%edi)
    cprintf("%s" , state);
    for(i = 0 ; i < 11 - strlen(state); i++)
80104b42:	31 db                	xor    %ebx,%ebx
    state = print_state(p->state);
80104b44:	e8 27 fc ff ff       	call   80104770 <print_state>
80104b49:	5a                   	pop    %edx
80104b4a:	59                   	pop    %ecx
    cprintf("%s" , state);
80104b4b:	50                   	push   %eax
80104b4c:	68 ea 82 10 80       	push   $0x801082ea
    state = print_state(p->state);
80104b51:	89 c6                	mov    %eax,%esi
    cprintf("%s" , state);
80104b53:	e8 08 bb ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 11 - strlen(state); i++)
80104b58:	83 c4 10             	add    $0x10,%esp
80104b5b:	eb 16                	jmp    80104b73 <show_all_processes_scheduling+0x303>
80104b5d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf(" ");
80104b60:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 11 - strlen(state); i++)
80104b63:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104b66:	68 11 84 10 80       	push   $0x80108411
80104b6b:	e8 f0 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 11 - strlen(state); i++)
80104b70:	83 c4 10             	add    $0x10,%esp
80104b73:	83 ec 0c             	sub    $0xc,%esp
80104b76:	56                   	push   %esi
80104b77:	e8 f4 07 00 00       	call   80105370 <strlen>
80104b7c:	ba 0b 00 00 00       	mov    $0xb,%edx
80104b81:	83 c4 10             	add    $0x10,%esp
80104b84:	29 c2                	sub    %eax,%edx
80104b86:	39 da                	cmp    %ebx,%edx
80104b88:	7f d6                	jg     80104b60 <show_all_processes_scheduling+0x2f0>
    queue_name =  find_queue_name(p->schedQueue);
80104b8a:	8b 87 80 00 00 00    	mov    0x80(%edi),%eax
    return "PRIORITY";
80104b90:	be 97 83 10 80       	mov    $0x80108397,%esi
  if(queue == 3){
80104b95:	83 f8 03             	cmp    $0x3,%eax
80104b98:	74 1a                	je     80104bb4 <show_all_processes_scheduling+0x344>
  }else if(queue == 2){
80104b9a:	83 f8 02             	cmp    $0x2,%eax
    return "SJF";
80104b9d:	be a8 83 10 80       	mov    $0x801083a8,%esi
  }else if(queue == 2){
80104ba2:	74 10                	je     80104bb4 <show_all_processes_scheduling+0x344>
    return "";
80104ba4:	83 f8 01             	cmp    $0x1,%eax
80104ba7:	be a0 83 10 80       	mov    $0x801083a0,%esi
80104bac:	b8 20 88 10 80       	mov    $0x80108820,%eax
80104bb1:	0f 45 f0             	cmovne %eax,%esi
    cprintf("%s ", queue_name);
80104bb4:	83 ec 08             	sub    $0x8,%esp
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104bb7:	31 db                	xor    %ebx,%ebx
    cprintf("%s ", queue_name);
80104bb9:	56                   	push   %esi
80104bba:	68 e7 83 10 80       	push   $0x801083e7
80104bbf:	e8 9c ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104bc4:	83 c4 10             	add    $0x10,%esp
80104bc7:	eb 1a                	jmp    80104be3 <show_all_processes_scheduling+0x373>
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104bd0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104bd3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104bd6:	68 11 84 10 80       	push   $0x80108411
80104bdb:	e8 80 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 12 - strlen(queue_name); i++)
80104be0:	83 c4 10             	add    $0x10,%esp
80104be3:	83 ec 0c             	sub    $0xc,%esp
80104be6:	56                   	push   %esi
80104be7:	e8 84 07 00 00       	call   80105370 <strlen>
80104bec:	b9 0c 00 00 00       	mov    $0xc,%ecx
80104bf1:	83 c4 10             	add    $0x10,%esp
80104bf4:	29 c1                	sub    %eax,%ecx
80104bf6:	39 d9                	cmp    %ebx,%ecx
80104bf8:	7f d6                	jg     80104bd0 <show_all_processes_scheduling+0x360>
    cprintf("%d  ", p->priority);
80104bfa:	83 ec 08             	sub    $0x8,%esp
80104bfd:	ff b7 84 00 00 00    	pushl  0x84(%edi)
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c03:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->priority);
80104c05:	68 eb 83 10 80       	push   $0x801083eb
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c0a:	be 08 00 00 00       	mov    $0x8,%esi
    cprintf("%d  ", p->priority);
80104c0f:	e8 4c ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c14:	83 c4 10             	add    $0x10,%esp
80104c17:	eb 1a                	jmp    80104c33 <show_all_processes_scheduling+0x3c3>
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104c20:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c23:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104c26:	68 11 84 10 80       	push   $0x80108411
80104c2b:	e8 30 ba ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 8 - int_size(p->priority); i++)
80104c30:	83 c4 10             	add    $0x10,%esp
80104c33:	83 ec 0c             	sub    $0xc,%esp
80104c36:	ff b7 84 00 00 00    	pushl  0x84(%edi)
80104c3c:	e8 7f fb ff ff       	call   801047c0 <int_size>
80104c41:	89 f2                	mov    %esi,%edx
80104c43:	83 c4 10             	add    $0x10,%esp
80104c46:	29 c2                	sub    %eax,%edx
80104c48:	39 da                	cmp    %ebx,%edx
80104c4a:	7f d4                	jg     80104c20 <show_all_processes_scheduling+0x3b0>
    cprintf("%d  ", p->lottery_ticket);
80104c4c:	83 ec 08             	sub    $0x8,%esp
80104c4f:	ff 77 7c             	pushl  0x7c(%edi)
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c52:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->lottery_ticket);
80104c54:	68 eb 83 10 80       	push   $0x801083eb
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c59:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->lottery_ticket);
80104c5e:	e8 fd b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c63:	83 c4 10             	add    $0x10,%esp
80104c66:	eb 1b                	jmp    80104c83 <show_all_processes_scheduling+0x413>
80104c68:	90                   	nop
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104c70:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c73:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104c76:	68 11 84 10 80       	push   $0x80108411
80104c7b:	e8 e0 b9 ff ff       	call   80100660 <cprintf>
    for(i = 0 ; i < 10 - int_size(p->lottery_ticket); i++)
80104c80:	83 c4 10             	add    $0x10,%esp
80104c83:	83 ec 0c             	sub    $0xc,%esp
80104c86:	ff 77 7c             	pushl  0x7c(%edi)
80104c89:	e8 32 fb ff ff       	call   801047c0 <int_size>
80104c8e:	89 f1                	mov    %esi,%ecx
80104c90:	83 c4 10             	add    $0x10,%esp
80104c93:	29 c1                	sub    %eax,%ecx
80104c95:	39 d9                	cmp    %ebx,%ecx
80104c97:	7f d7                	jg     80104c70 <show_all_processes_scheduling+0x400>
    cprintf("%d  ", p->burst_time);
80104c99:	83 ec 08             	sub    $0x8,%esp
80104c9c:	ff b7 88 00 00 00    	pushl  0x88(%edi)
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104ca2:	31 db                	xor    %ebx,%ebx
    cprintf("%d  ", p->burst_time);
80104ca4:	68 eb 83 10 80       	push   $0x801083eb
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104ca9:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%d  ", p->burst_time);
80104cae:	e8 ad b9 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104cb3:	83 c4 10             	add    $0x10,%esp
80104cb6:	eb 1b                	jmp    80104cd3 <show_all_processes_scheduling+0x463>
80104cb8:	90                   	nop
80104cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf(" ");
80104cc0:	83 ec 0c             	sub    $0xc,%esp
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104cc3:	83 c3 01             	add    $0x1,%ebx
      cprintf(" ");
80104cc6:	68 11 84 10 80       	push   $0x80108411
80104ccb:	e8 90 b9 ff ff       	call   80100660 <cprintf>
        for(i = 0 ; i < 10 - int_size(p->burst_time); i++)
80104cd0:	83 c4 10             	add    $0x10,%esp
80104cd3:	83 ec 0c             	sub    $0xc,%esp
80104cd6:	ff b7 88 00 00 00    	pushl  0x88(%edi)
80104cdc:	e8 df fa ff ff       	call   801047c0 <int_size>
80104ce1:	89 f2                	mov    %esi,%edx
80104ce3:	83 c4 10             	add    $0x10,%esp
80104ce6:	29 c2                	sub    %eax,%edx
80104ce8:	39 da                	cmp    %ebx,%edx
80104cea:	7f d4                	jg     80104cc0 <show_all_processes_scheduling+0x450>
    cprintf("%d  " , p->process_count);
80104cec:	83 ec 08             	sub    $0x8,%esp
80104cef:	ff b7 8c 00 00 00    	pushl  0x8c(%edi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cf5:	81 c7 90 00 00 00    	add    $0x90,%edi
    cprintf("%d  " , p->process_count);
80104cfb:	68 eb 83 10 80       	push   $0x801083eb
80104d00:	e8 5b b9 ff ff       	call   80100660 <cprintf>
    cprintf("\n");
80104d05:	c7 04 24 1f 88 10 80 	movl   $0x8010881f,(%esp)
80104d0c:	e8 4f b9 ff ff       	call   80100660 <cprintf>
80104d11:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d14:	81 ff 34 64 11 80    	cmp    $0x80116434,%edi
80104d1a:	0f 82 72 fd ff ff    	jb     80104a92 <show_all_processes_scheduling+0x222>
  }
}
80104d20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d23:	5b                   	pop    %ebx
80104d24:	5e                   	pop    %esi
80104d25:	5f                   	pop    %edi
80104d26:	5d                   	pop    %ebp
80104d27:	c3                   	ret    
80104d28:	90                   	nop
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d30 <scheduler>:

void
scheduler(void)
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	56                   	push   %esi
80104d34:	53                   	push   %ebx
80104d35:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;  
  struct cpu *c = mycpu();
80104d38:	e8 a3 ed ff ff       	call   80103ae0 <mycpu>
80104d3d:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104d3f:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104d46:	00 00 00 
80104d49:	8d 70 04             	lea    0x4(%eax),%esi
80104d4c:	eb 4b                	jmp    80104d99 <scheduler+0x69>
80104d4e:	66 90                	xchg   %ax,%ax
    if(p !=0 ) {
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80104d50:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104d53:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
      switchuvm(p);
80104d59:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104d5c:	50                   	push   %eax
80104d5d:	e8 9e 28 00 00       	call   80107600 <switchuvm>
      p->state = RUNNING;
80104d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d65:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

      swtch(&(c->scheduler), p->context);
80104d6c:	5a                   	pop    %edx
80104d6d:	59                   	pop    %ecx
80104d6e:	ff 70 1c             	pushl  0x1c(%eax)
80104d71:	56                   	push   %esi
80104d72:	e8 14 06 00 00       	call   8010538b <swtch>
      switchkvm();
80104d77:	e8 64 28 00 00       	call   801075e0 <switchkvm>
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80104d7c:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104d83:	00 00 00 
80104d86:	83 c4 10             	add    $0x10,%esp
    }

    release(&ptable.lock);
80104d89:	83 ec 0c             	sub    $0xc,%esp
80104d8c:	68 00 40 11 80       	push   $0x80114000
80104d91:	e8 6a 03 00 00       	call   80105100 <release>
    sti();
80104d96:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
80104d99:	fb                   	sti    
    acquire(&ptable.lock);
80104d9a:	83 ec 0c             	sub    $0xc,%esp
80104d9d:	68 00 40 11 80       	push   $0x80114000
80104da2:	e8 99 02 00 00       	call   80105040 <acquire>
    p = lotterySched();
80104da7:	e8 84 f7 ff ff       	call   80104530 <lotterySched>
    if(p == 0)
80104dac:	83 c4 10             	add    $0x10,%esp
80104daf:	85 c0                	test   %eax,%eax
80104db1:	75 9d                	jne    80104d50 <scheduler+0x20>
      p = SJFSched();
80104db3:	e8 98 f8 ff ff       	call   80104650 <SJFSched>
    if(p == 0)
80104db8:	85 c0                	test   %eax,%eax
80104dba:	75 94                	jne    80104d50 <scheduler+0x20>
      p = prioritySched();
80104dbc:	e8 2f f8 ff ff       	call   801045f0 <prioritySched>
    if(p !=0 ) {
80104dc1:	85 c0                	test   %eax,%eax
80104dc3:	74 c4                	je     80104d89 <scheduler+0x59>
80104dc5:	eb 89                	jmp    80104d50 <scheduler+0x20>
80104dc7:	66 90                	xchg   %ax,%ax
80104dc9:	66 90                	xchg   %ax,%ax
80104dcb:	66 90                	xchg   %ax,%ax
80104dcd:	66 90                	xchg   %ax,%ax
80104dcf:	90                   	nop

80104dd0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	53                   	push   %ebx
80104dd4:	83 ec 0c             	sub    $0xc,%esp
80104dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104dda:	68 e8 84 10 80       	push   $0x801084e8
80104ddf:	8d 43 04             	lea    0x4(%ebx),%eax
80104de2:	50                   	push   %eax
80104de3:	e8 18 01 00 00       	call   80104f00 <initlock>
  lk->name = name;
80104de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104deb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104df1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104df4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104dfb:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104dfe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e01:	c9                   	leave  
80104e02:	c3                   	ret    
80104e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	56                   	push   %esi
80104e14:	53                   	push   %ebx
80104e15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e18:	83 ec 0c             	sub    $0xc,%esp
80104e1b:	8d 73 04             	lea    0x4(%ebx),%esi
80104e1e:	56                   	push   %esi
80104e1f:	e8 1c 02 00 00       	call   80105040 <acquire>
  while (lk->locked) {
80104e24:	8b 13                	mov    (%ebx),%edx
80104e26:	83 c4 10             	add    $0x10,%esp
80104e29:	85 d2                	test   %edx,%edx
80104e2b:	74 16                	je     80104e43 <acquiresleep+0x33>
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104e30:	83 ec 08             	sub    $0x8,%esp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
80104e35:	e8 46 f2 ff ff       	call   80104080 <sleep>
  while (lk->locked) {
80104e3a:	8b 03                	mov    (%ebx),%eax
80104e3c:	83 c4 10             	add    $0x10,%esp
80104e3f:	85 c0                	test   %eax,%eax
80104e41:	75 ed                	jne    80104e30 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104e43:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104e49:	e8 32 ed ff ff       	call   80103b80 <myproc>
80104e4e:	8b 40 10             	mov    0x10(%eax),%eax
80104e51:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104e54:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e57:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e5a:	5b                   	pop    %ebx
80104e5b:	5e                   	pop    %esi
80104e5c:	5d                   	pop    %ebp
  release(&lk->lk);
80104e5d:	e9 9e 02 00 00       	jmp    80105100 <release>
80104e62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	56                   	push   %esi
80104e74:	53                   	push   %ebx
80104e75:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e78:	83 ec 0c             	sub    $0xc,%esp
80104e7b:	8d 73 04             	lea    0x4(%ebx),%esi
80104e7e:	56                   	push   %esi
80104e7f:	e8 bc 01 00 00       	call   80105040 <acquire>
  lk->locked = 0;
80104e84:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104e8a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104e91:	89 1c 24             	mov    %ebx,(%esp)
80104e94:	e8 a7 f3 ff ff       	call   80104240 <wakeup>
  release(&lk->lk);
80104e99:	89 75 08             	mov    %esi,0x8(%ebp)
80104e9c:	83 c4 10             	add    $0x10,%esp
}
80104e9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ea2:	5b                   	pop    %ebx
80104ea3:	5e                   	pop    %esi
80104ea4:	5d                   	pop    %ebp
  release(&lk->lk);
80104ea5:	e9 56 02 00 00       	jmp    80105100 <release>
80104eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104eb0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	57                   	push   %edi
80104eb4:	56                   	push   %esi
80104eb5:	53                   	push   %ebx
80104eb6:	31 ff                	xor    %edi,%edi
80104eb8:	83 ec 18             	sub    $0x18,%esp
80104ebb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ebe:	8d 73 04             	lea    0x4(%ebx),%esi
80104ec1:	56                   	push   %esi
80104ec2:	e8 79 01 00 00       	call   80105040 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ec7:	8b 03                	mov    (%ebx),%eax
80104ec9:	83 c4 10             	add    $0x10,%esp
80104ecc:	85 c0                	test   %eax,%eax
80104ece:	74 13                	je     80104ee3 <holdingsleep+0x33>
80104ed0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104ed3:	e8 a8 ec ff ff       	call   80103b80 <myproc>
80104ed8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104edb:	0f 94 c0             	sete   %al
80104ede:	0f b6 c0             	movzbl %al,%eax
80104ee1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104ee3:	83 ec 0c             	sub    $0xc,%esp
80104ee6:	56                   	push   %esi
80104ee7:	e8 14 02 00 00       	call   80105100 <release>
  return r;
}
80104eec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104eef:	89 f8                	mov    %edi,%eax
80104ef1:	5b                   	pop    %ebx
80104ef2:	5e                   	pop    %esi
80104ef3:	5f                   	pop    %edi
80104ef4:	5d                   	pop    %ebp
80104ef5:	c3                   	ret    
80104ef6:	66 90                	xchg   %ax,%ax
80104ef8:	66 90                	xchg   %ax,%ax
80104efa:	66 90                	xchg   %ax,%ax
80104efc:	66 90                	xchg   %ax,%ax
80104efe:	66 90                	xchg   %ax,%ax

80104f00 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f06:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f0f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f12:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f19:	5d                   	pop    %ebp
80104f1a:	c3                   	ret    
80104f1b:	90                   	nop
80104f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f20 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f20:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f21:	31 d2                	xor    %edx,%edx
{
80104f23:	89 e5                	mov    %esp,%ebp
80104f25:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104f26:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104f29:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104f2c:	83 e8 08             	sub    $0x8,%eax
80104f2f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f30:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104f36:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f3c:	77 1a                	ja     80104f58 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f3e:	8b 58 04             	mov    0x4(%eax),%ebx
80104f41:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104f44:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104f47:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f49:	83 fa 0a             	cmp    $0xa,%edx
80104f4c:	75 e2                	jne    80104f30 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104f4e:	5b                   	pop    %ebx
80104f4f:	5d                   	pop    %ebp
80104f50:	c3                   	ret    
80104f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f58:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104f5b:	83 c1 28             	add    $0x28,%ecx
80104f5e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104f60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104f66:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104f69:	39 c1                	cmp    %eax,%ecx
80104f6b:	75 f3                	jne    80104f60 <getcallerpcs+0x40>
}
80104f6d:	5b                   	pop    %ebx
80104f6e:	5d                   	pop    %ebp
80104f6f:	c3                   	ret    

80104f70 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	53                   	push   %ebx
80104f74:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104f77:	9c                   	pushf  
80104f78:	5b                   	pop    %ebx
  asm volatile("cli");
80104f79:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104f7a:	e8 61 eb ff ff       	call   80103ae0 <mycpu>
80104f7f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104f85:	85 c0                	test   %eax,%eax
80104f87:	75 11                	jne    80104f9a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104f89:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104f8f:	e8 4c eb ff ff       	call   80103ae0 <mycpu>
80104f94:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104f9a:	e8 41 eb ff ff       	call   80103ae0 <mycpu>
80104f9f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104fa6:	83 c4 04             	add    $0x4,%esp
80104fa9:	5b                   	pop    %ebx
80104faa:	5d                   	pop    %ebp
80104fab:	c3                   	ret    
80104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <popcli>:

void
popcli(void)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104fb6:	9c                   	pushf  
80104fb7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104fb8:	f6 c4 02             	test   $0x2,%ah
80104fbb:	75 35                	jne    80104ff2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104fbd:	e8 1e eb ff ff       	call   80103ae0 <mycpu>
80104fc2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104fc9:	78 34                	js     80104fff <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104fcb:	e8 10 eb ff ff       	call   80103ae0 <mycpu>
80104fd0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104fd6:	85 d2                	test   %edx,%edx
80104fd8:	74 06                	je     80104fe0 <popcli+0x30>
    sti();
}
80104fda:	c9                   	leave  
80104fdb:	c3                   	ret    
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104fe0:	e8 fb ea ff ff       	call   80103ae0 <mycpu>
80104fe5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104feb:	85 c0                	test   %eax,%eax
80104fed:	74 eb                	je     80104fda <popcli+0x2a>
  asm volatile("sti");
80104fef:	fb                   	sti    
}
80104ff0:	c9                   	leave  
80104ff1:	c3                   	ret    
    panic("popcli - interruptible");
80104ff2:	83 ec 0c             	sub    $0xc,%esp
80104ff5:	68 f3 84 10 80       	push   $0x801084f3
80104ffa:	e8 91 b3 ff ff       	call   80100390 <panic>
    panic("popcli");
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	68 0a 85 10 80       	push   $0x8010850a
80105007:	e8 84 b3 ff ff       	call   80100390 <panic>
8010500c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105010 <holding>:
{
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
80105013:	56                   	push   %esi
80105014:	53                   	push   %ebx
80105015:	8b 75 08             	mov    0x8(%ebp),%esi
80105018:	31 db                	xor    %ebx,%ebx
  pushcli();
8010501a:	e8 51 ff ff ff       	call   80104f70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010501f:	8b 06                	mov    (%esi),%eax
80105021:	85 c0                	test   %eax,%eax
80105023:	74 10                	je     80105035 <holding+0x25>
80105025:	8b 5e 08             	mov    0x8(%esi),%ebx
80105028:	e8 b3 ea ff ff       	call   80103ae0 <mycpu>
8010502d:	39 c3                	cmp    %eax,%ebx
8010502f:	0f 94 c3             	sete   %bl
80105032:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105035:	e8 76 ff ff ff       	call   80104fb0 <popcli>
}
8010503a:	89 d8                	mov    %ebx,%eax
8010503c:	5b                   	pop    %ebx
8010503d:	5e                   	pop    %esi
8010503e:	5d                   	pop    %ebp
8010503f:	c3                   	ret    

80105040 <acquire>:
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	56                   	push   %esi
80105044:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105045:	e8 26 ff ff ff       	call   80104f70 <pushcli>
  if(holding(lk))
8010504a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010504d:	83 ec 0c             	sub    $0xc,%esp
80105050:	53                   	push   %ebx
80105051:	e8 ba ff ff ff       	call   80105010 <holding>
80105056:	83 c4 10             	add    $0x10,%esp
80105059:	85 c0                	test   %eax,%eax
8010505b:	0f 85 83 00 00 00    	jne    801050e4 <acquire+0xa4>
80105061:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105063:	ba 01 00 00 00       	mov    $0x1,%edx
80105068:	eb 09                	jmp    80105073 <acquire+0x33>
8010506a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105070:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105073:	89 d0                	mov    %edx,%eax
80105075:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105078:	85 c0                	test   %eax,%eax
8010507a:	75 f4                	jne    80105070 <acquire+0x30>
  __sync_synchronize();
8010507c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105081:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105084:	e8 57 ea ff ff       	call   80103ae0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105089:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010508c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010508f:	89 e8                	mov    %ebp,%eax
80105091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105098:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010509e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801050a4:	77 1a                	ja     801050c0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801050a6:	8b 48 04             	mov    0x4(%eax),%ecx
801050a9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801050ac:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801050af:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801050b1:	83 fe 0a             	cmp    $0xa,%esi
801050b4:	75 e2                	jne    80105098 <acquire+0x58>
}
801050b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050b9:	5b                   	pop    %ebx
801050ba:	5e                   	pop    %esi
801050bb:	5d                   	pop    %ebp
801050bc:	c3                   	ret    
801050bd:	8d 76 00             	lea    0x0(%esi),%esi
801050c0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801050c3:	83 c2 28             	add    $0x28,%edx
801050c6:	8d 76 00             	lea    0x0(%esi),%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801050d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801050d6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801050d9:	39 d0                	cmp    %edx,%eax
801050db:	75 f3                	jne    801050d0 <acquire+0x90>
}
801050dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050e0:	5b                   	pop    %ebx
801050e1:	5e                   	pop    %esi
801050e2:	5d                   	pop    %ebp
801050e3:	c3                   	ret    
    panic("acquire");
801050e4:	83 ec 0c             	sub    $0xc,%esp
801050e7:	68 11 85 10 80       	push   $0x80108511
801050ec:	e8 9f b2 ff ff       	call   80100390 <panic>
801050f1:	eb 0d                	jmp    80105100 <release>
801050f3:	90                   	nop
801050f4:	90                   	nop
801050f5:	90                   	nop
801050f6:	90                   	nop
801050f7:	90                   	nop
801050f8:	90                   	nop
801050f9:	90                   	nop
801050fa:	90                   	nop
801050fb:	90                   	nop
801050fc:	90                   	nop
801050fd:	90                   	nop
801050fe:	90                   	nop
801050ff:	90                   	nop

80105100 <release>:
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	53                   	push   %ebx
80105104:	83 ec 10             	sub    $0x10,%esp
80105107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010510a:	53                   	push   %ebx
8010510b:	e8 00 ff ff ff       	call   80105010 <holding>
80105110:	83 c4 10             	add    $0x10,%esp
80105113:	85 c0                	test   %eax,%eax
80105115:	74 22                	je     80105139 <release+0x39>
  lk->pcs[0] = 0;
80105117:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010511e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105125:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010512a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105130:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105133:	c9                   	leave  
  popcli();
80105134:	e9 77 fe ff ff       	jmp    80104fb0 <popcli>
    panic("release");
80105139:	83 ec 0c             	sub    $0xc,%esp
8010513c:	68 19 85 10 80       	push   $0x80108519
80105141:	e8 4a b2 ff ff       	call   80100390 <panic>
80105146:	66 90                	xchg   %ax,%ax
80105148:	66 90                	xchg   %ax,%ax
8010514a:	66 90                	xchg   %ax,%ax
8010514c:	66 90                	xchg   %ax,%ax
8010514e:	66 90                	xchg   %ax,%ax

80105150 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	53                   	push   %ebx
80105155:	8b 55 08             	mov    0x8(%ebp),%edx
80105158:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010515b:	f6 c2 03             	test   $0x3,%dl
8010515e:	75 05                	jne    80105165 <memset+0x15>
80105160:	f6 c1 03             	test   $0x3,%cl
80105163:	74 13                	je     80105178 <memset+0x28>
  asm volatile("cld; rep stosb" :
80105165:	89 d7                	mov    %edx,%edi
80105167:	8b 45 0c             	mov    0xc(%ebp),%eax
8010516a:	fc                   	cld    
8010516b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010516d:	5b                   	pop    %ebx
8010516e:	89 d0                	mov    %edx,%eax
80105170:	5f                   	pop    %edi
80105171:	5d                   	pop    %ebp
80105172:	c3                   	ret    
80105173:	90                   	nop
80105174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80105178:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010517c:	c1 e9 02             	shr    $0x2,%ecx
8010517f:	89 f8                	mov    %edi,%eax
80105181:	89 fb                	mov    %edi,%ebx
80105183:	c1 e0 18             	shl    $0x18,%eax
80105186:	c1 e3 10             	shl    $0x10,%ebx
80105189:	09 d8                	or     %ebx,%eax
8010518b:	09 f8                	or     %edi,%eax
8010518d:	c1 e7 08             	shl    $0x8,%edi
80105190:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105192:	89 d7                	mov    %edx,%edi
80105194:	fc                   	cld    
80105195:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105197:	5b                   	pop    %ebx
80105198:	89 d0                	mov    %edx,%eax
8010519a:	5f                   	pop    %edi
8010519b:	5d                   	pop    %ebp
8010519c:	c3                   	ret    
8010519d:	8d 76 00             	lea    0x0(%esi),%esi

801051a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	57                   	push   %edi
801051a4:	56                   	push   %esi
801051a5:	53                   	push   %ebx
801051a6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801051a9:	8b 75 08             	mov    0x8(%ebp),%esi
801051ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801051af:	85 db                	test   %ebx,%ebx
801051b1:	74 29                	je     801051dc <memcmp+0x3c>
    if(*s1 != *s2)
801051b3:	0f b6 16             	movzbl (%esi),%edx
801051b6:	0f b6 0f             	movzbl (%edi),%ecx
801051b9:	38 d1                	cmp    %dl,%cl
801051bb:	75 2b                	jne    801051e8 <memcmp+0x48>
801051bd:	b8 01 00 00 00       	mov    $0x1,%eax
801051c2:	eb 14                	jmp    801051d8 <memcmp+0x38>
801051c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051c8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801051cc:	83 c0 01             	add    $0x1,%eax
801051cf:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801051d4:	38 ca                	cmp    %cl,%dl
801051d6:	75 10                	jne    801051e8 <memcmp+0x48>
  while(n-- > 0){
801051d8:	39 d8                	cmp    %ebx,%eax
801051da:	75 ec                	jne    801051c8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801051dc:	5b                   	pop    %ebx
  return 0;
801051dd:	31 c0                	xor    %eax,%eax
}
801051df:	5e                   	pop    %esi
801051e0:	5f                   	pop    %edi
801051e1:	5d                   	pop    %ebp
801051e2:	c3                   	ret    
801051e3:	90                   	nop
801051e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801051e8:	0f b6 c2             	movzbl %dl,%eax
}
801051eb:	5b                   	pop    %ebx
      return *s1 - *s2;
801051ec:	29 c8                	sub    %ecx,%eax
}
801051ee:	5e                   	pop    %esi
801051ef:	5f                   	pop    %edi
801051f0:	5d                   	pop    %ebp
801051f1:	c3                   	ret    
801051f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105200 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	56                   	push   %esi
80105204:	53                   	push   %ebx
80105205:	8b 45 08             	mov    0x8(%ebp),%eax
80105208:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010520b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010520e:	39 c3                	cmp    %eax,%ebx
80105210:	73 26                	jae    80105238 <memmove+0x38>
80105212:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105215:	39 c8                	cmp    %ecx,%eax
80105217:	73 1f                	jae    80105238 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105219:	85 f6                	test   %esi,%esi
8010521b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010521e:	74 0f                	je     8010522f <memmove+0x2f>
      *--d = *--s;
80105220:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105224:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105227:	83 ea 01             	sub    $0x1,%edx
8010522a:	83 fa ff             	cmp    $0xffffffff,%edx
8010522d:	75 f1                	jne    80105220 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010522f:	5b                   	pop    %ebx
80105230:	5e                   	pop    %esi
80105231:	5d                   	pop    %ebp
80105232:	c3                   	ret    
80105233:	90                   	nop
80105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105238:	31 d2                	xor    %edx,%edx
8010523a:	85 f6                	test   %esi,%esi
8010523c:	74 f1                	je     8010522f <memmove+0x2f>
8010523e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105240:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105244:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105247:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010524a:	39 d6                	cmp    %edx,%esi
8010524c:	75 f2                	jne    80105240 <memmove+0x40>
}
8010524e:	5b                   	pop    %ebx
8010524f:	5e                   	pop    %esi
80105250:	5d                   	pop    %ebp
80105251:	c3                   	ret    
80105252:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105260 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105263:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105264:	eb 9a                	jmp    80105200 <memmove>
80105266:	8d 76 00             	lea    0x0(%esi),%esi
80105269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105270 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	57                   	push   %edi
80105274:	56                   	push   %esi
80105275:	8b 7d 10             	mov    0x10(%ebp),%edi
80105278:	53                   	push   %ebx
80105279:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010527c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010527f:	85 ff                	test   %edi,%edi
80105281:	74 2f                	je     801052b2 <strncmp+0x42>
80105283:	0f b6 01             	movzbl (%ecx),%eax
80105286:	0f b6 1e             	movzbl (%esi),%ebx
80105289:	84 c0                	test   %al,%al
8010528b:	74 37                	je     801052c4 <strncmp+0x54>
8010528d:	38 c3                	cmp    %al,%bl
8010528f:	75 33                	jne    801052c4 <strncmp+0x54>
80105291:	01 f7                	add    %esi,%edi
80105293:	eb 13                	jmp    801052a8 <strncmp+0x38>
80105295:	8d 76 00             	lea    0x0(%esi),%esi
80105298:	0f b6 01             	movzbl (%ecx),%eax
8010529b:	84 c0                	test   %al,%al
8010529d:	74 21                	je     801052c0 <strncmp+0x50>
8010529f:	0f b6 1a             	movzbl (%edx),%ebx
801052a2:	89 d6                	mov    %edx,%esi
801052a4:	38 d8                	cmp    %bl,%al
801052a6:	75 1c                	jne    801052c4 <strncmp+0x54>
    n--, p++, q++;
801052a8:	8d 56 01             	lea    0x1(%esi),%edx
801052ab:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801052ae:	39 fa                	cmp    %edi,%edx
801052b0:	75 e6                	jne    80105298 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801052b2:	5b                   	pop    %ebx
    return 0;
801052b3:	31 c0                	xor    %eax,%eax
}
801052b5:	5e                   	pop    %esi
801052b6:	5f                   	pop    %edi
801052b7:	5d                   	pop    %ebp
801052b8:	c3                   	ret    
801052b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052c0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801052c4:	29 d8                	sub    %ebx,%eax
}
801052c6:	5b                   	pop    %ebx
801052c7:	5e                   	pop    %esi
801052c8:	5f                   	pop    %edi
801052c9:	5d                   	pop    %ebp
801052ca:	c3                   	ret    
801052cb:	90                   	nop
801052cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052d0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	56                   	push   %esi
801052d4:	53                   	push   %ebx
801052d5:	8b 45 08             	mov    0x8(%ebp),%eax
801052d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801052db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801052de:	89 c2                	mov    %eax,%edx
801052e0:	eb 19                	jmp    801052fb <strncpy+0x2b>
801052e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052e8:	83 c3 01             	add    $0x1,%ebx
801052eb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801052ef:	83 c2 01             	add    $0x1,%edx
801052f2:	84 c9                	test   %cl,%cl
801052f4:	88 4a ff             	mov    %cl,-0x1(%edx)
801052f7:	74 09                	je     80105302 <strncpy+0x32>
801052f9:	89 f1                	mov    %esi,%ecx
801052fb:	85 c9                	test   %ecx,%ecx
801052fd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105300:	7f e6                	jg     801052e8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105302:	31 c9                	xor    %ecx,%ecx
80105304:	85 f6                	test   %esi,%esi
80105306:	7e 17                	jle    8010531f <strncpy+0x4f>
80105308:	90                   	nop
80105309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105310:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105314:	89 f3                	mov    %esi,%ebx
80105316:	83 c1 01             	add    $0x1,%ecx
80105319:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010531b:	85 db                	test   %ebx,%ebx
8010531d:	7f f1                	jg     80105310 <strncpy+0x40>
  return os;
}
8010531f:	5b                   	pop    %ebx
80105320:	5e                   	pop    %esi
80105321:	5d                   	pop    %ebp
80105322:	c3                   	ret    
80105323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105330 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	56                   	push   %esi
80105334:	53                   	push   %ebx
80105335:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105338:	8b 45 08             	mov    0x8(%ebp),%eax
8010533b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010533e:	85 c9                	test   %ecx,%ecx
80105340:	7e 26                	jle    80105368 <safestrcpy+0x38>
80105342:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105346:	89 c1                	mov    %eax,%ecx
80105348:	eb 17                	jmp    80105361 <safestrcpy+0x31>
8010534a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105350:	83 c2 01             	add    $0x1,%edx
80105353:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105357:	83 c1 01             	add    $0x1,%ecx
8010535a:	84 db                	test   %bl,%bl
8010535c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010535f:	74 04                	je     80105365 <safestrcpy+0x35>
80105361:	39 f2                	cmp    %esi,%edx
80105363:	75 eb                	jne    80105350 <safestrcpy+0x20>
    ;
  *s = 0;
80105365:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105368:	5b                   	pop    %ebx
80105369:	5e                   	pop    %esi
8010536a:	5d                   	pop    %ebp
8010536b:	c3                   	ret    
8010536c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105370 <strlen>:

int
strlen(const char *s)
{
80105370:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105371:	31 c0                	xor    %eax,%eax
{
80105373:	89 e5                	mov    %esp,%ebp
80105375:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105378:	80 3a 00             	cmpb   $0x0,(%edx)
8010537b:	74 0c                	je     80105389 <strlen+0x19>
8010537d:	8d 76 00             	lea    0x0(%esi),%esi
80105380:	83 c0 01             	add    $0x1,%eax
80105383:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105387:	75 f7                	jne    80105380 <strlen+0x10>
    ;
  return n;
}
80105389:	5d                   	pop    %ebp
8010538a:	c3                   	ret    

8010538b <swtch>:
8010538b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010538f:	8b 54 24 08          	mov    0x8(%esp),%edx
80105393:	55                   	push   %ebp
80105394:	53                   	push   %ebx
80105395:	56                   	push   %esi
80105396:	57                   	push   %edi
80105397:	89 20                	mov    %esp,(%eax)
80105399:	89 d4                	mov    %edx,%esp
8010539b:	5f                   	pop    %edi
8010539c:	5e                   	pop    %esi
8010539d:	5b                   	pop    %ebx
8010539e:	5d                   	pop    %ebp
8010539f:	c3                   	ret    

801053a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	53                   	push   %ebx
801053a4:	83 ec 04             	sub    $0x4,%esp
801053a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801053aa:	e8 d1 e7 ff ff       	call   80103b80 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801053af:	8b 00                	mov    (%eax),%eax
801053b1:	39 d8                	cmp    %ebx,%eax
801053b3:	76 1b                	jbe    801053d0 <fetchint+0x30>
801053b5:	8d 53 04             	lea    0x4(%ebx),%edx
801053b8:	39 d0                	cmp    %edx,%eax
801053ba:	72 14                	jb     801053d0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801053bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801053bf:	8b 13                	mov    (%ebx),%edx
801053c1:	89 10                	mov    %edx,(%eax)
  return 0;
801053c3:	31 c0                	xor    %eax,%eax
}
801053c5:	83 c4 04             	add    $0x4,%esp
801053c8:	5b                   	pop    %ebx
801053c9:	5d                   	pop    %ebp
801053ca:	c3                   	ret    
801053cb:	90                   	nop
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801053d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053d5:	eb ee                	jmp    801053c5 <fetchint+0x25>
801053d7:	89 f6                	mov    %esi,%esi
801053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053e0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	53                   	push   %ebx
801053e4:	83 ec 04             	sub    $0x4,%esp
801053e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801053ea:	e8 91 e7 ff ff       	call   80103b80 <myproc>

  if(addr >= curproc->sz)
801053ef:	39 18                	cmp    %ebx,(%eax)
801053f1:	76 29                	jbe    8010541c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801053f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801053f6:	89 da                	mov    %ebx,%edx
801053f8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801053fa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801053fc:	39 c3                	cmp    %eax,%ebx
801053fe:	73 1c                	jae    8010541c <fetchstr+0x3c>
    if(*s == 0)
80105400:	80 3b 00             	cmpb   $0x0,(%ebx)
80105403:	75 10                	jne    80105415 <fetchstr+0x35>
80105405:	eb 39                	jmp    80105440 <fetchstr+0x60>
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105410:	80 3a 00             	cmpb   $0x0,(%edx)
80105413:	74 1b                	je     80105430 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105415:	83 c2 01             	add    $0x1,%edx
80105418:	39 d0                	cmp    %edx,%eax
8010541a:	77 f4                	ja     80105410 <fetchstr+0x30>
    return -1;
8010541c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105421:	83 c4 04             	add    $0x4,%esp
80105424:	5b                   	pop    %ebx
80105425:	5d                   	pop    %ebp
80105426:	c3                   	ret    
80105427:	89 f6                	mov    %esi,%esi
80105429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105430:	83 c4 04             	add    $0x4,%esp
80105433:	89 d0                	mov    %edx,%eax
80105435:	29 d8                	sub    %ebx,%eax
80105437:	5b                   	pop    %ebx
80105438:	5d                   	pop    %ebp
80105439:	c3                   	ret    
8010543a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105440:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105442:	eb dd                	jmp    80105421 <fetchstr+0x41>
80105444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010544a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105450 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	56                   	push   %esi
80105454:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105455:	e8 26 e7 ff ff       	call   80103b80 <myproc>
8010545a:	8b 40 18             	mov    0x18(%eax),%eax
8010545d:	8b 55 08             	mov    0x8(%ebp),%edx
80105460:	8b 40 44             	mov    0x44(%eax),%eax
80105463:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105466:	e8 15 e7 ff ff       	call   80103b80 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010546b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010546d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105470:	39 c6                	cmp    %eax,%esi
80105472:	73 1c                	jae    80105490 <argint+0x40>
80105474:	8d 53 08             	lea    0x8(%ebx),%edx
80105477:	39 d0                	cmp    %edx,%eax
80105479:	72 15                	jb     80105490 <argint+0x40>
  *ip = *(int*)(addr);
8010547b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010547e:	8b 53 04             	mov    0x4(%ebx),%edx
80105481:	89 10                	mov    %edx,(%eax)
  return 0;
80105483:	31 c0                	xor    %eax,%eax
}
80105485:	5b                   	pop    %ebx
80105486:	5e                   	pop    %esi
80105487:	5d                   	pop    %ebp
80105488:	c3                   	ret    
80105489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105495:	eb ee                	jmp    80105485 <argint+0x35>
80105497:	89 f6                	mov    %esi,%esi
80105499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054a0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	56                   	push   %esi
801054a4:	53                   	push   %ebx
801054a5:	83 ec 10             	sub    $0x10,%esp
801054a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801054ab:	e8 d0 e6 ff ff       	call   80103b80 <myproc>
801054b0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801054b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054b5:	83 ec 08             	sub    $0x8,%esp
801054b8:	50                   	push   %eax
801054b9:	ff 75 08             	pushl  0x8(%ebp)
801054bc:	e8 8f ff ff ff       	call   80105450 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801054c1:	83 c4 10             	add    $0x10,%esp
801054c4:	85 c0                	test   %eax,%eax
801054c6:	78 28                	js     801054f0 <argptr+0x50>
801054c8:	85 db                	test   %ebx,%ebx
801054ca:	78 24                	js     801054f0 <argptr+0x50>
801054cc:	8b 16                	mov    (%esi),%edx
801054ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054d1:	39 c2                	cmp    %eax,%edx
801054d3:	76 1b                	jbe    801054f0 <argptr+0x50>
801054d5:	01 c3                	add    %eax,%ebx
801054d7:	39 da                	cmp    %ebx,%edx
801054d9:	72 15                	jb     801054f0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801054db:	8b 55 0c             	mov    0xc(%ebp),%edx
801054de:	89 02                	mov    %eax,(%edx)
  return 0;
801054e0:	31 c0                	xor    %eax,%eax
}
801054e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054e5:	5b                   	pop    %ebx
801054e6:	5e                   	pop    %esi
801054e7:	5d                   	pop    %ebp
801054e8:	c3                   	ret    
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801054f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054f5:	eb eb                	jmp    801054e2 <argptr+0x42>
801054f7:	89 f6                	mov    %esi,%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105506:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105509:	50                   	push   %eax
8010550a:	ff 75 08             	pushl  0x8(%ebp)
8010550d:	e8 3e ff ff ff       	call   80105450 <argint>
80105512:	83 c4 10             	add    $0x10,%esp
80105515:	85 c0                	test   %eax,%eax
80105517:	78 17                	js     80105530 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105519:	83 ec 08             	sub    $0x8,%esp
8010551c:	ff 75 0c             	pushl  0xc(%ebp)
8010551f:	ff 75 f4             	pushl  -0xc(%ebp)
80105522:	e8 b9 fe ff ff       	call   801053e0 <fetchstr>
80105527:	83 c4 10             	add    $0x10,%esp
}
8010552a:	c9                   	leave  
8010552b:	c3                   	ret    
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105535:	c9                   	leave  
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <syscall>:
[SYS_show_processes_scheduling] sys_show_processes_scheduling,
};

void
syscall(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	53                   	push   %ebx
80105544:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105547:	e8 34 e6 ff ff       	call   80103b80 <myproc>
  num = curproc->tf->eax;
8010554c:	8b 50 18             	mov    0x18(%eax),%edx
  struct proc *curproc = myproc();
8010554f:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80105551:	8b 42 1c             	mov    0x1c(%edx),%eax
  if (num == 22) {
80105554:	83 f8 16             	cmp    $0x16,%eax
80105557:	74 37                	je     80105590 <syscall+0x50>
    int arg = 0;
    argint(0 ,&arg);    
    curproc->tf->eax = sys_incNum(arg);    
  }
  else if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105559:	8d 48 ff             	lea    -0x1(%eax),%ecx
8010555c:	83 f9 1b             	cmp    $0x1b,%ecx
8010555f:	77 1f                	ja     80105580 <syscall+0x40>
80105561:	8b 04 85 40 85 10 80 	mov    -0x7fef7ac0(,%eax,4),%eax
80105568:	85 c0                	test   %eax,%eax
8010556a:	74 14                	je     80105580 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010556c:	ff d0                	call   *%eax
8010556e:	8b 53 18             	mov    0x18(%ebx),%edx
80105571:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    curproc->tf->eax = -1;
  }
}
80105574:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105577:	c9                   	leave  
80105578:	c3                   	ret    
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curproc->tf->eax = -1;
80105580:	c7 42 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%edx)
}
80105587:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010558a:	c9                   	leave  
8010558b:	c3                   	ret    
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    argint(0 ,&arg);    
80105590:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105593:	83 ec 08             	sub    $0x8,%esp
    int arg = 0;
80105596:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    argint(0 ,&arg);    
8010559d:	50                   	push   %eax
8010559e:	6a 00                	push   $0x0
801055a0:	e8 ab fe ff ff       	call   80105450 <argint>
    curproc->tf->eax = sys_incNum(arg);    
801055a5:	58                   	pop    %eax
801055a6:	ff 75 f4             	pushl  -0xc(%ebp)
801055a9:	e8 a2 0d 00 00       	call   80106350 <sys_incNum>
801055ae:	8b 53 18             	mov    0x18(%ebx),%edx
801055b1:	83 c4 10             	add    $0x10,%esp
801055b4:	89 42 1c             	mov    %eax,0x1c(%edx)
}
801055b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055ba:	c9                   	leave  
801055bb:	c3                   	ret    
801055bc:	66 90                	xchg   %ax,%ax
801055be:	66 90                	xchg   %ax,%ax

801055c0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	57                   	push   %edi
801055c4:	56                   	push   %esi
801055c5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801055c6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801055c9:	83 ec 44             	sub    $0x44,%esp
801055cc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801055cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801055d2:	56                   	push   %esi
801055d3:	50                   	push   %eax
{
801055d4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801055d7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801055da:	e8 91 cc ff ff       	call   80102270 <nameiparent>
801055df:	83 c4 10             	add    $0x10,%esp
801055e2:	85 c0                	test   %eax,%eax
801055e4:	0f 84 46 01 00 00    	je     80105730 <create+0x170>
    return 0;
  ilock(dp);
801055ea:	83 ec 0c             	sub    $0xc,%esp
801055ed:	89 c3                	mov    %eax,%ebx
801055ef:	50                   	push   %eax
801055f0:	e8 fb c3 ff ff       	call   801019f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801055f5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801055f8:	83 c4 0c             	add    $0xc,%esp
801055fb:	50                   	push   %eax
801055fc:	56                   	push   %esi
801055fd:	53                   	push   %ebx
801055fe:	e8 1d c9 ff ff       	call   80101f20 <dirlookup>
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	89 c7                	mov    %eax,%edi
8010560a:	74 34                	je     80105640 <create+0x80>
    iunlockput(dp);
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	53                   	push   %ebx
80105610:	e8 6b c6 ff ff       	call   80101c80 <iunlockput>
    ilock(ip);
80105615:	89 3c 24             	mov    %edi,(%esp)
80105618:	e8 d3 c3 ff ff       	call   801019f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010561d:	83 c4 10             	add    $0x10,%esp
80105620:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105625:	0f 85 95 00 00 00    	jne    801056c0 <create+0x100>
8010562b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105630:	0f 85 8a 00 00 00    	jne    801056c0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105636:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105639:	89 f8                	mov    %edi,%eax
8010563b:	5b                   	pop    %ebx
8010563c:	5e                   	pop    %esi
8010563d:	5f                   	pop    %edi
8010563e:	5d                   	pop    %ebp
8010563f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105640:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105644:	83 ec 08             	sub    $0x8,%esp
80105647:	50                   	push   %eax
80105648:	ff 33                	pushl  (%ebx)
8010564a:	e8 31 c2 ff ff       	call   80101880 <ialloc>
8010564f:	83 c4 10             	add    $0x10,%esp
80105652:	85 c0                	test   %eax,%eax
80105654:	89 c7                	mov    %eax,%edi
80105656:	0f 84 e8 00 00 00    	je     80105744 <create+0x184>
  ilock(ip);
8010565c:	83 ec 0c             	sub    $0xc,%esp
8010565f:	50                   	push   %eax
80105660:	e8 8b c3 ff ff       	call   801019f0 <ilock>
  ip->major = major;
80105665:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105669:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010566d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105671:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105675:	b8 01 00 00 00       	mov    $0x1,%eax
8010567a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010567e:	89 3c 24             	mov    %edi,(%esp)
80105681:	e8 ba c2 ff ff       	call   80101940 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105686:	83 c4 10             	add    $0x10,%esp
80105689:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010568e:	74 50                	je     801056e0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105690:	83 ec 04             	sub    $0x4,%esp
80105693:	ff 77 04             	pushl  0x4(%edi)
80105696:	56                   	push   %esi
80105697:	53                   	push   %ebx
80105698:	e8 f3 ca ff ff       	call   80102190 <dirlink>
8010569d:	83 c4 10             	add    $0x10,%esp
801056a0:	85 c0                	test   %eax,%eax
801056a2:	0f 88 8f 00 00 00    	js     80105737 <create+0x177>
  iunlockput(dp);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	53                   	push   %ebx
801056ac:	e8 cf c5 ff ff       	call   80101c80 <iunlockput>
  return ip;
801056b1:	83 c4 10             	add    $0x10,%esp
}
801056b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056b7:	89 f8                	mov    %edi,%eax
801056b9:	5b                   	pop    %ebx
801056ba:	5e                   	pop    %esi
801056bb:	5f                   	pop    %edi
801056bc:	5d                   	pop    %ebp
801056bd:	c3                   	ret    
801056be:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	57                   	push   %edi
    return 0;
801056c4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801056c6:	e8 b5 c5 ff ff       	call   80101c80 <iunlockput>
    return 0;
801056cb:	83 c4 10             	add    $0x10,%esp
}
801056ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056d1:	89 f8                	mov    %edi,%eax
801056d3:	5b                   	pop    %ebx
801056d4:	5e                   	pop    %esi
801056d5:	5f                   	pop    %edi
801056d6:	5d                   	pop    %ebp
801056d7:	c3                   	ret    
801056d8:	90                   	nop
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801056e0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801056e5:	83 ec 0c             	sub    $0xc,%esp
801056e8:	53                   	push   %ebx
801056e9:	e8 52 c2 ff ff       	call   80101940 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801056ee:	83 c4 0c             	add    $0xc,%esp
801056f1:	ff 77 04             	pushl  0x4(%edi)
801056f4:	68 d0 85 10 80       	push   $0x801085d0
801056f9:	57                   	push   %edi
801056fa:	e8 91 ca ff ff       	call   80102190 <dirlink>
801056ff:	83 c4 10             	add    $0x10,%esp
80105702:	85 c0                	test   %eax,%eax
80105704:	78 1c                	js     80105722 <create+0x162>
80105706:	83 ec 04             	sub    $0x4,%esp
80105709:	ff 73 04             	pushl  0x4(%ebx)
8010570c:	68 cf 85 10 80       	push   $0x801085cf
80105711:	57                   	push   %edi
80105712:	e8 79 ca ff ff       	call   80102190 <dirlink>
80105717:	83 c4 10             	add    $0x10,%esp
8010571a:	85 c0                	test   %eax,%eax
8010571c:	0f 89 6e ff ff ff    	jns    80105690 <create+0xd0>
      panic("create dots");
80105722:	83 ec 0c             	sub    $0xc,%esp
80105725:	68 c3 85 10 80       	push   $0x801085c3
8010572a:	e8 61 ac ff ff       	call   80100390 <panic>
8010572f:	90                   	nop
    return 0;
80105730:	31 ff                	xor    %edi,%edi
80105732:	e9 ff fe ff ff       	jmp    80105636 <create+0x76>
    panic("create: dirlink");
80105737:	83 ec 0c             	sub    $0xc,%esp
8010573a:	68 d2 85 10 80       	push   $0x801085d2
8010573f:	e8 4c ac ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105744:	83 ec 0c             	sub    $0xc,%esp
80105747:	68 b4 85 10 80       	push   $0x801085b4
8010574c:	e8 3f ac ff ff       	call   80100390 <panic>
80105751:	eb 0d                	jmp    80105760 <argfd.constprop.0>
80105753:	90                   	nop
80105754:	90                   	nop
80105755:	90                   	nop
80105756:	90                   	nop
80105757:	90                   	nop
80105758:	90                   	nop
80105759:	90                   	nop
8010575a:	90                   	nop
8010575b:	90                   	nop
8010575c:	90                   	nop
8010575d:	90                   	nop
8010575e:	90                   	nop
8010575f:	90                   	nop

80105760 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	56                   	push   %esi
80105764:	53                   	push   %ebx
80105765:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105767:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010576a:	89 d6                	mov    %edx,%esi
8010576c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010576f:	50                   	push   %eax
80105770:	6a 00                	push   $0x0
80105772:	e8 d9 fc ff ff       	call   80105450 <argint>
80105777:	83 c4 10             	add    $0x10,%esp
8010577a:	85 c0                	test   %eax,%eax
8010577c:	78 2a                	js     801057a8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010577e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105782:	77 24                	ja     801057a8 <argfd.constprop.0+0x48>
80105784:	e8 f7 e3 ff ff       	call   80103b80 <myproc>
80105789:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010578c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105790:	85 c0                	test   %eax,%eax
80105792:	74 14                	je     801057a8 <argfd.constprop.0+0x48>
  if(pfd)
80105794:	85 db                	test   %ebx,%ebx
80105796:	74 02                	je     8010579a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105798:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010579a:	89 06                	mov    %eax,(%esi)
  return 0;
8010579c:	31 c0                	xor    %eax,%eax
}
8010579e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057a1:	5b                   	pop    %ebx
801057a2:	5e                   	pop    %esi
801057a3:	5d                   	pop    %ebp
801057a4:	c3                   	ret    
801057a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801057a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ad:	eb ef                	jmp    8010579e <argfd.constprop.0+0x3e>
801057af:	90                   	nop

801057b0 <sys_dup>:
{
801057b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801057b1:	31 c0                	xor    %eax,%eax
{
801057b3:	89 e5                	mov    %esp,%ebp
801057b5:	56                   	push   %esi
801057b6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801057b7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801057ba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801057bd:	e8 9e ff ff ff       	call   80105760 <argfd.constprop.0>
801057c2:	85 c0                	test   %eax,%eax
801057c4:	78 42                	js     80105808 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
801057c6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057c9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801057cb:	e8 b0 e3 ff ff       	call   80103b80 <myproc>
801057d0:	eb 0e                	jmp    801057e0 <sys_dup+0x30>
801057d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057d8:	83 c3 01             	add    $0x1,%ebx
801057db:	83 fb 10             	cmp    $0x10,%ebx
801057de:	74 28                	je     80105808 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
801057e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801057e4:	85 d2                	test   %edx,%edx
801057e6:	75 f0                	jne    801057d8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801057e8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801057ec:	83 ec 0c             	sub    $0xc,%esp
801057ef:	ff 75 f4             	pushl  -0xc(%ebp)
801057f2:	e8 59 b9 ff ff       	call   80101150 <filedup>
  return fd;
801057f7:	83 c4 10             	add    $0x10,%esp
}
801057fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057fd:	89 d8                	mov    %ebx,%eax
801057ff:	5b                   	pop    %ebx
80105800:	5e                   	pop    %esi
80105801:	5d                   	pop    %ebp
80105802:	c3                   	ret    
80105803:	90                   	nop
80105804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105808:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010580b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105810:	89 d8                	mov    %ebx,%eax
80105812:	5b                   	pop    %ebx
80105813:	5e                   	pop    %esi
80105814:	5d                   	pop    %ebp
80105815:	c3                   	ret    
80105816:	8d 76 00             	lea    0x0(%esi),%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105820 <sys_read>:
{
80105820:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105821:	31 c0                	xor    %eax,%eax
{
80105823:	89 e5                	mov    %esp,%ebp
80105825:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105828:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010582b:	e8 30 ff ff ff       	call   80105760 <argfd.constprop.0>
80105830:	85 c0                	test   %eax,%eax
80105832:	78 4c                	js     80105880 <sys_read+0x60>
80105834:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105837:	83 ec 08             	sub    $0x8,%esp
8010583a:	50                   	push   %eax
8010583b:	6a 02                	push   $0x2
8010583d:	e8 0e fc ff ff       	call   80105450 <argint>
80105842:	83 c4 10             	add    $0x10,%esp
80105845:	85 c0                	test   %eax,%eax
80105847:	78 37                	js     80105880 <sys_read+0x60>
80105849:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010584c:	83 ec 04             	sub    $0x4,%esp
8010584f:	ff 75 f0             	pushl  -0x10(%ebp)
80105852:	50                   	push   %eax
80105853:	6a 01                	push   $0x1
80105855:	e8 46 fc ff ff       	call   801054a0 <argptr>
8010585a:	83 c4 10             	add    $0x10,%esp
8010585d:	85 c0                	test   %eax,%eax
8010585f:	78 1f                	js     80105880 <sys_read+0x60>
  return fileread(f, p, n);
80105861:	83 ec 04             	sub    $0x4,%esp
80105864:	ff 75 f0             	pushl  -0x10(%ebp)
80105867:	ff 75 f4             	pushl  -0xc(%ebp)
8010586a:	ff 75 ec             	pushl  -0x14(%ebp)
8010586d:	e8 4e ba ff ff       	call   801012c0 <fileread>
80105872:	83 c4 10             	add    $0x10,%esp
}
80105875:	c9                   	leave  
80105876:	c3                   	ret    
80105877:	89 f6                	mov    %esi,%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105885:	c9                   	leave  
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_write>:
{
80105890:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105891:	31 c0                	xor    %eax,%eax
{
80105893:	89 e5                	mov    %esp,%ebp
80105895:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105898:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010589b:	e8 c0 fe ff ff       	call   80105760 <argfd.constprop.0>
801058a0:	85 c0                	test   %eax,%eax
801058a2:	78 4c                	js     801058f0 <sys_write+0x60>
801058a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058a7:	83 ec 08             	sub    $0x8,%esp
801058aa:	50                   	push   %eax
801058ab:	6a 02                	push   $0x2
801058ad:	e8 9e fb ff ff       	call   80105450 <argint>
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	85 c0                	test   %eax,%eax
801058b7:	78 37                	js     801058f0 <sys_write+0x60>
801058b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058bc:	83 ec 04             	sub    $0x4,%esp
801058bf:	ff 75 f0             	pushl  -0x10(%ebp)
801058c2:	50                   	push   %eax
801058c3:	6a 01                	push   $0x1
801058c5:	e8 d6 fb ff ff       	call   801054a0 <argptr>
801058ca:	83 c4 10             	add    $0x10,%esp
801058cd:	85 c0                	test   %eax,%eax
801058cf:	78 1f                	js     801058f0 <sys_write+0x60>
  return filewrite(f, p, n);
801058d1:	83 ec 04             	sub    $0x4,%esp
801058d4:	ff 75 f0             	pushl  -0x10(%ebp)
801058d7:	ff 75 f4             	pushl  -0xc(%ebp)
801058da:	ff 75 ec             	pushl  -0x14(%ebp)
801058dd:	e8 6e ba ff ff       	call   80101350 <filewrite>
801058e2:	83 c4 10             	add    $0x10,%esp
}
801058e5:	c9                   	leave  
801058e6:	c3                   	ret    
801058e7:	89 f6                	mov    %esi,%esi
801058e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801058f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058f5:	c9                   	leave  
801058f6:	c3                   	ret    
801058f7:	89 f6                	mov    %esi,%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105900 <sys_close>:
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105906:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105909:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010590c:	e8 4f fe ff ff       	call   80105760 <argfd.constprop.0>
80105911:	85 c0                	test   %eax,%eax
80105913:	78 2b                	js     80105940 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105915:	e8 66 e2 ff ff       	call   80103b80 <myproc>
8010591a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010591d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105920:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105927:	00 
  fileclose(f);
80105928:	ff 75 f4             	pushl  -0xc(%ebp)
8010592b:	e8 70 b8 ff ff       	call   801011a0 <fileclose>
  return 0;
80105930:	83 c4 10             	add    $0x10,%esp
80105933:	31 c0                	xor    %eax,%eax
}
80105935:	c9                   	leave  
80105936:	c3                   	ret    
80105937:	89 f6                	mov    %esi,%esi
80105939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105945:	c9                   	leave  
80105946:	c3                   	ret    
80105947:	89 f6                	mov    %esi,%esi
80105949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105950 <sys_fstat>:
{
80105950:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105951:	31 c0                	xor    %eax,%eax
{
80105953:	89 e5                	mov    %esp,%ebp
80105955:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105958:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010595b:	e8 00 fe ff ff       	call   80105760 <argfd.constprop.0>
80105960:	85 c0                	test   %eax,%eax
80105962:	78 2c                	js     80105990 <sys_fstat+0x40>
80105964:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105967:	83 ec 04             	sub    $0x4,%esp
8010596a:	6a 14                	push   $0x14
8010596c:	50                   	push   %eax
8010596d:	6a 01                	push   $0x1
8010596f:	e8 2c fb ff ff       	call   801054a0 <argptr>
80105974:	83 c4 10             	add    $0x10,%esp
80105977:	85 c0                	test   %eax,%eax
80105979:	78 15                	js     80105990 <sys_fstat+0x40>
  return filestat(f, st);
8010597b:	83 ec 08             	sub    $0x8,%esp
8010597e:	ff 75 f4             	pushl  -0xc(%ebp)
80105981:	ff 75 f0             	pushl  -0x10(%ebp)
80105984:	e8 e7 b8 ff ff       	call   80101270 <filestat>
80105989:	83 c4 10             	add    $0x10,%esp
}
8010598c:	c9                   	leave  
8010598d:	c3                   	ret    
8010598e:	66 90                	xchg   %ax,%ax
    return -1;
80105990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105995:	c9                   	leave  
80105996:	c3                   	ret    
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059a0 <sys_link>:
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	57                   	push   %edi
801059a4:	56                   	push   %esi
801059a5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059a6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801059a9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059ac:	50                   	push   %eax
801059ad:	6a 00                	push   $0x0
801059af:	e8 4c fb ff ff       	call   80105500 <argstr>
801059b4:	83 c4 10             	add    $0x10,%esp
801059b7:	85 c0                	test   %eax,%eax
801059b9:	0f 88 fb 00 00 00    	js     80105aba <sys_link+0x11a>
801059bf:	8d 45 d0             	lea    -0x30(%ebp),%eax
801059c2:	83 ec 08             	sub    $0x8,%esp
801059c5:	50                   	push   %eax
801059c6:	6a 01                	push   $0x1
801059c8:	e8 33 fb ff ff       	call   80105500 <argstr>
801059cd:	83 c4 10             	add    $0x10,%esp
801059d0:	85 c0                	test   %eax,%eax
801059d2:	0f 88 e2 00 00 00    	js     80105aba <sys_link+0x11a>
  begin_op();
801059d8:	e8 33 d5 ff ff       	call   80102f10 <begin_op>
  if((ip = namei(old)) == 0){
801059dd:	83 ec 0c             	sub    $0xc,%esp
801059e0:	ff 75 d4             	pushl  -0x2c(%ebp)
801059e3:	e8 68 c8 ff ff       	call   80102250 <namei>
801059e8:	83 c4 10             	add    $0x10,%esp
801059eb:	85 c0                	test   %eax,%eax
801059ed:	89 c3                	mov    %eax,%ebx
801059ef:	0f 84 ea 00 00 00    	je     80105adf <sys_link+0x13f>
  ilock(ip);
801059f5:	83 ec 0c             	sub    $0xc,%esp
801059f8:	50                   	push   %eax
801059f9:	e8 f2 bf ff ff       	call   801019f0 <ilock>
  if(ip->type == T_DIR){
801059fe:	83 c4 10             	add    $0x10,%esp
80105a01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a06:	0f 84 bb 00 00 00    	je     80105ac7 <sys_link+0x127>
  ip->nlink++;
80105a0c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105a11:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105a14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105a17:	53                   	push   %ebx
80105a18:	e8 23 bf ff ff       	call   80101940 <iupdate>
  iunlock(ip);
80105a1d:	89 1c 24             	mov    %ebx,(%esp)
80105a20:	e8 ab c0 ff ff       	call   80101ad0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105a25:	58                   	pop    %eax
80105a26:	5a                   	pop    %edx
80105a27:	57                   	push   %edi
80105a28:	ff 75 d0             	pushl  -0x30(%ebp)
80105a2b:	e8 40 c8 ff ff       	call   80102270 <nameiparent>
80105a30:	83 c4 10             	add    $0x10,%esp
80105a33:	85 c0                	test   %eax,%eax
80105a35:	89 c6                	mov    %eax,%esi
80105a37:	74 5b                	je     80105a94 <sys_link+0xf4>
  ilock(dp);
80105a39:	83 ec 0c             	sub    $0xc,%esp
80105a3c:	50                   	push   %eax
80105a3d:	e8 ae bf ff ff       	call   801019f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a42:	83 c4 10             	add    $0x10,%esp
80105a45:	8b 03                	mov    (%ebx),%eax
80105a47:	39 06                	cmp    %eax,(%esi)
80105a49:	75 3d                	jne    80105a88 <sys_link+0xe8>
80105a4b:	83 ec 04             	sub    $0x4,%esp
80105a4e:	ff 73 04             	pushl  0x4(%ebx)
80105a51:	57                   	push   %edi
80105a52:	56                   	push   %esi
80105a53:	e8 38 c7 ff ff       	call   80102190 <dirlink>
80105a58:	83 c4 10             	add    $0x10,%esp
80105a5b:	85 c0                	test   %eax,%eax
80105a5d:	78 29                	js     80105a88 <sys_link+0xe8>
  iunlockput(dp);
80105a5f:	83 ec 0c             	sub    $0xc,%esp
80105a62:	56                   	push   %esi
80105a63:	e8 18 c2 ff ff       	call   80101c80 <iunlockput>
  iput(ip);
80105a68:	89 1c 24             	mov    %ebx,(%esp)
80105a6b:	e8 b0 c0 ff ff       	call   80101b20 <iput>
  end_op();
80105a70:	e8 0b d5 ff ff       	call   80102f80 <end_op>
  return 0;
80105a75:	83 c4 10             	add    $0x10,%esp
80105a78:	31 c0                	xor    %eax,%eax
}
80105a7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a7d:	5b                   	pop    %ebx
80105a7e:	5e                   	pop    %esi
80105a7f:	5f                   	pop    %edi
80105a80:	5d                   	pop    %ebp
80105a81:	c3                   	ret    
80105a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105a88:	83 ec 0c             	sub    $0xc,%esp
80105a8b:	56                   	push   %esi
80105a8c:	e8 ef c1 ff ff       	call   80101c80 <iunlockput>
    goto bad;
80105a91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105a94:	83 ec 0c             	sub    $0xc,%esp
80105a97:	53                   	push   %ebx
80105a98:	e8 53 bf ff ff       	call   801019f0 <ilock>
  ip->nlink--;
80105a9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105aa2:	89 1c 24             	mov    %ebx,(%esp)
80105aa5:	e8 96 be ff ff       	call   80101940 <iupdate>
  iunlockput(ip);
80105aaa:	89 1c 24             	mov    %ebx,(%esp)
80105aad:	e8 ce c1 ff ff       	call   80101c80 <iunlockput>
  end_op();
80105ab2:	e8 c9 d4 ff ff       	call   80102f80 <end_op>
  return -1;
80105ab7:	83 c4 10             	add    $0x10,%esp
}
80105aba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80105abd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ac2:	5b                   	pop    %ebx
80105ac3:	5e                   	pop    %esi
80105ac4:	5f                   	pop    %edi
80105ac5:	5d                   	pop    %ebp
80105ac6:	c3                   	ret    
    iunlockput(ip);
80105ac7:	83 ec 0c             	sub    $0xc,%esp
80105aca:	53                   	push   %ebx
80105acb:	e8 b0 c1 ff ff       	call   80101c80 <iunlockput>
    end_op();
80105ad0:	e8 ab d4 ff ff       	call   80102f80 <end_op>
    return -1;
80105ad5:	83 c4 10             	add    $0x10,%esp
80105ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105add:	eb 9b                	jmp    80105a7a <sys_link+0xda>
    end_op();
80105adf:	e8 9c d4 ff ff       	call   80102f80 <end_op>
    return -1;
80105ae4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ae9:	eb 8f                	jmp    80105a7a <sys_link+0xda>
80105aeb:	90                   	nop
80105aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105af0 <sys_unlink>:
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	57                   	push   %edi
80105af4:	56                   	push   %esi
80105af5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105af6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105af9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80105afc:	50                   	push   %eax
80105afd:	6a 00                	push   $0x0
80105aff:	e8 fc f9 ff ff       	call   80105500 <argstr>
80105b04:	83 c4 10             	add    $0x10,%esp
80105b07:	85 c0                	test   %eax,%eax
80105b09:	0f 88 77 01 00 00    	js     80105c86 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80105b0f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105b12:	e8 f9 d3 ff ff       	call   80102f10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b17:	83 ec 08             	sub    $0x8,%esp
80105b1a:	53                   	push   %ebx
80105b1b:	ff 75 c0             	pushl  -0x40(%ebp)
80105b1e:	e8 4d c7 ff ff       	call   80102270 <nameiparent>
80105b23:	83 c4 10             	add    $0x10,%esp
80105b26:	85 c0                	test   %eax,%eax
80105b28:	89 c6                	mov    %eax,%esi
80105b2a:	0f 84 60 01 00 00    	je     80105c90 <sys_unlink+0x1a0>
  ilock(dp);
80105b30:	83 ec 0c             	sub    $0xc,%esp
80105b33:	50                   	push   %eax
80105b34:	e8 b7 be ff ff       	call   801019f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b39:	58                   	pop    %eax
80105b3a:	5a                   	pop    %edx
80105b3b:	68 d0 85 10 80       	push   $0x801085d0
80105b40:	53                   	push   %ebx
80105b41:	e8 ba c3 ff ff       	call   80101f00 <namecmp>
80105b46:	83 c4 10             	add    $0x10,%esp
80105b49:	85 c0                	test   %eax,%eax
80105b4b:	0f 84 03 01 00 00    	je     80105c54 <sys_unlink+0x164>
80105b51:	83 ec 08             	sub    $0x8,%esp
80105b54:	68 cf 85 10 80       	push   $0x801085cf
80105b59:	53                   	push   %ebx
80105b5a:	e8 a1 c3 ff ff       	call   80101f00 <namecmp>
80105b5f:	83 c4 10             	add    $0x10,%esp
80105b62:	85 c0                	test   %eax,%eax
80105b64:	0f 84 ea 00 00 00    	je     80105c54 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105b6a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105b6d:	83 ec 04             	sub    $0x4,%esp
80105b70:	50                   	push   %eax
80105b71:	53                   	push   %ebx
80105b72:	56                   	push   %esi
80105b73:	e8 a8 c3 ff ff       	call   80101f20 <dirlookup>
80105b78:	83 c4 10             	add    $0x10,%esp
80105b7b:	85 c0                	test   %eax,%eax
80105b7d:	89 c3                	mov    %eax,%ebx
80105b7f:	0f 84 cf 00 00 00    	je     80105c54 <sys_unlink+0x164>
  ilock(ip);
80105b85:	83 ec 0c             	sub    $0xc,%esp
80105b88:	50                   	push   %eax
80105b89:	e8 62 be ff ff       	call   801019f0 <ilock>
  if(ip->nlink < 1)
80105b8e:	83 c4 10             	add    $0x10,%esp
80105b91:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105b96:	0f 8e 10 01 00 00    	jle    80105cac <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105b9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ba1:	74 6d                	je     80105c10 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105ba3:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105ba6:	83 ec 04             	sub    $0x4,%esp
80105ba9:	6a 10                	push   $0x10
80105bab:	6a 00                	push   $0x0
80105bad:	50                   	push   %eax
80105bae:	e8 9d f5 ff ff       	call   80105150 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105bb3:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105bb6:	6a 10                	push   $0x10
80105bb8:	ff 75 c4             	pushl  -0x3c(%ebp)
80105bbb:	50                   	push   %eax
80105bbc:	56                   	push   %esi
80105bbd:	e8 0e c2 ff ff       	call   80101dd0 <writei>
80105bc2:	83 c4 20             	add    $0x20,%esp
80105bc5:	83 f8 10             	cmp    $0x10,%eax
80105bc8:	0f 85 eb 00 00 00    	jne    80105cb9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80105bce:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bd3:	0f 84 97 00 00 00    	je     80105c70 <sys_unlink+0x180>
  iunlockput(dp);
80105bd9:	83 ec 0c             	sub    $0xc,%esp
80105bdc:	56                   	push   %esi
80105bdd:	e8 9e c0 ff ff       	call   80101c80 <iunlockput>
  ip->nlink--;
80105be2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105be7:	89 1c 24             	mov    %ebx,(%esp)
80105bea:	e8 51 bd ff ff       	call   80101940 <iupdate>
  iunlockput(ip);
80105bef:	89 1c 24             	mov    %ebx,(%esp)
80105bf2:	e8 89 c0 ff ff       	call   80101c80 <iunlockput>
  end_op();
80105bf7:	e8 84 d3 ff ff       	call   80102f80 <end_op>
  return 0;
80105bfc:	83 c4 10             	add    $0x10,%esp
80105bff:	31 c0                	xor    %eax,%eax
}
80105c01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c04:	5b                   	pop    %ebx
80105c05:	5e                   	pop    %esi
80105c06:	5f                   	pop    %edi
80105c07:	5d                   	pop    %ebp
80105c08:	c3                   	ret    
80105c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c10:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105c14:	76 8d                	jbe    80105ba3 <sys_unlink+0xb3>
80105c16:	bf 20 00 00 00       	mov    $0x20,%edi
80105c1b:	eb 0f                	jmp    80105c2c <sys_unlink+0x13c>
80105c1d:	8d 76 00             	lea    0x0(%esi),%esi
80105c20:	83 c7 10             	add    $0x10,%edi
80105c23:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105c26:	0f 83 77 ff ff ff    	jae    80105ba3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c2c:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105c2f:	6a 10                	push   $0x10
80105c31:	57                   	push   %edi
80105c32:	50                   	push   %eax
80105c33:	53                   	push   %ebx
80105c34:	e8 97 c0 ff ff       	call   80101cd0 <readi>
80105c39:	83 c4 10             	add    $0x10,%esp
80105c3c:	83 f8 10             	cmp    $0x10,%eax
80105c3f:	75 5e                	jne    80105c9f <sys_unlink+0x1af>
    if(de.inum != 0)
80105c41:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105c46:	74 d8                	je     80105c20 <sys_unlink+0x130>
    iunlockput(ip);
80105c48:	83 ec 0c             	sub    $0xc,%esp
80105c4b:	53                   	push   %ebx
80105c4c:	e8 2f c0 ff ff       	call   80101c80 <iunlockput>
    goto bad;
80105c51:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105c54:	83 ec 0c             	sub    $0xc,%esp
80105c57:	56                   	push   %esi
80105c58:	e8 23 c0 ff ff       	call   80101c80 <iunlockput>
  end_op();
80105c5d:	e8 1e d3 ff ff       	call   80102f80 <end_op>
  return -1;
80105c62:	83 c4 10             	add    $0x10,%esp
80105c65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c6a:	eb 95                	jmp    80105c01 <sys_unlink+0x111>
80105c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105c70:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105c75:	83 ec 0c             	sub    $0xc,%esp
80105c78:	56                   	push   %esi
80105c79:	e8 c2 bc ff ff       	call   80101940 <iupdate>
80105c7e:	83 c4 10             	add    $0x10,%esp
80105c81:	e9 53 ff ff ff       	jmp    80105bd9 <sys_unlink+0xe9>
    return -1;
80105c86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c8b:	e9 71 ff ff ff       	jmp    80105c01 <sys_unlink+0x111>
    end_op();
80105c90:	e8 eb d2 ff ff       	call   80102f80 <end_op>
    return -1;
80105c95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9a:	e9 62 ff ff ff       	jmp    80105c01 <sys_unlink+0x111>
      panic("isdirempty: readi");
80105c9f:	83 ec 0c             	sub    $0xc,%esp
80105ca2:	68 f4 85 10 80       	push   $0x801085f4
80105ca7:	e8 e4 a6 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105cac:	83 ec 0c             	sub    $0xc,%esp
80105caf:	68 e2 85 10 80       	push   $0x801085e2
80105cb4:	e8 d7 a6 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105cb9:	83 ec 0c             	sub    $0xc,%esp
80105cbc:	68 06 86 10 80       	push   $0x80108606
80105cc1:	e8 ca a6 ff ff       	call   80100390 <panic>
80105cc6:	8d 76 00             	lea    0x0(%esi),%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cd0 <sys_open>:

int
sys_open(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	57                   	push   %edi
80105cd4:	56                   	push   %esi
80105cd5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105cd6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105cd9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105cdc:	50                   	push   %eax
80105cdd:	6a 00                	push   $0x0
80105cdf:	e8 1c f8 ff ff       	call   80105500 <argstr>
80105ce4:	83 c4 10             	add    $0x10,%esp
80105ce7:	85 c0                	test   %eax,%eax
80105ce9:	0f 88 1d 01 00 00    	js     80105e0c <sys_open+0x13c>
80105cef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105cf2:	83 ec 08             	sub    $0x8,%esp
80105cf5:	50                   	push   %eax
80105cf6:	6a 01                	push   $0x1
80105cf8:	e8 53 f7 ff ff       	call   80105450 <argint>
80105cfd:	83 c4 10             	add    $0x10,%esp
80105d00:	85 c0                	test   %eax,%eax
80105d02:	0f 88 04 01 00 00    	js     80105e0c <sys_open+0x13c>
    return -1;

  begin_op();
80105d08:	e8 03 d2 ff ff       	call   80102f10 <begin_op>

  if(omode & O_CREATE){
80105d0d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105d11:	0f 85 a9 00 00 00    	jne    80105dc0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105d17:	83 ec 0c             	sub    $0xc,%esp
80105d1a:	ff 75 e0             	pushl  -0x20(%ebp)
80105d1d:	e8 2e c5 ff ff       	call   80102250 <namei>
80105d22:	83 c4 10             	add    $0x10,%esp
80105d25:	85 c0                	test   %eax,%eax
80105d27:	89 c6                	mov    %eax,%esi
80105d29:	0f 84 b2 00 00 00    	je     80105de1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
80105d2f:	83 ec 0c             	sub    $0xc,%esp
80105d32:	50                   	push   %eax
80105d33:	e8 b8 bc ff ff       	call   801019f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d38:	83 c4 10             	add    $0x10,%esp
80105d3b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d40:	0f 84 aa 00 00 00    	je     80105df0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d46:	e8 95 b3 ff ff       	call   801010e0 <filealloc>
80105d4b:	85 c0                	test   %eax,%eax
80105d4d:	89 c7                	mov    %eax,%edi
80105d4f:	0f 84 a6 00 00 00    	je     80105dfb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105d55:	e8 26 de ff ff       	call   80103b80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d5a:	31 db                	xor    %ebx,%ebx
80105d5c:	eb 0e                	jmp    80105d6c <sys_open+0x9c>
80105d5e:	66 90                	xchg   %ax,%ax
80105d60:	83 c3 01             	add    $0x1,%ebx
80105d63:	83 fb 10             	cmp    $0x10,%ebx
80105d66:	0f 84 ac 00 00 00    	je     80105e18 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105d6c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105d70:	85 d2                	test   %edx,%edx
80105d72:	75 ec                	jne    80105d60 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105d74:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105d77:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105d7b:	56                   	push   %esi
80105d7c:	e8 4f bd ff ff       	call   80101ad0 <iunlock>
  end_op();
80105d81:	e8 fa d1 ff ff       	call   80102f80 <end_op>

  f->type = FD_INODE;
80105d86:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105d8c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d8f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105d92:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105d95:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105d9c:	89 d0                	mov    %edx,%eax
80105d9e:	f7 d0                	not    %eax
80105da0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105da3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105da6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105da9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105dad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105db0:	89 d8                	mov    %ebx,%eax
80105db2:	5b                   	pop    %ebx
80105db3:	5e                   	pop    %esi
80105db4:	5f                   	pop    %edi
80105db5:	5d                   	pop    %ebp
80105db6:	c3                   	ret    
80105db7:	89 f6                	mov    %esi,%esi
80105db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105dc0:	83 ec 0c             	sub    $0xc,%esp
80105dc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105dc6:	31 c9                	xor    %ecx,%ecx
80105dc8:	6a 00                	push   $0x0
80105dca:	ba 02 00 00 00       	mov    $0x2,%edx
80105dcf:	e8 ec f7 ff ff       	call   801055c0 <create>
    if(ip == 0){
80105dd4:	83 c4 10             	add    $0x10,%esp
80105dd7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105dd9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105ddb:	0f 85 65 ff ff ff    	jne    80105d46 <sys_open+0x76>
      end_op();
80105de1:	e8 9a d1 ff ff       	call   80102f80 <end_op>
      return -1;
80105de6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105deb:	eb c0                	jmp    80105dad <sys_open+0xdd>
80105ded:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105df0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105df3:	85 c9                	test   %ecx,%ecx
80105df5:	0f 84 4b ff ff ff    	je     80105d46 <sys_open+0x76>
    iunlockput(ip);
80105dfb:	83 ec 0c             	sub    $0xc,%esp
80105dfe:	56                   	push   %esi
80105dff:	e8 7c be ff ff       	call   80101c80 <iunlockput>
    end_op();
80105e04:	e8 77 d1 ff ff       	call   80102f80 <end_op>
    return -1;
80105e09:	83 c4 10             	add    $0x10,%esp
80105e0c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e11:	eb 9a                	jmp    80105dad <sys_open+0xdd>
80105e13:	90                   	nop
80105e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105e18:	83 ec 0c             	sub    $0xc,%esp
80105e1b:	57                   	push   %edi
80105e1c:	e8 7f b3 ff ff       	call   801011a0 <fileclose>
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	eb d5                	jmp    80105dfb <sys_open+0x12b>
80105e26:	8d 76 00             	lea    0x0(%esi),%esi
80105e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e30 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e36:	e8 d5 d0 ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e3b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e3e:	83 ec 08             	sub    $0x8,%esp
80105e41:	50                   	push   %eax
80105e42:	6a 00                	push   $0x0
80105e44:	e8 b7 f6 ff ff       	call   80105500 <argstr>
80105e49:	83 c4 10             	add    $0x10,%esp
80105e4c:	85 c0                	test   %eax,%eax
80105e4e:	78 30                	js     80105e80 <sys_mkdir+0x50>
80105e50:	83 ec 0c             	sub    $0xc,%esp
80105e53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e56:	31 c9                	xor    %ecx,%ecx
80105e58:	6a 00                	push   $0x0
80105e5a:	ba 01 00 00 00       	mov    $0x1,%edx
80105e5f:	e8 5c f7 ff ff       	call   801055c0 <create>
80105e64:	83 c4 10             	add    $0x10,%esp
80105e67:	85 c0                	test   %eax,%eax
80105e69:	74 15                	je     80105e80 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e6b:	83 ec 0c             	sub    $0xc,%esp
80105e6e:	50                   	push   %eax
80105e6f:	e8 0c be ff ff       	call   80101c80 <iunlockput>
  end_op();
80105e74:	e8 07 d1 ff ff       	call   80102f80 <end_op>
  return 0;
80105e79:	83 c4 10             	add    $0x10,%esp
80105e7c:	31 c0                	xor    %eax,%eax
}
80105e7e:	c9                   	leave  
80105e7f:	c3                   	ret    
    end_op();
80105e80:	e8 fb d0 ff ff       	call   80102f80 <end_op>
    return -1;
80105e85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e8a:	c9                   	leave  
80105e8b:	c3                   	ret    
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e90 <sys_mknod>:

int
sys_mknod(void)
{
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
80105e93:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105e96:	e8 75 d0 ff ff       	call   80102f10 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105e9b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e9e:	83 ec 08             	sub    $0x8,%esp
80105ea1:	50                   	push   %eax
80105ea2:	6a 00                	push   $0x0
80105ea4:	e8 57 f6 ff ff       	call   80105500 <argstr>
80105ea9:	83 c4 10             	add    $0x10,%esp
80105eac:	85 c0                	test   %eax,%eax
80105eae:	78 60                	js     80105f10 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105eb0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105eb3:	83 ec 08             	sub    $0x8,%esp
80105eb6:	50                   	push   %eax
80105eb7:	6a 01                	push   $0x1
80105eb9:	e8 92 f5 ff ff       	call   80105450 <argint>
  if((argstr(0, &path)) < 0 ||
80105ebe:	83 c4 10             	add    $0x10,%esp
80105ec1:	85 c0                	test   %eax,%eax
80105ec3:	78 4b                	js     80105f10 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105ec5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ec8:	83 ec 08             	sub    $0x8,%esp
80105ecb:	50                   	push   %eax
80105ecc:	6a 02                	push   $0x2
80105ece:	e8 7d f5 ff ff       	call   80105450 <argint>
     argint(1, &major) < 0 ||
80105ed3:	83 c4 10             	add    $0x10,%esp
80105ed6:	85 c0                	test   %eax,%eax
80105ed8:	78 36                	js     80105f10 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105eda:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105ede:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105ee1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105ee5:	ba 03 00 00 00       	mov    $0x3,%edx
80105eea:	50                   	push   %eax
80105eeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105eee:	e8 cd f6 ff ff       	call   801055c0 <create>
80105ef3:	83 c4 10             	add    $0x10,%esp
80105ef6:	85 c0                	test   %eax,%eax
80105ef8:	74 16                	je     80105f10 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105efa:	83 ec 0c             	sub    $0xc,%esp
80105efd:	50                   	push   %eax
80105efe:	e8 7d bd ff ff       	call   80101c80 <iunlockput>
  end_op();
80105f03:	e8 78 d0 ff ff       	call   80102f80 <end_op>
  return 0;
80105f08:	83 c4 10             	add    $0x10,%esp
80105f0b:	31 c0                	xor    %eax,%eax
}
80105f0d:	c9                   	leave  
80105f0e:	c3                   	ret    
80105f0f:	90                   	nop
    end_op();
80105f10:	e8 6b d0 ff ff       	call   80102f80 <end_op>
    return -1;
80105f15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f1a:	c9                   	leave  
80105f1b:	c3                   	ret    
80105f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f20 <sys_chdir>:

int
sys_chdir(void)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	56                   	push   %esi
80105f24:	53                   	push   %ebx
80105f25:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105f28:	e8 53 dc ff ff       	call   80103b80 <myproc>
80105f2d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105f2f:	e8 dc cf ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f37:	83 ec 08             	sub    $0x8,%esp
80105f3a:	50                   	push   %eax
80105f3b:	6a 00                	push   $0x0
80105f3d:	e8 be f5 ff ff       	call   80105500 <argstr>
80105f42:	83 c4 10             	add    $0x10,%esp
80105f45:	85 c0                	test   %eax,%eax
80105f47:	78 77                	js     80105fc0 <sys_chdir+0xa0>
80105f49:	83 ec 0c             	sub    $0xc,%esp
80105f4c:	ff 75 f4             	pushl  -0xc(%ebp)
80105f4f:	e8 fc c2 ff ff       	call   80102250 <namei>
80105f54:	83 c4 10             	add    $0x10,%esp
80105f57:	85 c0                	test   %eax,%eax
80105f59:	89 c3                	mov    %eax,%ebx
80105f5b:	74 63                	je     80105fc0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105f5d:	83 ec 0c             	sub    $0xc,%esp
80105f60:	50                   	push   %eax
80105f61:	e8 8a ba ff ff       	call   801019f0 <ilock>
  if(ip->type != T_DIR){
80105f66:	83 c4 10             	add    $0x10,%esp
80105f69:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f6e:	75 30                	jne    80105fa0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f70:	83 ec 0c             	sub    $0xc,%esp
80105f73:	53                   	push   %ebx
80105f74:	e8 57 bb ff ff       	call   80101ad0 <iunlock>
  iput(curproc->cwd);
80105f79:	58                   	pop    %eax
80105f7a:	ff 76 68             	pushl  0x68(%esi)
80105f7d:	e8 9e bb ff ff       	call   80101b20 <iput>
  end_op();
80105f82:	e8 f9 cf ff ff       	call   80102f80 <end_op>
  curproc->cwd = ip;
80105f87:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105f8a:	83 c4 10             	add    $0x10,%esp
80105f8d:	31 c0                	xor    %eax,%eax
}
80105f8f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105f92:	5b                   	pop    %ebx
80105f93:	5e                   	pop    %esi
80105f94:	5d                   	pop    %ebp
80105f95:	c3                   	ret    
80105f96:	8d 76 00             	lea    0x0(%esi),%esi
80105f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105fa0:	83 ec 0c             	sub    $0xc,%esp
80105fa3:	53                   	push   %ebx
80105fa4:	e8 d7 bc ff ff       	call   80101c80 <iunlockput>
    end_op();
80105fa9:	e8 d2 cf ff ff       	call   80102f80 <end_op>
    return -1;
80105fae:	83 c4 10             	add    $0x10,%esp
80105fb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fb6:	eb d7                	jmp    80105f8f <sys_chdir+0x6f>
80105fb8:	90                   	nop
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105fc0:	e8 bb cf ff ff       	call   80102f80 <end_op>
    return -1;
80105fc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fca:	eb c3                	jmp    80105f8f <sys_chdir+0x6f>
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fd0 <sys_exec>:

int
sys_exec(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	57                   	push   %edi
80105fd4:	56                   	push   %esi
80105fd5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105fd6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105fdc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105fe2:	50                   	push   %eax
80105fe3:	6a 00                	push   $0x0
80105fe5:	e8 16 f5 ff ff       	call   80105500 <argstr>
80105fea:	83 c4 10             	add    $0x10,%esp
80105fed:	85 c0                	test   %eax,%eax
80105fef:	0f 88 87 00 00 00    	js     8010607c <sys_exec+0xac>
80105ff5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105ffb:	83 ec 08             	sub    $0x8,%esp
80105ffe:	50                   	push   %eax
80105fff:	6a 01                	push   $0x1
80106001:	e8 4a f4 ff ff       	call   80105450 <argint>
80106006:	83 c4 10             	add    $0x10,%esp
80106009:	85 c0                	test   %eax,%eax
8010600b:	78 6f                	js     8010607c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010600d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106013:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80106016:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106018:	68 80 00 00 00       	push   $0x80
8010601d:	6a 00                	push   $0x0
8010601f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106025:	50                   	push   %eax
80106026:	e8 25 f1 ff ff       	call   80105150 <memset>
8010602b:	83 c4 10             	add    $0x10,%esp
8010602e:	eb 2c                	jmp    8010605c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106030:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106036:	85 c0                	test   %eax,%eax
80106038:	74 56                	je     80106090 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010603a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106040:	83 ec 08             	sub    $0x8,%esp
80106043:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106046:	52                   	push   %edx
80106047:	50                   	push   %eax
80106048:	e8 93 f3 ff ff       	call   801053e0 <fetchstr>
8010604d:	83 c4 10             	add    $0x10,%esp
80106050:	85 c0                	test   %eax,%eax
80106052:	78 28                	js     8010607c <sys_exec+0xac>
  for(i=0;; i++){
80106054:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106057:	83 fb 20             	cmp    $0x20,%ebx
8010605a:	74 20                	je     8010607c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010605c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106062:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106069:	83 ec 08             	sub    $0x8,%esp
8010606c:	57                   	push   %edi
8010606d:	01 f0                	add    %esi,%eax
8010606f:	50                   	push   %eax
80106070:	e8 2b f3 ff ff       	call   801053a0 <fetchint>
80106075:	83 c4 10             	add    $0x10,%esp
80106078:	85 c0                	test   %eax,%eax
8010607a:	79 b4                	jns    80106030 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010607c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010607f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106084:	5b                   	pop    %ebx
80106085:	5e                   	pop    %esi
80106086:	5f                   	pop    %edi
80106087:	5d                   	pop    %ebp
80106088:	c3                   	ret    
80106089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106090:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106096:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80106099:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801060a0:	00 00 00 00 
  return exec(path, argv);
801060a4:	50                   	push   %eax
801060a5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801060ab:	e8 60 ac ff ff       	call   80100d10 <exec>
801060b0:	83 c4 10             	add    $0x10,%esp
}
801060b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060b6:	5b                   	pop    %ebx
801060b7:	5e                   	pop    %esi
801060b8:	5f                   	pop    %edi
801060b9:	5d                   	pop    %ebp
801060ba:	c3                   	ret    
801060bb:	90                   	nop
801060bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060c0 <sys_pipe>:

int
sys_pipe(void)
{
801060c0:	55                   	push   %ebp
801060c1:	89 e5                	mov    %esp,%ebp
801060c3:	57                   	push   %edi
801060c4:	56                   	push   %esi
801060c5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801060c6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801060c9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801060cc:	6a 08                	push   $0x8
801060ce:	50                   	push   %eax
801060cf:	6a 00                	push   $0x0
801060d1:	e8 ca f3 ff ff       	call   801054a0 <argptr>
801060d6:	83 c4 10             	add    $0x10,%esp
801060d9:	85 c0                	test   %eax,%eax
801060db:	0f 88 ae 00 00 00    	js     8010618f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801060e1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801060e4:	83 ec 08             	sub    $0x8,%esp
801060e7:	50                   	push   %eax
801060e8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801060eb:	50                   	push   %eax
801060ec:	e8 bf d4 ff ff       	call   801035b0 <pipealloc>
801060f1:	83 c4 10             	add    $0x10,%esp
801060f4:	85 c0                	test   %eax,%eax
801060f6:	0f 88 93 00 00 00    	js     8010618f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801060fc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801060ff:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106101:	e8 7a da ff ff       	call   80103b80 <myproc>
80106106:	eb 10                	jmp    80106118 <sys_pipe+0x58>
80106108:	90                   	nop
80106109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106110:	83 c3 01             	add    $0x1,%ebx
80106113:	83 fb 10             	cmp    $0x10,%ebx
80106116:	74 60                	je     80106178 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80106118:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010611c:	85 f6                	test   %esi,%esi
8010611e:	75 f0                	jne    80106110 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106120:	8d 73 08             	lea    0x8(%ebx),%esi
80106123:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106127:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010612a:	e8 51 da ff ff       	call   80103b80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010612f:	31 d2                	xor    %edx,%edx
80106131:	eb 0d                	jmp    80106140 <sys_pipe+0x80>
80106133:	90                   	nop
80106134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106138:	83 c2 01             	add    $0x1,%edx
8010613b:	83 fa 10             	cmp    $0x10,%edx
8010613e:	74 28                	je     80106168 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80106140:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106144:	85 c9                	test   %ecx,%ecx
80106146:	75 f0                	jne    80106138 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80106148:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010614c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010614f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106151:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106154:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106157:	31 c0                	xor    %eax,%eax
}
80106159:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010615c:	5b                   	pop    %ebx
8010615d:	5e                   	pop    %esi
8010615e:	5f                   	pop    %edi
8010615f:	5d                   	pop    %ebp
80106160:	c3                   	ret    
80106161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80106168:	e8 13 da ff ff       	call   80103b80 <myproc>
8010616d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106174:	00 
80106175:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80106178:	83 ec 0c             	sub    $0xc,%esp
8010617b:	ff 75 e0             	pushl  -0x20(%ebp)
8010617e:	e8 1d b0 ff ff       	call   801011a0 <fileclose>
    fileclose(wf);
80106183:	58                   	pop    %eax
80106184:	ff 75 e4             	pushl  -0x1c(%ebp)
80106187:	e8 14 b0 ff ff       	call   801011a0 <fileclose>
    return -1;
8010618c:	83 c4 10             	add    $0x10,%esp
8010618f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106194:	eb c3                	jmp    80106159 <sys_pipe+0x99>
80106196:	66 90                	xchg   %ax,%ax
80106198:	66 90                	xchg   %ax,%ax
8010619a:	66 90                	xchg   %ax,%ax
8010619c:	66 90                	xchg   %ax,%ax
8010619e:	66 90                	xchg   %ax,%ax

801061a0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801061a3:	5d                   	pop    %ebp
  return fork();
801061a4:	e9 77 db ff ff       	jmp    80103d20 <fork>
801061a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061b0 <sys_exit>:

int
sys_exit(void)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	83 ec 08             	sub    $0x8,%esp
  exit();
801061b6:	e8 45 dd ff ff       	call   80103f00 <exit>
  return 0;  // not reached
}
801061bb:	31 c0                	xor    %eax,%eax
801061bd:	c9                   	leave  
801061be:	c3                   	ret    
801061bf:	90                   	nop

801061c0 <sys_wait>:

int
sys_wait(void)
{
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801061c3:	5d                   	pop    %ebp
  return wait();
801061c4:	e9 77 df ff ff       	jmp    80104140 <wait>
801061c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061d0 <sys_kill>:

int
sys_kill(void)
{
801061d0:	55                   	push   %ebp
801061d1:	89 e5                	mov    %esp,%ebp
801061d3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801061d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061d9:	50                   	push   %eax
801061da:	6a 00                	push   $0x0
801061dc:	e8 6f f2 ff ff       	call   80105450 <argint>
801061e1:	83 c4 10             	add    $0x10,%esp
801061e4:	85 c0                	test   %eax,%eax
801061e6:	78 18                	js     80106200 <sys_kill+0x30>
    return -1;
  return kill(pid);
801061e8:	83 ec 0c             	sub    $0xc,%esp
801061eb:	ff 75 f4             	pushl  -0xc(%ebp)
801061ee:	e8 ad e0 ff ff       	call   801042a0 <kill>
801061f3:	83 c4 10             	add    $0x10,%esp
}
801061f6:	c9                   	leave  
801061f7:	c3                   	ret    
801061f8:	90                   	nop
801061f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106205:	c9                   	leave  
80106206:	c3                   	ret    
80106207:	89 f6                	mov    %esi,%esi
80106209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106210 <sys_getpid>:

int
sys_getpid(void)
{
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
80106213:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106216:	e8 65 d9 ff ff       	call   80103b80 <myproc>
8010621b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010621e:	c9                   	leave  
8010621f:	c3                   	ret    

80106220 <sys_sbrk>:

int
sys_sbrk(void)
{
80106220:	55                   	push   %ebp
80106221:	89 e5                	mov    %esp,%ebp
80106223:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106224:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106227:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010622a:	50                   	push   %eax
8010622b:	6a 00                	push   $0x0
8010622d:	e8 1e f2 ff ff       	call   80105450 <argint>
80106232:	83 c4 10             	add    $0x10,%esp
80106235:	85 c0                	test   %eax,%eax
80106237:	78 27                	js     80106260 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106239:	e8 42 d9 ff ff       	call   80103b80 <myproc>
  if(growproc(n) < 0)
8010623e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106241:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106243:	ff 75 f4             	pushl  -0xc(%ebp)
80106246:	e8 55 da ff ff       	call   80103ca0 <growproc>
8010624b:	83 c4 10             	add    $0x10,%esp
8010624e:	85 c0                	test   %eax,%eax
80106250:	78 0e                	js     80106260 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106252:	89 d8                	mov    %ebx,%eax
80106254:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106257:	c9                   	leave  
80106258:	c3                   	ret    
80106259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106260:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106265:	eb eb                	jmp    80106252 <sys_sbrk+0x32>
80106267:	89 f6                	mov    %esi,%esi
80106269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106270 <sys_sleep>:

int
sys_sleep(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106274:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106277:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010627a:	50                   	push   %eax
8010627b:	6a 00                	push   $0x0
8010627d:	e8 ce f1 ff ff       	call   80105450 <argint>
80106282:	83 c4 10             	add    $0x10,%esp
80106285:	85 c0                	test   %eax,%eax
80106287:	0f 88 8a 00 00 00    	js     80106317 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010628d:	83 ec 0c             	sub    $0xc,%esp
80106290:	68 40 64 11 80       	push   $0x80116440
80106295:	e8 a6 ed ff ff       	call   80105040 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010629a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010629d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801062a0:	8b 1d 80 6c 11 80    	mov    0x80116c80,%ebx
  while(ticks - ticks0 < n){
801062a6:	85 d2                	test   %edx,%edx
801062a8:	75 27                	jne    801062d1 <sys_sleep+0x61>
801062aa:	eb 54                	jmp    80106300 <sys_sleep+0x90>
801062ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801062b0:	83 ec 08             	sub    $0x8,%esp
801062b3:	68 40 64 11 80       	push   $0x80116440
801062b8:	68 80 6c 11 80       	push   $0x80116c80
801062bd:	e8 be dd ff ff       	call   80104080 <sleep>
  while(ticks - ticks0 < n){
801062c2:	a1 80 6c 11 80       	mov    0x80116c80,%eax
801062c7:	83 c4 10             	add    $0x10,%esp
801062ca:	29 d8                	sub    %ebx,%eax
801062cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801062cf:	73 2f                	jae    80106300 <sys_sleep+0x90>
    if(myproc()->killed){
801062d1:	e8 aa d8 ff ff       	call   80103b80 <myproc>
801062d6:	8b 40 24             	mov    0x24(%eax),%eax
801062d9:	85 c0                	test   %eax,%eax
801062db:	74 d3                	je     801062b0 <sys_sleep+0x40>
      release(&tickslock);
801062dd:	83 ec 0c             	sub    $0xc,%esp
801062e0:	68 40 64 11 80       	push   $0x80116440
801062e5:	e8 16 ee ff ff       	call   80105100 <release>
      return -1;
801062ea:	83 c4 10             	add    $0x10,%esp
801062ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801062f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062f5:	c9                   	leave  
801062f6:	c3                   	ret    
801062f7:	89 f6                	mov    %esi,%esi
801062f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106300:	83 ec 0c             	sub    $0xc,%esp
80106303:	68 40 64 11 80       	push   $0x80116440
80106308:	e8 f3 ed ff ff       	call   80105100 <release>
  return 0;
8010630d:	83 c4 10             	add    $0x10,%esp
80106310:	31 c0                	xor    %eax,%eax
}
80106312:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106315:	c9                   	leave  
80106316:	c3                   	ret    
    return -1;
80106317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631c:	eb f4                	jmp    80106312 <sys_sleep+0xa2>
8010631e:	66 90                	xchg   %ax,%ax

80106320 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106320:	55                   	push   %ebp
80106321:	89 e5                	mov    %esp,%ebp
80106323:	53                   	push   %ebx
80106324:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106327:	68 40 64 11 80       	push   $0x80116440
8010632c:	e8 0f ed ff ff       	call   80105040 <acquire>
  xticks = ticks;
80106331:	8b 1d 80 6c 11 80    	mov    0x80116c80,%ebx
  release(&tickslock);
80106337:	c7 04 24 40 64 11 80 	movl   $0x80116440,(%esp)
8010633e:	e8 bd ed ff ff       	call   80105100 <release>
  return xticks;
}
80106343:	89 d8                	mov    %ebx,%eax
80106345:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106348:	c9                   	leave  
80106349:	c3                   	ret    
8010634a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106350 <sys_incNum>:

int
sys_incNum(int num)
{
80106350:	55                   	push   %ebp
80106351:	89 e5                	mov    %esp,%ebp
80106353:	83 ec 10             	sub    $0x10,%esp
  num++;
80106356:	8b 45 08             	mov    0x8(%ebp),%eax
80106359:	83 c0 01             	add    $0x1,%eax
  cprintf("increased and print in kernel surface %d\n",num);
8010635c:	50                   	push   %eax
8010635d:	68 18 86 10 80       	push   $0x80108618
80106362:	e8 f9 a2 ff ff       	call   80100660 <cprintf>
  return 22;
}
80106367:	b8 16 00 00 00       	mov    $0x16,%eax
8010636c:	c9                   	leave  
8010636d:	c3                   	ret    
8010636e:	66 90                	xchg   %ax,%ax

80106370 <sys_getprocs>:

int
sys_getprocs()
{
80106370:	55                   	push   %ebp
80106371:	89 e5                	mov    %esp,%ebp
  return getprocs();
}
80106373:	5d                   	pop    %ebp
  return getprocs();
80106374:	e9 37 e1 ff ff       	jmp    801044b0 <getprocs>
80106379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106380 <sys_set_burst_time>:

void sys_set_burst_time()
{
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	83 ec 20             	sub    $0x20,%esp
  int burst_time;
  argint(0, &burst_time);
80106386:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106389:	50                   	push   %eax
8010638a:	6a 00                	push   $0x0
8010638c:	e8 bf f0 ff ff       	call   80105450 <argint>
  int pid;
  argint(1, &pid);
80106391:	58                   	pop    %eax
80106392:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106395:	5a                   	pop    %edx
80106396:	50                   	push   %eax
80106397:	6a 01                	push   $0x1
80106399:	e8 b2 f0 ff ff       	call   80105450 <argint>
  find_and_set_burst_time(burst_time , pid);
8010639e:	59                   	pop    %ecx
8010639f:	58                   	pop    %eax
801063a0:	ff 75 f4             	pushl  -0xc(%ebp)
801063a3:	ff 75 f0             	pushl  -0x10(%ebp)
801063a6:	e8 95 e3 ff ff       	call   80104740 <find_and_set_burst_time>
}
801063ab:	83 c4 10             	add    $0x10,%esp
801063ae:	c9                   	leave  
801063af:	c3                   	ret    

801063b0 <sys_set_priority>:
void sys_set_priority()
{
801063b0:	55                   	push   %ebp
801063b1:	89 e5                	mov    %esp,%ebp
801063b3:	83 ec 20             	sub    $0x20,%esp
  int priority;
  argint(0, &priority);
801063b6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063b9:	50                   	push   %eax
801063ba:	6a 00                	push   $0x0
801063bc:	e8 8f f0 ff ff       	call   80105450 <argint>
  int pid;
  argint(1, &pid);
801063c1:	58                   	pop    %eax
801063c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063c5:	5a                   	pop    %edx
801063c6:	50                   	push   %eax
801063c7:	6a 01                	push   $0x1
801063c9:	e8 82 f0 ff ff       	call   80105450 <argint>
  find_and_set_priority(priority, pid);
801063ce:	59                   	pop    %ecx
801063cf:	58                   	pop    %eax
801063d0:	ff 75 f4             	pushl  -0xc(%ebp)
801063d3:	ff 75 f0             	pushl  -0x10(%ebp)
801063d6:	e8 d5 e2 ff ff       	call   801046b0 <find_and_set_priority>
}
801063db:	83 c4 10             	add    $0x10,%esp
801063de:	c9                   	leave  
801063df:	c3                   	ret    

801063e0 <sys_set_lottery_ticket>:

void sys_set_lottery_ticket(){
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 20             	sub    $0x20,%esp
  int lottery_ticket;
  argint(0, &lottery_ticket);
801063e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063e9:	50                   	push   %eax
801063ea:	6a 00                	push   $0x0
801063ec:	e8 5f f0 ff ff       	call   80105450 <argint>
  int pid;
  argint(1, &pid);
801063f1:	58                   	pop    %eax
801063f2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063f5:	5a                   	pop    %edx
801063f6:	50                   	push   %eax
801063f7:	6a 01                	push   $0x1
801063f9:	e8 52 f0 ff ff       	call   80105450 <argint>
  find_and_set_lottery_ticket(lottery_ticket , pid);
801063fe:	59                   	pop    %ecx
801063ff:	58                   	pop    %eax
80106400:	ff 75 f4             	pushl  -0xc(%ebp)
80106403:	ff 75 f0             	pushl  -0x10(%ebp)
80106406:	e8 d5 e2 ff ff       	call   801046e0 <find_and_set_lottery_ticket>
}
8010640b:	83 c4 10             	add    $0x10,%esp
8010640e:	c9                   	leave  
8010640f:	c3                   	ret    

80106410 <sys_set_sched_queue>:

void sys_set_sched_queue()
{
80106410:	55                   	push   %ebp
80106411:	89 e5                	mov    %esp,%ebp
80106413:	83 ec 20             	sub    $0x20,%esp
  int qeue_number;
  argint(0, &qeue_number);
80106416:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106419:	50                   	push   %eax
8010641a:	6a 00                	push   $0x0
8010641c:	e8 2f f0 ff ff       	call   80105450 <argint>
  int pid;
  argint(1, &pid);
80106421:	58                   	pop    %eax
80106422:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106425:	5a                   	pop    %edx
80106426:	50                   	push   %eax
80106427:	6a 01                	push   $0x1
80106429:	e8 22 f0 ff ff       	call   80105450 <argint>
  find_and_set_sched_queue(qeue_number, pid);
8010642e:	59                   	pop    %ecx
8010642f:	58                   	pop    %eax
80106430:	ff 75 f4             	pushl  -0xc(%ebp)
80106433:	ff 75 f0             	pushl  -0x10(%ebp)
80106436:	e8 d5 e2 ff ff       	call   80104710 <find_and_set_sched_queue>
}
8010643b:	83 c4 10             	add    $0x10,%esp
8010643e:	c9                   	leave  
8010643f:	c3                   	ret    

80106440 <sys_show_processes_scheduling>:

void sys_show_processes_scheduling()
{
80106440:	55                   	push   %ebp
80106441:	89 e5                	mov    %esp,%ebp
  show_all_processes_scheduling();
80106443:	5d                   	pop    %ebp
  show_all_processes_scheduling();
80106444:	e9 27 e4 ff ff       	jmp    80104870 <show_all_processes_scheduling>

80106449 <alltraps>:
80106449:	1e                   	push   %ds
8010644a:	06                   	push   %es
8010644b:	0f a0                	push   %fs
8010644d:	0f a8                	push   %gs
8010644f:	60                   	pusha  
80106450:	66 b8 10 00          	mov    $0x10,%ax
80106454:	8e d8                	mov    %eax,%ds
80106456:	8e c0                	mov    %eax,%es
80106458:	54                   	push   %esp
80106459:	e8 c2 00 00 00       	call   80106520 <trap>
8010645e:	83 c4 04             	add    $0x4,%esp

80106461 <trapret>:
80106461:	61                   	popa   
80106462:	0f a9                	pop    %gs
80106464:	0f a1                	pop    %fs
80106466:	07                   	pop    %es
80106467:	1f                   	pop    %ds
80106468:	83 c4 08             	add    $0x8,%esp
8010646b:	cf                   	iret   
8010646c:	66 90                	xchg   %ax,%ax
8010646e:	66 90                	xchg   %ax,%ax

80106470 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106470:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106471:	31 c0                	xor    %eax,%eax
{
80106473:	89 e5                	mov    %esp,%ebp
80106475:	83 ec 08             	sub    $0x8,%esp
80106478:	90                   	nop
80106479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106480:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106487:	c7 04 c5 82 64 11 80 	movl   $0x8e000008,-0x7fee9b7e(,%eax,8)
8010648e:	08 00 00 8e 
80106492:	66 89 14 c5 80 64 11 	mov    %dx,-0x7fee9b80(,%eax,8)
80106499:	80 
8010649a:	c1 ea 10             	shr    $0x10,%edx
8010649d:	66 89 14 c5 86 64 11 	mov    %dx,-0x7fee9b7a(,%eax,8)
801064a4:	80 
  for(i = 0; i < 256; i++)
801064a5:	83 c0 01             	add    $0x1,%eax
801064a8:	3d 00 01 00 00       	cmp    $0x100,%eax
801064ad:	75 d1                	jne    80106480 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801064af:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
801064b4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801064b7:	c7 05 82 66 11 80 08 	movl   $0xef000008,0x80116682
801064be:	00 00 ef 
  initlock(&tickslock, "time");
801064c1:	68 42 86 10 80       	push   $0x80108642
801064c6:	68 40 64 11 80       	push   $0x80116440
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801064cb:	66 a3 80 66 11 80    	mov    %ax,0x80116680
801064d1:	c1 e8 10             	shr    $0x10,%eax
801064d4:	66 a3 86 66 11 80    	mov    %ax,0x80116686
  initlock(&tickslock, "time");
801064da:	e8 21 ea ff ff       	call   80104f00 <initlock>
}
801064df:	83 c4 10             	add    $0x10,%esp
801064e2:	c9                   	leave  
801064e3:	c3                   	ret    
801064e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801064ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801064f0 <idtinit>:

void
idtinit(void)
{
801064f0:	55                   	push   %ebp
  pd[0] = size-1;
801064f1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801064f6:	89 e5                	mov    %esp,%ebp
801064f8:	83 ec 10             	sub    $0x10,%esp
801064fb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801064ff:	b8 80 64 11 80       	mov    $0x80116480,%eax
80106504:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106508:	c1 e8 10             	shr    $0x10,%eax
8010650b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010650f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106512:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106515:	c9                   	leave  
80106516:	c3                   	ret    
80106517:	89 f6                	mov    %esi,%esi
80106519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106520 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106520:	55                   	push   %ebp
80106521:	89 e5                	mov    %esp,%ebp
80106523:	57                   	push   %edi
80106524:	56                   	push   %esi
80106525:	53                   	push   %ebx
80106526:	83 ec 1c             	sub    $0x1c,%esp
80106529:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010652c:	8b 47 30             	mov    0x30(%edi),%eax
8010652f:	83 f8 40             	cmp    $0x40,%eax
80106532:	0f 84 f0 00 00 00    	je     80106628 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106538:	83 e8 20             	sub    $0x20,%eax
8010653b:	83 f8 1f             	cmp    $0x1f,%eax
8010653e:	77 10                	ja     80106550 <trap+0x30>
80106540:	ff 24 85 e8 86 10 80 	jmp    *-0x7fef7918(,%eax,4)
80106547:	89 f6                	mov    %esi,%esi
80106549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106550:	e8 2b d6 ff ff       	call   80103b80 <myproc>
80106555:	85 c0                	test   %eax,%eax
80106557:	8b 5f 38             	mov    0x38(%edi),%ebx
8010655a:	0f 84 14 02 00 00    	je     80106774 <trap+0x254>
80106560:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106564:	0f 84 0a 02 00 00    	je     80106774 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010656a:	0f 20 d1             	mov    %cr2,%ecx
8010656d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106570:	e8 eb d5 ff ff       	call   80103b60 <cpuid>
80106575:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106578:	8b 47 34             	mov    0x34(%edi),%eax
8010657b:	8b 77 30             	mov    0x30(%edi),%esi
8010657e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106581:	e8 fa d5 ff ff       	call   80103b80 <myproc>
80106586:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106589:	e8 f2 d5 ff ff       	call   80103b80 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010658e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106591:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106594:	51                   	push   %ecx
80106595:	53                   	push   %ebx
80106596:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106597:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010659a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010659d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010659e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065a1:	52                   	push   %edx
801065a2:	ff 70 10             	pushl  0x10(%eax)
801065a5:	68 a4 86 10 80       	push   $0x801086a4
801065aa:	e8 b1 a0 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801065af:	83 c4 20             	add    $0x20,%esp
801065b2:	e8 c9 d5 ff ff       	call   80103b80 <myproc>
801065b7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065be:	e8 bd d5 ff ff       	call   80103b80 <myproc>
801065c3:	85 c0                	test   %eax,%eax
801065c5:	74 1d                	je     801065e4 <trap+0xc4>
801065c7:	e8 b4 d5 ff ff       	call   80103b80 <myproc>
801065cc:	8b 50 24             	mov    0x24(%eax),%edx
801065cf:	85 d2                	test   %edx,%edx
801065d1:	74 11                	je     801065e4 <trap+0xc4>
801065d3:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801065d7:	83 e0 03             	and    $0x3,%eax
801065da:	66 83 f8 03          	cmp    $0x3,%ax
801065de:	0f 84 4c 01 00 00    	je     80106730 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801065e4:	e8 97 d5 ff ff       	call   80103b80 <myproc>
801065e9:	85 c0                	test   %eax,%eax
801065eb:	74 0b                	je     801065f8 <trap+0xd8>
801065ed:	e8 8e d5 ff ff       	call   80103b80 <myproc>
801065f2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801065f6:	74 68                	je     80106660 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065f8:	e8 83 d5 ff ff       	call   80103b80 <myproc>
801065fd:	85 c0                	test   %eax,%eax
801065ff:	74 19                	je     8010661a <trap+0xfa>
80106601:	e8 7a d5 ff ff       	call   80103b80 <myproc>
80106606:	8b 40 24             	mov    0x24(%eax),%eax
80106609:	85 c0                	test   %eax,%eax
8010660b:	74 0d                	je     8010661a <trap+0xfa>
8010660d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106611:	83 e0 03             	and    $0x3,%eax
80106614:	66 83 f8 03          	cmp    $0x3,%ax
80106618:	74 37                	je     80106651 <trap+0x131>
    exit();
}
8010661a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010661d:	5b                   	pop    %ebx
8010661e:	5e                   	pop    %esi
8010661f:	5f                   	pop    %edi
80106620:	5d                   	pop    %ebp
80106621:	c3                   	ret    
80106622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80106628:	e8 53 d5 ff ff       	call   80103b80 <myproc>
8010662d:	8b 58 24             	mov    0x24(%eax),%ebx
80106630:	85 db                	test   %ebx,%ebx
80106632:	0f 85 e8 00 00 00    	jne    80106720 <trap+0x200>
    myproc()->tf = tf;
80106638:	e8 43 d5 ff ff       	call   80103b80 <myproc>
8010663d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106640:	e8 fb ee ff ff       	call   80105540 <syscall>
    if(myproc()->killed)
80106645:	e8 36 d5 ff ff       	call   80103b80 <myproc>
8010664a:	8b 48 24             	mov    0x24(%eax),%ecx
8010664d:	85 c9                	test   %ecx,%ecx
8010664f:	74 c9                	je     8010661a <trap+0xfa>
}
80106651:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106654:	5b                   	pop    %ebx
80106655:	5e                   	pop    %esi
80106656:	5f                   	pop    %edi
80106657:	5d                   	pop    %ebp
      exit();
80106658:	e9 a3 d8 ff ff       	jmp    80103f00 <exit>
8010665d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106660:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106664:	75 92                	jne    801065f8 <trap+0xd8>
    yield();
80106666:	e8 c5 d9 ff ff       	call   80104030 <yield>
8010666b:	eb 8b                	jmp    801065f8 <trap+0xd8>
8010666d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106670:	e8 eb d4 ff ff       	call   80103b60 <cpuid>
80106675:	85 c0                	test   %eax,%eax
80106677:	0f 84 c3 00 00 00    	je     80106740 <trap+0x220>
    lapiceoi();
8010667d:	e8 3e c4 ff ff       	call   80102ac0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106682:	e8 f9 d4 ff ff       	call   80103b80 <myproc>
80106687:	85 c0                	test   %eax,%eax
80106689:	0f 85 38 ff ff ff    	jne    801065c7 <trap+0xa7>
8010668f:	e9 50 ff ff ff       	jmp    801065e4 <trap+0xc4>
80106694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106698:	e8 e3 c2 ff ff       	call   80102980 <kbdintr>
    lapiceoi();
8010669d:	e8 1e c4 ff ff       	call   80102ac0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066a2:	e8 d9 d4 ff ff       	call   80103b80 <myproc>
801066a7:	85 c0                	test   %eax,%eax
801066a9:	0f 85 18 ff ff ff    	jne    801065c7 <trap+0xa7>
801066af:	e9 30 ff ff ff       	jmp    801065e4 <trap+0xc4>
801066b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801066b8:	e8 53 02 00 00       	call   80106910 <uartintr>
    lapiceoi();
801066bd:	e8 fe c3 ff ff       	call   80102ac0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066c2:	e8 b9 d4 ff ff       	call   80103b80 <myproc>
801066c7:	85 c0                	test   %eax,%eax
801066c9:	0f 85 f8 fe ff ff    	jne    801065c7 <trap+0xa7>
801066cf:	e9 10 ff ff ff       	jmp    801065e4 <trap+0xc4>
801066d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801066d8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
801066dc:	8b 77 38             	mov    0x38(%edi),%esi
801066df:	e8 7c d4 ff ff       	call   80103b60 <cpuid>
801066e4:	56                   	push   %esi
801066e5:	53                   	push   %ebx
801066e6:	50                   	push   %eax
801066e7:	68 4c 86 10 80       	push   $0x8010864c
801066ec:	e8 6f 9f ff ff       	call   80100660 <cprintf>
    lapiceoi();
801066f1:	e8 ca c3 ff ff       	call   80102ac0 <lapiceoi>
    break;
801066f6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066f9:	e8 82 d4 ff ff       	call   80103b80 <myproc>
801066fe:	85 c0                	test   %eax,%eax
80106700:	0f 85 c1 fe ff ff    	jne    801065c7 <trap+0xa7>
80106706:	e9 d9 fe ff ff       	jmp    801065e4 <trap+0xc4>
8010670b:	90                   	nop
8010670c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106710:	e8 db bc ff ff       	call   801023f0 <ideintr>
80106715:	e9 63 ff ff ff       	jmp    8010667d <trap+0x15d>
8010671a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106720:	e8 db d7 ff ff       	call   80103f00 <exit>
80106725:	e9 0e ff ff ff       	jmp    80106638 <trap+0x118>
8010672a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106730:	e8 cb d7 ff ff       	call   80103f00 <exit>
80106735:	e9 aa fe ff ff       	jmp    801065e4 <trap+0xc4>
8010673a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106740:	83 ec 0c             	sub    $0xc,%esp
80106743:	68 40 64 11 80       	push   $0x80116440
80106748:	e8 f3 e8 ff ff       	call   80105040 <acquire>
      wakeup(&ticks);
8010674d:	c7 04 24 80 6c 11 80 	movl   $0x80116c80,(%esp)
      ticks++;
80106754:	83 05 80 6c 11 80 01 	addl   $0x1,0x80116c80
      wakeup(&ticks);
8010675b:	e8 e0 da ff ff       	call   80104240 <wakeup>
      release(&tickslock);
80106760:	c7 04 24 40 64 11 80 	movl   $0x80116440,(%esp)
80106767:	e8 94 e9 ff ff       	call   80105100 <release>
8010676c:	83 c4 10             	add    $0x10,%esp
8010676f:	e9 09 ff ff ff       	jmp    8010667d <trap+0x15d>
80106774:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106777:	e8 e4 d3 ff ff       	call   80103b60 <cpuid>
8010677c:	83 ec 0c             	sub    $0xc,%esp
8010677f:	56                   	push   %esi
80106780:	53                   	push   %ebx
80106781:	50                   	push   %eax
80106782:	ff 77 30             	pushl  0x30(%edi)
80106785:	68 70 86 10 80       	push   $0x80108670
8010678a:	e8 d1 9e ff ff       	call   80100660 <cprintf>
      panic("trap");
8010678f:	83 c4 14             	add    $0x14,%esp
80106792:	68 47 86 10 80       	push   $0x80108647
80106797:	e8 f4 9b ff ff       	call   80100390 <panic>
8010679c:	66 90                	xchg   %ax,%ax
8010679e:	66 90                	xchg   %ax,%ax

801067a0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801067a0:	a1 fc b5 10 80       	mov    0x8010b5fc,%eax
{
801067a5:	55                   	push   %ebp
801067a6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801067a8:	85 c0                	test   %eax,%eax
801067aa:	74 1c                	je     801067c8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067ac:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067b1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801067b2:	a8 01                	test   $0x1,%al
801067b4:	74 12                	je     801067c8 <uartgetc+0x28>
801067b6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067bb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801067bc:	0f b6 c0             	movzbl %al,%eax
}
801067bf:	5d                   	pop    %ebp
801067c0:	c3                   	ret    
801067c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801067c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067cd:	5d                   	pop    %ebp
801067ce:	c3                   	ret    
801067cf:	90                   	nop

801067d0 <uartputc.part.0>:
uartputc(int c)
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	57                   	push   %edi
801067d4:	56                   	push   %esi
801067d5:	53                   	push   %ebx
801067d6:	89 c7                	mov    %eax,%edi
801067d8:	bb 80 00 00 00       	mov    $0x80,%ebx
801067dd:	be fd 03 00 00       	mov    $0x3fd,%esi
801067e2:	83 ec 0c             	sub    $0xc,%esp
801067e5:	eb 1b                	jmp    80106802 <uartputc.part.0+0x32>
801067e7:	89 f6                	mov    %esi,%esi
801067e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801067f0:	83 ec 0c             	sub    $0xc,%esp
801067f3:	6a 0a                	push   $0xa
801067f5:	e8 e6 c2 ff ff       	call   80102ae0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067fa:	83 c4 10             	add    $0x10,%esp
801067fd:	83 eb 01             	sub    $0x1,%ebx
80106800:	74 07                	je     80106809 <uartputc.part.0+0x39>
80106802:	89 f2                	mov    %esi,%edx
80106804:	ec                   	in     (%dx),%al
80106805:	a8 20                	test   $0x20,%al
80106807:	74 e7                	je     801067f0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106809:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010680e:	89 f8                	mov    %edi,%eax
80106810:	ee                   	out    %al,(%dx)
}
80106811:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106814:	5b                   	pop    %ebx
80106815:	5e                   	pop    %esi
80106816:	5f                   	pop    %edi
80106817:	5d                   	pop    %ebp
80106818:	c3                   	ret    
80106819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106820 <uartinit>:
{
80106820:	55                   	push   %ebp
80106821:	31 c9                	xor    %ecx,%ecx
80106823:	89 c8                	mov    %ecx,%eax
80106825:	89 e5                	mov    %esp,%ebp
80106827:	57                   	push   %edi
80106828:	56                   	push   %esi
80106829:	53                   	push   %ebx
8010682a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010682f:	89 da                	mov    %ebx,%edx
80106831:	83 ec 0c             	sub    $0xc,%esp
80106834:	ee                   	out    %al,(%dx)
80106835:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010683a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010683f:	89 fa                	mov    %edi,%edx
80106841:	ee                   	out    %al,(%dx)
80106842:	b8 0c 00 00 00       	mov    $0xc,%eax
80106847:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010684c:	ee                   	out    %al,(%dx)
8010684d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106852:	89 c8                	mov    %ecx,%eax
80106854:	89 f2                	mov    %esi,%edx
80106856:	ee                   	out    %al,(%dx)
80106857:	b8 03 00 00 00       	mov    $0x3,%eax
8010685c:	89 fa                	mov    %edi,%edx
8010685e:	ee                   	out    %al,(%dx)
8010685f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106864:	89 c8                	mov    %ecx,%eax
80106866:	ee                   	out    %al,(%dx)
80106867:	b8 01 00 00 00       	mov    $0x1,%eax
8010686c:	89 f2                	mov    %esi,%edx
8010686e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010686f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106874:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106875:	3c ff                	cmp    $0xff,%al
80106877:	74 5a                	je     801068d3 <uartinit+0xb3>
  uart = 1;
80106879:	c7 05 fc b5 10 80 01 	movl   $0x1,0x8010b5fc
80106880:	00 00 00 
80106883:	89 da                	mov    %ebx,%edx
80106885:	ec                   	in     (%dx),%al
80106886:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010688b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010688c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010688f:	bb 68 87 10 80       	mov    $0x80108768,%ebx
  ioapicenable(IRQ_COM1, 0);
80106894:	6a 00                	push   $0x0
80106896:	6a 04                	push   $0x4
80106898:	e8 a3 bd ff ff       	call   80102640 <ioapicenable>
8010689d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801068a0:	b8 78 00 00 00       	mov    $0x78,%eax
801068a5:	eb 13                	jmp    801068ba <uartinit+0x9a>
801068a7:	89 f6                	mov    %esi,%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801068b0:	83 c3 01             	add    $0x1,%ebx
801068b3:	0f be 03             	movsbl (%ebx),%eax
801068b6:	84 c0                	test   %al,%al
801068b8:	74 19                	je     801068d3 <uartinit+0xb3>
  if(!uart)
801068ba:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
801068c0:	85 d2                	test   %edx,%edx
801068c2:	74 ec                	je     801068b0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801068c4:	83 c3 01             	add    $0x1,%ebx
801068c7:	e8 04 ff ff ff       	call   801067d0 <uartputc.part.0>
801068cc:	0f be 03             	movsbl (%ebx),%eax
801068cf:	84 c0                	test   %al,%al
801068d1:	75 e7                	jne    801068ba <uartinit+0x9a>
}
801068d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068d6:	5b                   	pop    %ebx
801068d7:	5e                   	pop    %esi
801068d8:	5f                   	pop    %edi
801068d9:	5d                   	pop    %ebp
801068da:	c3                   	ret    
801068db:	90                   	nop
801068dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068e0 <uartputc>:
  if(!uart)
801068e0:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
{
801068e6:	55                   	push   %ebp
801068e7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801068e9:	85 d2                	test   %edx,%edx
{
801068eb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801068ee:	74 10                	je     80106900 <uartputc+0x20>
}
801068f0:	5d                   	pop    %ebp
801068f1:	e9 da fe ff ff       	jmp    801067d0 <uartputc.part.0>
801068f6:	8d 76 00             	lea    0x0(%esi),%esi
801068f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106900:	5d                   	pop    %ebp
80106901:	c3                   	ret    
80106902:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106910 <uartintr>:

void
uartintr(void)
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106916:	68 a0 67 10 80       	push   $0x801067a0
8010691b:	e8 c0 a1 ff ff       	call   80100ae0 <consoleintr>
}
80106920:	83 c4 10             	add    $0x10,%esp
80106923:	c9                   	leave  
80106924:	c3                   	ret    

80106925 <vector0>:
80106925:	6a 00                	push   $0x0
80106927:	6a 00                	push   $0x0
80106929:	e9 1b fb ff ff       	jmp    80106449 <alltraps>

8010692e <vector1>:
8010692e:	6a 00                	push   $0x0
80106930:	6a 01                	push   $0x1
80106932:	e9 12 fb ff ff       	jmp    80106449 <alltraps>

80106937 <vector2>:
80106937:	6a 00                	push   $0x0
80106939:	6a 02                	push   $0x2
8010693b:	e9 09 fb ff ff       	jmp    80106449 <alltraps>

80106940 <vector3>:
80106940:	6a 00                	push   $0x0
80106942:	6a 03                	push   $0x3
80106944:	e9 00 fb ff ff       	jmp    80106449 <alltraps>

80106949 <vector4>:
80106949:	6a 00                	push   $0x0
8010694b:	6a 04                	push   $0x4
8010694d:	e9 f7 fa ff ff       	jmp    80106449 <alltraps>

80106952 <vector5>:
80106952:	6a 00                	push   $0x0
80106954:	6a 05                	push   $0x5
80106956:	e9 ee fa ff ff       	jmp    80106449 <alltraps>

8010695b <vector6>:
8010695b:	6a 00                	push   $0x0
8010695d:	6a 06                	push   $0x6
8010695f:	e9 e5 fa ff ff       	jmp    80106449 <alltraps>

80106964 <vector7>:
80106964:	6a 00                	push   $0x0
80106966:	6a 07                	push   $0x7
80106968:	e9 dc fa ff ff       	jmp    80106449 <alltraps>

8010696d <vector8>:
8010696d:	6a 08                	push   $0x8
8010696f:	e9 d5 fa ff ff       	jmp    80106449 <alltraps>

80106974 <vector9>:
80106974:	6a 00                	push   $0x0
80106976:	6a 09                	push   $0x9
80106978:	e9 cc fa ff ff       	jmp    80106449 <alltraps>

8010697d <vector10>:
8010697d:	6a 0a                	push   $0xa
8010697f:	e9 c5 fa ff ff       	jmp    80106449 <alltraps>

80106984 <vector11>:
80106984:	6a 0b                	push   $0xb
80106986:	e9 be fa ff ff       	jmp    80106449 <alltraps>

8010698b <vector12>:
8010698b:	6a 0c                	push   $0xc
8010698d:	e9 b7 fa ff ff       	jmp    80106449 <alltraps>

80106992 <vector13>:
80106992:	6a 0d                	push   $0xd
80106994:	e9 b0 fa ff ff       	jmp    80106449 <alltraps>

80106999 <vector14>:
80106999:	6a 0e                	push   $0xe
8010699b:	e9 a9 fa ff ff       	jmp    80106449 <alltraps>

801069a0 <vector15>:
801069a0:	6a 00                	push   $0x0
801069a2:	6a 0f                	push   $0xf
801069a4:	e9 a0 fa ff ff       	jmp    80106449 <alltraps>

801069a9 <vector16>:
801069a9:	6a 00                	push   $0x0
801069ab:	6a 10                	push   $0x10
801069ad:	e9 97 fa ff ff       	jmp    80106449 <alltraps>

801069b2 <vector17>:
801069b2:	6a 11                	push   $0x11
801069b4:	e9 90 fa ff ff       	jmp    80106449 <alltraps>

801069b9 <vector18>:
801069b9:	6a 00                	push   $0x0
801069bb:	6a 12                	push   $0x12
801069bd:	e9 87 fa ff ff       	jmp    80106449 <alltraps>

801069c2 <vector19>:
801069c2:	6a 00                	push   $0x0
801069c4:	6a 13                	push   $0x13
801069c6:	e9 7e fa ff ff       	jmp    80106449 <alltraps>

801069cb <vector20>:
801069cb:	6a 00                	push   $0x0
801069cd:	6a 14                	push   $0x14
801069cf:	e9 75 fa ff ff       	jmp    80106449 <alltraps>

801069d4 <vector21>:
801069d4:	6a 00                	push   $0x0
801069d6:	6a 15                	push   $0x15
801069d8:	e9 6c fa ff ff       	jmp    80106449 <alltraps>

801069dd <vector22>:
801069dd:	6a 00                	push   $0x0
801069df:	6a 16                	push   $0x16
801069e1:	e9 63 fa ff ff       	jmp    80106449 <alltraps>

801069e6 <vector23>:
801069e6:	6a 00                	push   $0x0
801069e8:	6a 17                	push   $0x17
801069ea:	e9 5a fa ff ff       	jmp    80106449 <alltraps>

801069ef <vector24>:
801069ef:	6a 00                	push   $0x0
801069f1:	6a 18                	push   $0x18
801069f3:	e9 51 fa ff ff       	jmp    80106449 <alltraps>

801069f8 <vector25>:
801069f8:	6a 00                	push   $0x0
801069fa:	6a 19                	push   $0x19
801069fc:	e9 48 fa ff ff       	jmp    80106449 <alltraps>

80106a01 <vector26>:
80106a01:	6a 00                	push   $0x0
80106a03:	6a 1a                	push   $0x1a
80106a05:	e9 3f fa ff ff       	jmp    80106449 <alltraps>

80106a0a <vector27>:
80106a0a:	6a 00                	push   $0x0
80106a0c:	6a 1b                	push   $0x1b
80106a0e:	e9 36 fa ff ff       	jmp    80106449 <alltraps>

80106a13 <vector28>:
80106a13:	6a 00                	push   $0x0
80106a15:	6a 1c                	push   $0x1c
80106a17:	e9 2d fa ff ff       	jmp    80106449 <alltraps>

80106a1c <vector29>:
80106a1c:	6a 00                	push   $0x0
80106a1e:	6a 1d                	push   $0x1d
80106a20:	e9 24 fa ff ff       	jmp    80106449 <alltraps>

80106a25 <vector30>:
80106a25:	6a 00                	push   $0x0
80106a27:	6a 1e                	push   $0x1e
80106a29:	e9 1b fa ff ff       	jmp    80106449 <alltraps>

80106a2e <vector31>:
80106a2e:	6a 00                	push   $0x0
80106a30:	6a 1f                	push   $0x1f
80106a32:	e9 12 fa ff ff       	jmp    80106449 <alltraps>

80106a37 <vector32>:
80106a37:	6a 00                	push   $0x0
80106a39:	6a 20                	push   $0x20
80106a3b:	e9 09 fa ff ff       	jmp    80106449 <alltraps>

80106a40 <vector33>:
80106a40:	6a 00                	push   $0x0
80106a42:	6a 21                	push   $0x21
80106a44:	e9 00 fa ff ff       	jmp    80106449 <alltraps>

80106a49 <vector34>:
80106a49:	6a 00                	push   $0x0
80106a4b:	6a 22                	push   $0x22
80106a4d:	e9 f7 f9 ff ff       	jmp    80106449 <alltraps>

80106a52 <vector35>:
80106a52:	6a 00                	push   $0x0
80106a54:	6a 23                	push   $0x23
80106a56:	e9 ee f9 ff ff       	jmp    80106449 <alltraps>

80106a5b <vector36>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	6a 24                	push   $0x24
80106a5f:	e9 e5 f9 ff ff       	jmp    80106449 <alltraps>

80106a64 <vector37>:
80106a64:	6a 00                	push   $0x0
80106a66:	6a 25                	push   $0x25
80106a68:	e9 dc f9 ff ff       	jmp    80106449 <alltraps>

80106a6d <vector38>:
80106a6d:	6a 00                	push   $0x0
80106a6f:	6a 26                	push   $0x26
80106a71:	e9 d3 f9 ff ff       	jmp    80106449 <alltraps>

80106a76 <vector39>:
80106a76:	6a 00                	push   $0x0
80106a78:	6a 27                	push   $0x27
80106a7a:	e9 ca f9 ff ff       	jmp    80106449 <alltraps>

80106a7f <vector40>:
80106a7f:	6a 00                	push   $0x0
80106a81:	6a 28                	push   $0x28
80106a83:	e9 c1 f9 ff ff       	jmp    80106449 <alltraps>

80106a88 <vector41>:
80106a88:	6a 00                	push   $0x0
80106a8a:	6a 29                	push   $0x29
80106a8c:	e9 b8 f9 ff ff       	jmp    80106449 <alltraps>

80106a91 <vector42>:
80106a91:	6a 00                	push   $0x0
80106a93:	6a 2a                	push   $0x2a
80106a95:	e9 af f9 ff ff       	jmp    80106449 <alltraps>

80106a9a <vector43>:
80106a9a:	6a 00                	push   $0x0
80106a9c:	6a 2b                	push   $0x2b
80106a9e:	e9 a6 f9 ff ff       	jmp    80106449 <alltraps>

80106aa3 <vector44>:
80106aa3:	6a 00                	push   $0x0
80106aa5:	6a 2c                	push   $0x2c
80106aa7:	e9 9d f9 ff ff       	jmp    80106449 <alltraps>

80106aac <vector45>:
80106aac:	6a 00                	push   $0x0
80106aae:	6a 2d                	push   $0x2d
80106ab0:	e9 94 f9 ff ff       	jmp    80106449 <alltraps>

80106ab5 <vector46>:
80106ab5:	6a 00                	push   $0x0
80106ab7:	6a 2e                	push   $0x2e
80106ab9:	e9 8b f9 ff ff       	jmp    80106449 <alltraps>

80106abe <vector47>:
80106abe:	6a 00                	push   $0x0
80106ac0:	6a 2f                	push   $0x2f
80106ac2:	e9 82 f9 ff ff       	jmp    80106449 <alltraps>

80106ac7 <vector48>:
80106ac7:	6a 00                	push   $0x0
80106ac9:	6a 30                	push   $0x30
80106acb:	e9 79 f9 ff ff       	jmp    80106449 <alltraps>

80106ad0 <vector49>:
80106ad0:	6a 00                	push   $0x0
80106ad2:	6a 31                	push   $0x31
80106ad4:	e9 70 f9 ff ff       	jmp    80106449 <alltraps>

80106ad9 <vector50>:
80106ad9:	6a 00                	push   $0x0
80106adb:	6a 32                	push   $0x32
80106add:	e9 67 f9 ff ff       	jmp    80106449 <alltraps>

80106ae2 <vector51>:
80106ae2:	6a 00                	push   $0x0
80106ae4:	6a 33                	push   $0x33
80106ae6:	e9 5e f9 ff ff       	jmp    80106449 <alltraps>

80106aeb <vector52>:
80106aeb:	6a 00                	push   $0x0
80106aed:	6a 34                	push   $0x34
80106aef:	e9 55 f9 ff ff       	jmp    80106449 <alltraps>

80106af4 <vector53>:
80106af4:	6a 00                	push   $0x0
80106af6:	6a 35                	push   $0x35
80106af8:	e9 4c f9 ff ff       	jmp    80106449 <alltraps>

80106afd <vector54>:
80106afd:	6a 00                	push   $0x0
80106aff:	6a 36                	push   $0x36
80106b01:	e9 43 f9 ff ff       	jmp    80106449 <alltraps>

80106b06 <vector55>:
80106b06:	6a 00                	push   $0x0
80106b08:	6a 37                	push   $0x37
80106b0a:	e9 3a f9 ff ff       	jmp    80106449 <alltraps>

80106b0f <vector56>:
80106b0f:	6a 00                	push   $0x0
80106b11:	6a 38                	push   $0x38
80106b13:	e9 31 f9 ff ff       	jmp    80106449 <alltraps>

80106b18 <vector57>:
80106b18:	6a 00                	push   $0x0
80106b1a:	6a 39                	push   $0x39
80106b1c:	e9 28 f9 ff ff       	jmp    80106449 <alltraps>

80106b21 <vector58>:
80106b21:	6a 00                	push   $0x0
80106b23:	6a 3a                	push   $0x3a
80106b25:	e9 1f f9 ff ff       	jmp    80106449 <alltraps>

80106b2a <vector59>:
80106b2a:	6a 00                	push   $0x0
80106b2c:	6a 3b                	push   $0x3b
80106b2e:	e9 16 f9 ff ff       	jmp    80106449 <alltraps>

80106b33 <vector60>:
80106b33:	6a 00                	push   $0x0
80106b35:	6a 3c                	push   $0x3c
80106b37:	e9 0d f9 ff ff       	jmp    80106449 <alltraps>

80106b3c <vector61>:
80106b3c:	6a 00                	push   $0x0
80106b3e:	6a 3d                	push   $0x3d
80106b40:	e9 04 f9 ff ff       	jmp    80106449 <alltraps>

80106b45 <vector62>:
80106b45:	6a 00                	push   $0x0
80106b47:	6a 3e                	push   $0x3e
80106b49:	e9 fb f8 ff ff       	jmp    80106449 <alltraps>

80106b4e <vector63>:
80106b4e:	6a 00                	push   $0x0
80106b50:	6a 3f                	push   $0x3f
80106b52:	e9 f2 f8 ff ff       	jmp    80106449 <alltraps>

80106b57 <vector64>:
80106b57:	6a 00                	push   $0x0
80106b59:	6a 40                	push   $0x40
80106b5b:	e9 e9 f8 ff ff       	jmp    80106449 <alltraps>

80106b60 <vector65>:
80106b60:	6a 00                	push   $0x0
80106b62:	6a 41                	push   $0x41
80106b64:	e9 e0 f8 ff ff       	jmp    80106449 <alltraps>

80106b69 <vector66>:
80106b69:	6a 00                	push   $0x0
80106b6b:	6a 42                	push   $0x42
80106b6d:	e9 d7 f8 ff ff       	jmp    80106449 <alltraps>

80106b72 <vector67>:
80106b72:	6a 00                	push   $0x0
80106b74:	6a 43                	push   $0x43
80106b76:	e9 ce f8 ff ff       	jmp    80106449 <alltraps>

80106b7b <vector68>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	6a 44                	push   $0x44
80106b7f:	e9 c5 f8 ff ff       	jmp    80106449 <alltraps>

80106b84 <vector69>:
80106b84:	6a 00                	push   $0x0
80106b86:	6a 45                	push   $0x45
80106b88:	e9 bc f8 ff ff       	jmp    80106449 <alltraps>

80106b8d <vector70>:
80106b8d:	6a 00                	push   $0x0
80106b8f:	6a 46                	push   $0x46
80106b91:	e9 b3 f8 ff ff       	jmp    80106449 <alltraps>

80106b96 <vector71>:
80106b96:	6a 00                	push   $0x0
80106b98:	6a 47                	push   $0x47
80106b9a:	e9 aa f8 ff ff       	jmp    80106449 <alltraps>

80106b9f <vector72>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	6a 48                	push   $0x48
80106ba3:	e9 a1 f8 ff ff       	jmp    80106449 <alltraps>

80106ba8 <vector73>:
80106ba8:	6a 00                	push   $0x0
80106baa:	6a 49                	push   $0x49
80106bac:	e9 98 f8 ff ff       	jmp    80106449 <alltraps>

80106bb1 <vector74>:
80106bb1:	6a 00                	push   $0x0
80106bb3:	6a 4a                	push   $0x4a
80106bb5:	e9 8f f8 ff ff       	jmp    80106449 <alltraps>

80106bba <vector75>:
80106bba:	6a 00                	push   $0x0
80106bbc:	6a 4b                	push   $0x4b
80106bbe:	e9 86 f8 ff ff       	jmp    80106449 <alltraps>

80106bc3 <vector76>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	6a 4c                	push   $0x4c
80106bc7:	e9 7d f8 ff ff       	jmp    80106449 <alltraps>

80106bcc <vector77>:
80106bcc:	6a 00                	push   $0x0
80106bce:	6a 4d                	push   $0x4d
80106bd0:	e9 74 f8 ff ff       	jmp    80106449 <alltraps>

80106bd5 <vector78>:
80106bd5:	6a 00                	push   $0x0
80106bd7:	6a 4e                	push   $0x4e
80106bd9:	e9 6b f8 ff ff       	jmp    80106449 <alltraps>

80106bde <vector79>:
80106bde:	6a 00                	push   $0x0
80106be0:	6a 4f                	push   $0x4f
80106be2:	e9 62 f8 ff ff       	jmp    80106449 <alltraps>

80106be7 <vector80>:
80106be7:	6a 00                	push   $0x0
80106be9:	6a 50                	push   $0x50
80106beb:	e9 59 f8 ff ff       	jmp    80106449 <alltraps>

80106bf0 <vector81>:
80106bf0:	6a 00                	push   $0x0
80106bf2:	6a 51                	push   $0x51
80106bf4:	e9 50 f8 ff ff       	jmp    80106449 <alltraps>

80106bf9 <vector82>:
80106bf9:	6a 00                	push   $0x0
80106bfb:	6a 52                	push   $0x52
80106bfd:	e9 47 f8 ff ff       	jmp    80106449 <alltraps>

80106c02 <vector83>:
80106c02:	6a 00                	push   $0x0
80106c04:	6a 53                	push   $0x53
80106c06:	e9 3e f8 ff ff       	jmp    80106449 <alltraps>

80106c0b <vector84>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	6a 54                	push   $0x54
80106c0f:	e9 35 f8 ff ff       	jmp    80106449 <alltraps>

80106c14 <vector85>:
80106c14:	6a 00                	push   $0x0
80106c16:	6a 55                	push   $0x55
80106c18:	e9 2c f8 ff ff       	jmp    80106449 <alltraps>

80106c1d <vector86>:
80106c1d:	6a 00                	push   $0x0
80106c1f:	6a 56                	push   $0x56
80106c21:	e9 23 f8 ff ff       	jmp    80106449 <alltraps>

80106c26 <vector87>:
80106c26:	6a 00                	push   $0x0
80106c28:	6a 57                	push   $0x57
80106c2a:	e9 1a f8 ff ff       	jmp    80106449 <alltraps>

80106c2f <vector88>:
80106c2f:	6a 00                	push   $0x0
80106c31:	6a 58                	push   $0x58
80106c33:	e9 11 f8 ff ff       	jmp    80106449 <alltraps>

80106c38 <vector89>:
80106c38:	6a 00                	push   $0x0
80106c3a:	6a 59                	push   $0x59
80106c3c:	e9 08 f8 ff ff       	jmp    80106449 <alltraps>

80106c41 <vector90>:
80106c41:	6a 00                	push   $0x0
80106c43:	6a 5a                	push   $0x5a
80106c45:	e9 ff f7 ff ff       	jmp    80106449 <alltraps>

80106c4a <vector91>:
80106c4a:	6a 00                	push   $0x0
80106c4c:	6a 5b                	push   $0x5b
80106c4e:	e9 f6 f7 ff ff       	jmp    80106449 <alltraps>

80106c53 <vector92>:
80106c53:	6a 00                	push   $0x0
80106c55:	6a 5c                	push   $0x5c
80106c57:	e9 ed f7 ff ff       	jmp    80106449 <alltraps>

80106c5c <vector93>:
80106c5c:	6a 00                	push   $0x0
80106c5e:	6a 5d                	push   $0x5d
80106c60:	e9 e4 f7 ff ff       	jmp    80106449 <alltraps>

80106c65 <vector94>:
80106c65:	6a 00                	push   $0x0
80106c67:	6a 5e                	push   $0x5e
80106c69:	e9 db f7 ff ff       	jmp    80106449 <alltraps>

80106c6e <vector95>:
80106c6e:	6a 00                	push   $0x0
80106c70:	6a 5f                	push   $0x5f
80106c72:	e9 d2 f7 ff ff       	jmp    80106449 <alltraps>

80106c77 <vector96>:
80106c77:	6a 00                	push   $0x0
80106c79:	6a 60                	push   $0x60
80106c7b:	e9 c9 f7 ff ff       	jmp    80106449 <alltraps>

80106c80 <vector97>:
80106c80:	6a 00                	push   $0x0
80106c82:	6a 61                	push   $0x61
80106c84:	e9 c0 f7 ff ff       	jmp    80106449 <alltraps>

80106c89 <vector98>:
80106c89:	6a 00                	push   $0x0
80106c8b:	6a 62                	push   $0x62
80106c8d:	e9 b7 f7 ff ff       	jmp    80106449 <alltraps>

80106c92 <vector99>:
80106c92:	6a 00                	push   $0x0
80106c94:	6a 63                	push   $0x63
80106c96:	e9 ae f7 ff ff       	jmp    80106449 <alltraps>

80106c9b <vector100>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	6a 64                	push   $0x64
80106c9f:	e9 a5 f7 ff ff       	jmp    80106449 <alltraps>

80106ca4 <vector101>:
80106ca4:	6a 00                	push   $0x0
80106ca6:	6a 65                	push   $0x65
80106ca8:	e9 9c f7 ff ff       	jmp    80106449 <alltraps>

80106cad <vector102>:
80106cad:	6a 00                	push   $0x0
80106caf:	6a 66                	push   $0x66
80106cb1:	e9 93 f7 ff ff       	jmp    80106449 <alltraps>

80106cb6 <vector103>:
80106cb6:	6a 00                	push   $0x0
80106cb8:	6a 67                	push   $0x67
80106cba:	e9 8a f7 ff ff       	jmp    80106449 <alltraps>

80106cbf <vector104>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	6a 68                	push   $0x68
80106cc3:	e9 81 f7 ff ff       	jmp    80106449 <alltraps>

80106cc8 <vector105>:
80106cc8:	6a 00                	push   $0x0
80106cca:	6a 69                	push   $0x69
80106ccc:	e9 78 f7 ff ff       	jmp    80106449 <alltraps>

80106cd1 <vector106>:
80106cd1:	6a 00                	push   $0x0
80106cd3:	6a 6a                	push   $0x6a
80106cd5:	e9 6f f7 ff ff       	jmp    80106449 <alltraps>

80106cda <vector107>:
80106cda:	6a 00                	push   $0x0
80106cdc:	6a 6b                	push   $0x6b
80106cde:	e9 66 f7 ff ff       	jmp    80106449 <alltraps>

80106ce3 <vector108>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	6a 6c                	push   $0x6c
80106ce7:	e9 5d f7 ff ff       	jmp    80106449 <alltraps>

80106cec <vector109>:
80106cec:	6a 00                	push   $0x0
80106cee:	6a 6d                	push   $0x6d
80106cf0:	e9 54 f7 ff ff       	jmp    80106449 <alltraps>

80106cf5 <vector110>:
80106cf5:	6a 00                	push   $0x0
80106cf7:	6a 6e                	push   $0x6e
80106cf9:	e9 4b f7 ff ff       	jmp    80106449 <alltraps>

80106cfe <vector111>:
80106cfe:	6a 00                	push   $0x0
80106d00:	6a 6f                	push   $0x6f
80106d02:	e9 42 f7 ff ff       	jmp    80106449 <alltraps>

80106d07 <vector112>:
80106d07:	6a 00                	push   $0x0
80106d09:	6a 70                	push   $0x70
80106d0b:	e9 39 f7 ff ff       	jmp    80106449 <alltraps>

80106d10 <vector113>:
80106d10:	6a 00                	push   $0x0
80106d12:	6a 71                	push   $0x71
80106d14:	e9 30 f7 ff ff       	jmp    80106449 <alltraps>

80106d19 <vector114>:
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 72                	push   $0x72
80106d1d:	e9 27 f7 ff ff       	jmp    80106449 <alltraps>

80106d22 <vector115>:
80106d22:	6a 00                	push   $0x0
80106d24:	6a 73                	push   $0x73
80106d26:	e9 1e f7 ff ff       	jmp    80106449 <alltraps>

80106d2b <vector116>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	6a 74                	push   $0x74
80106d2f:	e9 15 f7 ff ff       	jmp    80106449 <alltraps>

80106d34 <vector117>:
80106d34:	6a 00                	push   $0x0
80106d36:	6a 75                	push   $0x75
80106d38:	e9 0c f7 ff ff       	jmp    80106449 <alltraps>

80106d3d <vector118>:
80106d3d:	6a 00                	push   $0x0
80106d3f:	6a 76                	push   $0x76
80106d41:	e9 03 f7 ff ff       	jmp    80106449 <alltraps>

80106d46 <vector119>:
80106d46:	6a 00                	push   $0x0
80106d48:	6a 77                	push   $0x77
80106d4a:	e9 fa f6 ff ff       	jmp    80106449 <alltraps>

80106d4f <vector120>:
80106d4f:	6a 00                	push   $0x0
80106d51:	6a 78                	push   $0x78
80106d53:	e9 f1 f6 ff ff       	jmp    80106449 <alltraps>

80106d58 <vector121>:
80106d58:	6a 00                	push   $0x0
80106d5a:	6a 79                	push   $0x79
80106d5c:	e9 e8 f6 ff ff       	jmp    80106449 <alltraps>

80106d61 <vector122>:
80106d61:	6a 00                	push   $0x0
80106d63:	6a 7a                	push   $0x7a
80106d65:	e9 df f6 ff ff       	jmp    80106449 <alltraps>

80106d6a <vector123>:
80106d6a:	6a 00                	push   $0x0
80106d6c:	6a 7b                	push   $0x7b
80106d6e:	e9 d6 f6 ff ff       	jmp    80106449 <alltraps>

80106d73 <vector124>:
80106d73:	6a 00                	push   $0x0
80106d75:	6a 7c                	push   $0x7c
80106d77:	e9 cd f6 ff ff       	jmp    80106449 <alltraps>

80106d7c <vector125>:
80106d7c:	6a 00                	push   $0x0
80106d7e:	6a 7d                	push   $0x7d
80106d80:	e9 c4 f6 ff ff       	jmp    80106449 <alltraps>

80106d85 <vector126>:
80106d85:	6a 00                	push   $0x0
80106d87:	6a 7e                	push   $0x7e
80106d89:	e9 bb f6 ff ff       	jmp    80106449 <alltraps>

80106d8e <vector127>:
80106d8e:	6a 00                	push   $0x0
80106d90:	6a 7f                	push   $0x7f
80106d92:	e9 b2 f6 ff ff       	jmp    80106449 <alltraps>

80106d97 <vector128>:
80106d97:	6a 00                	push   $0x0
80106d99:	68 80 00 00 00       	push   $0x80
80106d9e:	e9 a6 f6 ff ff       	jmp    80106449 <alltraps>

80106da3 <vector129>:
80106da3:	6a 00                	push   $0x0
80106da5:	68 81 00 00 00       	push   $0x81
80106daa:	e9 9a f6 ff ff       	jmp    80106449 <alltraps>

80106daf <vector130>:
80106daf:	6a 00                	push   $0x0
80106db1:	68 82 00 00 00       	push   $0x82
80106db6:	e9 8e f6 ff ff       	jmp    80106449 <alltraps>

80106dbb <vector131>:
80106dbb:	6a 00                	push   $0x0
80106dbd:	68 83 00 00 00       	push   $0x83
80106dc2:	e9 82 f6 ff ff       	jmp    80106449 <alltraps>

80106dc7 <vector132>:
80106dc7:	6a 00                	push   $0x0
80106dc9:	68 84 00 00 00       	push   $0x84
80106dce:	e9 76 f6 ff ff       	jmp    80106449 <alltraps>

80106dd3 <vector133>:
80106dd3:	6a 00                	push   $0x0
80106dd5:	68 85 00 00 00       	push   $0x85
80106dda:	e9 6a f6 ff ff       	jmp    80106449 <alltraps>

80106ddf <vector134>:
80106ddf:	6a 00                	push   $0x0
80106de1:	68 86 00 00 00       	push   $0x86
80106de6:	e9 5e f6 ff ff       	jmp    80106449 <alltraps>

80106deb <vector135>:
80106deb:	6a 00                	push   $0x0
80106ded:	68 87 00 00 00       	push   $0x87
80106df2:	e9 52 f6 ff ff       	jmp    80106449 <alltraps>

80106df7 <vector136>:
80106df7:	6a 00                	push   $0x0
80106df9:	68 88 00 00 00       	push   $0x88
80106dfe:	e9 46 f6 ff ff       	jmp    80106449 <alltraps>

80106e03 <vector137>:
80106e03:	6a 00                	push   $0x0
80106e05:	68 89 00 00 00       	push   $0x89
80106e0a:	e9 3a f6 ff ff       	jmp    80106449 <alltraps>

80106e0f <vector138>:
80106e0f:	6a 00                	push   $0x0
80106e11:	68 8a 00 00 00       	push   $0x8a
80106e16:	e9 2e f6 ff ff       	jmp    80106449 <alltraps>

80106e1b <vector139>:
80106e1b:	6a 00                	push   $0x0
80106e1d:	68 8b 00 00 00       	push   $0x8b
80106e22:	e9 22 f6 ff ff       	jmp    80106449 <alltraps>

80106e27 <vector140>:
80106e27:	6a 00                	push   $0x0
80106e29:	68 8c 00 00 00       	push   $0x8c
80106e2e:	e9 16 f6 ff ff       	jmp    80106449 <alltraps>

80106e33 <vector141>:
80106e33:	6a 00                	push   $0x0
80106e35:	68 8d 00 00 00       	push   $0x8d
80106e3a:	e9 0a f6 ff ff       	jmp    80106449 <alltraps>

80106e3f <vector142>:
80106e3f:	6a 00                	push   $0x0
80106e41:	68 8e 00 00 00       	push   $0x8e
80106e46:	e9 fe f5 ff ff       	jmp    80106449 <alltraps>

80106e4b <vector143>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	68 8f 00 00 00       	push   $0x8f
80106e52:	e9 f2 f5 ff ff       	jmp    80106449 <alltraps>

80106e57 <vector144>:
80106e57:	6a 00                	push   $0x0
80106e59:	68 90 00 00 00       	push   $0x90
80106e5e:	e9 e6 f5 ff ff       	jmp    80106449 <alltraps>

80106e63 <vector145>:
80106e63:	6a 00                	push   $0x0
80106e65:	68 91 00 00 00       	push   $0x91
80106e6a:	e9 da f5 ff ff       	jmp    80106449 <alltraps>

80106e6f <vector146>:
80106e6f:	6a 00                	push   $0x0
80106e71:	68 92 00 00 00       	push   $0x92
80106e76:	e9 ce f5 ff ff       	jmp    80106449 <alltraps>

80106e7b <vector147>:
80106e7b:	6a 00                	push   $0x0
80106e7d:	68 93 00 00 00       	push   $0x93
80106e82:	e9 c2 f5 ff ff       	jmp    80106449 <alltraps>

80106e87 <vector148>:
80106e87:	6a 00                	push   $0x0
80106e89:	68 94 00 00 00       	push   $0x94
80106e8e:	e9 b6 f5 ff ff       	jmp    80106449 <alltraps>

80106e93 <vector149>:
80106e93:	6a 00                	push   $0x0
80106e95:	68 95 00 00 00       	push   $0x95
80106e9a:	e9 aa f5 ff ff       	jmp    80106449 <alltraps>

80106e9f <vector150>:
80106e9f:	6a 00                	push   $0x0
80106ea1:	68 96 00 00 00       	push   $0x96
80106ea6:	e9 9e f5 ff ff       	jmp    80106449 <alltraps>

80106eab <vector151>:
80106eab:	6a 00                	push   $0x0
80106ead:	68 97 00 00 00       	push   $0x97
80106eb2:	e9 92 f5 ff ff       	jmp    80106449 <alltraps>

80106eb7 <vector152>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	68 98 00 00 00       	push   $0x98
80106ebe:	e9 86 f5 ff ff       	jmp    80106449 <alltraps>

80106ec3 <vector153>:
80106ec3:	6a 00                	push   $0x0
80106ec5:	68 99 00 00 00       	push   $0x99
80106eca:	e9 7a f5 ff ff       	jmp    80106449 <alltraps>

80106ecf <vector154>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	68 9a 00 00 00       	push   $0x9a
80106ed6:	e9 6e f5 ff ff       	jmp    80106449 <alltraps>

80106edb <vector155>:
80106edb:	6a 00                	push   $0x0
80106edd:	68 9b 00 00 00       	push   $0x9b
80106ee2:	e9 62 f5 ff ff       	jmp    80106449 <alltraps>

80106ee7 <vector156>:
80106ee7:	6a 00                	push   $0x0
80106ee9:	68 9c 00 00 00       	push   $0x9c
80106eee:	e9 56 f5 ff ff       	jmp    80106449 <alltraps>

80106ef3 <vector157>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	68 9d 00 00 00       	push   $0x9d
80106efa:	e9 4a f5 ff ff       	jmp    80106449 <alltraps>

80106eff <vector158>:
80106eff:	6a 00                	push   $0x0
80106f01:	68 9e 00 00 00       	push   $0x9e
80106f06:	e9 3e f5 ff ff       	jmp    80106449 <alltraps>

80106f0b <vector159>:
80106f0b:	6a 00                	push   $0x0
80106f0d:	68 9f 00 00 00       	push   $0x9f
80106f12:	e9 32 f5 ff ff       	jmp    80106449 <alltraps>

80106f17 <vector160>:
80106f17:	6a 00                	push   $0x0
80106f19:	68 a0 00 00 00       	push   $0xa0
80106f1e:	e9 26 f5 ff ff       	jmp    80106449 <alltraps>

80106f23 <vector161>:
80106f23:	6a 00                	push   $0x0
80106f25:	68 a1 00 00 00       	push   $0xa1
80106f2a:	e9 1a f5 ff ff       	jmp    80106449 <alltraps>

80106f2f <vector162>:
80106f2f:	6a 00                	push   $0x0
80106f31:	68 a2 00 00 00       	push   $0xa2
80106f36:	e9 0e f5 ff ff       	jmp    80106449 <alltraps>

80106f3b <vector163>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	68 a3 00 00 00       	push   $0xa3
80106f42:	e9 02 f5 ff ff       	jmp    80106449 <alltraps>

80106f47 <vector164>:
80106f47:	6a 00                	push   $0x0
80106f49:	68 a4 00 00 00       	push   $0xa4
80106f4e:	e9 f6 f4 ff ff       	jmp    80106449 <alltraps>

80106f53 <vector165>:
80106f53:	6a 00                	push   $0x0
80106f55:	68 a5 00 00 00       	push   $0xa5
80106f5a:	e9 ea f4 ff ff       	jmp    80106449 <alltraps>

80106f5f <vector166>:
80106f5f:	6a 00                	push   $0x0
80106f61:	68 a6 00 00 00       	push   $0xa6
80106f66:	e9 de f4 ff ff       	jmp    80106449 <alltraps>

80106f6b <vector167>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	68 a7 00 00 00       	push   $0xa7
80106f72:	e9 d2 f4 ff ff       	jmp    80106449 <alltraps>

80106f77 <vector168>:
80106f77:	6a 00                	push   $0x0
80106f79:	68 a8 00 00 00       	push   $0xa8
80106f7e:	e9 c6 f4 ff ff       	jmp    80106449 <alltraps>

80106f83 <vector169>:
80106f83:	6a 00                	push   $0x0
80106f85:	68 a9 00 00 00       	push   $0xa9
80106f8a:	e9 ba f4 ff ff       	jmp    80106449 <alltraps>

80106f8f <vector170>:
80106f8f:	6a 00                	push   $0x0
80106f91:	68 aa 00 00 00       	push   $0xaa
80106f96:	e9 ae f4 ff ff       	jmp    80106449 <alltraps>

80106f9b <vector171>:
80106f9b:	6a 00                	push   $0x0
80106f9d:	68 ab 00 00 00       	push   $0xab
80106fa2:	e9 a2 f4 ff ff       	jmp    80106449 <alltraps>

80106fa7 <vector172>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	68 ac 00 00 00       	push   $0xac
80106fae:	e9 96 f4 ff ff       	jmp    80106449 <alltraps>

80106fb3 <vector173>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	68 ad 00 00 00       	push   $0xad
80106fba:	e9 8a f4 ff ff       	jmp    80106449 <alltraps>

80106fbf <vector174>:
80106fbf:	6a 00                	push   $0x0
80106fc1:	68 ae 00 00 00       	push   $0xae
80106fc6:	e9 7e f4 ff ff       	jmp    80106449 <alltraps>

80106fcb <vector175>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 af 00 00 00       	push   $0xaf
80106fd2:	e9 72 f4 ff ff       	jmp    80106449 <alltraps>

80106fd7 <vector176>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 b0 00 00 00       	push   $0xb0
80106fde:	e9 66 f4 ff ff       	jmp    80106449 <alltraps>

80106fe3 <vector177>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 b1 00 00 00       	push   $0xb1
80106fea:	e9 5a f4 ff ff       	jmp    80106449 <alltraps>

80106fef <vector178>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 b2 00 00 00       	push   $0xb2
80106ff6:	e9 4e f4 ff ff       	jmp    80106449 <alltraps>

80106ffb <vector179>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 b3 00 00 00       	push   $0xb3
80107002:	e9 42 f4 ff ff       	jmp    80106449 <alltraps>

80107007 <vector180>:
80107007:	6a 00                	push   $0x0
80107009:	68 b4 00 00 00       	push   $0xb4
8010700e:	e9 36 f4 ff ff       	jmp    80106449 <alltraps>

80107013 <vector181>:
80107013:	6a 00                	push   $0x0
80107015:	68 b5 00 00 00       	push   $0xb5
8010701a:	e9 2a f4 ff ff       	jmp    80106449 <alltraps>

8010701f <vector182>:
8010701f:	6a 00                	push   $0x0
80107021:	68 b6 00 00 00       	push   $0xb6
80107026:	e9 1e f4 ff ff       	jmp    80106449 <alltraps>

8010702b <vector183>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 b7 00 00 00       	push   $0xb7
80107032:	e9 12 f4 ff ff       	jmp    80106449 <alltraps>

80107037 <vector184>:
80107037:	6a 00                	push   $0x0
80107039:	68 b8 00 00 00       	push   $0xb8
8010703e:	e9 06 f4 ff ff       	jmp    80106449 <alltraps>

80107043 <vector185>:
80107043:	6a 00                	push   $0x0
80107045:	68 b9 00 00 00       	push   $0xb9
8010704a:	e9 fa f3 ff ff       	jmp    80106449 <alltraps>

8010704f <vector186>:
8010704f:	6a 00                	push   $0x0
80107051:	68 ba 00 00 00       	push   $0xba
80107056:	e9 ee f3 ff ff       	jmp    80106449 <alltraps>

8010705b <vector187>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 bb 00 00 00       	push   $0xbb
80107062:	e9 e2 f3 ff ff       	jmp    80106449 <alltraps>

80107067 <vector188>:
80107067:	6a 00                	push   $0x0
80107069:	68 bc 00 00 00       	push   $0xbc
8010706e:	e9 d6 f3 ff ff       	jmp    80106449 <alltraps>

80107073 <vector189>:
80107073:	6a 00                	push   $0x0
80107075:	68 bd 00 00 00       	push   $0xbd
8010707a:	e9 ca f3 ff ff       	jmp    80106449 <alltraps>

8010707f <vector190>:
8010707f:	6a 00                	push   $0x0
80107081:	68 be 00 00 00       	push   $0xbe
80107086:	e9 be f3 ff ff       	jmp    80106449 <alltraps>

8010708b <vector191>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 bf 00 00 00       	push   $0xbf
80107092:	e9 b2 f3 ff ff       	jmp    80106449 <alltraps>

80107097 <vector192>:
80107097:	6a 00                	push   $0x0
80107099:	68 c0 00 00 00       	push   $0xc0
8010709e:	e9 a6 f3 ff ff       	jmp    80106449 <alltraps>

801070a3 <vector193>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 c1 00 00 00       	push   $0xc1
801070aa:	e9 9a f3 ff ff       	jmp    80106449 <alltraps>

801070af <vector194>:
801070af:	6a 00                	push   $0x0
801070b1:	68 c2 00 00 00       	push   $0xc2
801070b6:	e9 8e f3 ff ff       	jmp    80106449 <alltraps>

801070bb <vector195>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 c3 00 00 00       	push   $0xc3
801070c2:	e9 82 f3 ff ff       	jmp    80106449 <alltraps>

801070c7 <vector196>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 c4 00 00 00       	push   $0xc4
801070ce:	e9 76 f3 ff ff       	jmp    80106449 <alltraps>

801070d3 <vector197>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 c5 00 00 00       	push   $0xc5
801070da:	e9 6a f3 ff ff       	jmp    80106449 <alltraps>

801070df <vector198>:
801070df:	6a 00                	push   $0x0
801070e1:	68 c6 00 00 00       	push   $0xc6
801070e6:	e9 5e f3 ff ff       	jmp    80106449 <alltraps>

801070eb <vector199>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 c7 00 00 00       	push   $0xc7
801070f2:	e9 52 f3 ff ff       	jmp    80106449 <alltraps>

801070f7 <vector200>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 c8 00 00 00       	push   $0xc8
801070fe:	e9 46 f3 ff ff       	jmp    80106449 <alltraps>

80107103 <vector201>:
80107103:	6a 00                	push   $0x0
80107105:	68 c9 00 00 00       	push   $0xc9
8010710a:	e9 3a f3 ff ff       	jmp    80106449 <alltraps>

8010710f <vector202>:
8010710f:	6a 00                	push   $0x0
80107111:	68 ca 00 00 00       	push   $0xca
80107116:	e9 2e f3 ff ff       	jmp    80106449 <alltraps>

8010711b <vector203>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 cb 00 00 00       	push   $0xcb
80107122:	e9 22 f3 ff ff       	jmp    80106449 <alltraps>

80107127 <vector204>:
80107127:	6a 00                	push   $0x0
80107129:	68 cc 00 00 00       	push   $0xcc
8010712e:	e9 16 f3 ff ff       	jmp    80106449 <alltraps>

80107133 <vector205>:
80107133:	6a 00                	push   $0x0
80107135:	68 cd 00 00 00       	push   $0xcd
8010713a:	e9 0a f3 ff ff       	jmp    80106449 <alltraps>

8010713f <vector206>:
8010713f:	6a 00                	push   $0x0
80107141:	68 ce 00 00 00       	push   $0xce
80107146:	e9 fe f2 ff ff       	jmp    80106449 <alltraps>

8010714b <vector207>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 cf 00 00 00       	push   $0xcf
80107152:	e9 f2 f2 ff ff       	jmp    80106449 <alltraps>

80107157 <vector208>:
80107157:	6a 00                	push   $0x0
80107159:	68 d0 00 00 00       	push   $0xd0
8010715e:	e9 e6 f2 ff ff       	jmp    80106449 <alltraps>

80107163 <vector209>:
80107163:	6a 00                	push   $0x0
80107165:	68 d1 00 00 00       	push   $0xd1
8010716a:	e9 da f2 ff ff       	jmp    80106449 <alltraps>

8010716f <vector210>:
8010716f:	6a 00                	push   $0x0
80107171:	68 d2 00 00 00       	push   $0xd2
80107176:	e9 ce f2 ff ff       	jmp    80106449 <alltraps>

8010717b <vector211>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 d3 00 00 00       	push   $0xd3
80107182:	e9 c2 f2 ff ff       	jmp    80106449 <alltraps>

80107187 <vector212>:
80107187:	6a 00                	push   $0x0
80107189:	68 d4 00 00 00       	push   $0xd4
8010718e:	e9 b6 f2 ff ff       	jmp    80106449 <alltraps>

80107193 <vector213>:
80107193:	6a 00                	push   $0x0
80107195:	68 d5 00 00 00       	push   $0xd5
8010719a:	e9 aa f2 ff ff       	jmp    80106449 <alltraps>

8010719f <vector214>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 d6 00 00 00       	push   $0xd6
801071a6:	e9 9e f2 ff ff       	jmp    80106449 <alltraps>

801071ab <vector215>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 d7 00 00 00       	push   $0xd7
801071b2:	e9 92 f2 ff ff       	jmp    80106449 <alltraps>

801071b7 <vector216>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 d8 00 00 00       	push   $0xd8
801071be:	e9 86 f2 ff ff       	jmp    80106449 <alltraps>

801071c3 <vector217>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 d9 00 00 00       	push   $0xd9
801071ca:	e9 7a f2 ff ff       	jmp    80106449 <alltraps>

801071cf <vector218>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 da 00 00 00       	push   $0xda
801071d6:	e9 6e f2 ff ff       	jmp    80106449 <alltraps>

801071db <vector219>:
801071db:	6a 00                	push   $0x0
801071dd:	68 db 00 00 00       	push   $0xdb
801071e2:	e9 62 f2 ff ff       	jmp    80106449 <alltraps>

801071e7 <vector220>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 dc 00 00 00       	push   $0xdc
801071ee:	e9 56 f2 ff ff       	jmp    80106449 <alltraps>

801071f3 <vector221>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 dd 00 00 00       	push   $0xdd
801071fa:	e9 4a f2 ff ff       	jmp    80106449 <alltraps>

801071ff <vector222>:
801071ff:	6a 00                	push   $0x0
80107201:	68 de 00 00 00       	push   $0xde
80107206:	e9 3e f2 ff ff       	jmp    80106449 <alltraps>

8010720b <vector223>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 df 00 00 00       	push   $0xdf
80107212:	e9 32 f2 ff ff       	jmp    80106449 <alltraps>

80107217 <vector224>:
80107217:	6a 00                	push   $0x0
80107219:	68 e0 00 00 00       	push   $0xe0
8010721e:	e9 26 f2 ff ff       	jmp    80106449 <alltraps>

80107223 <vector225>:
80107223:	6a 00                	push   $0x0
80107225:	68 e1 00 00 00       	push   $0xe1
8010722a:	e9 1a f2 ff ff       	jmp    80106449 <alltraps>

8010722f <vector226>:
8010722f:	6a 00                	push   $0x0
80107231:	68 e2 00 00 00       	push   $0xe2
80107236:	e9 0e f2 ff ff       	jmp    80106449 <alltraps>

8010723b <vector227>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 e3 00 00 00       	push   $0xe3
80107242:	e9 02 f2 ff ff       	jmp    80106449 <alltraps>

80107247 <vector228>:
80107247:	6a 00                	push   $0x0
80107249:	68 e4 00 00 00       	push   $0xe4
8010724e:	e9 f6 f1 ff ff       	jmp    80106449 <alltraps>

80107253 <vector229>:
80107253:	6a 00                	push   $0x0
80107255:	68 e5 00 00 00       	push   $0xe5
8010725a:	e9 ea f1 ff ff       	jmp    80106449 <alltraps>

8010725f <vector230>:
8010725f:	6a 00                	push   $0x0
80107261:	68 e6 00 00 00       	push   $0xe6
80107266:	e9 de f1 ff ff       	jmp    80106449 <alltraps>

8010726b <vector231>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 e7 00 00 00       	push   $0xe7
80107272:	e9 d2 f1 ff ff       	jmp    80106449 <alltraps>

80107277 <vector232>:
80107277:	6a 00                	push   $0x0
80107279:	68 e8 00 00 00       	push   $0xe8
8010727e:	e9 c6 f1 ff ff       	jmp    80106449 <alltraps>

80107283 <vector233>:
80107283:	6a 00                	push   $0x0
80107285:	68 e9 00 00 00       	push   $0xe9
8010728a:	e9 ba f1 ff ff       	jmp    80106449 <alltraps>

8010728f <vector234>:
8010728f:	6a 00                	push   $0x0
80107291:	68 ea 00 00 00       	push   $0xea
80107296:	e9 ae f1 ff ff       	jmp    80106449 <alltraps>

8010729b <vector235>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 eb 00 00 00       	push   $0xeb
801072a2:	e9 a2 f1 ff ff       	jmp    80106449 <alltraps>

801072a7 <vector236>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 ec 00 00 00       	push   $0xec
801072ae:	e9 96 f1 ff ff       	jmp    80106449 <alltraps>

801072b3 <vector237>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 ed 00 00 00       	push   $0xed
801072ba:	e9 8a f1 ff ff       	jmp    80106449 <alltraps>

801072bf <vector238>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 ee 00 00 00       	push   $0xee
801072c6:	e9 7e f1 ff ff       	jmp    80106449 <alltraps>

801072cb <vector239>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 ef 00 00 00       	push   $0xef
801072d2:	e9 72 f1 ff ff       	jmp    80106449 <alltraps>

801072d7 <vector240>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 f0 00 00 00       	push   $0xf0
801072de:	e9 66 f1 ff ff       	jmp    80106449 <alltraps>

801072e3 <vector241>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 f1 00 00 00       	push   $0xf1
801072ea:	e9 5a f1 ff ff       	jmp    80106449 <alltraps>

801072ef <vector242>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 f2 00 00 00       	push   $0xf2
801072f6:	e9 4e f1 ff ff       	jmp    80106449 <alltraps>

801072fb <vector243>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 f3 00 00 00       	push   $0xf3
80107302:	e9 42 f1 ff ff       	jmp    80106449 <alltraps>

80107307 <vector244>:
80107307:	6a 00                	push   $0x0
80107309:	68 f4 00 00 00       	push   $0xf4
8010730e:	e9 36 f1 ff ff       	jmp    80106449 <alltraps>

80107313 <vector245>:
80107313:	6a 00                	push   $0x0
80107315:	68 f5 00 00 00       	push   $0xf5
8010731a:	e9 2a f1 ff ff       	jmp    80106449 <alltraps>

8010731f <vector246>:
8010731f:	6a 00                	push   $0x0
80107321:	68 f6 00 00 00       	push   $0xf6
80107326:	e9 1e f1 ff ff       	jmp    80106449 <alltraps>

8010732b <vector247>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 f7 00 00 00       	push   $0xf7
80107332:	e9 12 f1 ff ff       	jmp    80106449 <alltraps>

80107337 <vector248>:
80107337:	6a 00                	push   $0x0
80107339:	68 f8 00 00 00       	push   $0xf8
8010733e:	e9 06 f1 ff ff       	jmp    80106449 <alltraps>

80107343 <vector249>:
80107343:	6a 00                	push   $0x0
80107345:	68 f9 00 00 00       	push   $0xf9
8010734a:	e9 fa f0 ff ff       	jmp    80106449 <alltraps>

8010734f <vector250>:
8010734f:	6a 00                	push   $0x0
80107351:	68 fa 00 00 00       	push   $0xfa
80107356:	e9 ee f0 ff ff       	jmp    80106449 <alltraps>

8010735b <vector251>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 fb 00 00 00       	push   $0xfb
80107362:	e9 e2 f0 ff ff       	jmp    80106449 <alltraps>

80107367 <vector252>:
80107367:	6a 00                	push   $0x0
80107369:	68 fc 00 00 00       	push   $0xfc
8010736e:	e9 d6 f0 ff ff       	jmp    80106449 <alltraps>

80107373 <vector253>:
80107373:	6a 00                	push   $0x0
80107375:	68 fd 00 00 00       	push   $0xfd
8010737a:	e9 ca f0 ff ff       	jmp    80106449 <alltraps>

8010737f <vector254>:
8010737f:	6a 00                	push   $0x0
80107381:	68 fe 00 00 00       	push   $0xfe
80107386:	e9 be f0 ff ff       	jmp    80106449 <alltraps>

8010738b <vector255>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 ff 00 00 00       	push   $0xff
80107392:	e9 b2 f0 ff ff       	jmp    80106449 <alltraps>
80107397:	66 90                	xchg   %ax,%ax
80107399:	66 90                	xchg   %ax,%ax
8010739b:	66 90                	xchg   %ax,%ax
8010739d:	66 90                	xchg   %ax,%ax
8010739f:	90                   	nop

801073a0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	57                   	push   %edi
801073a4:	56                   	push   %esi
801073a5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801073a6:	89 d3                	mov    %edx,%ebx
{
801073a8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
801073aa:	c1 eb 16             	shr    $0x16,%ebx
801073ad:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801073b0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801073b3:	8b 06                	mov    (%esi),%eax
801073b5:	a8 01                	test   $0x1,%al
801073b7:	74 27                	je     801073e0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073be:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801073c4:	c1 ef 0a             	shr    $0xa,%edi
}
801073c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801073ca:	89 fa                	mov    %edi,%edx
801073cc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801073d2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801073d5:	5b                   	pop    %ebx
801073d6:	5e                   	pop    %esi
801073d7:	5f                   	pop    %edi
801073d8:	5d                   	pop    %ebp
801073d9:	c3                   	ret    
801073da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801073e0:	85 c9                	test   %ecx,%ecx
801073e2:	74 2c                	je     80107410 <walkpgdir+0x70>
801073e4:	e8 47 b4 ff ff       	call   80102830 <kalloc>
801073e9:	85 c0                	test   %eax,%eax
801073eb:	89 c3                	mov    %eax,%ebx
801073ed:	74 21                	je     80107410 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801073ef:	83 ec 04             	sub    $0x4,%esp
801073f2:	68 00 10 00 00       	push   $0x1000
801073f7:	6a 00                	push   $0x0
801073f9:	50                   	push   %eax
801073fa:	e8 51 dd ff ff       	call   80105150 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801073ff:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107405:	83 c4 10             	add    $0x10,%esp
80107408:	83 c8 07             	or     $0x7,%eax
8010740b:	89 06                	mov    %eax,(%esi)
8010740d:	eb b5                	jmp    801073c4 <walkpgdir+0x24>
8010740f:	90                   	nop
}
80107410:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107413:	31 c0                	xor    %eax,%eax
}
80107415:	5b                   	pop    %ebx
80107416:	5e                   	pop    %esi
80107417:	5f                   	pop    %edi
80107418:	5d                   	pop    %ebp
80107419:	c3                   	ret    
8010741a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107420 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107420:	55                   	push   %ebp
80107421:	89 e5                	mov    %esp,%ebp
80107423:	57                   	push   %edi
80107424:	56                   	push   %esi
80107425:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107426:	89 d3                	mov    %edx,%ebx
80107428:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010742e:	83 ec 1c             	sub    $0x1c,%esp
80107431:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107434:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107438:	8b 7d 08             	mov    0x8(%ebp),%edi
8010743b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107440:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107443:	8b 45 0c             	mov    0xc(%ebp),%eax
80107446:	29 df                	sub    %ebx,%edi
80107448:	83 c8 01             	or     $0x1,%eax
8010744b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010744e:	eb 15                	jmp    80107465 <mappages+0x45>
    if(*pte & PTE_P)
80107450:	f6 00 01             	testb  $0x1,(%eax)
80107453:	75 45                	jne    8010749a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107455:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107458:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010745b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010745d:	74 31                	je     80107490 <mappages+0x70>
      break;
    a += PGSIZE;
8010745f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107465:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107468:	b9 01 00 00 00       	mov    $0x1,%ecx
8010746d:	89 da                	mov    %ebx,%edx
8010746f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107472:	e8 29 ff ff ff       	call   801073a0 <walkpgdir>
80107477:	85 c0                	test   %eax,%eax
80107479:	75 d5                	jne    80107450 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010747b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010747e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107483:	5b                   	pop    %ebx
80107484:	5e                   	pop    %esi
80107485:	5f                   	pop    %edi
80107486:	5d                   	pop    %ebp
80107487:	c3                   	ret    
80107488:	90                   	nop
80107489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107490:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107493:	31 c0                	xor    %eax,%eax
}
80107495:	5b                   	pop    %ebx
80107496:	5e                   	pop    %esi
80107497:	5f                   	pop    %edi
80107498:	5d                   	pop    %ebp
80107499:	c3                   	ret    
      panic("remap");
8010749a:	83 ec 0c             	sub    $0xc,%esp
8010749d:	68 70 87 10 80       	push   $0x80108770
801074a2:	e8 e9 8e ff ff       	call   80100390 <panic>
801074a7:	89 f6                	mov    %esi,%esi
801074a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801074b6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074bc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
801074be:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074c4:	83 ec 1c             	sub    $0x1c,%esp
801074c7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801074ca:	39 d3                	cmp    %edx,%ebx
801074cc:	73 66                	jae    80107534 <deallocuvm.part.0+0x84>
801074ce:	89 d6                	mov    %edx,%esi
801074d0:	eb 3d                	jmp    8010750f <deallocuvm.part.0+0x5f>
801074d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801074d8:	8b 10                	mov    (%eax),%edx
801074da:	f6 c2 01             	test   $0x1,%dl
801074dd:	74 26                	je     80107505 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801074df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801074e5:	74 58                	je     8010753f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801074e7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801074ea:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801074f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801074f3:	52                   	push   %edx
801074f4:	e8 87 b1 ff ff       	call   80102680 <kfree>
      *pte = 0;
801074f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074fc:	83 c4 10             	add    $0x10,%esp
801074ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107505:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010750b:	39 f3                	cmp    %esi,%ebx
8010750d:	73 25                	jae    80107534 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010750f:	31 c9                	xor    %ecx,%ecx
80107511:	89 da                	mov    %ebx,%edx
80107513:	89 f8                	mov    %edi,%eax
80107515:	e8 86 fe ff ff       	call   801073a0 <walkpgdir>
    if(!pte)
8010751a:	85 c0                	test   %eax,%eax
8010751c:	75 ba                	jne    801074d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010751e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107524:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010752a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107530:	39 f3                	cmp    %esi,%ebx
80107532:	72 db                	jb     8010750f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80107534:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107537:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010753a:	5b                   	pop    %ebx
8010753b:	5e                   	pop    %esi
8010753c:	5f                   	pop    %edi
8010753d:	5d                   	pop    %ebp
8010753e:	c3                   	ret    
        panic("kfree");
8010753f:	83 ec 0c             	sub    $0xc,%esp
80107542:	68 46 7f 10 80       	push   $0x80107f46
80107547:	e8 44 8e ff ff       	call   80100390 <panic>
8010754c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107550 <seginit>:
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107556:	e8 05 c6 ff ff       	call   80103b60 <cpuid>
8010755b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107561:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107566:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010756a:	c7 80 b8 3a 11 80 ff 	movl   $0xffff,-0x7feec548(%eax)
80107571:	ff 00 00 
80107574:	c7 80 bc 3a 11 80 00 	movl   $0xcf9a00,-0x7feec544(%eax)
8010757b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010757e:	c7 80 c0 3a 11 80 ff 	movl   $0xffff,-0x7feec540(%eax)
80107585:	ff 00 00 
80107588:	c7 80 c4 3a 11 80 00 	movl   $0xcf9200,-0x7feec53c(%eax)
8010758f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107592:	c7 80 c8 3a 11 80 ff 	movl   $0xffff,-0x7feec538(%eax)
80107599:	ff 00 00 
8010759c:	c7 80 cc 3a 11 80 00 	movl   $0xcffa00,-0x7feec534(%eax)
801075a3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801075a6:	c7 80 d0 3a 11 80 ff 	movl   $0xffff,-0x7feec530(%eax)
801075ad:	ff 00 00 
801075b0:	c7 80 d4 3a 11 80 00 	movl   $0xcff200,-0x7feec52c(%eax)
801075b7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801075ba:	05 b0 3a 11 80       	add    $0x80113ab0,%eax
  pd[1] = (uint)p;
801075bf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801075c3:	c1 e8 10             	shr    $0x10,%eax
801075c6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801075ca:	8d 45 f2             	lea    -0xe(%ebp),%eax
801075cd:	0f 01 10             	lgdtl  (%eax)
}
801075d0:	c9                   	leave  
801075d1:	c3                   	ret    
801075d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075e0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075e0:	a1 84 6c 11 80       	mov    0x80116c84,%eax
{
801075e5:	55                   	push   %ebp
801075e6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075e8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801075ed:	0f 22 d8             	mov    %eax,%cr3
}
801075f0:	5d                   	pop    %ebp
801075f1:	c3                   	ret    
801075f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107600 <switchuvm>:
{
80107600:	55                   	push   %ebp
80107601:	89 e5                	mov    %esp,%ebp
80107603:	57                   	push   %edi
80107604:	56                   	push   %esi
80107605:	53                   	push   %ebx
80107606:	83 ec 1c             	sub    $0x1c,%esp
80107609:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010760c:	85 db                	test   %ebx,%ebx
8010760e:	0f 84 cb 00 00 00    	je     801076df <switchuvm+0xdf>
  if(p->kstack == 0)
80107614:	8b 43 08             	mov    0x8(%ebx),%eax
80107617:	85 c0                	test   %eax,%eax
80107619:	0f 84 da 00 00 00    	je     801076f9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010761f:	8b 43 04             	mov    0x4(%ebx),%eax
80107622:	85 c0                	test   %eax,%eax
80107624:	0f 84 c2 00 00 00    	je     801076ec <switchuvm+0xec>
  pushcli();
8010762a:	e8 41 d9 ff ff       	call   80104f70 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010762f:	e8 ac c4 ff ff       	call   80103ae0 <mycpu>
80107634:	89 c6                	mov    %eax,%esi
80107636:	e8 a5 c4 ff ff       	call   80103ae0 <mycpu>
8010763b:	89 c7                	mov    %eax,%edi
8010763d:	e8 9e c4 ff ff       	call   80103ae0 <mycpu>
80107642:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107645:	83 c7 08             	add    $0x8,%edi
80107648:	e8 93 c4 ff ff       	call   80103ae0 <mycpu>
8010764d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107650:	83 c0 08             	add    $0x8,%eax
80107653:	ba 67 00 00 00       	mov    $0x67,%edx
80107658:	c1 e8 18             	shr    $0x18,%eax
8010765b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107662:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107669:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010766f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107674:	83 c1 08             	add    $0x8,%ecx
80107677:	c1 e9 10             	shr    $0x10,%ecx
8010767a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107680:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107685:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010768c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107691:	e8 4a c4 ff ff       	call   80103ae0 <mycpu>
80107696:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010769d:	e8 3e c4 ff ff       	call   80103ae0 <mycpu>
801076a2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801076a6:	8b 73 08             	mov    0x8(%ebx),%esi
801076a9:	e8 32 c4 ff ff       	call   80103ae0 <mycpu>
801076ae:	81 c6 00 10 00 00    	add    $0x1000,%esi
801076b4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801076b7:	e8 24 c4 ff ff       	call   80103ae0 <mycpu>
801076bc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801076c0:	b8 28 00 00 00       	mov    $0x28,%eax
801076c5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801076c8:	8b 43 04             	mov    0x4(%ebx),%eax
801076cb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076d0:	0f 22 d8             	mov    %eax,%cr3
}
801076d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076d6:	5b                   	pop    %ebx
801076d7:	5e                   	pop    %esi
801076d8:	5f                   	pop    %edi
801076d9:	5d                   	pop    %ebp
  popcli();
801076da:	e9 d1 d8 ff ff       	jmp    80104fb0 <popcli>
    panic("switchuvm: no process");
801076df:	83 ec 0c             	sub    $0xc,%esp
801076e2:	68 76 87 10 80       	push   $0x80108776
801076e7:	e8 a4 8c ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801076ec:	83 ec 0c             	sub    $0xc,%esp
801076ef:	68 a1 87 10 80       	push   $0x801087a1
801076f4:	e8 97 8c ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801076f9:	83 ec 0c             	sub    $0xc,%esp
801076fc:	68 8c 87 10 80       	push   $0x8010878c
80107701:	e8 8a 8c ff ff       	call   80100390 <panic>
80107706:	8d 76 00             	lea    0x0(%esi),%esi
80107709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107710 <inituvm>:
{
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	57                   	push   %edi
80107714:	56                   	push   %esi
80107715:	53                   	push   %ebx
80107716:	83 ec 1c             	sub    $0x1c,%esp
80107719:	8b 75 10             	mov    0x10(%ebp),%esi
8010771c:	8b 45 08             	mov    0x8(%ebp),%eax
8010771f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107722:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107728:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010772b:	77 49                	ja     80107776 <inituvm+0x66>
  mem = kalloc();
8010772d:	e8 fe b0 ff ff       	call   80102830 <kalloc>
  memset(mem, 0, PGSIZE);
80107732:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107735:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107737:	68 00 10 00 00       	push   $0x1000
8010773c:	6a 00                	push   $0x0
8010773e:	50                   	push   %eax
8010773f:	e8 0c da ff ff       	call   80105150 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107744:	58                   	pop    %eax
80107745:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010774b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107750:	5a                   	pop    %edx
80107751:	6a 06                	push   $0x6
80107753:	50                   	push   %eax
80107754:	31 d2                	xor    %edx,%edx
80107756:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107759:	e8 c2 fc ff ff       	call   80107420 <mappages>
  memmove(mem, init, sz);
8010775e:	89 75 10             	mov    %esi,0x10(%ebp)
80107761:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107764:	83 c4 10             	add    $0x10,%esp
80107767:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010776a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010776d:	5b                   	pop    %ebx
8010776e:	5e                   	pop    %esi
8010776f:	5f                   	pop    %edi
80107770:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107771:	e9 8a da ff ff       	jmp    80105200 <memmove>
    panic("inituvm: more than a page");
80107776:	83 ec 0c             	sub    $0xc,%esp
80107779:	68 b5 87 10 80       	push   $0x801087b5
8010777e:	e8 0d 8c ff ff       	call   80100390 <panic>
80107783:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107790 <loaduvm>:
{
80107790:	55                   	push   %ebp
80107791:	89 e5                	mov    %esp,%ebp
80107793:	57                   	push   %edi
80107794:	56                   	push   %esi
80107795:	53                   	push   %ebx
80107796:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107799:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801077a0:	0f 85 91 00 00 00    	jne    80107837 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
801077a6:	8b 75 18             	mov    0x18(%ebp),%esi
801077a9:	31 db                	xor    %ebx,%ebx
801077ab:	85 f6                	test   %esi,%esi
801077ad:	75 1a                	jne    801077c9 <loaduvm+0x39>
801077af:	eb 6f                	jmp    80107820 <loaduvm+0x90>
801077b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077b8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077be:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801077c4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801077c7:	76 57                	jbe    80107820 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801077c9:	8b 55 0c             	mov    0xc(%ebp),%edx
801077cc:	8b 45 08             	mov    0x8(%ebp),%eax
801077cf:	31 c9                	xor    %ecx,%ecx
801077d1:	01 da                	add    %ebx,%edx
801077d3:	e8 c8 fb ff ff       	call   801073a0 <walkpgdir>
801077d8:	85 c0                	test   %eax,%eax
801077da:	74 4e                	je     8010782a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
801077dc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077de:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801077e1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801077e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801077eb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801077f1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077f4:	01 d9                	add    %ebx,%ecx
801077f6:	05 00 00 00 80       	add    $0x80000000,%eax
801077fb:	57                   	push   %edi
801077fc:	51                   	push   %ecx
801077fd:	50                   	push   %eax
801077fe:	ff 75 10             	pushl  0x10(%ebp)
80107801:	e8 ca a4 ff ff       	call   80101cd0 <readi>
80107806:	83 c4 10             	add    $0x10,%esp
80107809:	39 f8                	cmp    %edi,%eax
8010780b:	74 ab                	je     801077b8 <loaduvm+0x28>
}
8010780d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107815:	5b                   	pop    %ebx
80107816:	5e                   	pop    %esi
80107817:	5f                   	pop    %edi
80107818:	5d                   	pop    %ebp
80107819:	c3                   	ret    
8010781a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107820:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107823:	31 c0                	xor    %eax,%eax
}
80107825:	5b                   	pop    %ebx
80107826:	5e                   	pop    %esi
80107827:	5f                   	pop    %edi
80107828:	5d                   	pop    %ebp
80107829:	c3                   	ret    
      panic("loaduvm: address should exist");
8010782a:	83 ec 0c             	sub    $0xc,%esp
8010782d:	68 cf 87 10 80       	push   $0x801087cf
80107832:	e8 59 8b ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107837:	83 ec 0c             	sub    $0xc,%esp
8010783a:	68 70 88 10 80       	push   $0x80108870
8010783f:	e8 4c 8b ff ff       	call   80100390 <panic>
80107844:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010784a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107850 <allocuvm>:
{
80107850:	55                   	push   %ebp
80107851:	89 e5                	mov    %esp,%ebp
80107853:	57                   	push   %edi
80107854:	56                   	push   %esi
80107855:	53                   	push   %ebx
80107856:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107859:	8b 7d 10             	mov    0x10(%ebp),%edi
8010785c:	85 ff                	test   %edi,%edi
8010785e:	0f 88 8e 00 00 00    	js     801078f2 <allocuvm+0xa2>
  if(newsz < oldsz)
80107864:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107867:	0f 82 93 00 00 00    	jb     80107900 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010786d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107870:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107876:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010787c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010787f:	0f 86 7e 00 00 00    	jbe    80107903 <allocuvm+0xb3>
80107885:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107888:	8b 7d 08             	mov    0x8(%ebp),%edi
8010788b:	eb 42                	jmp    801078cf <allocuvm+0x7f>
8010788d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107890:	83 ec 04             	sub    $0x4,%esp
80107893:	68 00 10 00 00       	push   $0x1000
80107898:	6a 00                	push   $0x0
8010789a:	50                   	push   %eax
8010789b:	e8 b0 d8 ff ff       	call   80105150 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801078a0:	58                   	pop    %eax
801078a1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801078a7:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078ac:	5a                   	pop    %edx
801078ad:	6a 06                	push   $0x6
801078af:	50                   	push   %eax
801078b0:	89 da                	mov    %ebx,%edx
801078b2:	89 f8                	mov    %edi,%eax
801078b4:	e8 67 fb ff ff       	call   80107420 <mappages>
801078b9:	83 c4 10             	add    $0x10,%esp
801078bc:	85 c0                	test   %eax,%eax
801078be:	78 50                	js     80107910 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
801078c0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801078c6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801078c9:	0f 86 81 00 00 00    	jbe    80107950 <allocuvm+0x100>
    mem = kalloc();
801078cf:	e8 5c af ff ff       	call   80102830 <kalloc>
    if(mem == 0){
801078d4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801078d6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801078d8:	75 b6                	jne    80107890 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801078da:	83 ec 0c             	sub    $0xc,%esp
801078dd:	68 ed 87 10 80       	push   $0x801087ed
801078e2:	e8 79 8d ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801078e7:	83 c4 10             	add    $0x10,%esp
801078ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801078ed:	39 45 10             	cmp    %eax,0x10(%ebp)
801078f0:	77 6e                	ja     80107960 <allocuvm+0x110>
}
801078f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801078f5:	31 ff                	xor    %edi,%edi
}
801078f7:	89 f8                	mov    %edi,%eax
801078f9:	5b                   	pop    %ebx
801078fa:	5e                   	pop    %esi
801078fb:	5f                   	pop    %edi
801078fc:	5d                   	pop    %ebp
801078fd:	c3                   	ret    
801078fe:	66 90                	xchg   %ax,%ax
    return oldsz;
80107900:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107903:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107906:	89 f8                	mov    %edi,%eax
80107908:	5b                   	pop    %ebx
80107909:	5e                   	pop    %esi
8010790a:	5f                   	pop    %edi
8010790b:	5d                   	pop    %ebp
8010790c:	c3                   	ret    
8010790d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107910:	83 ec 0c             	sub    $0xc,%esp
80107913:	68 05 88 10 80       	push   $0x80108805
80107918:	e8 43 8d ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010791d:	83 c4 10             	add    $0x10,%esp
80107920:	8b 45 0c             	mov    0xc(%ebp),%eax
80107923:	39 45 10             	cmp    %eax,0x10(%ebp)
80107926:	76 0d                	jbe    80107935 <allocuvm+0xe5>
80107928:	89 c1                	mov    %eax,%ecx
8010792a:	8b 55 10             	mov    0x10(%ebp),%edx
8010792d:	8b 45 08             	mov    0x8(%ebp),%eax
80107930:	e8 7b fb ff ff       	call   801074b0 <deallocuvm.part.0>
      kfree(mem);
80107935:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107938:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010793a:	56                   	push   %esi
8010793b:	e8 40 ad ff ff       	call   80102680 <kfree>
      return 0;
80107940:	83 c4 10             	add    $0x10,%esp
}
80107943:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107946:	89 f8                	mov    %edi,%eax
80107948:	5b                   	pop    %ebx
80107949:	5e                   	pop    %esi
8010794a:	5f                   	pop    %edi
8010794b:	5d                   	pop    %ebp
8010794c:	c3                   	ret    
8010794d:	8d 76 00             	lea    0x0(%esi),%esi
80107950:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107953:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107956:	5b                   	pop    %ebx
80107957:	89 f8                	mov    %edi,%eax
80107959:	5e                   	pop    %esi
8010795a:	5f                   	pop    %edi
8010795b:	5d                   	pop    %ebp
8010795c:	c3                   	ret    
8010795d:	8d 76 00             	lea    0x0(%esi),%esi
80107960:	89 c1                	mov    %eax,%ecx
80107962:	8b 55 10             	mov    0x10(%ebp),%edx
80107965:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107968:	31 ff                	xor    %edi,%edi
8010796a:	e8 41 fb ff ff       	call   801074b0 <deallocuvm.part.0>
8010796f:	eb 92                	jmp    80107903 <allocuvm+0xb3>
80107971:	eb 0d                	jmp    80107980 <deallocuvm>
80107973:	90                   	nop
80107974:	90                   	nop
80107975:	90                   	nop
80107976:	90                   	nop
80107977:	90                   	nop
80107978:	90                   	nop
80107979:	90                   	nop
8010797a:	90                   	nop
8010797b:	90                   	nop
8010797c:	90                   	nop
8010797d:	90                   	nop
8010797e:	90                   	nop
8010797f:	90                   	nop

80107980 <deallocuvm>:
{
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	8b 55 0c             	mov    0xc(%ebp),%edx
80107986:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107989:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010798c:	39 d1                	cmp    %edx,%ecx
8010798e:	73 10                	jae    801079a0 <deallocuvm+0x20>
}
80107990:	5d                   	pop    %ebp
80107991:	e9 1a fb ff ff       	jmp    801074b0 <deallocuvm.part.0>
80107996:	8d 76 00             	lea    0x0(%esi),%esi
80107999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801079a0:	89 d0                	mov    %edx,%eax
801079a2:	5d                   	pop    %ebp
801079a3:	c3                   	ret    
801079a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801079aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801079b0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	57                   	push   %edi
801079b4:	56                   	push   %esi
801079b5:	53                   	push   %ebx
801079b6:	83 ec 0c             	sub    $0xc,%esp
801079b9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801079bc:	85 f6                	test   %esi,%esi
801079be:	74 59                	je     80107a19 <freevm+0x69>
801079c0:	31 c9                	xor    %ecx,%ecx
801079c2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801079c7:	89 f0                	mov    %esi,%eax
801079c9:	e8 e2 fa ff ff       	call   801074b0 <deallocuvm.part.0>
801079ce:	89 f3                	mov    %esi,%ebx
801079d0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801079d6:	eb 0f                	jmp    801079e7 <freevm+0x37>
801079d8:	90                   	nop
801079d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079e0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801079e3:	39 fb                	cmp    %edi,%ebx
801079e5:	74 23                	je     80107a0a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801079e7:	8b 03                	mov    (%ebx),%eax
801079e9:	a8 01                	test   $0x1,%al
801079eb:	74 f3                	je     801079e0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801079f2:	83 ec 0c             	sub    $0xc,%esp
801079f5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079f8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801079fd:	50                   	push   %eax
801079fe:	e8 7d ac ff ff       	call   80102680 <kfree>
80107a03:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107a06:	39 fb                	cmp    %edi,%ebx
80107a08:	75 dd                	jne    801079e7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107a0a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107a0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a10:	5b                   	pop    %ebx
80107a11:	5e                   	pop    %esi
80107a12:	5f                   	pop    %edi
80107a13:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107a14:	e9 67 ac ff ff       	jmp    80102680 <kfree>
    panic("freevm: no pgdir");
80107a19:	83 ec 0c             	sub    $0xc,%esp
80107a1c:	68 21 88 10 80       	push   $0x80108821
80107a21:	e8 6a 89 ff ff       	call   80100390 <panic>
80107a26:	8d 76 00             	lea    0x0(%esi),%esi
80107a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a30 <setupkvm>:
{
80107a30:	55                   	push   %ebp
80107a31:	89 e5                	mov    %esp,%ebp
80107a33:	56                   	push   %esi
80107a34:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107a35:	e8 f6 ad ff ff       	call   80102830 <kalloc>
80107a3a:	85 c0                	test   %eax,%eax
80107a3c:	89 c6                	mov    %eax,%esi
80107a3e:	74 42                	je     80107a82 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107a40:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a43:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107a48:	68 00 10 00 00       	push   $0x1000
80107a4d:	6a 00                	push   $0x0
80107a4f:	50                   	push   %eax
80107a50:	e8 fb d6 ff ff       	call   80105150 <memset>
80107a55:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107a58:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a5b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107a5e:	83 ec 08             	sub    $0x8,%esp
80107a61:	8b 13                	mov    (%ebx),%edx
80107a63:	ff 73 0c             	pushl  0xc(%ebx)
80107a66:	50                   	push   %eax
80107a67:	29 c1                	sub    %eax,%ecx
80107a69:	89 f0                	mov    %esi,%eax
80107a6b:	e8 b0 f9 ff ff       	call   80107420 <mappages>
80107a70:	83 c4 10             	add    $0x10,%esp
80107a73:	85 c0                	test   %eax,%eax
80107a75:	78 19                	js     80107a90 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a77:	83 c3 10             	add    $0x10,%ebx
80107a7a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107a80:	75 d6                	jne    80107a58 <setupkvm+0x28>
}
80107a82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a85:	89 f0                	mov    %esi,%eax
80107a87:	5b                   	pop    %ebx
80107a88:	5e                   	pop    %esi
80107a89:	5d                   	pop    %ebp
80107a8a:	c3                   	ret    
80107a8b:	90                   	nop
80107a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107a90:	83 ec 0c             	sub    $0xc,%esp
80107a93:	56                   	push   %esi
      return 0;
80107a94:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107a96:	e8 15 ff ff ff       	call   801079b0 <freevm>
      return 0;
80107a9b:	83 c4 10             	add    $0x10,%esp
}
80107a9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107aa1:	89 f0                	mov    %esi,%eax
80107aa3:	5b                   	pop    %ebx
80107aa4:	5e                   	pop    %esi
80107aa5:	5d                   	pop    %ebp
80107aa6:	c3                   	ret    
80107aa7:	89 f6                	mov    %esi,%esi
80107aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ab0 <kvmalloc>:
{
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107ab6:	e8 75 ff ff ff       	call   80107a30 <setupkvm>
80107abb:	a3 84 6c 11 80       	mov    %eax,0x80116c84
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107ac0:	05 00 00 00 80       	add    $0x80000000,%eax
80107ac5:	0f 22 d8             	mov    %eax,%cr3
}
80107ac8:	c9                   	leave  
80107ac9:	c3                   	ret    
80107aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ad0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107ad0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107ad1:	31 c9                	xor    %ecx,%ecx
{
80107ad3:	89 e5                	mov    %esp,%ebp
80107ad5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107adb:	8b 45 08             	mov    0x8(%ebp),%eax
80107ade:	e8 bd f8 ff ff       	call   801073a0 <walkpgdir>
  if(pte == 0)
80107ae3:	85 c0                	test   %eax,%eax
80107ae5:	74 05                	je     80107aec <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107ae7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107aea:	c9                   	leave  
80107aeb:	c3                   	ret    
    panic("clearpteu");
80107aec:	83 ec 0c             	sub    $0xc,%esp
80107aef:	68 32 88 10 80       	push   $0x80108832
80107af4:	e8 97 88 ff ff       	call   80100390 <panic>
80107af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b00 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107b00:	55                   	push   %ebp
80107b01:	89 e5                	mov    %esp,%ebp
80107b03:	57                   	push   %edi
80107b04:	56                   	push   %esi
80107b05:	53                   	push   %ebx
80107b06:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107b09:	e8 22 ff ff ff       	call   80107a30 <setupkvm>
80107b0e:	85 c0                	test   %eax,%eax
80107b10:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107b13:	0f 84 9f 00 00 00    	je     80107bb8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107b19:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107b1c:	85 c9                	test   %ecx,%ecx
80107b1e:	0f 84 94 00 00 00    	je     80107bb8 <copyuvm+0xb8>
80107b24:	31 ff                	xor    %edi,%edi
80107b26:	eb 4a                	jmp    80107b72 <copyuvm+0x72>
80107b28:	90                   	nop
80107b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107b30:	83 ec 04             	sub    $0x4,%esp
80107b33:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107b39:	68 00 10 00 00       	push   $0x1000
80107b3e:	53                   	push   %ebx
80107b3f:	50                   	push   %eax
80107b40:	e8 bb d6 ff ff       	call   80105200 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107b45:	58                   	pop    %eax
80107b46:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107b4c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b51:	5a                   	pop    %edx
80107b52:	ff 75 e4             	pushl  -0x1c(%ebp)
80107b55:	50                   	push   %eax
80107b56:	89 fa                	mov    %edi,%edx
80107b58:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b5b:	e8 c0 f8 ff ff       	call   80107420 <mappages>
80107b60:	83 c4 10             	add    $0x10,%esp
80107b63:	85 c0                	test   %eax,%eax
80107b65:	78 61                	js     80107bc8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107b67:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107b6d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107b70:	76 46                	jbe    80107bb8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107b72:	8b 45 08             	mov    0x8(%ebp),%eax
80107b75:	31 c9                	xor    %ecx,%ecx
80107b77:	89 fa                	mov    %edi,%edx
80107b79:	e8 22 f8 ff ff       	call   801073a0 <walkpgdir>
80107b7e:	85 c0                	test   %eax,%eax
80107b80:	74 61                	je     80107be3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107b82:	8b 00                	mov    (%eax),%eax
80107b84:	a8 01                	test   $0x1,%al
80107b86:	74 4e                	je     80107bd6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107b88:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80107b8a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80107b8f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107b95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107b98:	e8 93 ac ff ff       	call   80102830 <kalloc>
80107b9d:	85 c0                	test   %eax,%eax
80107b9f:	89 c6                	mov    %eax,%esi
80107ba1:	75 8d                	jne    80107b30 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107ba3:	83 ec 0c             	sub    $0xc,%esp
80107ba6:	ff 75 e0             	pushl  -0x20(%ebp)
80107ba9:	e8 02 fe ff ff       	call   801079b0 <freevm>
  return 0;
80107bae:	83 c4 10             	add    $0x10,%esp
80107bb1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107bb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bbe:	5b                   	pop    %ebx
80107bbf:	5e                   	pop    %esi
80107bc0:	5f                   	pop    %edi
80107bc1:	5d                   	pop    %ebp
80107bc2:	c3                   	ret    
80107bc3:	90                   	nop
80107bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107bc8:	83 ec 0c             	sub    $0xc,%esp
80107bcb:	56                   	push   %esi
80107bcc:	e8 af aa ff ff       	call   80102680 <kfree>
      goto bad;
80107bd1:	83 c4 10             	add    $0x10,%esp
80107bd4:	eb cd                	jmp    80107ba3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107bd6:	83 ec 0c             	sub    $0xc,%esp
80107bd9:	68 56 88 10 80       	push   $0x80108856
80107bde:	e8 ad 87 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107be3:	83 ec 0c             	sub    $0xc,%esp
80107be6:	68 3c 88 10 80       	push   $0x8010883c
80107beb:	e8 a0 87 ff ff       	call   80100390 <panic>

80107bf0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107bf0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107bf1:	31 c9                	xor    %ecx,%ecx
{
80107bf3:	89 e5                	mov    %esp,%ebp
80107bf5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bfb:	8b 45 08             	mov    0x8(%ebp),%eax
80107bfe:	e8 9d f7 ff ff       	call   801073a0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107c03:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107c05:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107c06:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107c08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107c0d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107c10:	05 00 00 00 80       	add    $0x80000000,%eax
80107c15:	83 fa 05             	cmp    $0x5,%edx
80107c18:	ba 00 00 00 00       	mov    $0x0,%edx
80107c1d:	0f 45 c2             	cmovne %edx,%eax
}
80107c20:	c3                   	ret    
80107c21:	eb 0d                	jmp    80107c30 <copyout>
80107c23:	90                   	nop
80107c24:	90                   	nop
80107c25:	90                   	nop
80107c26:	90                   	nop
80107c27:	90                   	nop
80107c28:	90                   	nop
80107c29:	90                   	nop
80107c2a:	90                   	nop
80107c2b:	90                   	nop
80107c2c:	90                   	nop
80107c2d:	90                   	nop
80107c2e:	90                   	nop
80107c2f:	90                   	nop

80107c30 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107c30:	55                   	push   %ebp
80107c31:	89 e5                	mov    %esp,%ebp
80107c33:	57                   	push   %edi
80107c34:	56                   	push   %esi
80107c35:	53                   	push   %ebx
80107c36:	83 ec 1c             	sub    $0x1c,%esp
80107c39:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107c3c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c3f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107c42:	85 db                	test   %ebx,%ebx
80107c44:	75 40                	jne    80107c86 <copyout+0x56>
80107c46:	eb 70                	jmp    80107cb8 <copyout+0x88>
80107c48:	90                   	nop
80107c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107c50:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107c53:	89 f1                	mov    %esi,%ecx
80107c55:	29 d1                	sub    %edx,%ecx
80107c57:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107c5d:	39 d9                	cmp    %ebx,%ecx
80107c5f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107c62:	29 f2                	sub    %esi,%edx
80107c64:	83 ec 04             	sub    $0x4,%esp
80107c67:	01 d0                	add    %edx,%eax
80107c69:	51                   	push   %ecx
80107c6a:	57                   	push   %edi
80107c6b:	50                   	push   %eax
80107c6c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107c6f:	e8 8c d5 ff ff       	call   80105200 <memmove>
    len -= n;
    buf += n;
80107c74:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107c77:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107c7a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107c80:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107c82:	29 cb                	sub    %ecx,%ebx
80107c84:	74 32                	je     80107cb8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107c86:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c88:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107c8b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107c8e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c94:	56                   	push   %esi
80107c95:	ff 75 08             	pushl  0x8(%ebp)
80107c98:	e8 53 ff ff ff       	call   80107bf0 <uva2ka>
    if(pa0 == 0)
80107c9d:	83 c4 10             	add    $0x10,%esp
80107ca0:	85 c0                	test   %eax,%eax
80107ca2:	75 ac                	jne    80107c50 <copyout+0x20>
  }
  return 0;
}
80107ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107ca7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107cac:	5b                   	pop    %ebx
80107cad:	5e                   	pop    %esi
80107cae:	5f                   	pop    %edi
80107caf:	5d                   	pop    %ebp
80107cb0:	c3                   	ret    
80107cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107cbb:	31 c0                	xor    %eax,%eax
}
80107cbd:	5b                   	pop    %ebx
80107cbe:	5e                   	pop    %esi
80107cbf:	5f                   	pop    %edi
80107cc0:	5d                   	pop    %ebp
80107cc1:	c3                   	ret    
