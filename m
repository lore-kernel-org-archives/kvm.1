Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFB34A796
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302870; cv=none; b=gy2g4dnhCPx0Qqybt7vimM68nyqsPB4Is40ZobOiZlXkjlGRHDv48BKxJBdv0bODE/U3kdBiCLfCeq7b3xbn2CjOEq2yBx+p/gUHQTqUcvoh7W48lo/gx/aWde34NHfNQG9VPCqD03KcBznk52FdBHxCTvKT54hfTQw3TTKcl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302870; c=relaxed/simple;
	bh=8rGBoBCUoOcLqP2wLN/bNnRT/KbjMnE77eOwY0/JrC0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z/zU5CFthCYlG8JI+esKkbBAh8zd7YmCBUueB2PeGR+1rpGPrm+d/p5WpTjG9o8fxE8lUa2JpirM+s6DhiQthx/nju28hFRA69sX4GuY6gic7jruxPfOuosUR4oPK2EwMp0El7JqbbQQmbmpACvL5XLXvxWjcLXsCe46DCEnmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e9f6a49e69so1134605a34.0
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 12:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302865; x=1786907665;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Y8Dhju+pjFtIWTzdpFQRgVTtlF8FS2Xp3LK1/IAMls=;
        b=WxVNGkp3yjvOZsK3hpoowUprdilAJfFdtYu4K1v36VEoBD1Ac30jtNfgxPfk7dMxoz
         lGXdySMzX861UqtaPKMPRcd44r1y5vteFdkJVltIHjTvE/CZ8+JnpYYW0kWNpnjmqW+W
         dJCOyIrH1XIUaMYV4501jVjfbyjt3eXJ09Rh1CGimMUaTuqui+JGo4gLyPOFGAhG8FMq
         DcpxLru/tDZZGBL7GrnxBH3x6fHju+RuaxJJ+MGIC+T1ZLs4EAOtLmPNAjU+GHgNUVme
         wVBLXV9XvgJRHIeFudichPcrFu8fGuO5bDKENz7ngWZIFJxsP5qeJN0y2Lt+DbIvsYPi
         pCDw==
X-Gm-Message-State: AOJu0YxV1c4ZKbdm+8TbUqUT8rmgPYIFqcByVbDaTNDpahGZH08jEIgn
	KnH+0Csad/3l/zUrpDgB9kABfsYmkgscdywJi/Zckuey5Sh8uK/lPzx5tsipiWZRm6I7RghIoEf
	oBBCMtjZX3xkTC1hyo84xfvgC0qo43V6jkwmxVT1E402N2qcFxxEH+93fbmxplw==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:161f:b0:6a1:4a27:cd22 with SMTP id
 006d021491bc7-6b041b79e7emr7545781eaf.0.1786302865294; Sun, 09 Aug 2026
 12:14:25 -0700 (PDT)
Date: Sun, 09 Aug 2026 12:14:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a78d191.b50370da.49fe0.0042.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_put_kvm (3)
From: syzbot <syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b8c8af514d7 Add linux-next specific files for 20260807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14548079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d343b54cc50df0f
dashboard link: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1528e132580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ff4edcb608/disk-6b8c8af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f5fa331d8f2/vmlinux-6b8c8af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f993558ec63b/bzImage-6b8c8af5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com

------------[ cut here ]------------
timer_delete_sync(&sdp->delay_work)
WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x3aa/0x890 kernel/rcu/srcutree.c:706, CPU#1: syz.1.1070/8126
Modules linked in:
CPU: 1 UID: 0 PID: 8126 Comm: syz.1.1070 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:cleanup_srcu_struct+0x3aa/0x890 kernel/rcu/srcutree.c:706
Code: b9 8a 00 48 83 7d 00 00 4c 8b 74 24 10 0f 85 dd 03 00 00 41 ff c5 41 83 e5 0f 41 83 fd 07 0f 86 0e ff ff ff e9 ab 00 00 00 90 <0f> 0b 90 4c 8d b5 00 02 00 00 4c 89 f3 48 c1 eb 03 48 b8 00 00 00
RSP: 0018:ffffc9000bbbfc50 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000607edad41c80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8e253559 RDI: 00000000ffffffff
RBP: ffffe8ffffc4dc80 R08: ffffffff9058fb7f R09: 1ffffffff20b1f6f
R10: dffffc0000000000 R11: fffffbfff20b1f70 R12: ffff88807bfa8000
R13: 0000000000000000 R14: ffffffff8e5237d0 R15: 1ffffffff1ca47de
FS:  000055557293c500(0000) GS:ffff88812500c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000071042000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kvm_destroy_vm virt/kvm/kvm_main.c:1303 [inline]
 kvm_put_kvm+0x9cb/0xb50 virt/kvm/kvm_main.c:1332
 kvm_vm_release+0x43/0x50 virt/kvm/kvm_main.c:1355
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x22e/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x328/0x510 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25cc99e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed2b09948 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffed2b09a30 RCX: 00007f25cc99e0d9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 0000000000051665 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2d520000 R11: 0000000000000246 R12: 00007ffed2b09a70
R13: 00007f25ccc25fac R14: 00000000000516bf R15: 00007f25ccc25fa0
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
