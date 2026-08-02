Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA33ACA46
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686194; cv=none; b=IpLweroZm3scME3FA1c4sBPx+WlSf0/o/5BixyZER4eGE0rbFefZZiDmEAbTYX+bGIdK72CrI7Wl2hkMjtzUpEYNaHoF8uLv9ZMKzjqnVKq/vdkJQ8kaLCdaGWOKOLvQXb7NZmxZAeqgwcFL1HT2CwT2JVT+RhPT9GwNL9VVp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686194; c=relaxed/simple;
	bh=BVUBcbqGjsRzNyaVXFgYWgR6JF5mmUNjmUm+GGVT5EI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rQTJZ1yeljqta519We1//zcTwtqSrsGWZyFOb0tKY+lvHzWS0CLNT0eUFmlAVZ0RYH9DzsQs/XsrAYAE1oE7w2ZS73aKahJnthIhPdaJuUVvQjqsQHKe4EgczVLiUxM0K+3o4aCZH57B57qxBZjL1UJagyPit7y6CRV7ag0a3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4ab8b646492so4489649b6e.0
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 08:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785686191; x=1786290991;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6yIdQ0f04z44Ose39PNgv4Q0GzPZnUB1UrHSKaFiTLY=;
        b=OJRKPso0YRCOjHLK0zF7eJjwLJp/+ogv4yhTe6rZl468HWUP6Mh70meEkGge2OGm2a
         BFkemErNbDTHhze9O4f8lclWBBRZpL2BR1T9QuIndn2CRLtqQJ3HPuUmr/3VFyrTg5sz
         Dq67OKikXnwuuA1mZJk2K60D8eMhti5TzlBN/r4jzxlbzdB7edI2tjL7Unql9Ioz5wYC
         iDCnvMnxuDkWqO7XfZYapNP+Y30Zdc/1lrhUlhlYRlg7KIJj6k7yp5MkZeBAZDakrbcF
         4kzqWZ4U7S/82cTLVIzf7mzJwHHd6x5VtQy9s1k80Qrbfc2bviTe8a2GNMQvMusb1nQY
         dnNw==
X-Forwarded-Encrypted: i=1; AHgh+RqgbEQcjpmCmXw44Q/xgmBVkK9E76+sZnFua8Ay1ptIXiKUUrfu+yQRTqMbJuU+F05+7DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoK5EdHfYUq2GWAcEN3yAqI2iqeZG3vp8q9cgaJLQrthbSQpOl
	kD/I0uK9TJTfqqyCKfgnjshU7s3ktxQ/xUA5tkzIqzwjl93ulPt8w0qkhcAsu/JExncW11uiogv
	l8awldLtlW7Qmu5ty6A5qk0U/cyuzHpzsISNzwUk82lVHMDwlQS+YEBGk27w=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:250e:b0:495:f74a:b572 with SMTP id
 5614622812f47-4af5e031fb3mr10999278b6e.5.1785686191472; Sun, 02 Aug 2026
 08:56:31 -0700 (PDT)
Date: Sun, 02 Aug 2026 08:56:31 -0700
In-Reply-To: <6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6f68af.13bfb6d0.1ecdd5.0271.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [kvm-x86?] KASAN: use-after-free Read in kvm_xen_shared_info_init
From: syzbot <syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com>
To: aha310510@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dwmw2@infradead.org, dwmw@amazon.co.uk, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, paul@xen.org, 
	pbonzini@redhat.com, pdurrant@amazon.com, seanjc@google.com, 
	souradiptodas6@gmail.com, syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2d2338c93da7 Merge tag 'i2c-fixes-7.2-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fc9e32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fdf4c6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6ed15f8269a/disk-2d2338c9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4e97eab66d0/vmlinux-2d2338c9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/afd310a94440/bzImage-2d2338c9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x3c6/0x440 arch/x86/kvm/xen.c:90
Read of size 4 at addr ffff8880599c2900 by task syz.2.383/7257

CPU: 1 UID: 0 PID: 7257 Comm: syz.2.383 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 kvm_xen_shared_info_init+0x3c6/0x440 arch/x86/kvm/xen.c:90
 kvm_xen_hvm_set_attr+0xcef/0x16a0 arch/x86/kvm/xen.c:806
 kvm_arch_vm_ioctl+0x2a0/0x18d0 arch/x86/kvm/x86.c:7514
 kvm_vm_ioctl+0x1560/0x4180 virt/kvm/kvm_main.c:5381
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f03cc39e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f03cd189028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f03cc626090 RCX: 00007f03cc39e019
RDX: 0000200000000840 RSI: 000000004048aec9 RDI: 0000000000000004
RBP: 00007f03cc43500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f03cc626128 R14: 00007f03cc626090 R15: 00007ffd770bb9c8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xe pfn:0x599c2
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001a41648 ffff8880b85414b0 0000000000000000
raw: 000000000000000e 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 7257, tgid 7253 (syz.2.383), ts 169739507412, free_ts 169740156503
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 folio_alloc_mpol_noprof+0x36/0x260 mm/mempolicy.c:2509
 shmem_alloc_folio+0x135/0x160 mm/shmem.c:1917
 shmem_alloc_and_add_folio+0x371/0xd40 mm/shmem.c:1959
 shmem_get_folio_gfp+0x6ad/0x1910 mm/shmem.c:2512
 shmem_fault+0x1f9/0xa20 mm/shmem.c:2713
 __do_fault+0x10b/0x440 mm/memory.c:5425
 do_shared_fault mm/memory.c:5924 [inline]
 do_fault+0x2db/0x1750 mm/memory.c:5998
 do_pte_missing mm/memory.c:4566 [inline]
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault+0x187d/0x2a00 mm/memory.c:6517
 handle_mm_fault+0x37b/0xa30 mm/memory.c:6686
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x1178/0x32a0 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1752 [inline]
 get_user_pages_unlocked+0x30a/0x7d0 mm/gup.c:2681
 hva_to_pfn_slow virt/kvm/kvm_main.c:2903 [inline]
 hva_to_pfn+0x871/0xd60 virt/kvm/kvm_main.c:2999
page last free pid 7257 tgid 7253 stack trace:
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
 kvm_xen_hvm_set_attr+0x395/0x16a0 arch/x86/kvm/xen.c:798
 kvm_arch_vm_ioctl+0x2a0/0x18d0 arch/x86/kvm/x86.c:7514
 kvm_vm_ioctl+0x1560/0x4180 virt/kvm/kvm_main.c:5381
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880599c2800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880599c2880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880599c2900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880599c2980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880599c2a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
