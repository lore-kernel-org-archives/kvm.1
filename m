Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5F404BFA
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738388; cv=none; b=FEWPsX2niuCNLPWL03tE8KcGkLrBb0eBAxIC8wetg085hLA9cwTcRNoVv0JjSXgXtGrCQsucgVozcWeuLxb+3NSxdHZ1SghzhvzLKqBVmp1VaookKM3TWsPXma14AClG6DHejQVw+QVs2hAWJKHUFQDdQs6F6j7i45nivo2bBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738388; c=relaxed/simple;
	bh=8sslPtlPnPLFLWbig/CMUn+C/mrbkK96Yd7+jDEafYY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jOfkJjnPhM9dF84JZSVmUTfKmsoQs8SlMbTgF9RrXi6U7EFsdlVzzTwhgZdolqhYeue9YDOd2wpYgA1Nq0D7+agFHCMIn9c2xHUdnlWlZ6jGsZ6yuaOsjqD8Vf02+xbJ9RP6ch6bSHUfh1IvMvdejc4pTKWbJaOVWvUXndsiQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-486e64c8edeso3834741b6e.2
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 06:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738386; x=1783343186;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ku5aaGnqdztyXQmXnQV/p8ytRzL4FNqAk6nbvhBOXMk=;
        b=q0T5AIGzgfmxfET/E725rtzSkmuXMmb9nvQ5+hO58zRYAhFH630pv134p4qFTgK96T
         Cdanqs7fols1F7MjsRNk9EzIB3lDV04Lp5D5rOOCjDA7D/igKK+EPc4QelaLUCCPqIl2
         64MKUO4PusogvLioSfpGfiW2HPKkfXuNhfedE6MqBnHFjmJtlDXMvOvuVGweKQ22aGqt
         VWDOpYFx7dr7T6eJt5dTLH8Vu1SDJpLNqYtmCWuc3t4Sc246niG/Cezf3sDa9T3OJ4qT
         N6cDlMr1XsF/uQGx0KuszDU1hHpDfFGVKnve5kl/wFKaeR0vcv+5yS3NX83PPSTnungQ
         naeA==
X-Forwarded-Encrypted: i=1; AFNElJ+F3p9FogZliP/7NKGdLBd6sV0bBZC44Cp/gdh5Kg4rNCYix+Zih4GyaTyvzAH2znIIXuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgqkUaHrlHTH6GXS8w6tkljwmdHfthJYN0cwCGfSQi0t2b+Uz
	KqJKqfcufSAfYtjAN/IjANAxveUtf6a3TsFZwaZCtQwSgLA2gJKeqvnvjnb7Bj7SbV02seafaR3
	FyUoNECssbT0iwEvQ5UWbCrCS9Xn+DV1pgt2PbcCKEoDyyYkKM52nB9k0C2Q=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1454:b0:495:df22:f4de with SMTP id
 5614622812f47-495e53cec82mr357198b6e.7.1782738386112; Mon, 29 Jun 2026
 06:06:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 06:06:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a426dd2.854d4ab9.360e1d.0008.GAE@google.com>
Subject: [syzbot] [kvm-x86?] KASAN: use-after-free Read in kvm_setup_guest_pvclock
From: syzbot <syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f1b46e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77808e35144e725c
dashboard link: https://syzkaller.appspot.com/bug?extid=fb7c2dd166d3ea63df2a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9911e5707540/disk-dc59e4fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb0af0bc6e42/vmlinux-dc59e4fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b7ca0661e875/bzImage-dc59e4fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kvm_setup_guest_pvclock+0x5bf/0x660 arch/x86/kvm/x86.c:3272
Read of size 4 at addr ffff88804c505320 by task syz.1.5312/25543

CPU: 1 UID: 0 PID: 25543 Comm: syz.1.5312 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/10/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 kvm_setup_guest_pvclock+0x5bf/0x660 arch/x86/kvm/x86.c:3272
 kvm_guest_time_update+0xa11/0x10b0 arch/x86/kvm/x86.c:3408
 vcpu_enter_guest arch/x86/kvm/x86.c:11149 [inline]
 vcpu_run+0x1cf1/0x5d50 arch/x86/kvm/x86.c:11707
 kvm_arch_vcpu_ioctl_run+0x5b6/0x1890 arch/x86/kvm/x86.c:12062
 kvm_vcpu_ioctl+0x730/0x1700 virt/kvm/kvm_main.c:4470
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5deff9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5df0dd3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5df0216090 RCX: 00007f5deff9ce59
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00007f5df0032e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5df0216128 R14: 00007f5df0216090 R15: 00007ffd2f6378e8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x200000000 pfn:0x4c505
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea000145ba48 ffff8880b85414b0 0000000000000000
raw: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 25531, tgid 25531 (syz.1.5312), ts 1799784670966, free_ts 1801394089155
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 folio_alloc_mpol_noprof+0x36/0x260 mm/mempolicy.c:2509
 vma_alloc_folio_noprof+0xed/0x1d0 mm/mempolicy.c:2544
 folio_prealloc mm/memory.c:1207 [inline]
 alloc_anon_folio mm/memory.c:5247 [inline]
 do_anonymous_page+0xb2b/0x2080 mm/memory.c:5342
 do_pte_missing mm/memory.c:4564 [inline]
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault+0x1d2c/0x2a00 mm/memory.c:6517
 handle_mm_fault+0x37b/0xa30 mm/memory.c:6686
 do_user_addr_fault+0x5a3/0x12f0 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6f/0xd0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
page last free pid 25532 tgid 25531 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 __folio_put+0x3b4/0x5f0 mm/swap.c:112
 folio_put include/linux/mm.h:2124 [inline]
 put_page include/linux/mm.h:2193 [inline]
 kvm_release_page_clean virt/kvm/kvm_main.c:2813 [inline]
 kvm_release_page_clean+0x1dc/0x250 virt/kvm/kvm_main.c:2807
 hva_to_pfn_retry virt/kvm/pfncache.c:246 [inline]
 __kvm_gpc_refresh+0x1a63/0x22d0 virt/kvm/pfncache.c:330
 __kvm_gpc_activate+0x2ab/0x490 virt/kvm/pfncache.c:424
 kvm_gpc_activate_hva+0x73/0xa0 virt/kvm/pfncache.c:444
 kvm_xen_vcpu_set_attr+0xfa0/0x1350 arch/x86/kvm/xen.c:938
 kvm_arch_vcpu_ioctl+0xf98/0x5730 arch/x86/kvm/x86.c:6612
 kvm_vcpu_ioctl+0x8a0/0x1700 virt/kvm/kvm_main.c:4647
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804c505200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804c505280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88804c505300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff88804c505380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804c505400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
