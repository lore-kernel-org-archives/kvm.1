Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83A2D6E5A
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195695; cv=none; b=HMC87TUYQXoudLnj1yNfTfC9+t5wtFaQTSoy7fDRkJQ4EjQaHz8+t5M5rGYltB4wILgO1F3hA/QX/9nOHoxzhFZFGce8S7j2XtaG7gm6Eq5Uv/o8eDHyb5ZDRS6ChdEj3ycRGRKHsA8lKFYwsICciDavi2B35dWJ+I9fvU8rV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195695; c=relaxed/simple;
	bh=DqPkcxZ2Iky7o6NSqXBvZSJ5n+PhWbEN8ZbxQIMdLlk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RE/4DG3lTYDzz4NwTRDzc3rBEj7qOsvGmoEV4+kf5zih0snyMO7qqUseHmxNWC0LDMhZOEjuvlLFdsPVLNQoR/ynubTRMY50MPtYiruldK+kMd/UPtpjPLBFJqHbKyEpif8b0oXAOrmTxYXMbXP4zQ/IZoPC4GrRn1dVPh3u/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.216.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-368ac44b26dso2957848a91.2
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 06:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195693; x=1779800493;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DkQrNtBhC+WBmhuRCOKUoIZJp9AAysSjS7AGbEqjnE=;
        b=A8Tbs0r0UJ0BPU4GDqYqnzqHab6xZ2hkzwwskmHCSqnkE18Tab8uWL2wwJLAjbYPXj
         710Z1Ay4kMNr4MNTQVsd1ZAw6D+tVzc2EyM3DSkb8yk1amSJ6+KvO80JKOtYbnfNJCqg
         Zl6/LcqEEa4GjVddKzVYu8G1FS1EbjXNihYhbsl1D/548oCeCIY1oIo8Hg4NU9pQb0zQ
         w/U6Obazmy88/32sGHlaV4+X7JL6gfOuU6LBHckG7h7h2/t9oo046uwttdMwFYLVTmOD
         O4Fx3wA3mv1JxLPI9EaBSwAm9VtPB95p4mabGECQtaKqKWoPB9UeAseWWHlD1CqvfdWe
         LPqA==
X-Forwarded-Encrypted: i=1; AFNElJ/9I7+JdTJ5tsta8yYJ66Di36fxE27q8Bjvdg1iO/pcJbSQWLODSO5Rf3bCs3EBUEaAdgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZbtxiQbmvJbrq0TcN0Dz89wU89tpBwsJqxKH7z68mNICyqe0
	FqfvLavNiLroXErIZ6HYx1MTP8yZS//zrswV4RMZj7pgOLNDKoxRjOQzXVyijOIRhRkDE4b4Kw1
	jPKryWdzJiBG9JSTSfVaepDb+SUz6KoQNo6jSLdYRKoCxYVD669Bj3tK2huI=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:48c4:b0:35f:d56d:1c45 with SMTP id
 98e67ed59e1d1-369519cc92amr18826406a91.12.1779195692869; Tue, 19 May 2026
 06:01:32 -0700 (PDT)
Date: Tue, 19 May 2026 06:01:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com>
Subject: [syzbot] [kvm?] [kvm-x86?] KASAN: use-after-free Read in kvm_xen_shared_info_init
From: syzbot <syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, paul@xen.org, pbonzini@redhat.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d3a2a466b8d HID: core: Fix size_t specifier in hid_report..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1073cd6a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03f143994ada/disk-4d3a2a46.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/de287d829354/vmlinux-4d3a2a46.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3467e0106c40/bzImage-4d3a2a46.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x3c6/0x440 arch/x86/kvm/xen.c:90
Read of size 4 at addr ffff8880517e3900 by task syz.2.1046/11260

CPU: 0 UID: 0 PID: 11260 Comm: syz.2.1046 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 kvm_xen_shared_info_init+0x3c6/0x440 arch/x86/kvm/xen.c:90
 kvm_xen_hvm_set_attr+0xcef/0x16a0 arch/x86/kvm/xen.c:806
 kvm_arch_vm_ioctl+0x2a0/0x18d0 arch/x86/kvm/x86.c:7528
 kvm_vm_ioctl+0x1564/0x4050 virt/kvm/kvm_main.c:5380
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62be79ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f62bf733028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f62bea15fa0 RCX: 00007f62be79ce59
RDX: 0000000000000004 RSI: 000000004048aec9 RDI: 0000000000000003
RBP: 00007f62be832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f62bea16038 R14: 00007f62bea15fa0 R15: 00007ffcbacd7668
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x4 pfn:0x517e3
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001595b88 ffff8880b84412f0 0000000000000000
raw: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 11260, tgid 11259 (syz.2.1046), ts 375671463264, free_ts 375831741570
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x11a6/0x33b0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5226
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 folio_alloc_mpol_noprof+0x36/0x260 mm/mempolicy.c:2509
 vma_alloc_folio_noprof+0xed/0x1d0 mm/mempolicy.c:2544
 folio_prealloc mm/memory.c:1193 [inline]
 wp_page_copy mm/memory.c:3859 [inline]
 do_wp_page+0x1ee1/0x4350 mm/memory.c:4320
 handle_pte_fault mm/memory.c:6427 [inline]
 __handle_mm_fault+0x1ab6/0x2a00 mm/memory.c:6549
 handle_mm_fault+0x36d/0xa20 mm/memory.c:6718
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x1178/0x32a0 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1692 [inline]
 get_user_pages_unlocked+0x1cb/0x7d0 mm/gup.c:2681
 hva_to_pfn_slow virt/kvm/kvm_main.c:2903 [inline]
 hva_to_pfn+0x871/0xd60 virt/kvm/kvm_main.c:2999
 hva_to_pfn_retry virt/kvm/pfncache.c:209 [inline]
 __kvm_gpc_refresh+0xcea/0x22c0 virt/kvm/pfncache.c:330
 __kvm_gpc_activate+0x2ab/0x490 virt/kvm/pfncache.c:424
 kvm_gpc_activate_hva+0x73/0xa0 virt/kvm/pfncache.c:444
 kvm_xen_hvm_set_attr+0x395/0x16a0 arch/x86/kvm/xen.c:798
page last free pid 11260 tgid 11259 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x747/0x1040 mm/page_alloc.c:2943
 __folio_put+0x3b4/0x5f0 mm/swap.c:112
 folio_put include/linux/mm.h:2090 [inline]
 put_page include/linux/mm.h:2159 [inline]
 kvm_release_page_clean virt/kvm/kvm_main.c:2813 [inline]
 kvm_release_page_clean+0x1dc/0x250 virt/kvm/kvm_main.c:2807
 hva_to_pfn_retry virt/kvm/pfncache.c:246 [inline]
 __kvm_gpc_refresh+0x195d/0x22c0 virt/kvm/pfncache.c:330
 __kvm_gpc_activate+0x2ab/0x490 virt/kvm/pfncache.c:424
 kvm_gpc_activate_hva+0x73/0xa0 virt/kvm/pfncache.c:444
 kvm_xen_hvm_set_attr+0x395/0x16a0 arch/x86/kvm/xen.c:798
 kvm_arch_vm_ioctl+0x2a0/0x18d0 arch/x86/kvm/x86.c:7528
 kvm_vm_ioctl+0x1564/0x4050 virt/kvm/kvm_main.c:5380
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880517e3800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880517e3880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880517e3900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880517e3980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880517e3a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
