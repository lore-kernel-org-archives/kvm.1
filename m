Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B565474E
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791170249; cv=none; b=tOvVnuRfH35BTWGWkC7/aMuyB50cH1Cg7/mVcGIlQHf4u+pRVY4Zr5LYxC+8byvRzW4XuUPbfc896ToTi1GRBCIrRghaYhQKDQrCG+KUs/pKK6qubUH0fjKlLodjuEBmEgscg/UpwJkTXS/rnEf+iSaHz3ZUTxCXcBK06lmyhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791170249; c=relaxed/simple;
	bh=yIBkcz89UNj6rU+ADP3QqP7ROf5zhK/b4jncgcpMLvs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N5L1oowWzmL3W42BG9VLUKkCLims2LZuU+/A9yeIov+RtorjxdCII0Y6cbUOCaJB/Ez+qprc/lw/G8CS2Yrh8fL5Mhar/fhx49ddMXD7GxgKEfFI1XxRheSAb80GG4OdouL5r7kXyiKNQaxYXTjG568o4DWICjm55wDWHGEGT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b28d7ffab1so2313256b6e.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791170247; x=1791775047;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPu5KM8/puHdEbM483uwyKKWAbr6MgY/NxgZfvdRAwc=;
        b=cci5tpb793rmO5VLNJSbL7lwH0gkaLMWRBw1XYVBua+JZ35QjF88I1kfsoHjsVLsS5
         LJbkI+s6uUbcSJT7ET4XGcii9kB2X9B+UpoC7/9vfi2DE9rqIrAWJhaiHiXLXyvfszbO
         Y7WWcmuHgzU4WyZn1o57yAbt/1jGTuFhWBBj2aBP3yKg93MlNT4tNrhswpQeplEt3i47
         iHJogscuepat5Z7J6uGrpJc1UmPY2q8GcYhrtXrSDQET9VPyGkVNw8qiKgzFAEljK9WV
         rDqM4xWOiY0qGC4NGK4h9nsTDXc+dZLRW1F0h5tsaDNTkeQK7mYTu1pjjoc89kEz6iq2
         Xz5w==
X-Gm-Message-State: AFuF++nV1aApidcKK2UMebSZlxDhP3nmWYF76GcLVxumxVMZhsaWky/x
	32UmmF8VfH8UTJOLKy438OPVj536wXF6mF5i55pqVdt9ilz/Y1JyPeV8/6gjxhD9xKZGtjmo+qx
	uOQ+XD+GLrinEecoOtzD1XNm7m/B2v/sVquoGRRHAuJdJgVdQUSwNsUbGeBA=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1507:b0:4e8:4a03:dfa3 with SMTP id
 5614622812f47-4f30b800ecamr9051669b6e.40.1791170247178; Sun, 04 Oct 2026
 20:17:27 -0700 (PDT)
Date: Sun, 04 Oct 2026 20:17:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac316c7.01314a6c.556a8.000d.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_vcpu_pre_fault_memory
From: syzbot <syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce1e0223d8ad Merge tag 'devicetree-fixes-for-7.3-2' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1353dbf5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=db7bd0f41c2a7e82d4ba
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cdf6c9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cdf6c9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/217b0c1b14ee/disk-ce1e0223.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/335343cc5803/vmlinux-ce1e0223.xz
kernel image: https://storage.googleapis.com/syzbot-assets/760ef2f39df0/bzImage-ce1e0223.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com

------------[ cut here ]------------
r == 0 || r == -EIO
WARNING: arch/x86/kvm/../../../virt/kvm/kvm_main.c:4389 at kvm_vcpu_pre_fault_memory+0x45d/0x470 virt/kvm/kvm_main.c:4389, CPU#1: syz-executor267/8523
Modules linked in:
CPU: 1 UID: 0 PID: 8523 Comm: syz-executor267 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
RIP: 0010:kvm_vcpu_pre_fault_memory+0x45d/0x470 virt/kvm/kvm_main.c:4389
Code: fe ff ff e8 85 2e 88 00 90 0f 0b 90 e9 0d ff ff ff e8 77 2e 88 00 e8 42 85 f3 ff eb 8f e8 6b 2e 88 00 eb 05 e8 64 2e 88 00 90 <0f> 0b 90 e9 a7 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
RSP: 0018:ffffc900024dfc28 EFLAGS: 00010293
RAX: ffffffff813fe025 RBX: ffffc900024dfe00 RCX: ffff88807fcc0000
RDX: 0000000000000000 RSI: ffffffff8eaf6510 RDI: fffffffffffffffb
RBP: dffffc0000000000 R08: ffff88807fcc0000 R09: 0000000000000002
R10: fffffffffffffffb R11: 0000000000000000 R12: ffffc900024dfe00
R13: ffff88807fcc0000 R14: 1ffff1100ff98000 R15: fffffffffffffffb
FS:  00007f9c411186c0(0000) GS:ffff888124dc7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c4116312d CR3: 0000000026a4a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kvm_vcpu_ioctl+0x8a6/0xfd0 virt/kvm/kvm_main.c:4668
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c4118db49
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c411181d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9c4123bb88 RCX: 00007f9c4118db49
RDX: 0000200000000100 RSI: 00000000c040aed5 RDI: 0000000000000005
RBP: 00007f9c4123bb80 R08: 38203a6b63617473 R09: 38203a6b63617473
R10: 38203a6b63617473 R11: 0000000000000246 R12: 00007f9c4120b858
R13: 0000200000000118 R14: 0000200000000100 R15: 0000200000000600
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
