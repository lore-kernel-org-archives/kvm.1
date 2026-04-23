Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAA26E6F3
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977546; cv=none; b=A8idXDHvN6EwY60sBA1/igEyonvNLOGBwQak0ZKCLgX0FeYioo+8RGwr0h+F4HTKKRr009hTTYWjMEVG73/Xj1gGQ7PPiyQZGZnHtFNF1B/5fHQqX+JY0HFXk8hkSbQHygeC/Sp2Cf9Cj/cvB6xdBt6nHat1o3ceynADDwDAL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977546; c=relaxed/simple;
	bh=3vucp0MZUx1PxwRNoeXQyCKgM7tWqKNYAr4aRYdzad8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=jFiJXkEQ+0XUiRJCOsQdnkfmXrsQOTbyXjShsQtfpvn4ttHcw5ZIKvtJpRoR/iO3saQK0ir6wK5XetzJwklRVD7gaFSqYIo3Ce54/JTE02reH23mKX/zFmtaj2Lm/MGmksDUSOU58fGbznhgQkRZpvK+64T6rHlrQFmyetRDVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6948d83a548so11778494eaf.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 13:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977544; x=1777582344;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMs2/RKyUiezJ0Mkvd3k2pVXI1yax6hTuiTwjuqib3c=;
        b=CcC9WLbxYWZ0zJebjfqupMquK2ZBB3Zq+vM7ejLWn+iz1SQUqCw1yJi+hWiKScRKIs
         SUxqIgj+yyJcE47Rm59av4fFoGyBF8vSA4p6qGjFSR991ZJI7r+dMFG2EDNaoKbb3d/n
         4M+xDKB8ls4O2U0T16oILzVGeUOdRe2WfoiV8SG09pFR4N7LMweYYEi1B/jzHjAsgpmV
         SK2PyJyUY8jhUsuxeO/j/ZPIEcILbwH5iITmqoiI8oyfrIPuGvMu2OU41PK2YG8UOqyL
         fN+ozo4+021Z53bJOMRXHNOof1HGFIAI4L++3Fiz5YdfcVuIzhzxRFu/6V9wyQGimceC
         fFCw==
X-Gm-Message-State: AOJu0Yz9f7Mw0LdJ/VHjIpszh7h81JWnVGvN7qghlrjVivOB+oJN09Io
	HIi6OQ2j58+RgIRckK3FNUt+qW6Q6V1LShPcjaYlrJ/4qlI4vNjk0n8XVLPgpIkEFyEZcJOmPny
	Aki5SxcHfvF+TPTC1r86qioI/66SRd4BXJm2Bp3rngKiCDOpLjTDKSqVBOpc=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c90:b0:688:6d55:195 with SMTP id
 006d021491bc7-69462f2f14fmr17266443eaf.57.1776977544013; Thu, 23 Apr 2026
 13:52:24 -0700 (PDT)
Date: Thu, 23 Apr 2026 13:52:23 -0700
In-Reply-To: <20260423140833.439512-1-seanjc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ea8687.a00a0220.9259.002c.GAE@google.com>
Subject: [syzbot ci] Re: KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: syzbot ci <syzbot+ciae116ac2b0afefad@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, vkuznets@redhat.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
https://lore.kernel.org/all/20260423140833.439512-1-seanjc@google.com
* [PATCH 1/5] KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
* [PATCH 2/5] KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_tlb_flush_fifo()
* [PATCH 3/5] KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on cross-vCPU accesses
* [PATCH 4/5] KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
* [PATCH 5/5] KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active accesses

and found the following issue:
WARNING in kvm_hv_vcpu_uninit

Full report is available here:
https://ci.syzbot.org/series/e1f68dae-f32a-4112-a163-7a00f36d6508

***

WARNING in kvm_hv_vcpu_uninit

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      85f871f6ba46f20d7fbc0b016b4db648c33220dd
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/4f8c36c7-e865-4f65-bb81-e22962e8a1e0/config
syz repro: https://ci.syzbot.org/findings/60fac5d8-1296-4ec7-a8e3-40f561d007e9/syz_repro

------------[ cut here ]------------
debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
WARNING: arch/x86/kvm/hyperv.h:79 at to_hv_vcpu arch/x86/kvm/hyperv.h:78 [inline], CPU#1: syz.2.19/5974
WARNING: arch/x86/kvm/hyperv.h:79 at kvm_hv_vcpu_uninit+0x163/0x1b0 arch/x86/kvm/hyperv.c:906, CPU#1: syz.2.19/5974
Modules linked in:
CPU: 1 UID: 0 PID: 5974 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:to_hv_vcpu arch/x86/kvm/hyperv.h:78 [inline]
RIP: 0010:kvm_hv_vcpu_uninit+0x163/0x1b0 arch/x86/kvm/hyperv.c:906
Code: 48 89 df e8 0f 0f d8 00 48 c7 03 00 00 00 00 eb 05 e8 e1 8c 6d 00 5b 41 5c 41 5e 41 5f 5d e9 c4 a8 5a 0a cc e8 ce 8c 6d 00 90 <0f> 0b 90 e9 65 ff ff ff 48 c7 c1 00 12 12 90 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003e07940 EFLAGS: 00010293
RAX: ffffffff81592fe2 RBX: ffff8881b6acd380 RCX: ffff8881046e4980
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffff88817696d743 R09: 1ffff1102ed2dae8
R10: dffffc0000000000 R11: ffffed102ed2dae9 R12: 0000000000000000
R13: 00000000fffffff8 R14: ffff88817696d740 R15: dffffc0000000000
FS:  00007f4cc3a9b6c0(0000) GS:ffff8882a944f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4cc2c4edd5 CR3: 000000016d918000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 kvm_arch_vcpu_destroy+0x1a9/0x380 arch/x86/kvm/x86.c:12963
 kvm_vm_ioctl_create_vcpu+0x69a/0x930 virt/kvm/kvm_main.c:4269
 kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5168
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4cc2b9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4cc3a9b028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4cc2e15fa0 RCX: 00007f4cc2b9c819
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00007f4cc2c32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4cc2e16038 R14: 00007f4cc2e15fa0 R15: 00007ffd36efc848
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
