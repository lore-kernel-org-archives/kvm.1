Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753311CAF
	for <kvm@vger.kernel.org>; Sat, 20 Jun 2026 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927905; cv=none; b=kurbJY+VD8BxX9zEouJGVaoflMM7e9QAngGCgco4bopAMEGsUaiFlepP9vQnNyU6RreK55Z6YNqwYlUdqRrx+zzV3GjNI1fQ8yKtJ/MiJbg4XddE7KW4TPK3UuzafuRiCU6ziOkGjERkdO0Dk0bRRdeyDRHhcUXmPyOGSJOQtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927905; c=relaxed/simple;
	bh=jBcL117oefVqvzeFraAukXo1usvSQvY1WMhClDVpeK0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ih6+/caAiDBs3dtpKBCMkWK9qPU/ILnENm5YtDUDnrSnU7m0t1VTiKghHe09pLhnDA7ZnKqjlqVbo0pQSaJsrUWI/qY9mdWFqa4qPN5Erm0enhSc6g5Nv4OlEH4BxJBfOIaZjVlr9MugpqbRV4dqj0IcM4dFR1z4RIoOs6PBxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-489677a16bbso2540377b6e.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 20:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781927903; x=1782532703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1sOdCMXpSDAddoNBK2iHky7WrahVdcM6wwlTtYMx/Q=;
        b=pjATCJCATeclKnGWE4ECzh9X21ZV/QwlJJ8ApE3Z6tlRnixyzcAwioTok+fjeC30lJ
         L7+3D3c4WlgKCKLy7mFQ/LtX2kl/J247Eu1ZrOX4lxV43FoDT6ysSzTqT8RUz6T+ogYQ
         cH2cLh9ZoCUjh2M/1Y5TZuDUZek7MIxH3gPs9zO3bgqmm0w3MrtgBi4+jgcvEjd2z/6y
         YbbwcYI7JQRxEyXBDaKEp0ziPWnIjrmwumJy3Mtdb5o7bWffutSYZC5jLql13pg4ztTx
         4+Ie1Hl35ar3yyvWD/b9FA7dXfa35uY3LRwO5IeAwurGX5YaQ35Nw51w9Jl65rOfvN1V
         L+wg==
X-Forwarded-Encrypted: i=1; AFNElJ/FZIn4Mbdcw+sYi7/GUb/vvemLBrybqRJi7fHZVkbdTzE9UYW+ImD6qyEWHwU84qLNPIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytx3i3fTRU9YJni0Bd5gqDXoyyeo/l+iT1rZ/Z5auRbkNEfaBs
	JTGp/6dvl0qRvsC7SbWmAqMSdktyyZBOYUWFilVVZ5Qq77Ba8hNtF1+gvVyP1Aj6PKyegYBmFo7
	u37datlAwZIzTJN8nS4yrKL2qspxg1Q0+JcbeYEmN2bCedzCpFbxL51KMVks=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1c09:b0:468:6a2:897 with SMTP id
 5614622812f47-4896a9b5286mr5470331b6e.6.1781927903105; Fri, 19 Jun 2026
 20:58:23 -0700 (PDT)
Date: Fri, 19 Jun 2026 20:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a360fdf.871e809a.2d6dda.0000.GAE@google.com>
Subject: [syzbot] [kvm-x86?] WARNING in vcpu_run (2)
From: syzbot <syzbot+dd769db18693736eee89@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8c13415c8a43 Merge tag 'media/v7.2-1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec001c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4e6991ab3edc95e
dashboard link: https://syzkaller.appspot.com/bug?extid=dd769db18693736eee89
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157ce8ea580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1176e566580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27752fb81380/disk-8c13415c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/192b476e0df1/vmlinux-8c13415c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ba635e3d5aec/bzImage-8c13415c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd769db18693736eee89@syzkaller.appspotmail.com

------------[ cut here ]------------
irq == -1
WARNING: arch/x86/kvm/x86.c:10860 at kvm_check_and_inject_events arch/x86/kvm/x86.c:10860 [inline], CPU#0: syz.4.1716/11103
WARNING: arch/x86/kvm/x86.c:10860 at vcpu_enter_guest arch/x86/kvm/x86.c:11356 [inline], CPU#0: syz.4.1716/11103
WARNING: arch/x86/kvm/x86.c:10860 at vcpu_run+0x57ec/0x7950 arch/x86/kvm/x86.c:11770, CPU#0: syz.4.1716/11103
Modules linked in:
CPU: 0 UID: 0 PID: 11103 Comm: syz.4.1716 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:kvm_check_and_inject_events arch/x86/kvm/x86.c:10860 [inline]
RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:11356 [inline]
RIP: 0010:vcpu_run+0x57ec/0x7950 arch/x86/kvm/x86.c:11770
Code: b5 ff ff 89 d1 80 e1 07 38 c1 0f 8c 64 b1 ff ff 48 8b 7c 24 58 e8 a4 66 eb 00 48 8b 54 24 58 e9 50 b1 ff ff e8 b5 47 7e 00 90 <0f> 0b 90 4c 8b 64 24 10 e9 4c e7 ff ff e8 a2 47 7e 00 90 0f 0b 90
RSP: 0018:ffffc90006e375e0 EFLAGS: 00010293
RAX: ffffffff8147d98b RBX: ffff88805b402cc0 RCX: ffff88807bca5d00
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000ffffffff
RBP: ffffc90006e379b0 R08: ffff88805b402c57 R09: 1ffff1100b68058a
R10: dffffc0000000000 R11: ffffed100b68058b R12: 00000000ffffffff
R13: ffff88805b402ca0 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000555579916500(0000) GS:ffff88812525d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c74672780 CR3: 0000000075b22000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kvm_arch_vcpu_ioctl_run+0x1193/0x2070 arch/x86/kvm/x86.c:12125
 kvm_vcpu_ioctl+0xa61/0xfd0 virt/kvm/kvm_main.c:4470
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1c7479ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdeb74dbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1c74a15fa0 RCX: 00007f1c7479ce59
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00007f1c74832e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1c74a15fac R14: 00007f1c74a15fa0 R15: 00007f1c74a15fa0
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
