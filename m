Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90439E19A
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850229; cv=none; b=qwaEzwZ7VZk7+77nzQLkQXrQkwLdjmVJfZ20f/SPuYcq3MM8lBRvqad9TPY4Qq6bA6C22Pheebyk4DL9EfpplJhLVaswanR7rgF5n5+Z4YywFHYhJ5CAmUliIMuFwfE/vca61O0qPgxLMwbh/1oTHGK3A+8HB7OGcEiIXJGPovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850229; c=relaxed/simple;
	bh=ERr+1tk1uPRrobaMFGfJ/Q1xkES2hUiXZ6Zmeni1OxM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gNUU4SDlGmRvwroPhIbhKHIqtaz3WYVxgd63D2mX3Zqj6wWz64lxlY6ggf3P8eBuHtyBNylvf26c1OOWONiombiD/vLT+N9GO3SQ8YH1l0LZznpgHkMWd14cGUN7kz8cu7kiCwpM1zgu2m1IauDDYjiVoYafAL8MPa/8HTM7yrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-495b8120909so4036285b6e.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782850227; x=1783455027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZhqN4D3ehCcmgRo3CnnRFx/c5S54WSVUGiSXQDX+TE=;
        b=WBTq7hfnKzDGibSiB1lR/0+5/CgWAXJb1tl4cSaq+srBzu6qjyaCujGluVuhV2iSEU
         n9bI3OKGJfxPzmfC44cTK106Q2/NvJ5mFFOMtpg0sKQAUQ80qZAEaw+2oHR+yvk26GoJ
         ZTpkinlXO3+DEdknABJiWCXMyzuyJJBuwToVhc9ohZd3wwzFiv7bJTNwM7W/10vK+nUi
         Bg+QOojnpAHvxtCTwFSD4l1lcDcNa2L5LI9OALdvAKdO+GldPsV5uTWjrAmik4RlI0Jy
         3MqBJ7d5+VL2etN6IP6UWtbkfBcqQyF7IsZp8fVQHB7gATPlOE4U/YVwb+KL8fvqi856
         /TiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BwUnVWMofXUn/fsS1TLm6mn9N2jKLWE4XsoDtQL1w8EHAGRrPpeXfqDi42UJT8hdbSyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhoJLoy6yn0nlfNvh2VKwTDKiRAB3gIc3hvSrvCu9uFtEnAnV
	oF/SRVmaoo/v++/5D6ReQ2gqRmsSzujUVD8toTzGKKZF3+pW4opJviEx35AK2iLJmEE8nkOVGJk
	rBA6JxRWS4SERXIt9EI05GouwkU193URZYTD+GoDX3W9rYMfX0EcVbkxCXGY=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:88c9:b0:495:fd99:66a7 with SMTP id
 5614622812f47-495fd99688amr1265977b6e.34.1782850227422; Tue, 30 Jun 2026
 13:10:27 -0700 (PDT)
Date: Tue, 30 Jun 2026 13:10:27 -0700
In-Reply-To: <6a426dd2.854d4ab9.360e1d.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4422b3.35583610.9b6d.0002.GAE@google.com>
Subject: Re: [syzbot] [kvm-x86?] KASAN: use-after-free Read in kvm_setup_guest_pvclock
From: syzbot <syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7de6ae9e1220 Add linux-next specific files for 20260629
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163d19de580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93f99737ecde604c
dashboard link: https://syzkaller.appspot.com/bug?extid=fb7c2dd166d3ea63df2a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1309af41580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f28bae580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a09187a6eb8d/disk-7de6ae9e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f0a76dd86b32/vmlinux-7de6ae9e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/864b9d8296e7/bzImage-7de6ae9e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kvm_setup_guest_pvclock+0x439/0x620 arch/x86/kvm/x86.c:1728
Read of size 4 at addr ffff88804d02c320 by task syz.1.180/6591

CPU: 1 UID: 0 PID: 6591 Comm: syz.1.180 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 kvm_setup_guest_pvclock+0x439/0x620 arch/x86/kvm/x86.c:1728
 kvm_guest_time_update+0xa32/0xe60 arch/x86/kvm/x86.c:1864
 vcpu_enter_guest arch/x86/kvm/x86.c:8038 [inline]
 vcpu_run+0x150d/0x73e0 arch/x86/kvm/x86.c:8596
 kvm_arch_vcpu_ioctl_run+0xe51/0x1960 arch/x86/kvm/x86.c:8929
 kvm_vcpu_ioctl+0xa64/0xfe0 virt/kvm/kvm_main.c:4470
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbebb04ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbeba68d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbebb2c6090 RCX: 00007fbebb04ce59
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00007fbebb0e2e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbebb2c6128 R14: 00007fbebb2c6090 R15: 00007ffefb5754e8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x200000000 pfn:0x4d02c
flags: 0x80000000000000(node=0|zone=1)
raw: 0080000000000000 ffffea000159c008 ffff8880b8642f70 0000000000000000
raw: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 6589, tgid 6589 (syz.1.180), ts 149074813359
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1861
 prep_new_page mm/page_alloc.c:1869 [inline]
 get_page_from_freelist+0x264c/0x26c0 mm/page_alloc.c:3949
 __alloc_frozen_pages_noprof+0x1a6/0x390 mm/page_alloc.c:5322
 alloc_pages_mpol+0xce/0x280 mm/mempolicy.c:2490
 folio_alloc_mpol_noprof+0x3b/0x1e0 mm/mempolicy.c:2509
 vma_alloc_folio_noprof+0xe1/0x1e0 mm/mempolicy.c:2544
 folio_prealloc mm/memory.c:-1 [inline]
 alloc_anon_folio mm/memory.c:5247 [inline]
 do_anonymous_page mm/memory.c:5342 [inline]
 do_pte_missing+0x835/0x28f0 mm/memory.c:4564
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault mm/memory.c:6517 [inline]
 handle_mm_fault+0xe0b/0x1520 mm/memory.c:6686
 do_user_addr_fault+0xa4d/0x1340 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
page last free pid 6590 tgid 6589 ts 149102566230 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1408 [inline]
 __free_frozen_pages+0x10de/0x11c0 mm/page_alloc.c:2952
 __folio_put+0x30f/0x3c0 mm/swap.c:112
 hva_to_pfn_retry virt/kvm/pfncache.c:246 [inline]
 __kvm_gpc_refresh+0x1277/0x1710 virt/kvm/pfncache.c:330
 __kvm_gpc_activate+0x289/0x3b0 virt/kvm/pfncache.c:424
 kvm_xen_vcpu_set_attr+0x1d3/0x1190 arch/x86/kvm/xen.c:938
 kvm_arch_vcpu_ioctl+0x1467/0x23f0 arch/x86/kvm/x86.c:3815
 kvm_vcpu_ioctl+0x7e6/0xfe0 virt/kvm/kvm_main.c:4647
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804d02c200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804d02c280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88804d02c300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff88804d02c380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804d02c400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
