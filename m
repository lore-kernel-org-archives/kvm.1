Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530D36EA99
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614811; cv=none; b=ck+EcWOpSoPAPOZe6YBUn8JGQ/qP4Dp3hPTeAAOW0n6UBb+WHbJ07oYCMiO5h8nQ04MB9dUmsDpGCP8037YmwWo+Gp1Da9TMDM0LBSPGzIgOqkNxGNMyIH9P2fDKoZ1j2Q2GpbPBhjQqXb7PVq354vp2FxSa7suHWHN780S2+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614811; c=relaxed/simple;
	bh=JPUdxlyVjS4w94QCvkQoczCDqWYF4YJYEU63C5xcMa0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lHPoWgSBSH3GyyzHnYh7+AYrFhIAvpsPIt0nztECFNVqyIHdfPWflefdP+KSBN8B9aladtehXgz4dFixBPLTQ3/vtba5hdNbAZB3nOk1kFK6zZbJEkPZOFOXcqhSH1zcF3KbCMQu31rvQgP3AvJtTKD3mDdhXo4eVClTAtReas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-48976713b46so1781089b6e.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 09:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614809; x=1784219609;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nce31PG8w0SB9E6qXsFIeo2UWAHRGDx5cPnTtszk37g=;
        b=VdlhvR7slIh3ejYWLH1pjsIk90s55vVORY9ADOGr+uO3Qt8umkwDcBWSzuadHAzCJj
         oJfbblScN4ZW0l4/TDbNlLIXjbd6xolAR6VVYmyUSJ5yOgtrTd9p73Na7PJW6uaTgwI4
         fsrUu4qXykkv8ubwj+H4oSsfoe3/ITKIt4mFccWVuL1SYjtOjzE49tJiWaPHcw5A+JwV
         37FBDKA4LS82jkPdECaaKfIusJKkD4OCm0jJMSxQ8hot9JofkXd/JvsuGiSKnf5QIuNp
         ryrglRTC/L0M/m2O1xwGud4ODFoymFHseWVo0nzKhMK9xdiCkUO/NDvHLez6TRBEmiis
         sOFg==
X-Forwarded-Encrypted: i=1; AFNElJ/Vh9DbcmA5mvFRm9vrWjFByhIEjFThc7BjS2eX+9t7Mz9H204tI+Ge01rG3iZAHdnVf9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeV1sKl4+FE3w0t883eF+7IkoTtuNGi6ZlR3ta3CBoxlSEdcM6
	PUlMM44P+0yaBgOmfUlPa15B3RssOQPCZuDT47SdPrmcaAClPuy7Xi/v622t5ooMIxWjyQfCHBl
	q3y+6/9jAdqGZ4RkxPy+GBAqDnwR5PCqPXk/9xoN8cwKhFiuFx34vbYOKo6s=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3445:b0:495:e251:945d with SMTP id
 5614622812f47-4a2053fee65mr6876828b6e.43.1783614808880; Thu, 09 Jul 2026
 09:33:28 -0700 (PDT)
Date: Thu, 09 Jul 2026 09:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4fcd58.a1ad617e.25832.000f.GAE@google.com>
Subject: [syzbot] [kvm-x86?] WARNING in kvm_check_and_inject_events
From: syzbot <syzbot+9dcd0a11dc9703a49511@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e35b9b6ec0f Merge tag 'mm-hotfixes-stable-2026-07-06-17-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1144b739580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=9dcd0a11dc9703a49511
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129d4389580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de8432580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e35b9b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c14bac7bee17/vmlinux-0e35b9b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36bfa5293255/bzImage-0e35b9b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9dcd0a11dc9703a49511@syzkaller.appspotmail.com

------------[ cut here ]------------
irq == -1
WARNING: arch/x86/kvm/x86.c:10800 at kvm_check_and_inject_events+0xf1e/0x1070 arch/x86/kvm/x86.c:10800, CPU#0: syz.2.478/7431
Modules linked in:
CPU: 0 UID: 0 PID: 7431 Comm: syz.2.478 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kvm_check_and_inject_events+0xf1e/0x1070 arch/x86/kvm/x86.c:10800
Code: 00 48 8b 44 24 20 48 0d 00 01 01 00 48 89 44 24 10 e9 35 fd ff ff e8 51 44 7e 00 90 0f 0b 90 e9 b7 fe ff ff e8 43 44 7e 00 90 <0f> 0b 90 e9 2e f8 ff ff e8 d5 bd ee 00 e9 ae f6 ff ff 48 8b 7c 24
RSP: 0018:ffffc90003e77a20 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880564729c0 RCX: ffffffff818b8adc
RDX: ffff888027f40000 RSI: ffffffff818b8bfd RDI: ffff888027f40000
RBP: 00000000ffffffff R08: 0000000000000005 R09: 00000000ffffffff
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff8880564735ec
R13: 0000000000000001 R14: ffff888056472ca8 R15: ffff8880564732f8
FS:  000055558b257500(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb475a73780 CR3: 0000000034df7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 vcpu_enter_guest arch/x86/kvm/x86.c:11296 [inline]
 vcpu_run+0xf1d/0x5d50 arch/x86/kvm/x86.c:11707
 kvm_arch_vcpu_ioctl_run+0x5b6/0x1890 arch/x86/kvm/x86.c:12062
 kvm_vcpu_ioctl+0x730/0x1700 virt/kvm/kvm_main.c:4470
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb475b9de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc07cddbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb475e25fa0 RCX: 00007fb475b9de59
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00007fb475c33e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb475e25fac R14: 00007fb475e25fa0 R15: 00007fb475e25fa0
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
