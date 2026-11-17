Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878799;
	b=q/t+TfFHueYkNJu5f94EcnJ0mekvVvZzoR/y235e9RHoEJjg+VEBKgUhyKejwBIDQiIh
	 66Hykc4pde73wgyooH3teNpFeoV/5UJlk/nbZMI50+4QqQKetjS63WHOWbYphS7dhVMSt
	 LGG+gyNei3Qoy2iQqCTlwHDm0r79hCmfvit7184vqa5Fwbf732Z+JbYkNy7wuqfDrbJdf
	 mvUKqMKksbyk3ihG1mSGPHxvdjYwxgpuW7vg0VGG9bcQt7YwtxSG55FvmyFudlqkG1Rzn
	 85jBBHlcYcoyfYUbeMRZYnCtkurySqrmX66jp/KBmLn2C8Ai6OoFDS28g9hM8sMEC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878799;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=epcchHzIS3VqSI98VVvI5q5YGH3heghlEsMhhskGTmw=;
	b=enARuaySEdByHfnkhixox4JC6PzGTdEz9vB57WICQgiSUIgjNFLEYbMWHVIkDUQF7atU
	 UNPKlV5FszGtVEdnF+AqvXyPSOnT5IU444qVXKQJazsR/TwlaNST8E9hZar5KmNemOnFH
	 RmWEzg0w5uwFZqpK/xS6ieZcrtXgFkURAj7rLkRe6nBfxn+DOs7HqOKRMaWsAi2CrdgmL
	 T9PFqTP1HPS9FLxsXsmTtv2Y5C1ZnUhp3MeK7bQptsnlDxSxnvTohtXQhpnpS5zwobM7S
	 ict9/mr1OJY5kxTCMJS5GYxCGvRBKvKO70DkVg0zVhMW/nYNKepM0M3NZP02P4M7TcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0A606A323
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 01:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD0A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-8628955a085so5453713a34.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794878798; x=1795483598;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epcchHzIS3VqSI98VVvI5q5YGH3heghlEsMhhskGTmw=;
        b=0dsW1IQ8MPurB0W6RnpTBISPtifEI/N3U0OZ+qXzK8XfHdRKqV138zc9VfkF59c4vL
         38DReJPttLl6MSUSvFkfEeriVs3TRnojUoAH/UMNVKD+XtNoQDvzOOnczF+2oqROihSK
         CY1T6kg8tVw9fCyPoCUmFGRjGRULClC/5wazAX+ISxybBWjGIPMTDmVWdxaPZi1PxMbK
         rMySpJJYLabnK6YIz5/pxOoDeM/pqy+C3kGp/9tL6Awn8fskr9Swbb7LZ7NC2+6vdvRT
         y6V8AUkW7URtP6utLT1DCY1s9yyX5mAvnRuY44S/LiwW2o66V+BB9qhwz2d1vc0gsZlJ
         33IQ==
X-Gm-Message-State: APuU4Z+MlrKD/1qfh+XKuOSwZauBw2RmGITNhWpenAwvCy3xnuLsEtZF
	mUmFHL3cIp0V3+05E4XVp7pMr+t385AnYlJ3UJao6gITUuUMEmONHrf9pNMzrpqA+T9O644HSQ6
	rpIemNAcU66sEWge8qYhTo/TcaF43xuCdV1CkvXBl/aE6bCIW/BygfI5C26o=
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4d06:b0:572:86c8:6b4c with SMTP id
 5614622812f47-57286c86d22mr7066572b6e.6.1794878798015; Mon, 16 Nov 2026
 17:26:38 -0800 (PST)
Date: Mon, 16 Nov 2026 17:26:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afbad4d.f3cfa7c9.844a4.0002.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_dirty_ring_push (2)
From: syzbot <syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, lei.cao@stratus.com, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, peterx@redhat.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84abb955b101 Add linux-next specific files for 20261113
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b438bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f3ae09c7e4ef77b
dashboard link: https://syzkaller.appspot.com/bug?extid=55eaa971f4924b62c9a5
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62605aef5c3b/disk-84abb955.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00d7d82886e8/vmlinux-84abb955.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8a7705e14db/bzImage-84abb955.xz

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
WARNING: arch/x86/kvm/../../../virt/kvm/dirty_ring.c:225 at kvm_dirty_ring_push+0x2b2/0x5e0 virt/kvm/dirty_ring.c:225, CPU#0: syz.3.4/5803
Modules linked in:
CPU: 0 UID: 0 PID: 5803 Comm: syz.3.4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
RIP: 0010:kvm_dirty_ring_push+0x2b2/0x5e0 virt/kvm/dirty_ring.c:225
Code: 38 be 08 00 00 00 e8 8d 7e 08 01 f0 80 4b 38 08 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 af 87 88 00 90 <0f> 0b 90 e9 f8 fd ff ff e8 a1 87 88 00 90 0f 0b 90 e9 00 ff ff ff
RSP: 0018:ffffc90004c472e0 EFLAGS: 00010283
RAX: ffffffff81411e81 RBX: ffff88802dc68000 RCX: 0000000000080000
RDX: ffffc90005cc2000 RSI: 0000000000015a79 RDI: 0000000000015a7a
RBP: 1ffff11005b8d3a9 R08: 0000000000000000 R09: 1ffff1100aed72c6
R10: dffffc0000000000 R11: ffffed100aed72c7 R12: ffff88802dc69d50
R13: 1ffff11005b8d3aa R14: 0000000000000400 R15: 00000000fffffffe
FS:  00007f8bbd1ba6c0(0000) GS:ffff888123136000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000077000000 CR4: 00000000003526f0
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
RIP: 0033:0x00007f8bbc3a94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8bbd1ba028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8bbc625fa0 RCX: 00007f8bbc3a94d9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000007
RBP: 00007f8bbc438136 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8bbc626038 R14: 00007f8bbc625fa0 R15: 00007ffc1b4cf008
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about AI bisection see: https://goo.gl/tpsmEJ#ai-bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
