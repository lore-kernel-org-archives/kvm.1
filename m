Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930048;
	b=y3JtexY2HOJLfkaa+SyJNYu7wClrr4nv53gWuIx9QvUYWUhJI59PusNHjtWuv51tfPuC
	 dAbzu/3mP5PuLn3R8warwZ0jSYKbhu/MgUQrPeOrtEFMlHJeBZMjn0KyMWRHQavROWPLq
	 WH48QKhcURNsfVjvoiXzuN30Lf03b/kqIJAXJy3fdCh+0RfJ0+3fXa7x5XCZsqwhODd4A
	 eCGgH/fcKL9XmA7yJl2ojGrhsR7N0vvB9zoWA5gBcBNgYD1265n2XKYK7Zht7evrzFz0T
	 tH/UbrF/H272mR4cg2HbDjc66WM6Xhz+7GsslXXFiaK5R8h+oRmsBYuh7GofTA/En/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930048;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:In-Reply-To:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=2uRobH7cB+V+f7/Yy8ygzoo6bmhP7SFuLxqTJKOlnTU=;
	b=ZDY1Ldb0dvKVjYEHJQRuCvWb+RSmsH/7nNMLbwdm4002Ze26Ov1F70RTU6OFFqusOejR
	 b1zFE65XXLgnBX50T90L6vwrrx2Jp9TOxkBWo3EkNUSNKFxvYr5UpY3rCRQKmXz6bHQ3s
	 3WWwLCZaE9ECLQNSfkgZpXec+YZ6chHwbvjQX5lOlNC4jN6PoX5t/nVRv9XpLpvV/RMUT
	 jLkjq1mQh1ozOl5835qZDIHzxCWZuDserD2te1sFQJAA9UKX2Yyzhe3qZbgP2pEqRy9gJ
	 oS2iLDrqMAP4LqGJkL+f8kXdS+4VeKdu/VBGThsbF23P0mGAulvL2qe386ZG0TQN1TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA31606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 15:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5587351d419so3460302b6e.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 07:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794930047; x=1795534847;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2uRobH7cB+V+f7/Yy8ygzoo6bmhP7SFuLxqTJKOlnTU=;
        b=XK3pq270TUShKofzZd8XkNnC+GYzxEqzDYI7cMfzPVXEcL347sbT9wUEeH6TnB0ueD
         NrIDOnIXBS42G3L672Xj+PO4aaherb6gu1DDSJjmu9MHiGu/YwwGWmArusudHTH4vMjC
         WVvCdoUWxj2IQFD2zeY5TTITC0WYUEUJWU8H0Nm5qmoX7vR72nWgZUIqRXr/Dour9Jxi
         6I9BTU12erEhzYUhWg57IzrialQljWV7TLZaT31peZ/m1YaEZhMbhRzDs65P4GHQzyTS
         fviu3GQXPggVsFWVMKnNkyrd8N2GMVz4QGpR9CQP/ko17l1t/pgnzEkszL4QhBy8e9Tv
         W7aw==
X-Gm-Message-State: APuU4Z8LO7sl+kR5u3TQGTzFI6j9t6hWRVHC9/c0BmVDgGbK1B0nwD/t
	9xJbxlTAB/brnO6G1wPUro+8791MiEeYkMsW+VKAbtP5LWP3Gi/QBqHv9E/BYBeWuf9q+rJ+zEK
	COzMfrMTouXKJ03z+jyQdMN9p+gRz55f4IEJmSpuDrIKBQlhsN5w1M44qddQ=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:8419:b0:571:a186:d6b9 with SMTP id
 5614622812f47-571a186df41mr10001430b6e.13.1794930047213; Tue, 17 Nov 2026
 07:40:47 -0800 (PST)
Date: Tue, 17 Nov 2026 07:40:47 -0800
In-Reply-To: <6afbad4d.f3cfa7c9.844a4.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afc757f.6a9a30c8.1f5211.0003.GAE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_dirty_ring_push (2)
From: syzbot <syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, lei.cao@stratus.com, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, peterx@redhat.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    749a4de37040 Add linux-next specific files for 20261116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1341e5c3580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fedda7175e1c0b47
dashboard link: https://syzkaller.appspot.com/bug?extid=55eaa971f4924b62c9a5
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139fd73d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c1e5c3580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bd53057353b/disk-749a4de3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0d84c6a978c/vmlinux-749a4de3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e9b601ca025/bzImage-749a4de3.xz

The issue was bisected by AI to:

commit fb04a1eddb1a65b6588a021bdc132270d5ae48bb
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Oct 1 01:22:22 2020 +0000

    KVM: X86: Implement ring-based dirty memory tracking

AI reasoning:   https://syzkaller.appspot.com/ai_job?id=8ec79404-c0f6-4141-a152-96124787ad82

AI-generated root cause summary:
The KVM dirty ring implementation maps the per-vCPU dirty ring buffer
(ring->dirty_gfns) writable into userspace. In kvm_dirty_ring_reset(), KVM
iterates over entries marked with KVM_DIRTY_GFN_F_RESET and increments
ring->reset_index without verifying that reset_index has not advanced past
ring->dirty_index. When userspace sets KVM_DIRTY_GFN_F_RESET on un-dirtied
entries, reset_index surpasses dirty_index, causing kvm_dirty_ring_used()
(dirty_index - reset_index) to underflow to a large 32-bit unsigned integer
(~UINT_MAX). On subsequent guest memory writes, kvm_dirty_ring_push() checks
kvm_dirty_ring_full(), observes that the used entry count exceeds ring->size,
and triggers the WARN_ON_ONCE(kvm_dirty_ring_full(ring)) assertion.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=55eaa971f4924b62c9a5

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com

The cause commit was identified by AI and may be wrong.
If you agree with it, please also add:
Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")

------------[ cut here ]------------
kvm_dirty_ring_full(ring)
WARNING: arch/x86/kvm/../../../virt/kvm/dirty_ring.c:225 at kvm_dirty_ring_push+0x2b2/0x5e0 virt/kvm/dirty_ring.c:225, CPU#0: syz.0.2477/13660
Modules linked in:
CPU: 0 UID: 0 PID: 13660 Comm: syz.0.2477 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
RIP: 0010:kvm_dirty_ring_push+0x2b2/0x5e0 virt/kvm/dirty_ring.c:225
Code: 38 be 08 00 00 00 e8 8d 10 08 01 f0 80 4b 38 08 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 cf 84 88 00 90 <0f> 0b 90 e9 f8 fd ff ff e8 c1 84 88 00 90 0f 0b 90 e9 00 ff ff ff
RSP: 0018:ffffc900065872e0 EFLAGS: 00010293
RAX: ffffffff81412d31 RBX: ffff888059575100 RCX: ffff88802a9b0000
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 00000000fffffffe
RBP: 1ffff1100b2aedc9 R08: ffff8880369ec9d7 R09: 1ffff11006d3d93a
R10: dffffc0000000000 R11: ffffed1006d3d93b R12: ffff888059576e50
R13: 1ffff1100b2aedca R14: 0000000000000400 R15: 00000000fffffffe
FS:  00007f585c1b76c0(0000) GS:ffff888123134000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007a420000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 make_spte+0x71a/0xc80 arch/x86/kvm/mmu/spte.c:296
 tdp_mmu_map_handle_target_level arch/x86/kvm/mmu/tdp_mmu.c:1144 [inline]
 kvm_tdp_mmu_map+0x140e/0x1f40 arch/x86/kvm/mmu/tdp_mmu.c:1300
 kvm_tdp_mmu_page_fault arch/x86/kvm/mmu/mmu.c:5029 [inline]
 kvm_tdp_page_fault+0x2f7/0x3a0 arch/x86/kvm/mmu/mmu.c:5042
 kvm_mmu_do_page_fault+0x31d/0x640 arch/x86/kvm/mmu/mmu.c:5089
 kvm_mmu_page_fault+0x1f8/0xc00 arch/x86/kvm/mmu/mmu.c:6698
 vt_handle_exit+0x28/0x160 arch/x86/kvm/vmx/main.c:974
 vcpu_enter_guest arch/x86/kvm/x86.c:8540 [inline]
 vcpu_run+0x4da1/0x7890 arch/x86/kvm/x86.c:8695
 kvm_arch_vcpu_ioctl_run+0xe83/0x18b0 arch/x86/kvm/x86.c:9035
 kvm_vcpu_ioctl+0xa61/0xfd0 virt/kvm/kvm_main.c:4595
 vfs_ioctl fs/ioctl.c:52 [inline]
 __do_sys_ioctl fs/ioctl.c:604 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:590
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x00007f585b3a94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f585c1b7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f585b626090 RCX: 00007f585b3a94d9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00007f585b438136 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f585b626128 R14: 00007f585b626090 R15: 00007ffe50d85978
 </TASK>
